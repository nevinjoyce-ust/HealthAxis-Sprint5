using Microsoft.AspNetCore.Identity;

namespace HealthAxis.API.Models;

public class Notification
{
    public int Id { get; set; }

    public string RecipientUserId { get; set; } = string.Empty;

    public IdentityUser? RecipientUser { get; set; }

    public string Title { get; set; } = string.Empty;

    public string Message { get; set; } = string.Empty;

    public string NotificationType { get; set; } = string.Empty;

    public bool IsRead { get; set; }

    public DateTime CreatedAtUtc { get; set; } = DateTime.UtcNow;

    public DateTime? ReadAtUtc { get; set; }

    public string? RelatedEntityType { get; set; }

    public int? RelatedEntityId { get; set; }
}