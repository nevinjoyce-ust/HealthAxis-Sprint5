using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Dtos.Appointment;
using HealthAxis.Shared.Enums;

namespace HealthAxis.Admin.Services;

public interface IAdminReportService
{
    Task<PagedResultDto<AppointmentReportDto>> GetAppointmentReportsAsync(PaginationQueryDto pagination);

    Task<PagedResultDto<AppointmentDto>> GetAppointmentReportDetailsAsync(
        DateOnly date,
        AppointmentStatus? status,
        PaginationQueryDto pagination);

    Task<ApiResponse<AppointmentDto>> UpdateAppointmentStatusAsync(
        int appointmentId,
        UpdateAppointmentStatusDto request);
}
