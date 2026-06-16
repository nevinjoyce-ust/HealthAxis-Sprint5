using HealthAxis.API.Data;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using Microsoft.EntityFrameworkCore;

namespace HealthAxis.API.Repositories.Impl;

public class HealthRecordRepository : Repository<HealthRecord>, IHealthRecordRepository
{
    public HealthRecordRepository(HealthAxisDbContext context) : base(context)
    {
    }

    public async Task<List<HealthRecord>> GetHealthRecordsByPatientIdAsync(int patientId)
    {
        return await _context.Set<HealthRecord>()
            .Where(record => record.PatientId == patientId)
            .ToListAsync();
    }
}