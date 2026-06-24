using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Dtos.Appointment;
using HealthAxis.Shared.Dtos.Auth;
using HealthAxis.Shared.Dtos.Patient;
using HealthAxis.Shared.Enums;

namespace HealthAxis.Admin.Services;

public interface IAdminPatientService
{
    Task<PagedResultDto<PatientDto>> GetPatientsAsync(PaginationQueryDto pagination, string? search);

    Task<ApiResponse<PatientDto>> UpdatePatientAsync(int id, UpdatePatientDto request);

    Task<ApiResponse<string>> ResetPatientPasswordAsync(int id, AdminResetPasswordDto request);

    Task<PagedResultDto<AppointmentDto>> GetPatientAppointmentsAsync(
        int patientId,
        AppointmentStatus? status,
        PaginationQueryDto pagination);
}
