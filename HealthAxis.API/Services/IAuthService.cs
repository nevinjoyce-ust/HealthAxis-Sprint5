using HealthAxis.API.Dtos.Auth;

namespace HealthAxis.API.Services;

public interface IAuthService
{
    Task<(bool Success, string Message, string UserId)> RegisterAsync(RegisterDto request);

    Task<(bool Success, string Message, AuthResponseDto? Response)> LoginAsync(LoginDto request);

    Task<(bool Success, string Message, AuthResponseDto? Response)> RefreshTokenAsync(RefreshTokenRequestDto request);
}
