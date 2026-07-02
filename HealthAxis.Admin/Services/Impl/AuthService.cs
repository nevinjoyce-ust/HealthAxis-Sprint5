using System.Net;
using System.Net.Http.Json;
using HealthAxis.Admin.Auth;
using HealthAxis.Shared.Dtos.Auth;

namespace HealthAxis.Admin.Services.Impl;

public class AuthService : IAuthService
{
    private readonly HttpClient _httpClient;
    private readonly ITokenService _tokenService;
    private readonly CustomAuthenticationStateProvider _authStateProvider;

    public AuthService(
        HttpClient httpClient,
        ITokenService tokenService,
        CustomAuthenticationStateProvider authStateProvider)
    {
        _httpClient = httpClient;
        _tokenService = tokenService;
        _authStateProvider = authStateProvider;
    }

    public async Task<(AuthResponseDto? Response, string? ErrorMessage)> LoginAsync(LoginDto request)
    {
        var response = await _httpClient.PostAsJsonAsync("api/auth/login", request);

        if (response.StatusCode is HttpStatusCode.Unauthorized or HttpStatusCode.Forbidden)
        {
            return (null, "Invalid credentials.");
        }

        if (!response.IsSuccessStatusCode)
        {
            return (null, "Unable to sign in. Please try again.");
        }

        var authResponse = await response.Content.ReadFromJsonAsync<AuthResponseDto>();

        if (authResponse is null)
        {
            return (null, "Unable to sign in. Please try again.");
        }

        if (!string.Equals(authResponse.Role, "Admin", StringComparison.OrdinalIgnoreCase))
        {
            await _tokenService.ClearTokensAsync();
            _authStateProvider.NotifyUserLoggedOut();
            return (null, "Invalid credentials.");
        }

        await _tokenService.SetAccessTokenAsync(authResponse.AccessToken);

        // Refresh token support is intentionally paused for now.
        // await _tokenService.SetRefreshTokenAsync(authResponse.RefreshToken);

        _authStateProvider.NotifyUserLoggedIn(authResponse.AccessToken);

        return (authResponse, null);
    }

    public async Task<string?> ChangePasswordAsync(ChangePasswordDto request)
    {
        var response = await _httpClient.PutAsJsonAsync("api/auth/change-password", request);

        var result = await ApiResponseHandler.ReadMessageResponseAsync(
            response,
            "Unable to change password.",
            "Password changed successfully.");

        return result.IsSuccess
            ? result.Data
            : result.ErrorMessage;
    }

    public async Task LogoutAsync()
    {
        await _tokenService.ClearTokensAsync();
        _authStateProvider.NotifyUserLoggedOut();
    }

    private sealed class AuthMessageResponse
    {
        public string Message { get; set; } = string.Empty;
    }
}
