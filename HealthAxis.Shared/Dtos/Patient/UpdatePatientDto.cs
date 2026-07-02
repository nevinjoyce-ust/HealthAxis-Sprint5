using HealthAxis.Shared.Validation;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace HealthAxis.Shared.Dtos.Patient;

public class UpdatePatientDto
{
    [Required(ErrorMessage = "Full name is required.")]
    [StringLength(100, ErrorMessage = "Full name cannot be more than 100 characters.")]
    [FullName]
    public string FullName { get; set; } = string.Empty;

    [Required(ErrorMessage = "Email is required.")]
    [EmailAddress(ErrorMessage = "Please enter a valid email address.")]
    [StringLength(256, ErrorMessage = "Email cannot be more than 256 characters.")]
    public string Email { get; set; } = string.Empty;

    [JsonRequired]
    [Required(ErrorMessage = "Date of birth is required.")]
    [DateOfBirth]
    public DateOnly DateOfBirth { get; set; }

    [Required(ErrorMessage = "Gender is required.")]
    [StringLength(20, ErrorMessage = "Gender cannot be more than 20 characters.")]
    public string Gender { get; set; } = string.Empty;

    [Required(ErrorMessage = "Phone number is required.")]
    [RegularExpression(@"^[6-9]\d{9}$", ErrorMessage = "Phone number must be a valid 10-digit number.")]
    public string PhoneNumber { get; set; } = string.Empty;

    [Required(ErrorMessage = "Address is required.")]
    [StringLength(250, ErrorMessage = "Address cannot be more than 250 characters.")]
    public string Address { get; set; } = string.Empty;
}