using AutoMapper;
using HealthAxis.API.Data;
using HealthAxis.API.Mappings;
using HealthAxis.API.Repositories;
using HealthAxis.API.Repositories.Impl;
using HealthAxis.API.Services.Impl;
using HealthAxis.API.Services;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();

// Add Swagger/OpenAPI support.
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Add EF Core DbContext.
builder.Services.AddDbContext<HealthAxisDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("HealthAxisDb")));

builder.Services.AddScoped<IUserRepository, UserRepository>();

builder.Services.AddScoped<IDoctorRepository, DoctorRepository>();
builder.Services.AddScoped<IPatientRepository, PatientRepository>();
builder.Services.AddScoped<IAppointmentRepository, AppointmentRepository>();
builder.Services.AddScoped<IHealthRecordRepository, HealthRecordRepository>();

builder.Services.AddScoped<IDoctorService, DoctorService>();
builder.Services.AddScoped<IPatientService, PatientService>();
builder.Services.AddScoped<IAppointmentService, AppointmentService>();
builder.Services.AddScoped<IHealthRecordService, HealthRecordService>();
builder.Services.AddScoped<IAdminService, AdminService>();

builder.Services.AddSingleton<IMapper>(sp =>
{
    var config = new MapperConfiguration(
        cfg => cfg.AddProfile<MappingProfile>(),
        null
    );

    return config.CreateMapper();
});



var app = builder.Build();

// Read AppName from appsettings.json.
var appName = builder.Configuration["AppSettings:AppName"] ?? "HealthAxis API";

// Simple request logging middleware.
app.Use(async (context, next) =>
{
    var logger = context.RequestServices.GetRequiredService<ILogger<Program>>();

    logger.LogInformation(
        "Request started: {Method} {Path} for {AppName}",
        context.Request.Method,
        context.Request.Path,
        appName
    );

    await next();

    logger.LogInformation(
        "Request completed: {Method} {Path} with status code {StatusCode}",
        context.Request.Method,
        context.Request.Path,
        context.Response.StatusCode
    );
});

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.MapGet("/", () => $"{appName} is running successfully.");

app.Run();