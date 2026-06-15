using HealthAxis.API.Models;
using HealthAxis.API.Repositories;

namespace HealthAxis.API.Repositories.Interfaces;

public interface IAppointmentRepository : IRepository<Appointment>
{
    Task<List<Appointment>> GetAppointmentsByPatientIdAsync(int patientId);

    Task<List<Appointment>> GetAppointmentsByDoctorIdAsync(int doctorId);

    Task<List<Appointment>> GetAppointmentsByDoctorIdAndDateAsync(int doctorId, DateOnly date);
}