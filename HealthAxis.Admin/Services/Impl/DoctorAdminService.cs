using System.Net.Http.Json;
using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Dtos.Appointment;
using HealthAxis.Shared.Dtos.Auth;
using HealthAxis.Shared.Dtos.Doctor;
using HealthAxis.Shared.Enums;

namespace HealthAxis.Admin.Services.Impl;

public class DoctorAdminService(HttpClient httpClient) : IDoctorAdminService
{
    public async Task<PagedResultDto<DoctorDto>> GetDoctorsAsync(
        PaginationQueryDto pagination,
        string? search = null,
        DoctorSpecialisation? specialisation = null)
    {
        var url = $"api/admin/doctors?pageNumber={pagination.PageNumber}&pageSize={pagination.PageSize}";

        if (!string.IsNullOrWhiteSpace(search))
        {
            url += $"&search={Uri.EscapeDataString(search.Trim())}";
        }

        if (specialisation.HasValue)
        {
            url += $"&specialisation={Uri.EscapeDataString(specialisation.Value.ToString())}";
        }

        return await httpClient.GetFromJsonAsync<PagedResultDto<DoctorDto>>(url)
            ?? new PagedResultDto<DoctorDto>();
    }

    public async Task<ApiResponse<DoctorDto>> CreateDoctorAsync(CreateDoctorDto request)
    {
        var response = await httpClient.PostAsJsonAsync("api/admin/doctors", request);

        return await ApiResponseHandler.ReadResponseAsync<DoctorDto>(
            response,
            "Unable to create doctor.");
    }

    public async Task<ApiResponse<DoctorDto>> UpdateDoctorAsync(int id, UpdateDoctorDto request)
    {
        var response = await httpClient.PutAsJsonAsync($"api/admin/doctors/{id}", request);

        return await ApiResponseHandler.ReadResponseAsync<DoctorDto>(
            response,
            "Unable to update doctor.");
    }

    public async Task<ApiResponse<string>> ResetDoctorPasswordAsync(int id, AdminResetPasswordDto request)
    {
        var response = await httpClient.PutAsJsonAsync($"api/admin/doctors/{id}/password", request);

        return await ApiResponseHandler.ReadMessageResponseAsync(
            response,
            "Unable to reset doctor password.",
            "Doctor password reset successfully.");
    }

    public async Task<ApiResponse<UpdateDoctorAvailabilityDto>> UpdateAvailabilityAsync(
        int id,
        UpdateDoctorAvailabilityDto request)
    {
        var response = await httpClient.PutAsJsonAsync(
            $"api/admin/doctors/{id}/availability",
            request);

        return await ApiResponseHandler.ReadResponseAsync<UpdateDoctorAvailabilityDto>(
            response,
            "Unable to update doctor availability.");
    }

    public async Task<PagedResultDto<AppointmentDto>> GetDoctorAppointmentsAsync(
        int doctorId,
        AppointmentStatus? status,
        PaginationQueryDto pagination)
    {
        var url = $"api/admin/doctors/{doctorId}/appointments?pageNumber={pagination.PageNumber}&pageSize={pagination.PageSize}";

        if (status.HasValue)
        {
            url += $"&status={Uri.EscapeDataString(status.Value.ToString())}";
        }

        return await httpClient.GetFromJsonAsync<PagedResultDto<AppointmentDto>>(url)
            ?? new PagedResultDto<AppointmentDto>();
    }
}
