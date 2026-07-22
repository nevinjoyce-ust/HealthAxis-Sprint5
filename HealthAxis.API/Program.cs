using HealthAxis.API.BackgroundServices;
using HealthAxis.API.Data;
using HealthAxis.API.Mappings;
using HealthAxis.API.Messaging;
using HealthAxis.API.Middlewares;
using HealthAxis.API.Repositories;
using HealthAxis.API.Repositories.Impl;
using HealthAxis.API.Services;
using HealthAxis.API.Services.Impl;
using MassTransit;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.StaticFiles;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.FileProviders;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi;
using Serilog;
using System.Security.Claims;
using System.Text;
using System.Text.Json;

Log.Logger = new LoggerConfiguration()
    .MinimumLevel.Information()
    .Enrich.FromLogContext()
    .WriteTo.Console()
    .CreateBootstrapLogger();

try
{
    var builder = WebApplication.CreateBuilder(args);
    var appName = builder.Configuration["AppSettings:AppName"] ??
        "HealthAxis API";

    builder.Host.UseSerilog((context, services, configuration) => configuration
        .ReadFrom.Configuration(context.Configuration)
        .ReadFrom.Services(services)
        .Enrich.FromLogContext()
        .Enrich.WithProperty("Application", appName));

    builder.Services.AddControllers()
        .AddJsonOptions(options =>
            options.JsonSerializerOptions.PropertyNamingPolicy =
                JsonNamingPolicy.CamelCase);

    builder.Services.AddEndpointsApiExplorer();
    builder.Services.AddSwaggerGen(options =>
    {
        options.SwaggerDoc("v1", new OpenApiInfo
        {
            Title = "HealthAxis API",
            Version = "v1"
        });

        options.AddSecurityDefinition("bearer", new OpenApiSecurityScheme
        {
            Type = SecuritySchemeType.Http,
            Scheme = "bearer",
            BearerFormat = "JWT",
            Description = "JWT Authorization header using the Bearer scheme."
        });

        options.AddSecurityRequirement(document => new OpenApiSecurityRequirement
        {
            [new OpenApiSecuritySchemeReference("bearer", document)] = []
        });
    });

    builder.Services.AddExceptionHandler<GlobalExceptionHandler>();
    builder.Services.AddProblemDetails();
    builder.Services.AddHealthChecks();

    builder.Services.AddDbContext<HealthAxisDbContext>(options =>
        options.UseSqlServer(
            builder.Configuration.GetConnectionString("HealthAxisDb")));

    builder.Services.AddIdentity<IdentityUser, IdentityRole>(options =>
    {
        options.User.RequireUniqueEmail = true;
        options.Password.RequireDigit = true;
        options.Password.RequireUppercase = true;
        options.Password.RequireLowercase = true;
        options.Password.RequireNonAlphanumeric = true;
        options.Password.RequiredLength = 8;
    })
    .AddEntityFrameworkStores<HealthAxisDbContext>()
    .AddDefaultTokenProviders();

    var jwtSettings = builder.Configuration.GetSection("Jwt");

    builder.Services.AddAuthentication(options =>
    {
        options.DefaultAuthenticateScheme =
            JwtBearerDefaults.AuthenticationScheme;
        options.DefaultChallengeScheme =
            JwtBearerDefaults.AuthenticationScheme;
    })
    .AddJwtBearer(options =>
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidIssuer = jwtSettings["Issuer"],
            ValidateAudience = true,
            ValidAudience = jwtSettings["Audience"],
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            IssuerSigningKey = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes(jwtSettings["Key"]!)),
            NameClaimType = ClaimTypes.Email,
            RoleClaimType = ClaimTypes.Role,
            ClockSkew = TimeSpan.Zero
        });

    builder.Services.AddAuthorization();

    builder.Services.AddScoped<IDoctorRepository, DoctorRepository>();
    builder.Services.AddScoped<IPatientRepository, PatientRepository>();
    builder.Services.AddScoped<IAppointmentRepository, AppointmentRepository>();
    builder.Services.AddScoped<IHealthRecordRepository, HealthRecordRepository>();
    builder.Services.AddScoped<INotificationRepository, NotificationRepository>();

    builder.Services.AddScoped<IAuthService, AuthService>();
    builder.Services.AddScoped<IDoctorService, DoctorService>();
    builder.Services.AddScoped<IPatientService, PatientService>();
    builder.Services.AddScoped<IAppointmentService, AppointmentService>();
    builder.Services.AddScoped<IHealthRecordService, HealthRecordService>();
    builder.Services.AddScoped<IAdminService, AdminService>();
    builder.Services.AddScoped<IAdminHandoffService, AdminHandoffService>();

    builder.Services.AddMemoryCache();

    builder.Services.AddHostedService<HeartbeatService>();
    builder.Services.AddHostedService<NotificationCleanupService>();
    builder.Services.AddHostedService<PendingAppointmentDeadlineService>();
    builder.Services.AddHostedService<ExpiredConfirmedAppointmentService>();

    builder.Services.AddMassTransit(options =>
    {
        options.AddConsumer<AppointmentBookedConsumer>();

        options.UsingRabbitMq((context, configuration) =>
        {
            var rabbit = builder.Configuration.GetSection("RabbitMq");
            var rabbitPort = rabbit.GetValue<ushort>("Port", 5672);

            configuration.Host(
                rabbit["HostName"] ?? "localhost",
                rabbitPort,
                rabbit["VirtualHost"] ?? "/",
                host =>
                {
                    host.Username(rabbit["UserName"] ?? "guest");
                    host.Password(rabbit["Password"] ?? "guest");
                });

            configuration.ReceiveEndpoint(
                rabbit["AppointmentBookedQueue"] ??
                    "appointment.booked.queue",
                endpoint => endpoint.ConfigureConsumer<AppointmentBookedConsumer>(
                    context));
        });
    });

    builder.Services.AddAutoMapper(configuration =>
        configuration.AddProfile<MappingProfile>());

    var app = builder.Build();

    app.UseExceptionHandler();

    app.UseSerilogRequestLogging(options =>
    {
        options.MessageTemplate =
            "HTTP {RequestMethod} {RequestPath} responded {StatusCode} in {Elapsed:0.0000} ms";
    });

    using (var scope = app.Services.CreateScope())
    {
        var seedDemoData = builder.Configuration
            .GetValue<bool>("SeedData:SeedDemoData");

        await IdentityDataSeeder.SeedAsync(
            scope.ServiceProvider.GetRequiredService<RoleManager<IdentityRole>>(),
            scope.ServiceProvider.GetRequiredService<UserManager<IdentityUser>>(),
            scope.ServiceProvider.GetRequiredService<HealthAxisDbContext>(),
            seedDemoData);
    }

    if (app.Environment.IsDevelopment())
    {
        app.UseSwagger();
        app.UseSwaggerUI();
    }

    app.UseDefaultFiles();

    var blazorContentTypes = new FileExtensionContentTypeProvider();
    blazorContentTypes.Mappings[".dat"] = "application/octet-stream";
    blazorContentTypes.Mappings[".wasm"] = "application/wasm";

    var adminWebRoot = Path.Combine(
        app.Environment.WebRootPath,
        "admin");

    app.UseStaticFiles(new StaticFileOptions
    {
        FileProvider = new PhysicalFileProvider(adminWebRoot),
        RequestPath = "/admin",
        ContentTypeProvider = blazorContentTypes
    });

    // Serves Angular from the root wwwroot folder.
    app.UseStaticFiles();

    app.UseAuthentication();
    app.UseAuthorization();

    app.MapHealthChecks("/health");
    app.MapControllers();

    app.MapFallback("/api/{**path}", () => Results.NotFound());
    app.MapFallbackToFile("/admin/{*path:nonfile}", "admin/index.html");
    app.MapFallbackToFile("{*path:nonfile}", "index.html");

    Log.Information("Starting {ApplicationName}", appName);

    await app.RunAsync();
}
catch (Exception exception)
{
    Log.Fatal(exception, "HealthAxis API terminated unexpectedly.");
}
finally
{
    await Log.CloseAndFlushAsync();
}
