using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Dtos.Appointment;
using HealthAxis.Shared.Dtos.Auth;
using HealthAxis.Shared.Dtos.Doctor;
using HealthAxis.Shared.Dtos.Patient;
using HealthAxis.Shared.Enums;

namespace HealthAxis.API.Services;

public interface IAdminService
{
    Task<AdminDashboardSummaryDto> GetDashboardSummaryAsync();

    Task<PagedResultDto<DoctorDto>> GetDoctorsAsync(
        PaginationQueryDto pagination,
        string? search = null,
        DoctorSpecialisation? specialisation = null);

    Task<DoctorDto?> CreateDoctorAsync(CreateDoctorDto dto);

    Task<DoctorDto?> UpdateDoctorAsync(int id, UpdateDoctorDto dto);

    Task ResetDoctorPasswordAsync(int id, AdminResetPasswordDto dto);

    Task<PagedResultDto<AppointmentDto>> GetDoctorAppointmentsAsync(int doctorId, AppointmentStatus? status, PaginationQueryDto pagination);

    Task<PagedResultDto<PatientDto>> GetPatientsAsync(PaginationQueryDto pagination, string? search);

    Task<PatientDto?> UpdatePatientAsync(int id, UpdatePatientDto dto);

    Task ResetPatientPasswordAsync(int id, AdminResetPasswordDto dto);

    Task<PagedResultDto<AppointmentDto>> GetPatientAppointmentsAsync(int patientId, AppointmentStatus? status, PaginationQueryDto pagination);

    Task<PagedResultDto<AppointmentReportDto>> GetAppointmentReportsAsync(PaginationQueryDto pagination);

    Task<PagedResultDto<AppointmentDto>> GetAppointmentReportDetailsAsync(
        DateOnly date,
        AppointmentStatus? status,
        PaginationQueryDto pagination);
}
