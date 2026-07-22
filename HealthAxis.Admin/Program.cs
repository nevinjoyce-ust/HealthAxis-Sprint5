using HealthAxis.Admin;
using HealthAxis.Admin.Auth;
using HealthAxis.Admin.Constants;
using HealthAxis.Admin.Services;
using HealthAxis.Admin.Services.Impl;
using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.AspNetCore.Components.Web;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;

var builder = WebAssemblyHostBuilder.CreateDefault(args);

builder.RootComponents.Add<App>("#app");
builder.RootComponents.Add<HeadOutlet>("head::after");

var apiBaseUrl = builder.Configuration["ApiBaseUrl"];

if (string.IsNullOrWhiteSpace(apiBaseUrl))
{
    throw new InvalidOperationException(
        "ApiBaseUrl is missing from wwwroot/appsettings.json.");
}

var angularLoginUrl = builder.Configuration["AngularLoginUrl"];

if (string.IsNullOrWhiteSpace(angularLoginUrl))
{
    throw new InvalidOperationException(
        "AngularLoginUrl is missing from wwwroot/appsettings.json.");
}

var applicationOrigin = new Uri(
    new Uri(builder.HostEnvironment.BaseAddress),
    apiBaseUrl);

builder.Services.AddSingleton(new AppUrls
{
    AngularLoginUrl = angularLoginUrl
});

builder.Services.AddTransient<AuthTokenHandler>();

builder.Services
    .AddHttpClient("Api", client =>
    {
        client.BaseAddress = applicationOrigin;
    })
    .AddHttpMessageHandler<AuthTokenHandler>();

builder.Services.AddScoped(serviceProvider =>
    serviceProvider
        .GetRequiredService<IHttpClientFactory>()
        .CreateClient("Api"));

builder.Services.AddAuthorizationCore();

builder.Services.AddScoped<ITokenService, TokenService>();
builder.Services.AddScoped<CustomAuthenticationStateProvider>();
builder.Services.AddScoped<AuthenticationStateProvider>(serviceProvider =>
    serviceProvider.GetRequiredService<CustomAuthenticationStateProvider>());
builder.Services.AddScoped<IAuthService, AuthService>();
builder.Services.AddScoped<IDoctorAdminService, DoctorAdminService>();
builder.Services.AddScoped<IAdminReportService, AdminReportService>();
builder.Services.AddScoped<IAdminPatientService, AdminPatientService>();
builder.Services.AddScoped<IAdminDashboardService, AdminDashboardService>();

await builder.Build().RunAsync();
