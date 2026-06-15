using HealthAxis.API.Data;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace HealthAxis.API.Repositories.Impl;

public class UserRepository : Repository<User>, IUserRepository
{
    public UserRepository(HealthAxisDbContext context) : base(context)
    {
    }

    public async Task<string?> GetFullNameByIdAsync(int userId)
    {
        return await _context.Set<User>()
            .Where(user => user.Id == userId)
            .Select(user => user.FullName)
            .FirstOrDefaultAsync();
    }

    public async Task<User?> GetByEmailAsync(string email)
    {
        return await _context.Set<User>()
            .FirstOrDefaultAsync(user => user.Email == email);
    }
}