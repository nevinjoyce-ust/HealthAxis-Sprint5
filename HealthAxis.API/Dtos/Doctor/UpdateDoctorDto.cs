using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;
using HealthAxis.API.Enums;
using HealthAxis.API.Validation;

namespace HealthAxis.API.Dtos;

public class UpdateDoctorDto
{
    [Required]
    [StringLength(100)]
    public string FullName { get; set; } = string.Empty;

    [JsonRequired]
    [Required]
    public DoctorSpecialisation Specialisation { get; set; }

    [JsonRequired]
    [Required]
    [PracticeStartDate(70)]
    public DateOnly PracticeStartDate { get; set; }

    [JsonRequired]
    [Range(0, 999999)]
    public decimal ConsultationFee { get; set; }
}
