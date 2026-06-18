using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace HealthAxis.API.Dtos;

public class CreateHealthRecordDto
{
    [JsonRequired]
    [Required]
    public int AppointmentId { get; set; }

    [JsonRequired]
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
