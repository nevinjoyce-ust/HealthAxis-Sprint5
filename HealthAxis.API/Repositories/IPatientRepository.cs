using HealthAxis.API.Models;

namespace HealthAxis.API.Repositories;

public interface IPatientRepository : IRepository<Patient>
{
    Task<Patient?> GetPatientByIdWithUserAsync(int id);

    Task<Patient?> GetPatientByUserIdAsync(string userId);
}
