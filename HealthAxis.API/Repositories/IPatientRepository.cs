using HealthAxis.API.Models;

namespace HealthAxis.API.Repositories;

public interface IPatientRepository : IRepository<Patient>
{
    Task<PagedResult<Patient>> GetAllPatientsWithUserAsync(
        int pageNumber,
        int pageSize,
        string? search);

    Task<Patient?> GetPatientByIdWithUserAsync(int id);

    Task<Patient?> GetPatientByUserIdAsync(string userId);
}
