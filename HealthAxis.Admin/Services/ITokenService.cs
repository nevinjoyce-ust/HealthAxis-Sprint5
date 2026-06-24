namespace HealthAxis.Admin.Services;

public interface ITokenService
{
    Task SetAccessTokenAsync(string token);
    Task<string?> GetAccessTokenAsync();
    Task RemoveAccessTokenAsync();

    // Refresh token support is intentionally paused for now.
    // These methods are kept commented so refresh support can be restored later if needed.
    // Task SetRefreshTokenAsync(string token);
    // Task<string?> GetRefreshTokenAsync();
    // Task RemoveRefreshTokenAsync();

    Task ClearTokensAsync();
}
