using HealthAxis.API.Dtos;

namespace HealthAxis.API.Services;

public interface IAppointmentService
{
    Task<List<AppointmentDto>> GetAllAppointmentsAsync();

    Task<AppointmentDto?> CreateAppointmentAsync(CreateAppointmentDto dto);

    Task<AppointmentDto?> UpdateAppointmentStatusAsync(int id, UpdateAppointmentStatusDto dto);

    Task<AppointmentDto?> DeleteAppointmentAsync(int id);

    Task<List<AppointmentReportDto>> GetAppointmentReportsAsync();
}