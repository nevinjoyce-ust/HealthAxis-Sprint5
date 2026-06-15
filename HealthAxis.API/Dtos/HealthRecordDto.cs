namespace HealthAxis.API.Dtos;

public class HealthRecordDto
{
    public int Id { get; set; }

    public int PatientId { get; set; }

    public int DoctorId { get; set; }

    public string PatientName { get; set; } = string.Empty;

    public string DoctorName { get; set; } = string.Empty;

    public DateOnly VisitDate { get; set; }

    public string Diagnosis { get; set; } = string.Empty;

    public string Prescription { get; set; } = string.Empty;

    public string? Notes { get; set; }
}