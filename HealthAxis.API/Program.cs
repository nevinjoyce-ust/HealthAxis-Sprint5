using AutoMapper;
using HealthAxis.API.BackgroundServices;
using HealthAxis.API.Data;
using HealthAxis.API.Mappings;
using HealthAxis.API.Messaging;
using HealthAxis.API.Middlewares;
using HealthAxis.API.Options;
using HealthAxis.API.Repositories;
using HealthAxis.API.Repositories.Impl;
using HealthAxis.API.Services;
using HealthAxis.API.Services.Impl;
using MassTransit;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi;
using Serilog;
using System.Security.Claims;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;

Log.Logger = new LoggerConfiguration()
    .MinimumLevel.Information()
    .Enrich.FromLogContext()
    .WriteTo.Console()
    .CreateBootstrapLogger();

try
{
    var builder = WebApplication.CreateBuilder(args);

    const string HealthAxisAdminCorsPolicy = "HealthAxisAdminCorsPolicy";

    var appName = builder.Configuration["AppSettings:AppName"] ?? "HealthAxis API";

    builder.Host.UseSerilog((context, services, loggerConfiguration) =>
    {
        loggerConfiguration
            .ReadFrom.Configuration(context.Configuration)
            .ReadFrom.Services(services)
            .Enrich.FromLogContext()
            .Enrich.WithProperty("Application", appName);
    });

    builder.Services.AddCors(options =>
    {
        options.AddPolicy(HealthAxisAdminCorsPolicy, policy =>
        {
            policy
                .WithOrigins(
                    "https://localhost:7041",
                    "http://localhost:5291",
                    "http://localhost:4200",
                    "https://localhost:4200")
                .AllowAnyHeader()
                .AllowAnyMethod();
        });
    });

    builder.Services.AddControllers()
        .AddJsonOptions(options =>
        {
            options.JsonSerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
        });

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

    builder.Services.AddDbContext<HealthAxisDbContext>(options =>
        options.UseSqlServer(builder.Configuration.GetConnectionString("HealthAxisDb")));

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
        options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
        options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
    })
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidIssuer = jwtSettings["Issuer"],

            ValidateAudience = true,
            ValidAudience = jwtSettings["Audience"],

            ValidateLifetime = true,

            ValidateIssuerSigningKey = true,
            IssuerSigningKey = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes(jwtSettings["Key"]!)
            ),

            NameClaimType = ClaimTypes.Email,
            RoleClaimType = ClaimTypes.Role,

            ClockSkew = TimeSpan.Zero
        };
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
    builder.Services.AddMemoryCache();
    builder.Services.AddScoped<IAdminHandoffService, AdminHandoffService>();
    builder.Services.AddScoped<IDoctorAvailabilityCacheService, DoctorAvailabilityCacheService>();

    builder.Services.AddHostedService<HeartbeatService>();
    builder.Services.AddHostedService<NotificationCleanupService>();

    builder.Services.AddScoped<IRabbitMqPublisher, RabbitMqPublisher>();

    builder.Services.AddMassTransit(options =>
    {
        options.AddConsumer<AppointmentBookedConsumer>();

        options.UsingRabbitMq((context, cfg) =>
        {
            var rabbitConfig = builder.Configuration.GetSection("RabbitMq");

            cfg.Host(
                rabbitConfig["HostName"] ?? "localhost",
                rabbitConfig["VirtualHost"] ?? "/",
                host =>
                {
                    host.Username(rabbitConfig["UserName"] ?? "guest");
                    host.Password(rabbitConfig["Password"] ?? "guest");
                });

            cfg.ReceiveEndpoint(
                rabbitConfig["AppointmentBookedQueue"] ?? "appointment.booked.queue",
                endpoint =>
                {
                    endpoint.ConfigureConsumer<AppointmentBookedConsumer>(context);
                });
        });
    });
    builder.Services.Configure<GarnetOptions>(builder.Configuration.GetSection("Garnet"));

    builder.Services.AddStackExchangeRedisCache(option =>
    {
        var garnetOptions = builder.Configuration.GetSection("Garnet").Get<GarnetOptions>() 
            ?? new GarnetOptions();
        option.Configuration = garnetOptions.ConnectionString;
        option.InstanceName = garnetOptions.InstanceName;
    });

    builder.Services.AddAutoMapper(cfg =>
    {
        cfg.AddProfile<MappingProfile>();
    });

    var app = builder.Build();

    app.UseExceptionHandler();

    app.UseSerilogRequestLogging(options =>
    {
        options.MessageTemplate =
            "HTTP {RequestMethod} {RequestPath} responded {StatusCode} in {Elapsed:0.0000} ms";

        options.EnrichDiagnosticContext = (diagnosticContext, httpContext) =>
        {
            var userId =
                httpContext.User.FindFirstValue(ClaimTypes.NameIdentifier)
                ?? httpContext.User.FindFirstValue("nameid")
                ?? httpContext.User.FindFirstValue("sub")
                ?? "anonymous";

            var userName =
                httpContext.User.Identity?.Name
                ?? httpContext.User.FindFirstValue(ClaimTypes.Email)
                ?? httpContext.User.FindFirstValue("email")
                ?? httpContext.User.FindFirstValue("unique_name")
                ?? userId;

            var role =
                httpContext.User.FindFirstValue(ClaimTypes.Role)
                ?? httpContext.User.FindFirstValue("role")
                ?? "unknown";

            diagnosticContext.Set("RequestHost", httpContext.Request.Host.Value ?? string.Empty);
            diagnosticContext.Set("RequestScheme", httpContext.Request.Scheme);
            diagnosticContext.Set("UserId", userId);
            diagnosticContext.Set("UserName", userName);
            diagnosticContext.Set("UserRole", role);
        };
    });

    using (var scope = app.Services.CreateScope())
    {
        var roleManager = scope.ServiceProvider.GetRequiredService<RoleManager<IdentityRole>>();
        var userManager = scope.ServiceProvider.GetRequiredService<UserManager<IdentityUser>>();
        var context = scope.ServiceProvider.GetRequiredService<HealthAxisDbContext>();
        
        var seedDemoData = builder.Configuration.GetValue<bool>("SeedData:SeedDemoData");

        await IdentityDataSeeder.SeedAsync(
            roleManager,
            userManager,
            context,
            seedDemoData);
    }

    if (app.Environment.IsDevelopment())
    {
        app.UseSwagger();
        app.UseSwaggerUI();
    }


    if (!app.Environment.IsDevelopment())
    {
        app.UseHttpsRedirection();
    }


    app.UseCors(HealthAxisAdminCorsPolicy);

    app.UseAuthentication();
    app.UseAuthorization();

    app.MapControllers();

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
