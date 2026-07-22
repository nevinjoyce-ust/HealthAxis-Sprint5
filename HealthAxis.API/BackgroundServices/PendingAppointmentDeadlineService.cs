using HealthAxis.API.Constants;
using HealthAxis.API.Repositories;
using HealthAxis.Shared.Enums;

namespace HealthAxis.API.BackgroundServices;

public class PendingAppointmentDeadlineService(
    IServiceScopeFactory scopeFactory,
    ILogger<PendingAppointmentDeadlineService> logger) : BackgroundService
{
    private const int ConfirmationDeadlineHours = 24;
    private static readonly TimeSpan CheckInterval = TimeSpan.FromMinutes(30);

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        logger.LogInformation("PendingAppointmentDeadlineService started.");

        await CancelExpiredPendingAppointmentsAsync(stoppingToken);

        var initialDelay = GetDelayUntilNextHalfHour();

        logger.LogDebug(
            "Next pending appointment deadline check scheduled in {InitialDelay}.",
            initialDelay);

        await Task.Delay(initialDelay, stoppingToken);

        using var timer = new PeriodicTimer(CheckInterval);

        do
        {
            await CancelExpiredPendingAppointmentsAsync(stoppingToken);
        }
        while (await timer.WaitForNextTickAsync(stoppingToken));
    }

    private async Task CancelExpiredPendingAppointmentsAsync(
        CancellationToken stoppingToken)
    {
        try
        {
            await using var scope = scopeFactory.CreateAsyncScope();
            var repository = scope.ServiceProvider
                .GetRequiredService<IAppointmentRepository>();

            var cutoff = DateTime.Now.AddHours(ConfirmationDeadlineHours);
            var appointments = await repository
                .GetExpiredPendingAppointmentsAsync(cutoff);

            if (appointments.Count == 0)
            {
                logger.LogDebug(
                    "Pending appointment deadline check completed. No appointments required cancellation.");
                return;
            }

            foreach (var appointment in appointments)
            {
                appointment.Status = AppointmentStatus.Cancelled;
                appointment.CancellationReason =
                    ErrorMessages.PendingAppointmentAutoCancelledReason;
            }

            await repository.UpdateRangeAsync(appointments);

            logger.LogInformation(
                "Automatically cancelled {AppointmentCount} pending appointments after their confirmation deadline passed.",
                appointments.Count);
        }
        catch (OperationCanceledException exception)
            when (stoppingToken.IsCancellationRequested)
        {
            logger.LogDebug(
                exception,
                "Pending appointment deadline check cancelled during shutdown.");
        }
        catch (Exception exception)
        {
            logger.LogError(
                exception,
                "Pending appointment deadline check failed.");
        }
    }

    private static TimeSpan GetDelayUntilNextHalfHour()
    {
        var now = DateTime.Now;
        var nextRun = now.Minute < 30
            ? new DateTime(
                now.Year,
                now.Month,
                now.Day,
                now.Hour,
                30,
                0,
                now.Kind)
            : new DateTime(
                now.Year,
                now.Month,
                now.Day,
                now.Hour,
                0,
                0,
                now.Kind).AddHours(1);

        return nextRun - now;
    }

    public override Task StopAsync(CancellationToken cancellationToken)
    {
        logger.LogInformation("PendingAppointmentDeadlineService stopping.");
        return base.StopAsync(cancellationToken);
    }
}
