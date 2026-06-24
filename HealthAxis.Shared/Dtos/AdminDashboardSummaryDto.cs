namespace HealthAxis.Shared.Dtos;

public class AdminDashboardSummaryDto
{
    public int ActiveDoctorsCount { get; set; }

    public int RegisteredPatientsCount { get; set; }

    public int PendingAppointmentsCount { get; set; }

    public int ConfirmedAppointmentsCount { get; set; }

    public int CompletedAppointmentsCount { get; set; }

    public int CancelledAppointmentsCount { get; set; }

    public int TodaysAppointmentsCount { get; set; }

    public int TodaysPendingAppointmentsCount { get; set; }

    public int TodaysConfirmedAppointmentsCount { get; set; }

    public int TodaysCompletedAppointmentsCount { get; set; }

    public int TodaysCancelledAppointmentsCount { get; set; }
}
