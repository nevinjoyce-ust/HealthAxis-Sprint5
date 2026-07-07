using HealthAxis.API.Data;
using Microsoft.EntityFrameworkCore;

namespace HealthAxis.API.BackgroundServices;

public class NotificationCleanupService(
    IServiceScopeFactory scopeFactory,
    ILogger<NotificationCleanupService> logger) : BackgroundService
{
    private static readonly TimeSpan CleanupInterval = TimeSpan.FromHours(1);
    private static readonly TimeSpan RetentionPeriod = TimeSpan.FromDays(30);

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        logger.LogInformation("NotificationCleanupService started.");

        await RunCleanupAsync(stoppingToken);

        using var timer = new PeriodicTimer(CleanupInterval);

        while (await timer.WaitForNextTickAsync(stoppingToken))
        {
            await RunCleanupAsync(stoppingToken);
        }
    }

    private async Task RunCleanupAsync(CancellationToken stoppingToken)
    {
        try
        {
            await using var scope = scopeFactory.CreateAsyncScope();
            var context = scope.ServiceProvider.GetRequiredService<HealthAxisDbContext>();

            var cutoffDateUtc = DateTime.UtcNow.Subtract(RetentionPeriod);

            var oldNotifications = await context.Notifications
                .Where(notification => notification.CreatedAtUtc < cutoffDateUtc)
                .ToListAsync(stoppingToken);

            if (oldNotifications.Count == 0)
            {
                logger.LogInformation("Notification cleanup completed. No old notifications found.");
                return;
            }

            context.Notifications.RemoveRange(oldNotifications);
            await context.SaveChangesAsync(stoppingToken);

            logger.LogInformation(
                "Notification cleanup completed. Deleted {NotificationCount} old notifications.",
                oldNotifications.Count);
        }
        catch (OperationCanceledException) when (stoppingToken.IsCancellationRequested)
        {
            logger.LogInformation("Notification cleanup cancelled during shutdown.");
        }
        catch (Exception exception)
        {
            logger.LogError(exception, "Notification cleanup failed.");
        }
    }

    public override Task StopAsync(CancellationToken cancellationToken)
    {
        logger.LogInformation("NotificationCleanupService stopping.");

        return base.StopAsync(cancellationToken);
    }
}