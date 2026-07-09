using HealthAxis.API.Models;

namespace HealthAxis.API.Repositories;

public interface INotificationRepository : IRepository<Notification>
{
    Task<List<Notification>> GetUnreadByRecipientUserIdAsync(string recipientUserId);
}