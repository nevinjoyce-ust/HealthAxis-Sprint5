using HealthAxis.API.Data;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using Microsoft.EntityFrameworkCore;

namespace HealthAxis.API.Repositories.Impl;

public class DoctorRepository : Repository<Doctor>, IDoctorRepository
{
    public DoctorRepository(HealthAxisDbContext context) : base(context)
    {
    }

    public async Task<Doctor?> GetDoctorByUserIdAsync(int userId)
    {
        return await _context.Set<Doctor>()
            .FirstOrDefaultAsync(doctor => doctor.UserId == userId);
    }

    public async Task<bool?> GetAvailabilityAsync(int id)
    {
        var doctor = await _context.Set<Doctor>()
            .Where(doctor => doctor.Id == id)
            .Select(doctor => new
            {
                doctor.IsAvailable
            })
            .FirstOrDefaultAsync();

        if (doctor == null)
        {
            return null;
        }

        return doctor.IsAvailable;
    }
}