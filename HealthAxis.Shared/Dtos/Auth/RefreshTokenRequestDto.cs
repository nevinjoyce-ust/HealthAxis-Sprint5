using System.ComponentModel.DataAnnotations;

namespace HealthAxis.Shared.Dtos.Auth;

public class RefreshTokenRequestDto
{
    [Required]
    public string UserId { get; set; } = string.Empty;

    [Required]
    public string RefreshToken { get; set; } = string.Empty;
}
