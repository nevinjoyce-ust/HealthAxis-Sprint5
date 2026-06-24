using HealthAxis.Shared.Enums;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HealthAxis.API.Models;

public class Appointment
{
    [Key]
    public int Id { get; set; }

    [Required]
    public int PatientId { get; set; }

    [Required]
    public int DoctorId { get; set; }

    [Required]
    public DateOnly AppointmentDate { get; set; }

    [Required]
    public TimeOnly AppointmentTime { get; set; }

    [Required]
    [StringLength(30)]
    public AppointmentStatus Status { get; set; } = AppointmentStatus.Pending;

    [StringLength(250)]
    public string? CancellationReason { get; set; }

    [ForeignKey(nameof(PatientId))]
    public Patient? Patient { get; set; }

    [ForeignKey(nameof(DoctorId))]
    public Doctor? Doctor { get; set; }

    public HealthRecord? HealthRecord { get; set; }
}
