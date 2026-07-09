using HealthAxis.Shared.Dtos.Doctor;

namespace HealthAxis.API.Services;

public interface IDoctorAvailabilityCacheService
{
    Task<DoctorAvailableSlotsDto?> GetDoctorSlotsAsync(int doctorId, DateOnly date);

    Task SetDoctorSlotsAsync(int doctorId, DateOnly date, DoctorAvailableSlotsDto slots);

    Task RemoveDoctorSlotsAsync(int doctorId, DateOnly date);

    Task RemoveDoctorAvailabilityRangeAsync(int doctorId, int monthsAhead);
}
