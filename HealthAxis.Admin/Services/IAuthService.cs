using HealthAxis.Admin.Models;

namespace HealthAxis.Admin.Services;

public interface IAuthService
{
    Task<AuthResponse?> LoginAsync(LoginRequest request);
    Task LogoutAsync();
}
