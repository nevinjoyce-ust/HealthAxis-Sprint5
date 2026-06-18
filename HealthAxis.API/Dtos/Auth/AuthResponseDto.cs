namespace HealthAxis.API.Dtos.Auth;

public class AuthResponseDto
{
    public string AccessToken { get; set; } = string.Empty;

    public string RefreshToken { get; set; } = string.Empty;

    public string Message { get; set; } = string.Empty;

    public int ExpiresIn { get; set; }

    public string UserId { get; set; } = string.Empty;

    public int? PatientId { get; set; }

    public int? DoctorId { get; set; }

    public string Email { get; set; } = string.Empty;

    public string Role { get; set; } = string.Empty;
}
