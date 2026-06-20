using HealthAxis.API.Dtos;

namespace HealthAxis.API.Services;

public interface IHealthRecordService
{
    Task<PagedResultDto<HealthRecordDto>> GetHealthRecordsByPatientIdAsync(
        int patientId,
        PaginationQueryDto pagination);

    Task<PagedResultDto<HealthRecordDto>> GetHealthRecordsForDoctorPatientViewAsync(
        int patientId,
        int doctorId,
        PaginationQueryDto pagination);
    Task<PagedResultDto<HealthRecordDto>> GetHealthRecordsByPatientIdAndDoctorIdAsync(
        int patientId,
        int doctorId,
        PaginationQueryDto pagination);

    Task<HealthRecordDto> GetHealthRecordByIdAsync(int id);

    Task<HealthRecordDto> CreateHealthRecordAsync(CreateHealthRecordDto dto, int doctorId);
}
