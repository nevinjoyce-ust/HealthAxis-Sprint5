using HealthAxis.API.Data;
using HealthAxis.Shared.Enums;
using HealthAxis.API.Models;
using Microsoft.EntityFrameworkCore;

namespace HealthAxis.API.Repositories.Impl;

public class DoctorRepository(HealthAxisDbContext context) : Repository<Doctor>(context), IDoctorRepository
{
    public async Task<PagedResult<Doctor>> GetAllDoctorsAsync(
    int pageNumber,
    int pageSize,
    string? search = null,
    DoctorSpecialisation? specialisation = null,
    bool? isAvailable = null,
    DoctorSortBy sortBy = DoctorSortBy.Name,
    SortDirection sortDirection = SortDirection.Asc)
    {
        var query = _context.Doctors
            .AsNoTracking()
            .AsQueryable();

        if (!string.IsNullOrWhiteSpace(search))
        {
            var searchText = search.Trim();

            query = query.Where(doctor =>
                doctor.FullName.Contains(searchText));
        }

        if (specialisation.HasValue)
        {
            query = query.Where(doctor => doctor.Specialisation == specialisation.Value);
        }

        if (isAvailable.HasValue)
        {
            query = query.Where(doctor => doctor.IsAvailable == isAvailable.Value);
        }

        query = ApplySorting(query, sortBy, sortDirection);

        return await ToPagedResultAsync(query, pageNumber, pageSize);
    }

    public async Task<List<Doctor>> GetAvailableDoctorsAsync(DoctorSpecialisation? specialisation)
    {
        var query = _context.Doctors
            .AsNoTracking()
            .Where(doctor => doctor.IsAvailable);

        if (specialisation.HasValue)
        {
            query = query.Where(doctor => doctor.Specialisation == specialisation.Value);
        }

        return await query
            .OrderBy(doctor => doctor.Id)
            .ToListAsync();
    }

    public async Task<Doctor?> GetDoctorByIdAsync(int id)
    {
        return await _context.Doctors
            .FirstOrDefaultAsync(doctor => doctor.Id == id);
    }

    public async Task<PagedResult<Doctor>> GetAllDoctorsWithUserAsync(
        int pageNumber,
        int pageSize,
        string? search = null,
        DoctorSpecialisation? specialisation = null)
    {
        var query = _context.Doctors
            .Include(doctor => doctor.User)
            .AsQueryable();

        if (specialisation.HasValue)
        {
            query = query.Where(doctor => doctor.Specialisation == specialisation.Value);
        }

        if (!string.IsNullOrWhiteSpace(search))
        {
            var searchText = search.Trim();
            var specialisationMatched = Enum.TryParse<DoctorSpecialisation>(
                searchText,
                ignoreCase: true,
                out var parsedSpecialisation);

            query = query.Where(doctor =>
                doctor.FullName.Contains(searchText) ||
                (doctor.User != null && doctor.User.Email != null && doctor.User.Email.Contains(searchText)) ||
                (doctor.User != null && doctor.User.PhoneNumber != null && doctor.User.PhoneNumber.Contains(searchText)) ||
                (specialisationMatched && doctor.Specialisation == parsedSpecialisation));
        }

        query = query
            .OrderBy(doctor => doctor.FullName)
            .ThenBy(doctor => doctor.Id);

        return await ToPagedResultAsync(query, pageNumber, pageSize);
    }

    public async Task<Doctor?> GetDoctorByIdWithUserAsync(int id)
    {
        return await _context.Doctors
            .Include(doctor => doctor.User)
            .FirstOrDefaultAsync(doctor => doctor.Id == id);
    }

    public async Task<Doctor?> GetDoctorByUserIdAsync(string userId)
    {
        return await _context.Doctors
            .Include(doctor => doctor.User)
            .FirstOrDefaultAsync(doctor => doctor.UserId == userId);
    }

    public async Task<bool?> GetAvailabilityAsync(int id)
    {
        return await _context.Doctors
            .Where(doctor => doctor.Id == id)
            .Select(doctor => (bool?)doctor.IsAvailable)
            .FirstOrDefaultAsync();
    }

    private static IQueryable<Doctor> ApplySorting(
    IQueryable<Doctor> query,
    DoctorSortBy sortBy,
    SortDirection sortDirection)
    {
        var descending = sortDirection == SortDirection.Desc;

        return sortBy switch
        {
            DoctorSortBy.Fee => descending
                ? query.OrderByDescending(doctor => doctor.ConsultationFee).ThenBy(doctor => doctor.FullName)
                : query.OrderBy(doctor => doctor.ConsultationFee).ThenBy(doctor => doctor.FullName),

            DoctorSortBy.Experience => descending
                ? query.OrderBy(doctor => doctor.PracticeStartDate).ThenBy(doctor => doctor.FullName)
                : query.OrderByDescending(doctor => doctor.PracticeStartDate).ThenBy(doctor => doctor.FullName),

            _ => descending
                ? query.OrderByDescending(doctor => doctor.FullName).ThenBy(doctor => doctor.Id)
                : query.OrderBy(doctor => doctor.FullName).ThenBy(doctor => doctor.Id)
        };
    }
}
