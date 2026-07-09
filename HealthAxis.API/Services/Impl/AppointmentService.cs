using AutoMapper;
using HealthAxis.API.Constants;
using HealthAxis.API.Events;
using HealthAxis.API.Exceptions;
using HealthAxis.API.Messaging;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using HealthAxis.Shared.Constants;
using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Dtos.Appointment;
using HealthAxis.Shared.Enums;

namespace HealthAxis.API.Services.Impl;

public class AppointmentService(
    IAppointmentRepository appointmentRepository,
    IPatientRepository patientRepository,
    IDoctorRepository doctorRepository,
    IMapper mapper,
    IRabbitMqPublisher rabbitMqPublisher) : IAppointmentService
{
    private const int MinimumBookingHoursBeforeAppointment = 48;
    private const int MinimumCancellationHoursBeforeAppointment = 24;
    private const int PendingAutoCancelHoursBeforeAppointment = 24;
    private const int MaximumBookingMonthsAhead = 6;

    public async Task<PagedResultDto<AppointmentDto>> GetAllAppointmentsAsync(PaginationQueryDto pagination)
    {
        await AutoCancelExpiredPendingAppointmentsAsync();

        var appointments = await appointmentRepository.GetAllAppointmentsAsync(
            pagination.PageNumber,
            pagination.PageSize);

        return MapPagedResult<Appointment, AppointmentDto>(appointments);
    }

    public async Task<AppointmentDto> GetAppointmentByIdAsync(int id)
    {
        await AutoCancelExpiredPendingAppointmentsAsync();

        var appointment = await appointmentRepository.GetAppointmentByIdWithDetailsAsync(id);

        if (appointment == null)
        {
            throw new NotFoundException(ErrorMessages.AppointmentNotFound);
        }

        return mapper.Map<AppointmentDto>(appointment);
    }

    public async Task<AppointmentDto?> CreateAppointmentAsync(CreateAppointmentDto dto)
    {
        await ValidateAppointmentCanBeCreatedAsync(dto);

        var appointment = new Appointment
        {
            PatientId = dto.PatientId,
            DoctorId = dto.DoctorId,
            AppointmentDate = dto.AppointmentDate,
            AppointmentTime = dto.AppointmentTime,
            Status = AppointmentStatus.Pending
        };

        var createdAppointment = await appointmentRepository.AddAsync(appointment);

        var appointmentWithDetails = await appointmentRepository
            .GetAppointmentByIdWithDetailsAsync(createdAppointment.Id);

        if (appointmentWithDetails == null)
        {
            throw new NotFoundException(ErrorMessages.AppointmentNotFoundAfterCreation);
        }

        await rabbitMqPublisher.PublishAppointmentBookedAsync(new AppointmentBookedEvent
        {
            AppointmentId = appointmentWithDetails.Id,
            PatientId = appointmentWithDetails.PatientId,
            DoctorId = appointmentWithDetails.DoctorId,
            ScheduledDate = appointmentWithDetails.AppointmentDate,
            TimeSlot = appointmentWithDetails.AppointmentTime,
            OccurredAt = DateTime.UtcNow
        });

        return mapper.Map<AppointmentDto>(appointmentWithDetails);
    }

    public async Task<PagedResultDto<AppointmentDto>> GetAppointmentsByDoctorIdAsync(
        int doctorId,
        AppointmentStatus? status,
        PaginationQueryDto pagination)
    {
        await AutoCancelExpiredPendingAppointmentsAsync();

        var appointments = await appointmentRepository.GetAppointmentsByDoctorIdAsync(
            doctorId,
            status,
            pagination.PageNumber,
            pagination.PageSize);

        return MapPagedResult<Appointment, AppointmentDto>(appointments);
    }

    public async Task<PagedResultDto<AppointmentDto>> GetAppointmentsByPatientIdAsync(
        int patientId,
        AppointmentStatus? status,
        PaginationQueryDto pagination)
    {
        await AutoCancelExpiredPendingAppointmentsAsync();

        var appointments = await appointmentRepository.GetAppointmentsByPatientIdAsync(
            patientId,
            status,
            pagination.PageNumber,
            pagination.PageSize);

        return MapPagedResult<Appointment, AppointmentDto>(appointments);
    }

    public async Task<PagedResultDto<AppointmentDto>> GetAppointmentsByDoctorIdAndDateAsync(
        int doctorId,
        DateOnly date,
        PaginationQueryDto pagination)
    {
        await AutoCancelExpiredPendingAppointmentsAsync();

        var appointments = await appointmentRepository.GetAppointmentsByDoctorIdAndDateAsync(
            doctorId,
            date,
            pagination.PageNumber,
            pagination.PageSize);

        return MapPagedResult<Appointment, AppointmentDto>(appointments);
    }

    public async Task<PagedResultDto<AppointmentDto>> GetAppointmentsByDateAndStatusAsync(
        DateOnly date,
        AppointmentStatus? status,
        PaginationQueryDto pagination)
    {
        await AutoCancelExpiredPendingAppointmentsAsync();

        var appointments = await appointmentRepository.GetAppointmentsByDateAndStatusAsync(
            date,
            status,
            pagination.PageNumber,
            pagination.PageSize);

        return MapPagedResult<Appointment, AppointmentDto>(appointments);
    }

    public async Task<AppointmentDto?> UpdateAppointmentStatusAsync(
        int id,
        UpdateAppointmentStatusDto dto,
        string currentRole,
        int? currentPatientId,
        int? currentDoctorId)
    {
        await AutoCancelExpiredPendingAppointmentsAsync();

        var appointment = await appointmentRepository.GetAppointmentByIdWithDetailsAsync(id);

        if (appointment == null)
        {
            throw new NotFoundException(ErrorMessages.AppointmentNotFound);
        }

        switch (dto.Status)
        {
            case AppointmentStatus.Confirmed:
                ConfirmAppointment(appointment, currentRole, currentDoctorId);
                break;

            case AppointmentStatus.Cancelled:
                CancelAppointment(appointment, dto, currentRole, currentPatientId, currentDoctorId);
                break;

            case AppointmentStatus.Completed:
                throw new BusinessRuleException(ErrorMessages.AppointmentCompletedOnlyThroughHealthRecord);

            default:
                throw new BusinessRuleException(ErrorMessages.UnsupportedAppointmentStatusTransition);
        }

        await appointmentRepository.UpdateAsync(appointment);

        var appointmentWithDetails = await appointmentRepository.GetAppointmentByIdWithDetailsAsync(id);

        return appointmentWithDetails == null
            ? throw new NotFoundException(ErrorMessages.AppointmentNotFound)
            : mapper.Map<AppointmentDto>(appointmentWithDetails);
    }

    public async Task<List<AppointmentReportDto>> GetAppointmentReportsAsync()
    {
        await AutoCancelExpiredPendingAppointmentsAsync();

        return await appointmentRepository.GetAppointmentReportsAsync();
    }

    private async Task ValidateAppointmentCanBeCreatedAsync(CreateAppointmentDto dto)
    {
        var patient = await patientRepository.GetByIdAsync(dto.PatientId);

        if (patient == null)
        {
            throw new NotFoundException(ErrorMessages.PatientNotFound);
        }

        var doctor = await doctorRepository.GetDoctorByIdAsync(dto.DoctorId);

        if (doctor == null)
        {
            throw new NotFoundException(ErrorMessages.DoctorNotFound);
        }

        if (!doctor.IsAvailable)
        {
            throw new BusinessRuleException(ErrorMessages.DoctorUnavailable);
        }

        if (!IsAtLeastHoursAhead(dto.AppointmentDate, dto.AppointmentTime, MinimumBookingHoursBeforeAppointment))
        {
            throw new BusinessRuleException(ErrorMessages.AppointmentMustBeBookedAtLeast48HoursAhead);
        }

        if (IsMoreThanMonthsAhead(dto.AppointmentDate, MaximumBookingMonthsAhead))
        {
            throw new BusinessRuleException(ErrorMessages.AppointmentCannotBeBookedMoreThanSixMonthsAhead);
        }

        if (await appointmentRepository.DoctorHasNonCancelledAppointmentAtAsync(
                dto.DoctorId,
                dto.AppointmentDate,
                dto.AppointmentTime))
        {
            throw new ConflictException(ErrorMessages.DoctorSlotAlreadyBooked);
        }

        if (await appointmentRepository.PatientHasNonCancelledAppointmentAtAsync(
                dto.PatientId,
                dto.AppointmentDate,
                dto.AppointmentTime))
        {
            throw new ConflictException(ErrorMessages.PatientSlotAlreadyBooked);
        }

        if (await appointmentRepository.PatientHasNonCancelledAppointmentWithDoctorOnDateAsync(
                dto.PatientId,
                dto.DoctorId,
                dto.AppointmentDate))
        {
            throw new ConflictException(ErrorMessages.PatientAlreadyHasAppointmentWithDoctorOnDate);
        }
    }

    private static void ConfirmAppointment(Appointment appointment, string currentRole, int? currentDoctorId)
    {
        if (appointment.Status != AppointmentStatus.Pending)
        {
            throw new BusinessRuleException(ErrorMessages.OnlyPendingAppointmentsCanBeConfirmed);
        }

        if (currentRole == AppRoles.Patient)
        {
            throw new ForbiddenException(ErrorMessages.UnsupportedAppointmentStatusTransition);
        }

        if (currentRole == AppRoles.Doctor && currentDoctorId != appointment.DoctorId)
        {
            throw new ForbiddenException(ErrorMessages.DoctorsCanManageOnlyOwnAppointments);
        }

        appointment.Status = AppointmentStatus.Confirmed;
        appointment.CancellationReason = null;
    }

    private static void CancelAppointment(
        Appointment appointment,
        UpdateAppointmentStatusDto dto,
        string currentRole,
        int? currentPatientId,
        int? currentDoctorId)
    {
        EnsureAppointmentCanBeCancelled(appointment, dto);

        var reason = dto.CancellationReason!.Trim();

        appointment.CancellationReason = currentRole switch
        {
            AppRoles.Patient => BuildPatientCancellationReason(
                appointment,
                reason,
                currentPatientId),

            AppRoles.Doctor => BuildDoctorCancellationReason(
                appointment,
                reason,
                currentDoctorId),

            AppRoles.Admin => reason + ErrorMessages.CancelledByAdminSuffix,

            _ => throw new ForbiddenException(ErrorMessages.UnsupportedAppointmentStatusTransition)
        };

        appointment.Status = AppointmentStatus.Cancelled;
    }

    private static void EnsureAppointmentCanBeCancelled(
        Appointment appointment,
        UpdateAppointmentStatusDto dto)
    {
        if (string.IsNullOrWhiteSpace(dto.CancellationReason))
        {
            throw new BusinessRuleException(ErrorMessages.CancellationReasonRequired);
        }

        if (appointment.Status == AppointmentStatus.Completed)
        {
            throw new BusinessRuleException(ErrorMessages.CompletedAppointmentsCannotBeCancelled);
        }

        if (appointment.Status == AppointmentStatus.Cancelled)
        {
            throw new BusinessRuleException(ErrorMessages.CancelledAppointmentsCannotBeCancelledAgain);
        }
    }

    private static string BuildPatientCancellationReason(
        Appointment appointment,
        string reason,
        int? currentPatientId)
    {
        if (currentPatientId != appointment.PatientId)
        {
            throw new ForbiddenException(ErrorMessages.PatientsCanManageOnlyOwnAppointments);
        }

        if (appointment.Status != AppointmentStatus.Pending)
        {
            throw new BusinessRuleException(ErrorMessages.PatientsCanCancelOnlyPendingAppointments);
        }

        return reason + ErrorMessages.CancelledByPatientSuffix;
    }

    private static string BuildDoctorCancellationReason(
        Appointment appointment,
        string reason,
        int? currentDoctorId)
    {
        if (currentDoctorId != appointment.DoctorId)
        {
            throw new ForbiddenException(ErrorMessages.DoctorsCanManageOnlyOwnAppointments);
        }

        if (appointment.Status != AppointmentStatus.Pending &&
            appointment.Status != AppointmentStatus.Confirmed)
        {
            throw new BusinessRuleException(ErrorMessages.DoctorsCanCancelOnlyPendingOrConfirmedAppointments);
        }

        if (!IsAtLeastHoursAhead(
                appointment.AppointmentDate,
                appointment.AppointmentTime,
                MinimumCancellationHoursBeforeAppointment))
        {
            throw new BusinessRuleException(ErrorMessages.AppointmentCannotBeCancelledWithin24Hours);
        }

        return reason + ErrorMessages.CancelledByDoctorSuffix;
    }

    private async Task AutoCancelExpiredPendingAppointmentsAsync()
    {
        var cutoffDateTime = DateTime.Now.AddHours(PendingAutoCancelHoursBeforeAppointment);
        var expiredPendingAppointments = await appointmentRepository.GetExpiredPendingAppointmentsAsync(cutoffDateTime);

        foreach (var appointment in expiredPendingAppointments)
        {
            appointment.Status = AppointmentStatus.Cancelled;
            appointment.CancellationReason = ErrorMessages.PendingAppointmentAutoCancelledReason;

            await appointmentRepository.UpdateAsync(appointment);
        }
    }

    private static bool IsAtLeastHoursAhead(DateOnly date, TimeOnly time, int minimumHours)
    {
        var scheduledAt = date.ToDateTime(time);

        return scheduledAt >= DateTime.Now.AddHours(minimumHours);
    }

    private static bool IsMoreThanMonthsAhead(DateOnly date, int maximumMonths)
    {
        var latestAllowedDate = DateOnly.FromDateTime(DateTime.Today).AddMonths(maximumMonths);

        return date > latestAllowedDate;
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
}
