namespace HealthAxis.Admin.Models;

public class Doctor
{
    public int Id { get; set; }
    public string FullName { get; set; } = string.Empty;
    public string Specialisation { get; set; } = string.Empty;
    public DateOnly PracticeStartDate { get; set; } = DateOnly.FromDateTime(DateTime.Today);
    public int YearsOfExperience { get; set; }
    public decimal ConsultationFee { get; set; }
    public bool IsAvailable { get; set; }
}
