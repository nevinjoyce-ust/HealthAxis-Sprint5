using System.Net;
using System.Net.Http.Json;
using HealthAxis.Admin.Models;

namespace HealthAxis.Admin.Services.Impl;

public class AuthService : IAuthService
{
    private readonly HttpClient _httpClient;
    private readonly ITokenService _tokenService;

    public AuthService(HttpClient httpClient, ITokenService tokenService)
    {
        _httpClient = httpClient;
        _tokenService = tokenService;
    }

    public async Task<AuthResponse?> LoginAsync(LoginRequest request)
    {
        var response = await _httpClient.PostAsJsonAsync("api/auth/login", request);

        if (response.StatusCode is HttpStatusCode.Unauthorized or HttpStatusCode.Forbidden)
        {
            return null;
        }

        if (!response.IsSuccessStatusCode)
        {
            return null;
        }

        var authResponse = await response.Content.ReadFromJsonAsync<AuthResponse>();

        if (authResponse is null)
        {
            return null;
        }

        if (!string.Equals(authResponse.Role, "Admin", StringComparison.OrdinalIgnoreCase))
        {
            await _tokenService.ClearTokensAsync();
            return null;
        }

        await _tokenService.SetAccessTokenAsync(authResponse.AccessToken);
        await _tokenService.SetRefreshTokenAsync(authResponse.RefreshToken);

        return authResponse;
    }

    public async Task LogoutAsync()
    {
        await _tokenService.ClearTokensAsync();
    }
}
