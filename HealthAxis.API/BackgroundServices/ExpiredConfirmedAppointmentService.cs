using HealthAxis.API.Constants;
using HealthAxis.API.Repositories;
using HealthAxis.API.Services;
using HealthAxis.Shared.Enums;

namespace HealthAxis.API.BackgroundServices;

public class ExpiredConfirmedAppointmentService(
    IServiceScopeFactory scopeFactory,
    ILogger<ExpiredConfirmedAppointmentService> logger) : BackgroundService
{
    private static readonly TimeSpan CheckInterval = TimeSpan.FromDays(1);

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        logger.LogInformation("ExpiredConfirmedAppointmentService started.");

        await CancelExpiredConfirmedAppointmentsAsync(stoppingToken);

        var initialDelay = GetDelayUntilNextMidnight();

        logger.LogDebug(
            "Next expired confirmed appointment check scheduled in {InitialDelay}.",
            initialDelay);

        await Task.Delay(initialDelay, stoppingToken);

        using var timer = new PeriodicTimer(CheckInterval);

        do
        {
            await CancelExpiredConfirmedAppointmentsAsync(stoppingToken);
        }
        while (await timer.WaitForNextTickAsync(stoppingToken));
    }

    private async Task CancelExpiredConfirmedAppointmentsAsync(
        CancellationToken stoppingToken)
    {
        try
        {
            await using var scope = scopeFactory.CreateAsyncScope();
            var repository = scope.ServiceProvider
                .GetRequiredService<IAppointmentRepository>();
            var cache = scope.ServiceProvider
                .GetRequiredService<IDoctorAvailabilityCacheService>();

            var today = DateOnly.FromDateTime(DateTime.Today);
            var appointments = await repository
                .GetExpiredConfirmedAppointmentsAsync(today);

            if (appointments.Count == 0)
            {
                logger.LogDebug(
                    "Expired confirmed appointment check completed. No appointments required cancellation.");
                return;
            }

            foreach (var appointment in appointments)
            {
                appointment.Status = AppointmentStatus.Cancelled;
                appointment.CancellationReason =
                    ErrorMessages.ExpiredConfirmedAppointmentAutoCancelledReason;
            }

            await repository.UpdateRangeAsync(appointments);

            foreach (var appointment in appointments)
            {
                await cache.RemoveDoctorSlotsAsync(
                    appointment.DoctorId,
                    appointment.AppointmentDate);
            }

            logger.LogInformation(
                "Automatically cancelled {AppointmentCount} confirmed appointments that passed without completion.",
                appointments.Count);
        }
        catch (OperationCanceledException exception) when (stoppingToken.IsCancellationRequested)
        {
            logger.LogDebug(
                exception,
                "Expired confirmed appointment check cancelled during shutdown.");
        }
        catch (Exception exception)
        {
            logger.LogError(exception, "Expired confirmed appointment check failed.");
        }
    }

    private static TimeSpan GetDelayUntilNextMidnight()
    {
        var now = DateTime.Now;
        return now.Date.AddDays(1) - now;
    }

    public override Task StopAsync(CancellationToken cancellationToken)
    {
        logger.LogInformation("ExpiredConfirmedAppointmentService stopping.");
        return base.StopAsync(cancellationToken);
    }
}
