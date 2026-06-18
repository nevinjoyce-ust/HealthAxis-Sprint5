using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace HealthAxis.API.Dtos;

public class CreateAppointmentDto
{
    [JsonRequired]
    [Required]
    public int PatientId { get; set; }

    [JsonRequired]
    [Required]
    public int DoctorId { get; set; }

    [JsonRequired]
    [Required]
    public DateOnly AppointmentDate { get; set; }

    [JsonRequired]
    [Required]
    public TimeOnly AppointmentTime { get; set; }
}
