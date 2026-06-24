using System.Net.Http.Json;
using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Dtos.Appointment;
using HealthAxis.Shared.Enums;

namespace HealthAxis.Admin.Services.Impl;

public class AdminReportService(HttpClient httpClient) : IAdminReportService
{
    public async Task<PagedResultDto<AppointmentReportDto>> GetAppointmentReportsAsync(
        PaginationQueryDto pagination)
    {
        var url = $"api/admin/reports/appointments?pageNumber={pagination.PageNumber}&pageSize={pagination.PageSize}";

        return await httpClient.GetFromJsonAsync<PagedResultDto<AppointmentReportDto>>(url)
            ?? new PagedResultDto<AppointmentReportDto>();
    }

    public async Task<PagedResultDto<AppointmentDto>> GetAppointmentReportDetailsAsync(
        DateOnly date,
        AppointmentStatus? status,
        PaginationQueryDto pagination)
    {
        var dateValue = Uri.EscapeDataString(date.ToString("yyyy-MM-dd"));
        var url = $"api/admin/reports/appointments/details?date={dateValue}&pageNumber={pagination.PageNumber}&pageSize={pagination.PageSize}";

        if (status.HasValue)
        {
            url += $"&status={Uri.EscapeDataString(status.Value.ToString())}";
        }

        return await httpClient.GetFromJsonAsync<PagedResultDto<AppointmentDto>>(url)
            ?? new PagedResultDto<AppointmentDto>();
    }

    public async Task<ApiResponse<AppointmentDto>> UpdateAppointmentStatusAsync(
        int appointmentId,
        UpdateAppointmentStatusDto request)
    {
        var response = await httpClient.PutAsJsonAsync(
            $"api/appointments/{appointmentId}/status",
            request);

        return await ApiResponseHandler.ReadResponseAsync<AppointmentDto>(
            response,
            "Unable to update appointment status.");
    }
}
