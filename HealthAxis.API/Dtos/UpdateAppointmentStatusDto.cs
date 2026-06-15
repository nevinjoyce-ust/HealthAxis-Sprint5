using System.ComponentModel.DataAnnotations;
using HealthAxis.API.Enums;

namespace HealthAxis.API.Dtos;

public class UpdateAppointmentStatusDto
{
    [Required]
    public AppointmentStatus Status { get; set; }

    [StringLength(250)]
    public string? CancellationReason { get; set; }
}