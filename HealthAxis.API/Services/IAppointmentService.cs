using HealthAxis.API.Dtos;

namespace HealthAxis.API.Services;

public interface IAppointmentService
{
    Task<PagedResultDto<AppointmentDto>> GetAllAppointmentsAsync(PaginationQueryDto pagination);

    Task<AppointmentDto> GetAppointmentByIdAsync(int id);

    Task<PagedResultDto<AppointmentDto>> GetAppointmentsByPatientIdAsync(int patientId, PaginationQueryDto pagination);

    Task<PagedResultDto<AppointmentDto>> GetAppointmentsByDoctorIdAsync(int doctorId, PaginationQueryDto pagination);

    Task<PagedResultDto<AppointmentDto>> GetAppointmentsByDoctorIdAndDateAsync(int doctorId, DateOnly date, PaginationQueryDto pagination);

    Task<AppointmentDto?> CreateAppointmentAsync(CreateAppointmentDto dto);

    Task<AppointmentDto?> UpdateAppointmentStatusAsync(
        int id,
        UpdateAppointmentStatusDto dto,
        string currentRole,
        int? currentPatientId,
        int? currentDoctorId);

    Task<AppointmentDto?> DeleteAppointmentAsync(int id);

    Task<List<AppointmentReportDto>> GetAppointmentReportsAsync();
}
