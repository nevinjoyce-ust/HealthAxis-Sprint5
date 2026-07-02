using HealthAxis.Shared.Enums;
using HealthAxis.API.Models;

namespace HealthAxis.API.Repositories;

public interface IDoctorRepository : IRepository<Doctor>
{
    Task<PagedResult<Doctor>> GetAllDoctorsAsync(
        int pageNumber,
        int pageSize,
        string? search = null,
        DoctorSpecialisation? specialisation = null,
        bool? isAvailable = null,
        DoctorSortBy sortBy = DoctorSortBy.Name,
        SortDirection sortDirection = SortDirection.Asc);

    Task<List<Doctor>> GetAvailableDoctorsAsync(DoctorSpecialisation? specialisation);

    Task<Doctor?> GetDoctorByIdAsync(int id);

    Task<PagedResult<Doctor>> GetAllDoctorsWithUserAsync(
        int pageNumber,
        int pageSize,
        string? search = null,
        DoctorSpecialisation? specialisation = null);

    Task<Doctor?> GetDoctorByIdWithUserAsync(int id);

    Task<Doctor?> GetDoctorByUserIdAsync(string userId);

    Task<bool?> GetAvailabilityAsync(int id);
}
