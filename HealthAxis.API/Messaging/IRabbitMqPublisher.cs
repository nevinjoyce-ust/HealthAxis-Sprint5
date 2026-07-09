using HealthAxis.API.Events;

namespace HealthAxis.API.Messaging;

public interface IRabbitMqPublisher
{
    Task PublishAppointmentBookedAsync(AppointmentBookedEvent appointmentEvent);
}