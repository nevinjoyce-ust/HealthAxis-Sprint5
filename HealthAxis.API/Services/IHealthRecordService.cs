using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Dtos.HealthRecord;
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

    Task<PagedResultDto<HealthRecordDto>> GetHealthRecordsByDoctorIdAsync(
        int doctorId,
        PaginationQueryDto pagination);
}
