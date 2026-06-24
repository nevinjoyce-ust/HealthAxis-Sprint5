using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;
using HealthAxis.Shared.Enums;

namespace HealthAxis.Shared.Dtos.Appointment;

public class UpdateAppointmentStatusDto
{
    [JsonRequired]
    [Required]
    public AppointmentStatus Status { get; set; }

    [StringLength(250)]
    public string? CancellationReason { get; set; }
}
