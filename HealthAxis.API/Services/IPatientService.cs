using HealthAxis.API.Dtos;

namespace HealthAxis.API.Services;

public interface IPatientService
{
    Task<PatientDto?> GetPatientByIdAsync(int id);

    Task<PatientDto?> GetPatientByUserIdAsync(int userId);

    Task<PatientDto?> UpdatePatientAsync(int id, UpdatePatientDto dto);

    Task<List<HealthRecordDto>> GetPatientHealthRecordsAsync(int patientId);
}