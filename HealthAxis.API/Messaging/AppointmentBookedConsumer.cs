using HealthAxis.API.Events;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using MassTransit;

namespace HealthAxis.API.Messaging;

public class AppointmentBookedConsumer : IConsumer<AppointmentBookedEvent>
{
    private const string AppointmentBookedNotificationType = "AppointmentBooked";

    private readonly IDoctorRepository _doctorRepository;
    private readonly INotificationRepository _notificationRepository;
    private readonly ILogger<AppointmentBookedConsumer> _logger;

    public AppointmentBookedConsumer(
        IDoctorRepository doctorRepository,
        INotificationRepository notificationRepository,
        ILogger<AppointmentBookedConsumer> logger)
    {
        _doctorRepository = doctorRepository;
        _notificationRepository = notificationRepository;
        _logger = logger;
    }

    public async Task Consume(ConsumeContext<AppointmentBookedEvent> context)
    {
        var appointmentEvent = context.Message;
        var doctor = await _doctorRepository
            .GetDoctorByIdAsync(appointmentEvent.DoctorId);

        if (doctor == null)
        {
            _logger.LogWarning(
                "Appointment booked event could not create a notification because the doctor was not found. AppointmentId={AppointmentId}, DoctorId={DoctorId}",
                appointmentEvent.AppointmentId,
                appointmentEvent.DoctorId);

            return;
        }

        var notification = new Notification
        {
            RecipientUserId = doctor.UserId,
            Title = "New appointment booked",
            Message =
                $"New appointment booked. Appointment ID: {appointmentEvent.AppointmentId}, " +
                $"Patient ID: {appointmentEvent.PatientId}, Date: {appointmentEvent.ScheduledDate}, " +
                $"Time: {appointmentEvent.TimeSlot}.",
            NotificationType = AppointmentBookedNotificationType,
            IsRead = false,
            CreatedAtUtc = DateTime.UtcNow,
            RelatedEntityType = nameof(Appointment),
            RelatedEntityId = appointmentEvent.AppointmentId
        };

        var createdNotification = await _notificationRepository.AddAsync(notification);


        _logger.LogInformation(
            "APPOINTMENT BOOKED | Appointment {AppointmentId} | Patient {PatientId} | Doctor {DoctorId} | {ScheduledDate} at {TimeSlot} | Notification {NotificationId} created",
            appointmentEvent.AppointmentId,
            appointmentEvent.PatientId,
            appointmentEvent.DoctorId,
            appointmentEvent.ScheduledDate,
            appointmentEvent.TimeSlot,
            createdNotification.Id);
    }
}
