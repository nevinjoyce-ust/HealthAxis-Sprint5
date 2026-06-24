using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Dtos.Doctor;
using HealthAxis.Shared.Enums;

namespace HealthAxis.API.Services;

public interface IDoctorService
{
    Task<PagedResultDto<PublicDoctorDto>> GetAllDoctorsAsync(PaginationQueryDto pagination, DoctorSpecialisation? specialisation);

    Task<PublicDoctorDto?> GetDoctorByIdAsync(int id);

    Task<PublicDoctorDto?> GetDoctorByUserIdAsync(string userId);

    Task<DoctorAvailabilityDto?> GetAvailabilityAsync(int id);

    Task<DoctorAvailabilityDto> UpdateAvailabilityAsync(
        int id,
        UpdateDoctorAvailabilityDto dto,
        string currentRole,
        int? currentDoctorId);
}

