using System.ComponentModel.DataAnnotations;

namespace HealthAxis.API.Dtos;

public class CreateHealthRecordDto
{
    [Required]
    public int PatientId { get; set; }

    [Required]
    public int DoctorId { get; set; }

    [Required]
    public DateOnly VisitDate { get; set; }

    [Required]
    [StringLength(500)]
    public string Diagnosis { get; set; } = string.Empty;

    [Required]
    [StringLength(500)]
    public string Prescription { get; set; } = string.Empty;

    [StringLength(1000)]
    public string? Notes { get; set; }
}