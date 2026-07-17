namespace HealthAxis.API.BackgroundServices;

public class HeartbeatService(
    ILogger<HeartbeatService> logger) : BackgroundService
{
    private static readonly TimeSpan HeartbeatInterval = TimeSpan.FromSeconds(10);

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        logger.LogInformation("HeartbeatService started.");

        while (!stoppingToken.IsCancellationRequested)
        {
            if (logger.IsEnabled(LogLevel.Information))
            {
                logger.LogInformation(
                    "HealthAxis heartbeat. TimestampUtc={TimestampUtc}",
                    DateTime.UtcNow);
            }

            await Task.Delay(HeartbeatInterval, stoppingToken);
        }
    }

    public override Task StopAsync(CancellationToken cancellationToken)
    {
        logger.LogInformation("HeartbeatService stopping.");
        return base.StopAsync(cancellationToken);
    }
}
