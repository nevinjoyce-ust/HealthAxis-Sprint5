namespace HealthAxis.API.Dtos;

public class DoctorAvailabilityDto
{
    public int DoctorId { get; set; }

    public bool IsAvailable { get; set; }

    public string Message { get; set; } = string.Empty;
}
