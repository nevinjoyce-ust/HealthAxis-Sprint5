namespace HealthAxis.Shared.Dtos.Doctor;

public class DoctorAvailabilityDto
{
    public int DoctorId { get; set; }

    public bool IsAvailable { get; set; }

    public string Message { get; set; } = string.Empty;
}
