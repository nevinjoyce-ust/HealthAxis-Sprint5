using HealthAxis.API.Dtos;

namespace HealthAxis.API.Services.Interfaces;

public interface IDoctorService
{
    Task<List<DoctorDto>> GetAllDoctorsAsync();

    Task<DoctorDto?> GetDoctorByIdAsync(int id);

    Task<DoctorDto?> GetDoctorByUserIdAsync(int userId);

    Task<DoctorAvailabilityDto?> GetAvailabilityAsync(int id);
}