using System.ComponentModel.DataAnnotations;
using HealthAxis.API.Enums;
using HealthAxis.API.Validation;

namespace HealthAxis.API.Dtos;

public class UpdateDoctorDto
{
    [Required]
    [StringLength(100)]
    public string FullName { get; set; } = string.Empty;

    [Required]
    public DoctorSpecialisation Specialisation { get; set; }

    [Required]
    [PracticeStartDate(70)]
    public DateOnly PracticeStartDate { get; set; }

    [Range(0, 999999)]
    public decimal ConsultationFee { get; set; }

    public bool IsAvailable { get; set; }
}