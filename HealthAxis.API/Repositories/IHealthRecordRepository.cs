using HealthAxis.API.Models;
using HealthAxis.API.Repositories;

namespace HealthAxis.API.Repositories;

public interface IHealthRecordRepository : IRepository<HealthRecord>
{
    Task<List<HealthRecord>> GetHealthRecordsByPatientIdAsync(int patientId);
}