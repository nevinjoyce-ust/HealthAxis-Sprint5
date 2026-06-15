using HealthAxis.API.Models;
using HealthAxis.API.Repositories;

namespace HealthAxis.API.Repositories.Interfaces;

public interface IUserRepository : IRepository<User>
{
    Task<string?> GetFullNameByIdAsync(int userId);

    Task<User?> GetByEmailAsync(string email);
}