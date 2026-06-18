using HealthAxis.API.Enums;

namespace HealthAxis.API.Dtos;

public class DoctorDto
{
    public int Id { get; set; }

    public string UserId { get; set; } = string.Empty;

    public string FullName { get; set; } = string.Empty;

    public string Email { get; set; } = string.Empty;

    public string PhoneNumber { get; set; } = string.Empty;

    public DoctorSpecialisation Specialisation { get; set; }

    public int YearsOfExperience { get; set; }

    public decimal ConsultationFee { get; set; }

    public bool IsAvailable { get; set; }
}
