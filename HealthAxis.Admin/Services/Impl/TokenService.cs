using Microsoft.JSInterop;

namespace HealthAxis.Admin.Services.Impl;

public class TokenService : ITokenService
{
    private const string AccessTokenKey = "healthAxisAdminAccessToken";

    private readonly IJSRuntime _jsRuntime;

    public TokenService(IJSRuntime jsRuntime)
    {
        _jsRuntime = jsRuntime;
    }

    public async Task SetAccessTokenAsync(string token)
    {
        await _jsRuntime.InvokeVoidAsync(
            "localStorage.setItem",
            AccessTokenKey,
            token);
    }

    public async Task<string?> GetAccessTokenAsync()
    {
        return await _jsRuntime.InvokeAsync<string?>(
            "localStorage.getItem",
            AccessTokenKey);
    }

    public async Task RemoveAccessTokenAsync()
    {
        await _jsRuntime.InvokeVoidAsync(
            "localStorage.removeItem",
            AccessTokenKey);
    }

    public async Task ClearTokensAsync()
    {
        await RemoveAccessTokenAsync();
    }
}
