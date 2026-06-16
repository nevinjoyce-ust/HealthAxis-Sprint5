using HealthAxis.API.Models;
using HealthAxis.API.Repositories;

namespace HealthAxis.API.Repositories;

public interface IPatientRepository : IRepository<Patient>
{
    Task<Patient?> GetPatientByUserIdAsync(int userId);
}