namespace HealthAxis.Shared.Dtos.Auth;

public class AdminHandoffCodeResponseDto
{
    public string Code { get; set; } = string.Empty;

    public int ExpiresInSeconds { get; set; }
}