using HealthAxis.API.Enums;
using HealthAxis.API.Models;

namespace HealthAxis.API.Repositories;

public interface IDoctorRepository : IRepository<Doctor>
{
    Task<PagedResult<Doctor>> GetAllDoctorsAsync(int pageNumber, int pageSize, DoctorSpecialisation? specialisation);

    Task<Doctor?> GetDoctorByIdAsync(int id);

    Task<PagedResult<Doctor>> GetAllDoctorsWithUserAsync(int pageNumber, int pageSize);

    Task<Doctor?> GetDoctorByIdWithUserAsync(int id);

    Task<Doctor?> GetDoctorByUserIdAsync(string userId);

    Task<bool?> GetAvailabilityAsync(int id);
}
