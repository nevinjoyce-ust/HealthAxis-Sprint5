using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace HealthAxis.Shared.Dtos.Auth;

public class RegisterDto
{
    [Required]
    [StringLength(100)]
    public string FullName { get; set; } = string.Empty;

    [Required]
    [EmailAddress]
    [StringLength(150)]
    public string Email { get; set; } = string.Empty;

    [Required]
    [Phone(ErrorMessage = "Please enter a valid phone number.")]
    [StringLength(20)]
    public string PhoneNumber { get; set; } = string.Empty;

    [Required]
    [StringLength(100, MinimumLength = 8)]
    public string Password { get; set; } = string.Empty;

    [Required]
    [Compare(nameof(Password), ErrorMessage = "Passwords do not match.")]
    public string ConfirmPassword { get; set; } = string.Empty;


    [JsonRequired]
    [Required]
    public DateOnly DateOfBirth { get; set; }

    [Required]
    [StringLength(20)]
    public string Gender { get; set; } = string.Empty;

    [Required]
    [StringLength(250)]
    public string Address { get; set; } = string.Empty;
}
