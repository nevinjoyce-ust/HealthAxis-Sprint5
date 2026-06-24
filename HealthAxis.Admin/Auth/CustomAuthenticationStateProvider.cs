using HealthAxis.Admin.Services;
using HealthAxis.Shared.Constants;
using Microsoft.AspNetCore.Components.Authorization;
using System.Security.Claims;
using System.Text.Json;

namespace HealthAxis.Admin.Auth;

public class CustomAuthenticationStateProvider : AuthenticationStateProvider
{
    private readonly ITokenService _tokenService;

    private ClaimsPrincipal _currentUser = new(new ClaimsIdentity());

    public CustomAuthenticationStateProvider(ITokenService tokenService)
    {
        _tokenService = tokenService;
    }

    public override async Task<AuthenticationState> GetAuthenticationStateAsync()
    {
        if (_currentUser.Identity?.IsAuthenticated == true)
        {
            return new AuthenticationState(_currentUser);
        }

        var token = await _tokenService.GetAccessTokenAsync();

        if (string.IsNullOrWhiteSpace(token))
        {
            return new AuthenticationState(new ClaimsPrincipal(new ClaimsIdentity()));
        }

        var claims = ParseClaimsFromJwt(token);
        var identity = new ClaimsIdentity(claims, "jwt");
        _currentUser = new ClaimsPrincipal(identity);

        return new AuthenticationState(_currentUser);
    }

    public void NotifyUserLoggedIn(string token)
    {
        var claims = ParseClaimsFromJwt(token);
        var identity = new ClaimsIdentity(claims, "jwt");
        _currentUser = new ClaimsPrincipal(identity);

        NotifyAuthenticationStateChanged(Task.FromResult(new AuthenticationState(_currentUser)));
    }

    public void NotifyUserLoggedOut()
    {
        _currentUser = new ClaimsPrincipal(new ClaimsIdentity());
        NotifyAuthenticationStateChanged(Task.FromResult(new AuthenticationState(_currentUser)));
    }

    private static IEnumerable<Claim> ParseClaimsFromJwt(string jwt)
    {
        var claims = new List<Claim>();
        var parts = jwt.Split('.');

        if (parts.Length < 2)
        {
            return claims;
        }

        var payload = parts[1];

        switch (payload.Length % 4)
        {
            case 2:
                payload += "==";
                break;
            case 3:
                payload += "=";
                break;
        }

        var jsonBytes = Convert.FromBase64String(payload);
        var keyValuePairs = JsonSerializer.Deserialize<Dictionary<string, JsonElement>>(jsonBytes);

        if (keyValuePairs is null)
        {
            return claims;
        }

        foreach (var kvp in keyValuePairs)
        {
            if (kvp.Value.ValueKind == JsonValueKind.Array)
            {
                foreach (var element in kvp.Value.EnumerateArray())
                {
                    AddClaimWithRoleNormalization(claims, kvp.Key, element.ToString());
                }
            }
            else
            {
                AddClaimWithRoleNormalization(claims, kvp.Key, kvp.Value.ToString());
            }
        }

        return claims;
    }

    private static void AddClaimWithRoleNormalization(List<Claim> claims, string claimType, string claimValue)
    {
        claims.Add(new Claim(claimType, claimValue));

        if (IsRoleClaim(claimType) && claimType != ClaimTypes.Role)
        {
            claims.Add(new Claim(ClaimTypes.Role, claimValue));
        }
    }

    private static bool IsRoleClaim(string claimType)
    {
        return string.Equals(claimType, AppClaimTypes.Role, StringComparison.OrdinalIgnoreCase)
            || string.Equals(claimType, "role", StringComparison.OrdinalIgnoreCase)
            || string.Equals(claimType, ClaimTypes.Role, StringComparison.OrdinalIgnoreCase)
            || claimType.EndsWith("/role", StringComparison.OrdinalIgnoreCase);
    }
}
