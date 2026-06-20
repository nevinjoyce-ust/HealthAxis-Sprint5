namespace HealthAxis.Admin.Models;

public class AppointmentReport
{
    public DateTime Date { get; set; }
    public int PendingCount { get; set; }
    public int ConfirmedCount { get; set; }
    public int CancelledCount { get; set; }
    public int CompletedCount { get; set; }

    public int TotalCount => PendingCount + ConfirmedCount + CancelledCount + CompletedCount;
}
