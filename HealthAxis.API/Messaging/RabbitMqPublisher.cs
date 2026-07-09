using HealthAxis.API.Events;
using MassTransit;

namespace HealthAxis.API.Messaging;

public class RabbitMqPublisher : IRabbitMqPublisher
{
    private readonly IPublishEndpoint _publishEndpoint;

    public RabbitMqPublisher(IPublishEndpoint publishEndpoint)
    {
        _publishEndpoint = publishEndpoint;
    }

    public Task PublishAppointmentBookedAsync(AppointmentBookedEvent appointmentEvent)
    {
        return _publishEndpoint.Publish(appointmentEvent);
    }
}