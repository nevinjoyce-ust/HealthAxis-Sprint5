using System.ComponentModel.DataAnnotations;
using HealthAxis.API.Enums;
using HealthAxis.API.Validation;

namespace HealthAxis.API.Dtos;

public class CreateDoctorDto
{
    [Required]
    [StringLength(100)]
    public string FullName { get; set; } = string.Empty;

    [Required]
    [EmailAddress]
    [StringLength(150)]
    public string Email { get; set; } = string.Empty;

    [Required]
    [StringLength(100)]
    public string Password { get; set; } = string.Empty;

    [Required]
    public DoctorSpecialisation Specialisation { get; set; }

    [Required]
    [PracticeStartDate(70)]
    public DateOnly PracticeStartDate { get; set; }

    [Range(0, 999999)]
    public decimal ConsultationFee { get; set; }

    public bool IsAvailable { get; set; } = true;
}