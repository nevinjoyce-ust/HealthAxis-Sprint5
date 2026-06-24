using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Dtos.Appointment;
using HealthAxis.Shared.Enums;

namespace HealthAxis.API.Services;

public interface IAppointmentService
{
    Task<PagedResultDto<AppointmentDto>> GetAllAppointmentsAsync(PaginationQueryDto pagination);

    Task<AppointmentDto> GetAppointmentByIdAsync(int id);

    Task<PagedResultDto<AppointmentDto>> GetAppointmentsByPatientIdAsync(int patientId, AppointmentStatus? status, PaginationQueryDto pagination);

    Task<PagedResultDto<AppointmentDto>> GetAppointmentsByDoctorIdAsync(int doctorId, AppointmentStatus? status, PaginationQueryDto pagination);

    Task<PagedResultDto<AppointmentDto>> GetAppointmentsByDoctorIdAndDateAsync(int doctorId, DateOnly date, PaginationQueryDto pagination);

    Task<PagedResultDto<AppointmentDto>> GetAppointmentsByDateAndStatusAsync(
        DateOnly date,
        AppointmentStatus? status,
        PaginationQueryDto pagination);

    Task<AppointmentDto?> CreateAppointmentAsync(CreateAppointmentDto dto);

    Task<AppointmentDto?> UpdateAppointmentStatusAsync(
        int id,
        UpdateAppointmentStatusDto dto,
        string currentRole,
        int? currentPatientId,
        int? currentDoctorId);

    Task<List<AppointmentReportDto>> GetAppointmentReportsAsync();
}
