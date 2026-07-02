using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HealthAxis.API.Models;

public class HealthRecord
{
    [Key]
    public int Id { get; set; }

    [Required]
    public int AppointmentId { get; set; }

    [Required]
    public int PatientAge { get; set; }

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

    [ForeignKey(nameof(AppointmentId))]
    public Appointment? Appointment { get; set; }
}
