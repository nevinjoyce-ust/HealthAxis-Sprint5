using HealthAxis.API.Data;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using Microsoft.EntityFrameworkCore;

namespace HealthAxis.API.Repositories.Impl;

public class PatientRepository : Repository<Patient>, IPatientRepository
{
    public PatientRepository(HealthAxisDbContext context) : base(context)
    {
    }

    public async Task<Patient?> GetPatientByUserIdAsync(int userId)
    {
        return await _context.Set<Patient>()
            .FirstOrDefaultAsync(patient => patient.UserId == userId);
    }
}