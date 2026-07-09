namespace HealthAxis.API.Events;

public class AppointmentBookedEvent
{
    public int AppointmentId { get; set; }

    public int PatientId { get; set; }

    public int DoctorId { get; set; }

    public DateOnly ScheduledDate { get; set; }

    public TimeOnly TimeSlot { get; set; }

    public DateTime OccurredAt { get; set; }
}