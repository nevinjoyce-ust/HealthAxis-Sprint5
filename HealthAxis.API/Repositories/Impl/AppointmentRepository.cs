using HealthAxis.API.Data;
using HealthAxis.API.Enums;
using HealthAxis.API.Models;
using Microsoft.EntityFrameworkCore;

namespace HealthAxis.API.Repositories.Impl;

public class AppointmentRepository : Repository<Appointment>, IAppointmentRepository
{
    public AppointmentRepository(HealthAxisDbContext context) : base(context)
    {
    }

    public async Task<PagedResult<Appointment>> GetAllAppointmentsAsync(int pageNumber, int pageSize)
    {
        var query = GetAppointmentsWithDetails()
            .OrderBy(appointment => appointment.AppointmentDate)
            .ThenBy(appointment => appointment.AppointmentTime)
            .ThenBy(appointment => appointment.Id);

        return await ToPagedResultAsync(query, pageNumber, pageSize);
    }

    public async Task<Appointment?> GetAppointmentByIdWithDetailsAsync(int appointmentId)
    {
        return await GetAppointmentsWithDetails()
            .FirstOrDefaultAsync(appointment => appointment.Id == appointmentId);
    }

    public async Task<PagedResult<Appointment>> GetAppointmentsByPatientIdAsync(
        int patientId,
        int pageNumber,
        int pageSize)
    {
        var query = GetAppointmentsWithDetails()
            .Where(appointment => appointment.PatientId == patientId)
            .OrderBy(appointment => appointment.AppointmentDate)
            .ThenBy(appointment => appointment.AppointmentTime)
            .ThenBy(appointment => appointment.Id);

        return await ToPagedResultAsync(query, pageNumber, pageSize);
    }

    public async Task<PagedResult<Appointment>> GetAppointmentsByDoctorIdAsync(
        int doctorId,
        int pageNumber,
        int pageSize)
    {
        var query = GetAppointmentsWithDetails()
            .Where(appointment => appointment.DoctorId == doctorId)
            .OrderBy(appointment => appointment.AppointmentDate)
            .ThenBy(appointment => appointment.AppointmentTime)
            .ThenBy(appointment => appointment.Id);

        return await ToPagedResultAsync(query, pageNumber, pageSize);
    }

    public async Task<PagedResult<Appointment>> GetAppointmentsByDoctorIdAndDateAsync(
        int doctorId,
        DateOnly date,
        int pageNumber,
        int pageSize)
    {
        var query = GetAppointmentsWithDetails()
            .Where(appointment =>
                appointment.DoctorId == doctorId &&
                appointment.AppointmentDate == date)
            .OrderBy(appointment => appointment.AppointmentTime)
            .ThenBy(appointment => appointment.Id);

        return await ToPagedResultAsync(query, pageNumber, pageSize);
    }

    public async Task<List<Appointment>> GetPendingAppointmentsAsync()
    {
        return await _context.Appointments
            .Where(appointment => appointment.Status == AppointmentStatus.Pending)
            .ToListAsync();
    }

    public async Task<bool> DoctorHasNonCancelledAppointmentAtAsync(int doctorId, DateOnly date, TimeOnly time)
    {
        return await _context.Appointments
            .AnyAsync(appointment =>
                appointment.DoctorId == doctorId &&
                appointment.AppointmentDate == date &&
                appointment.AppointmentTime == time &&
                appointment.Status != AppointmentStatus.Cancelled);
    }

    public async Task<bool> PatientHasNonCancelledAppointmentAtAsync(int patientId, DateOnly date, TimeOnly time)
    {
        return await _context.Appointments
            .AnyAsync(appointment =>
                appointment.PatientId == patientId &&
                appointment.AppointmentDate == date &&
                appointment.AppointmentTime == time &&
                appointment.Status != AppointmentStatus.Cancelled);
    }

    public async Task<bool> PatientHasNonCancelledAppointmentWithDoctorOnDateAsync(int patientId, int doctorId, DateOnly date)
    {
        return await _context.Appointments
            .AnyAsync(appointment =>
                appointment.PatientId == patientId &&
                appointment.DoctorId == doctorId &&
                appointment.AppointmentDate == date &&
                appointment.Status != AppointmentStatus.Cancelled);
    }

    public async Task<bool> DoctorHasConfirmedAppointmentsOnDateAsync(int doctorId, DateOnly date)
    {
        return await _context.Appointments
            .AnyAsync(appointment =>
                appointment.DoctorId == doctorId &&
                appointment.AppointmentDate == date &&
                appointment.Status == AppointmentStatus.Confirmed);
    }

    public async Task<List<Appointment>> GetPendingOrConfirmedAppointmentsByDoctorIdAndDateAsync(int doctorId, DateOnly date)
    {
        return await _context.Appointments
            .Where(appointment =>
                appointment.DoctorId == doctorId &&
                appointment.AppointmentDate == date &&
                (appointment.Status == AppointmentStatus.Pending ||
                 appointment.Status == AppointmentStatus.Confirmed))
            .ToListAsync();
    }

    public async Task<Appointment?> DeleteAppointmentAsync(int appointmentId)
    {
        var appointment = await GetAppointmentByIdWithDetailsAsync(appointmentId);

        if (appointment == null)
        {
            return null;
        }

        _dbSet.Remove(appointment);
        await _context.SaveChangesAsync();

        return appointment;
    }
    public async Task<bool> DoctorHasConfirmedAppointmentWithPatientAsync(int doctorId, int patientId)
    {
        return await _context.Appointments
            .AnyAsync(appointment =>
                appointment.DoctorId == doctorId &&
                appointment.PatientId == patientId &&
                appointment.Status == AppointmentStatus.Confirmed);
    }

    private IQueryable<Appointment> GetAppointmentsWithDetails()
    {
        return _context.Appointments
            .Include(appointment => appointment.Patient)
            .Include(appointment => appointment.Doctor)
            .Include(appointment => appointment.HealthRecord);
    }
}
