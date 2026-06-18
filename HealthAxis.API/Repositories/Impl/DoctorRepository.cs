using HealthAxis.API.Data;
using HealthAxis.API.Enums;
using HealthAxis.API.Models;
using Microsoft.EntityFrameworkCore;

namespace HealthAxis.API.Repositories.Impl;

public class DoctorRepository : Repository<Doctor>, IDoctorRepository
{
    public DoctorRepository(HealthAxisDbContext context) : base(context)
    {
    }

    public async Task<PagedResult<Doctor>> GetAllDoctorsAsync(
        int pageNumber,
        int pageSize,
        DoctorSpecialisation? specialisation)
    {
        var query = _context.Doctors
            .AsNoTracking()
            .AsQueryable();

        if (specialisation.HasValue)
        {
            query = query.Where(doctor => doctor.Specialisation == specialisation.Value);
        }

        query = query.OrderBy(doctor => doctor.Id);

        return await ToPagedResultAsync(query, pageNumber, pageSize);
    }

    public async Task<Doctor?> GetDoctorByIdAsync(int id)
    {
        return await _context.Doctors
            .FirstOrDefaultAsync(doctor => doctor.Id == id);
    }

    public async Task<PagedResult<Doctor>> GetAllDoctorsWithUserAsync(int pageNumber, int pageSize)
    {
        var query = _context.Doctors
            .Include(doctor => doctor.User)
            .OrderBy(doctor => doctor.Id)
            .AsQueryable();

        return await ToPagedResultAsync(query, pageNumber, pageSize);
    }

    public async Task<Doctor?> GetDoctorByIdWithUserAsync(int id)
    {
        return await _context.Doctors
            .Include(doctor => doctor.User)
            .FirstOrDefaultAsync(doctor => doctor.Id == id);
    }

    public async Task<Doctor?> GetDoctorByUserIdAsync(string userId)
    {
        return await _context.Doctors
            .FirstOrDefaultAsync(doctor => doctor.UserId == userId);
    }

    public async Task<bool?> GetAvailabilityAsync(int id)
    {
        return await _context.Doctors
            .Where(doctor => doctor.Id == id)
            .Select(doctor => (bool?)doctor.IsAvailable)
            .FirstOrDefaultAsync();
    }
}
