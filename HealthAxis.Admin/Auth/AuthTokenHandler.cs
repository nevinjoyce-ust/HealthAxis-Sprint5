using HealthAxis.Admin.Constants;
using HealthAxis.Admin.Services;
using Microsoft.AspNetCore.Components;
using System.Net;
using System.Net.Http.Headers;

namespace HealthAxis.Admin.Auth;

public class AuthTokenHandler : DelegatingHandler
{
    private readonly ITokenService _tokenService;
    private readonly CustomAuthenticationStateProvider _authStateProvider;
    private readonly NavigationManager _navigationManager;

    public AuthTokenHandler(
        ITokenService tokenService,
        CustomAuthenticationStateProvider authStateProvider,
        NavigationManager navigationManager)
    {
        _tokenService = tokenService;
        _authStateProvider = authStateProvider;
        _navigationManager = navigationManager;
    }

    protected override async Task<HttpResponseMessage> SendAsync(
        HttpRequestMessage request,
        CancellationToken cancellationToken)
    {
        var token = await _tokenService.GetAccessTokenAsync();

        if (!string.IsNullOrWhiteSpace(token))
        {
            request.Headers.Authorization =
                new AuthenticationHeaderValue("Bearer", token);
        }

        var response = await base.SendAsync(request, cancellationToken);

        if (ShouldHandleSessionExpiredResponse(request, response, token))
        {
            await _tokenService.ClearTokensAsync();
            _authStateProvider.NotifyUserLoggedOut();
            _navigationManager.NavigateTo(
                $"{AppUrls.AngularLoginUrl}?reason=session-expired",
                forceLoad: true);
        }

        return response;
    }

    private static bool ShouldHandleSessionExpiredResponse(
        HttpRequestMessage request,
        HttpResponseMessage response,
        string? token)
    {
        if (response.StatusCode != HttpStatusCode.Unauthorized)
        {
            return false;
        }

        if (string.IsNullOrWhiteSpace(token))
        {
            return false;
        }

        var path = request.RequestUri?.AbsolutePath ?? string.Empty;

        return !path.Contains("/api/auth/login", StringComparison.OrdinalIgnoreCase) &&
               !path.Contains("/api/auth/register", StringComparison.OrdinalIgnoreCase);
    }
}
