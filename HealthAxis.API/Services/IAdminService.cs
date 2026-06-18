using HealthAxis.API.Dtos;

namespace HealthAxis.API.Services;

public interface IAdminService
{
    Task<PagedResultDto<DoctorDto>> GetDoctorsAsync(PaginationQueryDto pagination);

    Task<DoctorDto?> CreateDoctorAsync(CreateDoctorDto dto);

    Task<DoctorDto?> UpdateDoctorAsync(int id, UpdateDoctorDto dto);

    Task<List<AppointmentReportDto>> GetAppointmentReportsAsync();

    Task<List<AppointmentHealthRecordReportDto>> GetAppointmentHealthRecordReportsAsync();
}