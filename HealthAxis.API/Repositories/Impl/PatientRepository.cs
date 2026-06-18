using HealthAxis.API.Data;
using HealthAxis.API.Models;
using Microsoft.EntityFrameworkCore;

namespace HealthAxis.API.Repositories.Impl;

public class PatientRepository : Repository<Patient>, IPatientRepository
{
    public PatientRepository(HealthAxisDbContext context) : base(context)
    {
    }

    public async Task<Patient?> GetPatientByIdWithUserAsync(int id)
    {
        return await _context.Patients
            .Include(patient => patient.User)
            .FirstOrDefaultAsync(patient => patient.Id == id);
    }

    public async Task<Patient?> GetPatientByUserIdAsync(string userId)
    {
        return await _context.Patients
            .FirstOrDefaultAsync(patient => patient.UserId == userId);
    }
}
