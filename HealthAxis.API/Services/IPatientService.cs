using HealthAxis.API.Dtos;

namespace HealthAxis.API.Services;

public interface IPatientService
{
    Task<PatientDto> GetPatientByIdAsync(int id);

    Task<PatientDto> GetPatientByUserIdAsync(string userId);

    Task<PatientDto> UpdatePatientAsync(int id, UpdatePatientDto dto);

    Task<PagedResultDto<HealthRecordDto>> GetPatientHealthRecordsAsync(
        int patientId,
        PaginationQueryDto pagination);
}
