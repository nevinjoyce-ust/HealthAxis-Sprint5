using System.Net.Http.Json;
using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Dtos.Appointment;
using HealthAxis.Shared.Dtos.Auth;
using HealthAxis.Shared.Dtos.Patient;
using HealthAxis.Shared.Enums;

namespace HealthAxis.Admin.Services.Impl;

public class AdminPatientService(HttpClient httpClient) : IAdminPatientService
{
    public async Task<PagedResultDto<PatientDto>> GetPatientsAsync(
        PaginationQueryDto pagination,
        string? search)
    {
        var url = $"api/admin/patients?pageNumber={pagination.PageNumber}&pageSize={pagination.PageSize}";

        if (!string.IsNullOrWhiteSpace(search))
        {
            url += $"&search={Uri.EscapeDataString(search.Trim())}";
        }

        return await httpClient.GetFromJsonAsync<PagedResultDto<PatientDto>>(url)
            ?? new PagedResultDto<PatientDto>();
    }

    public async Task<ApiResponse<PatientDto>> UpdatePatientAsync(int id, UpdatePatientDto request)
    {
        var response = await httpClient.PutAsJsonAsync($"api/admin/patients/{id}", request);

        return await ApiResponseHandler.ReadResponseAsync<PatientDto>(
            response,
            "Unable to update patient.");
    }

    public async Task<ApiResponse<string>> ResetPatientPasswordAsync(int id, AdminResetPasswordDto request)
    {
        var response = await httpClient.PutAsJsonAsync($"api/admin/patients/{id}/password", request);

        return await ApiResponseHandler.ReadMessageResponseAsync(
            response,
            "Unable to reset patient password.",
            "Patient password reset successfully.");
    }

    public async Task<PagedResultDto<AppointmentDto>> GetPatientAppointmentsAsync(
        int patientId,
        AppointmentStatus? status,
        PaginationQueryDto pagination)
    {
        var url = $"api/admin/patients/{patientId}/appointments?pageNumber={pagination.PageNumber}&pageSize={pagination.PageSize}";

        if (status.HasValue)
        {
            url += $"&status={Uri.EscapeDataString(status.Value.ToString())}";
        }

        return await httpClient.GetFromJsonAsync<PagedResultDto<AppointmentDto>>(url)
            ?? new PagedResultDto<AppointmentDto>();
    }
}
