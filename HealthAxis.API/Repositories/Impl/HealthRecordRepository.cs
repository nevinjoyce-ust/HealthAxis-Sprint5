using HealthAxis.API.Data;
using HealthAxis.API.Models;
using Microsoft.EntityFrameworkCore;

namespace HealthAxis.API.Repositories.Impl;

public class HealthRecordRepository : Repository<HealthRecord>, IHealthRecordRepository
{
    public HealthRecordRepository(HealthAxisDbContext context) : base(context)
    {
    }

    public async Task<PagedResult<HealthRecord>> GetHealthRecordsByPatientIdAsync(
        int patientId,
        int pageNumber,
        int pageSize)
    {
        var query = GetHealthRecordsWithDetails()
            .Where(record => record.Appointment != null && record.Appointment.PatientId == patientId)
            .OrderByDescending(record => record.VisitDate)
            .ThenByDescending(record => record.Id);

        return await ToPagedResultAsync(query, pageNumber, pageSize);
    }

    public async Task<PagedResult<HealthRecord>> GetHealthRecordsByPatientIdAndDoctorIdAsync(
        int patientId,
        int doctorId,
        int pageNumber,
        int pageSize)
    {
        var query = GetHealthRecordsWithDetails()
            .Where(record =>
                record.Appointment != null &&
                record.Appointment.PatientId == patientId &&
                record.Appointment.DoctorId == doctorId)
            .OrderByDescending(record => record.VisitDate)
            .ThenByDescending(record => record.Id);

        return await ToPagedResultAsync(query, pageNumber, pageSize);
    }

    public async Task<HealthRecord?> GetHealthRecordByIdWithDetailsAsync(int id)
    {
        return await GetHealthRecordsWithDetails()
            .FirstOrDefaultAsync(record => record.Id == id);
    }

    public async Task<HealthRecord?> GetHealthRecordByAppointmentIdAsync(int appointmentId)
    {
        return await GetHealthRecordsWithDetails()
            .FirstOrDefaultAsync(record => record.AppointmentId == appointmentId);
    }

    private IQueryable<HealthRecord> GetHealthRecordsWithDetails()
    {
        return _context.HealthRecords
            .Include(record => record.Appointment)
                .ThenInclude(appointment => appointment!.Patient)
            .Include(record => record.Appointment)
                .ThenInclude(appointment => appointment!.Doctor);
    }
}
