using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;
using HealthAxis.API.Enums;

namespace HealthAxis.API.Dtos;

public class CreateDoctorDto
{
    [Required]
    [StringLength(100)]
    public string FullName { get; set; } = string.Empty;

    [Required]
    [EmailAddress]
    [StringLength(256)]
    public string Email { get; set; } = string.Empty;

    [Required]
    [Phone]
    [StringLength(20)]
    public string PhoneNumber { get; set; } = string.Empty;

    [Required]
    [StringLength(100)]
    public string Password { get; set; } = string.Empty;

    [JsonRequired]
    [Required]
    public DoctorSpecialisation Specialisation { get; set; }

    [JsonRequired]
    [Required]
    public DateOnly PracticeStartDate { get; set; }

    [JsonRequired]
    [Range(0, 999999)]
    public decimal ConsultationFee { get; set; }

    [JsonRequired]
    public bool IsAvailable { get; set; } = true;
}
