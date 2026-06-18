using AutoMapper;
using HealthAxis.API.Constants;
using HealthAxis.API.Dtos;
using HealthAxis.API.Enums;
using HealthAxis.API.Exceptions;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;

namespace HealthAxis.API.Services.Impl;

public class AppointmentService(
    IAppointmentRepository appointmentRepository,
    IPatientRepository patientRepository,
    IDoctorRepository doctorRepository,
    IMapper mapper) : IAppointmentService
{
    private const int MinimumHoursBeforeAppointment = 24;

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

        var appointmentWithDetails = await appointmentRepository.GetAppointmentByIdWithDetailsAsync(createdAppointment.Id);

        return appointmentWithDetails == null
            ? throw new NotFoundException(ErrorMessages.AppointmentNotFoundAfterCreation)
            : mapper.Map<AppointmentDto>(appointmentWithDetails);
    }

    public async Task<PagedResultDto<AppointmentDto>> GetAppointmentsByDoctorIdAsync(
        int doctorId,
        PaginationQueryDto pagination)
    {
        await AutoCancelExpiredPendingAppointmentsAsync();

        var appointments = await appointmentRepository.GetAppointmentsByDoctorIdAsync(
            doctorId,
            pagination.PageNumber,
            pagination.PageSize);

        return MapPagedResult<Appointment, AppointmentDto>(appointments);
    }

    public async Task<PagedResultDto<AppointmentDto>> GetAppointmentsByPatientIdAsync(
        int patientId,
        PaginationQueryDto pagination)
    {
        await AutoCancelExpiredPendingAppointmentsAsync();

        var appointments = await appointmentRepository.GetAppointmentsByPatientIdAsync(
            patientId,
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

    public async Task<AppointmentDto?> DeleteAppointmentAsync(int id)
    {
        var appointment = await appointmentRepository.GetAppointmentByIdWithDetailsAsync(id);

        if (appointment == null)
        {
            throw new NotFoundException(ErrorMessages.AppointmentNotFound);
        }

        if (appointment.HealthRecord != null)
        {
            throw new BusinessRuleException(ErrorMessages.AppointmentCannotBeDeletedBecauseHealthRecordExists);
        }

        var deletedAppointment = await appointmentRepository.DeleteAppointmentAsync(id);

        return deletedAppointment == null
            ? throw new NotFoundException(ErrorMessages.AppointmentNotFound)
            : mapper.Map<AppointmentDto>(deletedAppointment);
    }

    public async Task<List<AppointmentReportDto>> GetAppointmentReportsAsync()
    {
        await AutoCancelExpiredPendingAppointmentsAsync();

        var appointments = await appointmentRepository.GetAllAsync();

        return appointments
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
            .OrderBy(report => report.Date)
            .ToList();
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

        if (!IsAtLeast24HoursAhead(dto.AppointmentDate, dto.AppointmentTime))
        {
            throw new BusinessRuleException(ErrorMessages.AppointmentMustBeBookedAtLeast24HoursAhead);
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

        var reason = dto.CancellationReason.Trim();

        if (currentRole == AppRoles.Patient)
        {
            if (currentPatientId != appointment.PatientId)
            {
                throw new ForbiddenException(ErrorMessages.PatientsCanManageOnlyOwnAppointments);
            }

            if (!IsAtLeast24HoursAhead(appointment.AppointmentDate, appointment.AppointmentTime))
            {
                throw new BusinessRuleException(ErrorMessages.AppointmentCannotBeCancelledWithin24Hours);
            }

            appointment.CancellationReason = reason + ErrorMessages.CancelledByPatientSuffix;
        }
        else if (currentRole == AppRoles.Doctor)
        {
            if (currentDoctorId != appointment.DoctorId)
            {
                throw new ForbiddenException(ErrorMessages.DoctorsCanManageOnlyOwnAppointments);
            }

            if (!IsAtLeast24HoursAhead(appointment.AppointmentDate, appointment.AppointmentTime))
            {
                throw new BusinessRuleException(ErrorMessages.AppointmentCannotBeCancelledWithin24Hours);
            }

            appointment.CancellationReason = reason + ErrorMessages.CancelledByDoctorSuffix;
        }
        else if (currentRole == AppRoles.Admin)
        {
            appointment.CancellationReason = reason + ErrorMessages.CancelledByAdminSuffix;
        }
        else
        {
            throw new ForbiddenException(ErrorMessages.UnsupportedAppointmentStatusTransition);
        }

        appointment.Status = AppointmentStatus.Cancelled;
    }

    private async Task AutoCancelExpiredPendingAppointmentsAsync()
    {
        var pendingAppointments = await appointmentRepository.GetPendingAppointmentsAsync();

        foreach (var appointment in pendingAppointments)
        {
            if (IsAtLeast24HoursAhead(appointment.AppointmentDate, appointment.AppointmentTime))
            {
                continue;
            }

            appointment.Status = AppointmentStatus.Cancelled;
            appointment.CancellationReason = ErrorMessages.PendingAppointmentAutoCancelledReason;

            await appointmentRepository.UpdateAsync(appointment);
        }
    }

    private static bool IsAtLeast24HoursAhead(DateOnly date, TimeOnly time)
    {
        var scheduledAt = date.ToDateTime(time);

        return scheduledAt >= DateTime.Now.AddHours(MinimumHoursBeforeAppointment);
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
