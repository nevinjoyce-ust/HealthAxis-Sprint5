using HealthAxis.Shared.Dtos.Auth;

namespace HealthAxis.Admin.Services;

public interface IAuthService
{
    Task<(AuthResponseDto? Response, string? ErrorMessage)> LoginAsync(LoginDto request);

    Task<string?> ChangePasswordAsync(ChangePasswordDto request);

    Task LogoutAsync();
}
