using HealthAxis.API.Models;

namespace HealthAxis.API.Repositories.Interfaces;

public interface IDoctorRepository : IRepository<Doctor>
{
    Task<Doctor?> GetDoctorByUserIdAsync(int userId);

    Task<bool?> GetAvailabilityAsync(int id);
}