using HealthAxis.API.Data;
using HealthAxis.API.Models;
using Microsoft.EntityFrameworkCore;

namespace HealthAxis.API.Repositories.Impl;

public class NotificationRepository(HealthAxisDbContext context)
    : Repository<Notification>(context), INotificationRepository
{
    public async Task<List<Notification>> GetUnreadByRecipientUserIdAsync(string recipientUserId)
    {
        return await _context.Notifications
            .Where(notification =>
                notification.RecipientUserId == recipientUserId &&
                !notification.IsRead)
            .OrderByDescending(notification => notification.CreatedAtUtc)
            .ToListAsync();
    }
}