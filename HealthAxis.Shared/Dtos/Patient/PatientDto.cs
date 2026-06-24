namespace HealthAxis.Shared.Dtos.Patient;

public class PatientDto
{
    public int Id { get; set; }

    public string UserId { get; set; } = string.Empty;

    public string FullName { get; set; } = string.Empty;

    public string Email { get; set; } = string.Empty;

    public DateOnly DateOfBirth { get; set; }

    public string Gender { get; set; } = string.Empty;

    public string PhoneNumber { get; set; } = string.Empty;

    public string Address { get; set; } = string.Empty;
}
