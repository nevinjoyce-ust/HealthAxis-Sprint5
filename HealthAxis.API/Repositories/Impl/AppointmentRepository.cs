using HealthAxis.API.Data;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using Microsoft.EntityFrameworkCore;

namespace HealthAxis.API.Repositories.Impl;

public class AppointmentRepository : Repository<Appointment>, IAppointmentRepository
{
    public AppointmentRepository(HealthAxisDbContext context) : base(context)
    {
    }

    public async Task<List<Appointment>> GetAppointmentsByPatientIdAsync(int patientId)
    {
        return await _context.Set<Appointment>()
            .Where(appointment => appointment.PatientId == patientId)
            .ToListAsync();
    }

    public async Task<List<Appointment>> GetAppointmentsByDoctorIdAsync(int doctorId)
    {
        return await _context.Set<Appointment>()
            .Where(appointment => appointment.DoctorId == doctorId)
            .ToListAsync();
    }

    public async Task<List<Appointment>> GetAppointmentsByDoctorIdAndDateAsync(int doctorId, DateOnly date)
    {
        return await _context.Set<Appointment>()
            .Where(appointment =>
                appointment.DoctorId == doctorId &&
                appointment.AppointmentDate == date)
            .ToListAsync();
    }

    public async Task<Appointment?> DeleteAppointmentAsync(int appointmentId)
    {
        var appointment = await GetByIdAsync(appointmentId);
        if (appointment == null) return null;

        _dbSet.Remove(appointment);
        await _context.SaveChangesAsync();
        return appointment;
    }
}
