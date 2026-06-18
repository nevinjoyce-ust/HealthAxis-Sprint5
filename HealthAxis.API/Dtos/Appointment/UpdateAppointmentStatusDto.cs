using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;
using HealthAxis.API.Enums;

namespace HealthAxis.API.Dtos;

public class UpdateAppointmentStatusDto
{
    [JsonRequired]
    [Required]
    public AppointmentStatus Status { get; set; }

    [StringLength(250)]
    public string? CancellationReason { get; set; }
}
