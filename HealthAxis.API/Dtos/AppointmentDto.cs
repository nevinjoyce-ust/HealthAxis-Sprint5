using HealthAxis.API.Enums;

namespace HealthAxis.API.Dtos;

public class AppointmentDto
{
    public int Id { get; set; }

    public int PatientId { get; set; }

    public int DoctorId { get; set; }

    public string PatientName { get; set; } = string.Empty;

    public string DoctorName { get; set; } = string.Empty;

    public DateOnly AppointmentDate { get; set; }

    public TimeOnly AppointmentTime { get; set; }

    public AppointmentStatus Status { get; set; }

    public string? CancellationReason { get; set; }

    public DateTime CreatedAt { get; set; }
}