using HealthAxis.API.Models;
using HealthAxis.API.Repositories;

namespace HealthAxis.API.Repositories.Interfaces;

public interface IPatientRepository : IRepository<Patient>
{
    Task<Patient?> GetPatientByUserIdAsync(int userId);
}