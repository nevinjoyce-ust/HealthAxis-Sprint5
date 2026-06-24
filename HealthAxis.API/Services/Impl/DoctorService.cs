using AutoMapper;
using HealthAxis.API.Constants;
using HealthAxis.Shared.Constants;
using HealthAxis.Shared.Dtos.Doctor;
using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Enums;
using HealthAxis.API.Exceptions;
using HealthAxis.API.Repositories;

namespace HealthAxis.API.Services.Impl;

public class DoctorService(
    IDoctorRepository doctorRepository,
    IMapper mapper,
    IAppointmentRepository? appointmentRepository = null) : IDoctorService
{
    public async Task<PagedResultDto<PublicDoctorDto>> GetAllDoctorsAsync(
        PaginationQueryDto pagination,
        DoctorSpecialisation? specialisation)
    {
        var doctors = await doctorRepository.GetAllDoctorsAsync(
            pagination.PageNumber,
            pagination.PageSize,
            specialisation);

        return MapPagedResult<HealthAxis.API.Models.Doctor, PublicDoctorDto>(doctors);
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

    public async Task<DoctorAvailabilityDto> UpdateAvailabilityAsync(
    int id,
    UpdateDoctorAvailabilityDto dto,
    string currentRole,
    int? currentDoctorId)
    {
        var appointmentRepositoryInstance = appointmentRepository
            ?? throw new InvalidOperationException("Appointment repository is required to update doctor availability.");

        var doctor = await doctorRepository.GetDoctorByIdAsync(id);

        if (doctor == null)
        {
            throw new NotFoundException(ErrorMessages.DoctorNotFound);
        }

        ValidateAvailabilityUpdatePermission(id, currentRole, currentDoctorId);

        var isDeactivation = doctor.IsAvailable && !dto.IsAvailable;

        if (isDeactivation)
        {
            await HandleDeactivationAsync(
                id,
                currentRole,
                appointmentRepositoryInstance);
        }

        doctor.IsAvailable = dto.IsAvailable;

        var updatedDoctor = await doctorRepository.UpdateAsync(doctor);

        if (updatedDoctor == null)
        {
            throw new NotFoundException(ErrorMessages.DoctorNotFound);
        }

        return CreateAvailabilityDto(updatedDoctor.Id, updatedDoctor.IsAvailable);
    }

    private PagedResultDto<TDestination> MapPagedResult<TSource, TDestination>(PagedResult<TSource> pagedResult)
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
    private static async Task HandleDeactivationAsync(
    int doctorId,
    string currentRole,
    IAppointmentRepository appointmentRepositoryInstance)
    {
        var today = DateOnly.FromDateTime(DateTime.Today);

        if (currentRole == AppRoles.Doctor)
        {
            await EnsureDoctorCanDeactivateSelfAsync(
                doctorId,
                today,
                appointmentRepositoryInstance);

            return;
        }

        if (currentRole == AppRoles.Admin)
        {
            await CancelTodaysAppointmentsForAdminDeactivationAsync(
                doctorId,
                today,
                appointmentRepositoryInstance);
        }
    }

    private static async Task EnsureDoctorCanDeactivateSelfAsync(
        int doctorId,
        DateOnly today,
        IAppointmentRepository appointmentRepositoryInstance)
    {
        var hasConfirmedAppointmentsToday = await appointmentRepositoryInstance
            .DoctorHasConfirmedAppointmentsOnDateAsync(doctorId, today);

        if (hasConfirmedAppointmentsToday)
        {
            throw new BusinessRuleException(ErrorMessages.DoctorCannotDeactivateWithConfirmedAppointmentsToday);
        }
    }

    private static async Task CancelTodaysAppointmentsForAdminDeactivationAsync(
        int doctorId,
        DateOnly today,
        IAppointmentRepository appointmentRepositoryInstance)
    {
        var appointmentsToCancel = await appointmentRepositoryInstance
            .GetPendingOrConfirmedAppointmentsByDoctorIdAndDateAsync(doctorId, today);

        foreach (var appointment in appointmentsToCancel)
        {
            appointment.Status = AppointmentStatus.Cancelled;
            appointment.CancellationReason = ErrorMessages.DoctorEmergencyCancellationReason;

            await appointmentRepositoryInstance.UpdateAsync(appointment);
        }
    }
}
