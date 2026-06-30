using AutoMapper;
using HealthAxis.API.Constants;
using HealthAxis.Shared.Constants;
using HealthAxis.Shared.Dtos.Doctor;
using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Enums;
using HealthAxis.API.Exceptions;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;

namespace HealthAxis.API.Services.Impl;

public class DoctorService(
    IDoctorRepository doctorRepository,
    IMapper mapper,
    IAppointmentRepository appointmentRepository) : IDoctorService
{
    private static readonly TimeOnly WorkDayStart = new(9, 0);
    private static readonly TimeOnly LunchStart = new(12, 0);
    private static readonly TimeOnly LunchEnd = new(13, 0);
    private static readonly TimeOnly WorkDayEnd = new(17, 0);
    private static readonly TimeSpan SlotDuration = TimeSpan.FromMinutes(30);

    private const int MinimumBookingHoursBeforeAppointment = 48;

    public async Task<PagedResultDto<PublicDoctorDto>> GetAllDoctorsAsync(
        PaginationQueryDto pagination,
        DoctorSpecialisation? specialisation)
    {
        var doctors = await doctorRepository.GetAllDoctorsAsync(
            pagination.PageNumber,
            pagination.PageSize,
            specialisation);

        return MapPagedResult<Doctor, PublicDoctorDto>(doctors);
    }

    public async Task<PublicDoctorDto?> GetDoctorByIdAsync(int id)
    {
        var doctor = await doctorRepository.GetDoctorByIdAsync(id);

        if (doctor == null)
        {
            return null;
        }

        return mapper.Map<PublicDoctorDto>(doctor);
    }

    public async Task<PublicDoctorDto?> GetDoctorByUserIdAsync(string userId)
    {
        var doctor = await doctorRepository.GetDoctorByUserIdAsync(userId);

        if (doctor == null)
        {
            return null;
        }

        return mapper.Map<PublicDoctorDto>(doctor);
    }

    public async Task<DoctorAvailabilityDto?> GetAvailabilityAsync(int id)
    {
        var availability = await doctorRepository.GetAvailabilityAsync(id);

        if (availability == null)
        {
            return null;
        }

        return new DoctorAvailabilityDto
        {
            DoctorId = id,
            IsAvailable = availability.Value,
            Message = availability.Value
                ? ErrorMessages.DoctorAvailableMessage
                : ErrorMessages.DoctorUnavailableMessage
        };
    }

    public async Task<DoctorAvailableSlotsDto> GetDoctorSlotsAsync(int id, DateOnly date)
    {
        var doctor = await doctorRepository.GetDoctorByIdAsync(id);

        if (doctor == null)
        {
            throw new NotFoundException(ErrorMessages.DoctorNotFound);
        }

        var bookedTimes = await GetBookedTimesAsync(doctor.Id, date);

        return CreateDoctorAvailableSlotsDto(doctor, date, bookedTimes);
    }

    public async Task<PagedResultDto<DoctorAvailableSlotsDto>> GetAvailableSlotsAsync(
        DateOnly date,
        DoctorSpecialisation? specialisation,
        PaginationQueryDto pagination)
    {
        var doctors = await doctorRepository.GetAvailableDoctorsAsync(specialisation);
        var appointments = await appointmentRepository.GetNonCancelledAppointmentsByDateAsync(date);

        var bookedTimesByDoctor = appointments
            .GroupBy(appointment => appointment.DoctorId)
            .ToDictionary(
                group => group.Key,
                group => group
                    .Select(appointment => appointment.AppointmentTime)
                    .ToHashSet());

        var doctorsWithAvailableSlots = new List<DoctorAvailableSlotsDto>();

        foreach (var doctor in doctors)
        {
            bookedTimesByDoctor.TryGetValue(doctor.Id, out var bookedTimes);
            bookedTimes ??= [];

            var doctorSlots = CreateDoctorAvailableSlotsDto(doctor, date, bookedTimes);

            if (doctorSlots.AvailableSlots.Count > 0)
            {
                doctorsWithAvailableSlots.Add(doctorSlots);
            }
        }

        var totalCount = doctorsWithAvailableSlots.Count;
        var totalPages = totalCount == 0
            ? 0
            : (int)Math.Ceiling(totalCount / (double)pagination.PageSize);

        var pagedItems = doctorsWithAvailableSlots
            .Skip((pagination.PageNumber - 1) * pagination.PageSize)
            .Take(pagination.PageSize)
            .ToList();

        return new PagedResultDto<DoctorAvailableSlotsDto>
        {
            Items = pagedItems,
            PageNumber = pagination.PageNumber,
            PageSize = pagination.PageSize,
            TotalCount = totalCount,
            TotalPages = totalPages
        };
    }

    public async Task<DoctorAvailabilityDto> UpdateAvailabilityAsync(
        int id,
        UpdateDoctorAvailabilityDto dto,
        string currentRole,
        int? currentDoctorId)
    {
        var doctor = await doctorRepository.GetDoctorByIdAsync(id);

        if (doctor == null)
        {
            throw new NotFoundException(ErrorMessages.DoctorNotFound);
        }

        ValidateAvailabilityUpdatePermission(id, currentRole, currentDoctorId);

        var isDeactivation = doctor.IsAvailable && !dto.IsAvailable;

        if (isDeactivation)
        {
            await HandleDeactivationAsync(id, currentRole);
        }

        doctor.IsAvailable = dto.IsAvailable;

        var updatedDoctor = await doctorRepository.UpdateAsync(doctor);

        if (updatedDoctor == null)
        {
            throw new NotFoundException(ErrorMessages.DoctorNotFound);
        }

        return CreateAvailabilityDto(updatedDoctor.Id, updatedDoctor.IsAvailable);
    }

    private static DoctorAvailableSlotsDto CreateDoctorAvailableSlotsDto(
        Doctor doctor,
        DateOnly date,
        HashSet<TimeOnly> bookedTimes)
    {
        return new DoctorAvailableSlotsDto
        {
            DoctorId = doctor.Id,
            DoctorName = doctor.FullName,
            Specialisation = doctor.Specialisation,
            YearsOfExperience = doctor.CalculateYearsOfExperience(),
            ConsultationFee = doctor.ConsultationFee,
            IsAvailable = doctor.IsAvailable,
            AvailableSlots = GenerateAvailableSlots(date, doctor.IsAvailable, bookedTimes)
        };
    }

    private async Task<HashSet<TimeOnly>> GetBookedTimesAsync(
        int doctorId,
        DateOnly date)
    {
        var appointments = await appointmentRepository.GetNonCancelledAppointmentsByDoctorIdAndDateAsync(
            doctorId,
            date);

        return appointments
            .Select(appointment => appointment.AppointmentTime)
            .ToHashSet();
    }

    private static List<TimeOnly> GenerateAvailableSlots(
        DateOnly date,
        bool doctorIsAvailable,
        HashSet<TimeOnly> bookedTimes)
    {
        var slots = new List<TimeOnly>();

        if (!doctorIsAvailable)
        {
            return slots;
        }

        for (var current = WorkDayStart; current < WorkDayEnd; current = current.Add(SlotDuration))
        {
            if (current >= LunchStart && current < LunchEnd)
            {
                continue;
            }

            if (!IsAtLeastHoursAhead(date, current, MinimumBookingHoursBeforeAppointment))
            {
                continue;
            }

            if (bookedTimes.Contains(current))
            {
                continue;
            }

            slots.Add(current);
        }

        return slots;
    }

    private static bool IsAtLeastHoursAhead(DateOnly date, TimeOnly time, int minimumHours)
    {
        var scheduledAt = date.ToDateTime(time);

        return scheduledAt >= DateTime.Now.AddHours(minimumHours);
    }

    private PagedResultDto<TDestination> MapPagedResult<TSource, TDestination>(
        PagedResult<TSource> pagedResult)
    {
        return new PagedResultDto<TDestination>
        {
            Items = mapper.Map<List<TDestination>>(pagedResult.Items),
            PageNumber = pagedResult.PageNumber,
            PageSize = pagedResult.PageSize,
            TotalCount = pagedResult.TotalCount,
            TotalPages = pagedResult.TotalPages
        };
    }

    private static void ValidateAvailabilityUpdatePermission(
        int doctorId,
        string currentRole,
        int? currentDoctorId)
    {
        if (currentRole == AppRoles.Doctor && currentDoctorId != doctorId)
        {
            throw new ForbiddenException(ErrorMessages.DoctorsCanUpdateOnlyOwnAvailability);
        }

        if (currentRole != AppRoles.Doctor && currentRole != AppRoles.Admin)
        {
            throw new ForbiddenException(ErrorMessages.UnsupportedAppointmentStatusTransition);
        }
    }

    private static DoctorAvailabilityDto CreateAvailabilityDto(int doctorId, bool isAvailable)
    {
        return new DoctorAvailabilityDto
        {
            DoctorId = doctorId,
            IsAvailable = isAvailable,
            Message = isAvailable
                ? ErrorMessages.DoctorAvailableMessage
                : ErrorMessages.DoctorUnavailableMessage
        };
    }

    private async Task HandleDeactivationAsync(
        int doctorId,
        string currentRole)
    {
        var today = DateOnly.FromDateTime(DateTime.Today);

        if (currentRole == AppRoles.Doctor)
        {
            await EnsureDoctorCanDeactivateSelfAsync(doctorId, today);
            return;
        }

        if (currentRole == AppRoles.Admin)
        {
            await CancelTodaysAppointmentsForAdminDeactivationAsync(doctorId, today);
        }
    }

    private async Task EnsureDoctorCanDeactivateSelfAsync(
        int doctorId,
        DateOnly today)
    {
        var hasConfirmedAppointmentsToday = await appointmentRepository
            .DoctorHasConfirmedAppointmentsOnDateAsync(doctorId, today);

        if (hasConfirmedAppointmentsToday)
        {
            throw new BusinessRuleException(ErrorMessages.DoctorCannotDeactivateWithConfirmedAppointmentsToday);
        }
    }

    private async Task CancelTodaysAppointmentsForAdminDeactivationAsync(
        int doctorId,
        DateOnly today)
    {
        var appointmentsToCancel = await appointmentRepository
            .GetPendingOrConfirmedAppointmentsByDoctorIdAndDateAsync(doctorId, today);

        foreach (var appointment in appointmentsToCancel)
        {
            appointment.Status = AppointmentStatus.Cancelled;
            appointment.CancellationReason = ErrorMessages.DoctorEmergencyCancellationReason;

            await appointmentRepository.UpdateAsync(appointment);
        }
    }
}
