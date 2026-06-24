using HealthAxis.API.Data;
using HealthAxis.API.Models;
using Microsoft.EntityFrameworkCore;

namespace HealthAxis.API.Repositories.Impl;

public class PatientRepository(HealthAxisDbContext context) : Repository<Patient>(context), IPatientRepository
{

    public async Task<PagedResult<Patient>> GetAllPatientsWithUserAsync(
        int pageNumber,
        int pageSize,
        string? search)
    {
        var query = _context.Patients
            .Include(patient => patient.User)
            .AsQueryable();

        if (!string.IsNullOrWhiteSpace(search))
        {
            var searchText = search.Trim();

            query = query.Where(patient =>
                patient.FullName.Contains(searchText) ||
                (patient.User != null && patient.User.Email != null && patient.User.Email.Contains(searchText)) ||
                (patient.User != null && patient.User.PhoneNumber != null && patient.User.PhoneNumber.Contains(searchText)));
        }

        query = query
            .OrderBy(patient => patient.FullName)
            .ThenBy(patient => patient.Id);

        return await ToPagedResultAsync(query, pageNumber, pageSize);
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
            .Include(patient => patient.User)
            .FirstOrDefaultAsync(patient => patient.UserId == userId);
    }
}
