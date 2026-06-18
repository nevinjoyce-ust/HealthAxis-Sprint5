using System.Text.Json.Serialization;

namespace HealthAxis.API.Dtos;

public class UpdateDoctorAvailabilityDto
{
    [JsonRequired]
    public bool IsAvailable { get; set; }
}
