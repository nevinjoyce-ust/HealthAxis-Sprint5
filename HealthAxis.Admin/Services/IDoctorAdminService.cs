using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Dtos.Appointment;
using HealthAxis.Shared.Dtos.Auth;
using HealthAxis.Shared.Dtos.Doctor;
using HealthAxis.Shared.Enums;

namespace HealthAxis.Admin.Services;

public interface IDoctorAdminService
{
    Task<PagedResultDto<DoctorDto>> GetDoctorsAsync(
        PaginationQueryDto pagination,
        string? search = null,
        DoctorSpecialisation? specialisation = null);

    Task<ApiResponse<DoctorDto>> CreateDoctorAsync(CreateDoctorDto request);

    Task<ApiResponse<DoctorDto>> UpdateDoctorAsync(int id, UpdateDoctorDto request);

    Task<ApiResponse<string>> ResetDoctorPasswordAsync(int id, AdminResetPasswordDto request);

    Task<ApiResponse<UpdateDoctorAvailabilityDto>> UpdateAvailabilityAsync(int id, UpdateDoctorAvailabilityDto request);

    Task<PagedResultDto<AppointmentDto>> GetDoctorAppointmentsAsync(
        int doctorId,
        AppointmentStatus? status,
        PaginationQueryDto pagination);
}
