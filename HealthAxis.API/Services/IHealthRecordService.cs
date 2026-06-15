using HealthAxis.API.Dtos;

namespace HealthAxis.API.Services.Interfaces;

public interface IHealthRecordService
{
    Task<List<HealthRecordDto>> GetHealthRecordsByPatientIdAsync(int patientId);

    Task<HealthRecordDto?> GetHealthRecordByIdAsync(int id);

    Task<HealthRecordDto?> CreateHealthRecordAsync(CreateHealthRecordDto dto);
}