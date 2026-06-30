using HealthAxis.Shared.Enums;

namespace HealthAxis.Shared.Dtos.Doctor;

public class DoctorAvailableSlotsDto
{
    public int DoctorId { get; set; }

    public string DoctorName { get; set; } = string.Empty;

    public DoctorSpecialisation Specialisation { get; set; }

    public int YearsOfExperience { get; set; }

    public decimal ConsultationFee { get; set; }

    public bool IsAvailable { get; set; }

    public List<TimeOnly> AvailableSlots { get; set; } = [];
}
