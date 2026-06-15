using HealthAxis.API.Dtos;

namespace HealthAxis.API.Services.Interfaces;

public interface IAppointmentService
{
    Task<List<AppointmentDto>> GetAllAppointmentsAsync();

    Task<AppointmentDto?> CreateAppointmentAsync(CreateAppointmentDto dto);

    Task<AppointmentDto?> UpdateAppointmentStatusAsync(int id, UpdateAppointmentStatusDto dto);

    Task<bool> DeleteAppointmentAsync(int id);

    Task<List<AppointmentReportDto>> GetAppointmentReportsAsync();
}