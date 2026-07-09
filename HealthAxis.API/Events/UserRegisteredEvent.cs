namespace HealthAxis.API.Events;

public class UserRegisteredEvent
{
    public string UserType { get; set; } = string.Empty;

    public int ReferenceId { get; set; }

    public string UserId { get; set; } = string.Empty;

    public string Email { get; set; } = string.Empty;

    public DateTime RegisteredAtUtc { get; set; }
}