using HealthAxis.API.Models;

namespace HealthAxis.API.Repositories;

public interface IAppointmentRepository : IRepository<Appointment>
{
    Task<PagedResult<Appointment>> GetAllAppointmentsAsync(int pageNumber, int pageSize);

    Task<Appointment?> GetAppointmentByIdWithDetailsAsync(int appointmentId);

    Task<PagedResult<Appointment>> GetAppointmentsByPatientIdAsync(int patientId, int pageNumber, int pageSize);

    Task<PagedResult<Appointment>> GetAppointmentsByDoctorIdAsync(int doctorId, int pageNumber, int pageSize);

    Task<PagedResult<Appointment>> GetAppointmentsByDoctorIdAndDateAsync(int doctorId, DateOnly date, int pageNumber, int pageSize);

    Task<List<Appointment>> GetPendingAppointmentsAsync();

    Task<bool> DoctorHasNonCancelledAppointmentAtAsync(int doctorId, DateOnly date, TimeOnly time);

    Task<bool> PatientHasNonCancelledAppointmentAtAsync(int patientId, DateOnly date, TimeOnly time);

    Task<bool> PatientHasNonCancelledAppointmentWithDoctorOnDateAsync(int patientId, int doctorId, DateOnly date);

    Task<bool> DoctorHasConfirmedAppointmentsOnDateAsync(int doctorId, DateOnly date);

    Task<List<Appointment>> GetPendingOrConfirmedAppointmentsByDoctorIdAndDateAsync(int doctorId, DateOnly date);

    Task<Appointment?> DeleteAppointmentAsync(int appointmentId);

    Task<bool> DoctorHasConfirmedAppointmentWithPatientAsync(int doctorId, int patientId);
}
