using HealthAxis.Shared.Dtos.Auth;

namespace HealthAxis.API.Services;

public interface IAuthService
{
    Task<(bool Success, string Message, string UserId)> RegisterAsync(RegisterDto request);

    Task<(bool Success, string Message, AuthResponseDto? Response)> LoginAsync(LoginDto request);

    // Refresh token support is intentionally paused for now.
    // Keep RefreshTokenRequestDto and the old implementation notes around so this can be restored later if needed.
    // Task<(bool Success, string Message, AuthResponseDto? Response)> RefreshTokenAsync(RefreshTokenRequestDto request);
}
