using HealthAxis.API.Models;

namespace HealthAxis.API.Repositories;

public interface IHealthRecordRepository : IRepository<HealthRecord>
{
    Task<PagedResult<HealthRecord>> GetHealthRecordsByPatientIdAsync(int patientId, int pageNumber, int pageSize);

    Task<PagedResult<HealthRecord>> GetHealthRecordsByPatientIdAndDoctorIdAsync(
        int patientId,
        int doctorId,
        int pageNumber,
        int pageSize);

    Task<HealthRecord?> GetHealthRecordByIdWithDetailsAsync(int id);

    Task<HealthRecord?> GetHealthRecordByAppointmentIdAsync(int appointmentId);
    Task<PagedResult<HealthRecord>> GetHealthRecordsByDoctorIdAsync(
        int doctorId,
        int pageNumber,
        int pageSize);
}
