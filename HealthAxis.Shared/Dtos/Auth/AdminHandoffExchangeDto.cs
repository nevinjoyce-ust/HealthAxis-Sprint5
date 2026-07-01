using System.ComponentModel.DataAnnotations;

namespace HealthAxis.Shared.Dtos.Auth;

public class AdminHandoffExchangeDto
{
    [Required]
    public string Code { get; set; } = string.Empty;
}