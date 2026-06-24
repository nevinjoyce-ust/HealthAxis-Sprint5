using AutoMapper;
using HealthAxis.API.Data;
using HealthAxis.API.Mappings;
using HealthAxis.API.Middlewares;
using HealthAxis.API.Repositories;
using HealthAxis.API.Repositories.Impl;
using HealthAxis.API.Services;
using HealthAxis.API.Services.Impl;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi;
using Serilog;
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

    const string HealthAxisAdminCorsPolicy = "HealthAxisAdminCorsPolicy";

    var appName = builder.Configuration["AppSettings:AppName"] ?? "HealthAxis API";

    builder.Services.AddSerilog((services, loggerConfiguration) => loggerConfiguration
        .ReadFrom.Configuration(builder.Configuration)
        .ReadFrom.Services(services)
        .Enrich.FromLogContext()
        .Enrich.WithProperty("Application", appName));

    builder.Services.AddCors(options =>
    {
        options.AddPolicy(HealthAxisAdminCorsPolicy, policy =>
        {
            policy
                .WithOrigins(
                    "https://localhost:7041",
                    "http://localhost:5291")
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

            ClockSkew = TimeSpan.Zero
        };
    });

    builder.Services.AddAuthorization();

    builder.Services.AddScoped<IDoctorRepository, DoctorRepository>();
    builder.Services.AddScoped<IPatientRepository, PatientRepository>();
    builder.Services.AddScoped<IAppointmentRepository, AppointmentRepository>();
    builder.Services.AddScoped<IHealthRecordRepository, HealthRecordRepository>();

    builder.Services.AddScoped<IAuthService, AuthService>();
    builder.Services.AddScoped<IDoctorService, DoctorService>();
    builder.Services.AddScoped<IPatientService, PatientService>();
    builder.Services.AddScoped<IAppointmentService, AppointmentService>();
    builder.Services.AddScoped<IHealthRecordService, HealthRecordService>();
    builder.Services.AddScoped<IAdminService, AdminService>();

    builder.Services.AddAutoMapper(cfg =>
    {
        cfg.AddProfile<MappingProfile>();
    });

    var app = builder.Build();

    app.UseExceptionHandler();

    app.UseSerilogRequestLogging(options =>
    {
        options.MessageTemplate = "HTTP {RequestMethod} {RequestPath} responded {StatusCode} in {Elapsed:0.0000} ms";

        options.EnrichDiagnosticContext = (diagnosticContext, httpContext) =>
        {
            diagnosticContext.Set("RequestHost", httpContext.Request.Host.Value ?? string.Empty);
            diagnosticContext.Set("RequestScheme", httpContext.Request.Scheme);
            diagnosticContext.Set("UserName", httpContext.User.Identity?.Name ?? "anonymous");
        };
    });

    using (var scope = app.Services.CreateScope())
    {
        var roleManager = scope.ServiceProvider.GetRequiredService<RoleManager<IdentityRole>>();
        var userManager = scope.ServiceProvider.GetRequiredService<UserManager<IdentityUser>>();
        var context = scope.ServiceProvider.GetRequiredService<HealthAxisDbContext>();

        await IdentityDataSeeder.SeedAsync(roleManager, userManager, context);
    }

    if (app.Environment.IsDevelopment())
    {
        app.UseSwagger();
        app.UseSwaggerUI();
    }

    app.UseHttpsRedirection();

    app.UseCors(HealthAxisAdminCorsPolicy);

    app.UseAuthentication();
    app.UseAuthorization();

    app.MapControllers();

    app.MapGet("/", () => $"{appName} is running successfully.");

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
