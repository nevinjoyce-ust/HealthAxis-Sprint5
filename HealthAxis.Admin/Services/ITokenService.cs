namespace HealthAxis.Admin.Services;

public interface ITokenService
{
    Task SetAccessTokenAsync(string token);
    Task<string?> GetAccessTokenAsync();
    Task RemoveAccessTokenAsync();
    Task ClearTokensAsync();
}
