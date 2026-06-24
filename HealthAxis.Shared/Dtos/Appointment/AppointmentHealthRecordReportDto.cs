using HealthAxis.Shared.Enums;

namespace HealthAxis.Shared.Dtos.Appointment;

public class AppointmentHealthRecordReportDto
{
    public int AppointmentId { get; set; }

    public int PatientId { get; set; }

    public int DoctorId { get; set; }

    public string PatientName { get; set; } = string.Empty;

    public string DoctorName { get; set; } = string.Empty;

    public DateOnly AppointmentDate { get; set; }

    public TimeOnly AppointmentTime { get; set; }

    public AppointmentStatus AppointmentStatus { get; set; }

    public bool HasHealthRecord { get; set; }

    public int? HealthRecordId { get; set; }

    public DateOnly? HealthRecordVisitDate { get; set; }
}
