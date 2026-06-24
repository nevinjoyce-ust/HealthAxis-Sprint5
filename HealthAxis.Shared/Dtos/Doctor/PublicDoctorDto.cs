using HealthAxis.Shared.Enums;

namespace HealthAxis.Shared.Dtos.Doctor;

public class PublicDoctorDto
{
    public int Id { get; set; }

    public string FullName { get; set; } = string.Empty;

    public DoctorSpecialisation Specialisation { get; set; }

    public int YearsOfExperience { get; set; }

    public decimal ConsultationFee { get; set; }

    public bool IsAvailable { get; set; }
}
