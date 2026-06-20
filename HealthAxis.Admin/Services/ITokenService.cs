namespace HealthAxis.Admin.Services;

public interface ITokenService
{
    Task SetAccessTokenAsync(string token);
    Task<string?> GetAccessTokenAsync();
    Task RemoveAccessTokenAsync();

    Task SetRefreshTokenAsync(string token);
    Task<string?> GetRefreshTokenAsync();
    Task RemoveRefreshTokenAsync();

    Task ClearTokensAsync();
}
