using HealthAxis.API.Data;
using HealthAxis.Shared.Dtos.Appointment;
using HealthAxis.Shared.Enums;
using HealthAxis.API.Models;
using Microsoft.EntityFrameworkCore;

namespace HealthAxis.API.Repositories.Impl;

public class AppointmentRepository(HealthAxisDbContext context) : Repository<Appointment>(context), IAppointmentRepository
{

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
    AppointmentStatus? status,
    int pageNumber,
    int pageSize)
    {
        var query = GetAppointmentsWithDetails()
            .Where(appointment => appointment.PatientId == patientId);

        if (status.HasValue)
        {
            query = query.Where(appointment => appointment.Status == status.Value);
        }

        query = query
            .OrderBy(appointment => appointment.AppointmentDate)
            .ThenBy(appointment => appointment.AppointmentTime)
            .ThenBy(appointment => appointment.Id);

        return await ToPagedResultAsync(query, pageNumber, pageSize);
    }

    public async Task<PagedResult<Appointment>> GetAppointmentsByDoctorIdAsync(
     int doctorId,
     AppointmentStatus? status,
     int pageNumber,
     int pageSize)
    {
        var query = GetAppointmentsWithDetails()
            .Where(appointment => appointment.DoctorId == doctorId);

        if (status.HasValue)
        {
            query = query.Where(appointment => appointment.Status == status.Value);
        }

        query = query
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

    public async Task<PagedResult<Appointment>> GetAppointmentsByDateAndStatusAsync(
        DateOnly date,
        AppointmentStatus? status,
        int pageNumber,
        int pageSize)
    {
        var query = GetAppointmentsWithDetails()
            .Where(appointment => appointment.AppointmentDate == date);

        if (status.HasValue)
        {
            query = query.Where(appointment => appointment.Status == status.Value);
        }

        query = query
            .OrderBy(appointment => appointment.AppointmentTime)
            .ThenBy(appointment => appointment.Id);

        return await ToPagedResultAsync(query, pageNumber, pageSize);
    }

    public async Task<List<Appointment>> GetExpiredPendingAppointmentsAsync(DateTime cutoffDateTime)
    {
        var cutoffDate = DateOnly.FromDateTime(cutoffDateTime);
        var cutoffTime = TimeOnly.FromDateTime(cutoffDateTime);

        return await _context.Appointments
            .Where(appointment =>
                appointment.Status == AppointmentStatus.Pending &&
                (appointment.AppointmentDate < cutoffDate ||
                 appointment.AppointmentDate == cutoffDate && appointment.AppointmentTime <= cutoffTime))
            .ToListAsync();
    }

    public async Task<List<AppointmentReportDto>> GetAppointmentReportsAsync()
    {
        return await _context.Appointments
            .GroupBy(appointment => appointment.AppointmentDate)
            .Select(group => new AppointmentReportDto
            {
                Date = group.Key,
                ConfirmedCount = group.Count(appointment => appointment.Status == AppointmentStatus.Confirmed),
                CancelledCount = group.Count(appointment => appointment.Status == AppointmentStatus.Cancelled),
                CompletedCount = group.Count(appointment => appointment.Status == AppointmentStatus.Completed),
                PendingCount = group.Count(appointment => appointment.Status == AppointmentStatus.Pending),
                TotalCount = group.Count()
            })
            .OrderByDescending(report => report.Date)
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
