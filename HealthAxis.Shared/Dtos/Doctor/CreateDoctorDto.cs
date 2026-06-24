using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;
using HealthAxis.Shared.Enums;
using HealthAxis.Shared.Validation;

namespace HealthAxis.Shared.Dtos.Doctor;

public class CreateDoctorDto
{
    [Required(ErrorMessage = "Full name is required.")]
    [StringLength(100, ErrorMessage = "Full name cannot be more than 100 characters.")]
    [FullName]
    public string FullName { get; set; } = string.Empty;

    [Required(ErrorMessage = "Email is required.")]
    [EmailAddress(ErrorMessage = "Email must be a valid email address.")]
    [StringLength(256, ErrorMessage = "Email cannot be more than 256 characters.")]
    public string Email { get; set; } = string.Empty;

    [Required(ErrorMessage = "Phone number is required.")]
    [Phone(ErrorMessage = "Please enter a valid phone number.")]
    public string PhoneNumber { get; set; } = string.Empty;

    [Required(ErrorMessage = "Password is required.")]
    [StringLength(100, MinimumLength = 8, ErrorMessage = "Password must be between 8 and 100 characters.")]
    public string Password { get; set; } = string.Empty;

    [JsonRequired]
    [Required]
    public DoctorSpecialisation Specialisation { get; set; }

    [JsonRequired]
    [Required]
    [PracticeStartDate(70)]
    public DateOnly PracticeStartDate { get; set; }

    [JsonRequired]
    [Range(0, 999999, ErrorMessage = "Consultation fee must be between 0 and 999999.")]
    public decimal ConsultationFee { get; set; }

    [JsonRequired]
    public bool IsAvailable { get; set; } = true;
}
