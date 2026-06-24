using System.Text.Json.Serialization;

namespace HealthAxis.Shared.Dtos.Doctor;

public class UpdateDoctorAvailabilityDto
{
    [JsonRequired]
    public bool IsAvailable { get; set; }
}
