using AutoMapper;
using HealthAxis.API.Constants;
using HealthAxis.Shared.Constants;
using HealthAxis.API.Data;
using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Dtos.Appointment;
using HealthAxis.Shared.Dtos.Auth;
using HealthAxis.Shared.Dtos.Doctor;
using HealthAxis.Shared.Dtos.Patient;
using HealthAxis.Shared.Enums;
using HealthAxis.API.Exceptions;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace HealthAxis.API.Services.Impl;

public class AdminService(
    HealthAxisDbContext context,
    IDoctorRepository doctorRepository,
    IPatientRepository patientRepository,
    IAppointmentService appointmentService,
    IMapper mapper,
    UserManager<IdentityUser> userManager) : IAdminService
{
    public async Task<AdminDashboardSummaryDto> GetDashboardSummaryAsync()
    {
        var today = DateOnly.FromDateTime(DateTime.Today);

        return new AdminDashboardSummaryDto
        {
            ActiveDoctorsCount = await context.Doctors.CountAsync(doctor => doctor.IsAvailable),
            RegisteredPatientsCount = await context.Patients.CountAsync(),
            PendingAppointmentsCount = await context.Appointments.CountAsync(appointment => appointment.Status == AppointmentStatus.Pending),
            ConfirmedAppointmentsCount = await context.Appointments.CountAsync(appointment => appointment.Status == AppointmentStatus.Confirmed),
            CompletedAppointmentsCount = await context.Appointments.CountAsync(appointment => appointment.Status == AppointmentStatus.Completed),
            CancelledAppointmentsCount = await context.Appointments.CountAsync(appointment => appointment.Status == AppointmentStatus.Cancelled),
            TodaysAppointmentsCount = await context.Appointments.CountAsync(appointment => appointment.AppointmentDate == today),
            TodaysPendingAppointmentsCount = await context.Appointments.CountAsync(appointment => appointment.AppointmentDate == today && appointment.Status == AppointmentStatus.Pending),
            TodaysConfirmedAppointmentsCount = await context.Appointments.CountAsync(appointment => appointment.AppointmentDate == today && appointment.Status == AppointmentStatus.Confirmed),
            TodaysCompletedAppointmentsCount = await context.Appointments.CountAsync(appointment => appointment.AppointmentDate == today && appointment.Status == AppointmentStatus.Completed),
            TodaysCancelledAppointmentsCount = await context.Appointments.CountAsync(appointment => appointment.AppointmentDate == today && appointment.Status == AppointmentStatus.Cancelled)
        };
    }

    public async Task<PagedResultDto<DoctorDto>> GetDoctorsAsync(
        PaginationQueryDto pagination,
        string? search = null,
        DoctorSpecialisation? specialisation = null)
    {
        var doctors = await doctorRepository.GetAllDoctorsWithUserAsync(
            pagination.PageNumber,
            pagination.PageSize,
            search,
            specialisation);

        return MapPagedResult<Doctor, DoctorDto>(doctors);
    }

    public async Task<DoctorDto?> CreateDoctorAsync(CreateDoctorDto dto)
    {
        var existingUser = await userManager.FindByEmailAsync(dto.Email);

        if (existingUser != null)
        {
            throw new ConflictException(ErrorMessages.EmailAlreadyExists);
        }

        await using var transaction = await context.Database.BeginTransactionAsync();

        try
        {
            var user = new IdentityUser
            {
                UserName = dto.Email,
                Email = dto.Email,
                PhoneNumber = dto.PhoneNumber,
                EmailConfirmed = true
            };

            var createUserResult = await userManager.CreateAsync(user, dto.Password);

            if (!createUserResult.Succeeded)
            {
                var errors = string.Join(" ", createUserResult.Errors.Select(error => error.Description));
                throw new BadRequestException(errors);
            }

            var addRoleResult = await userManager.AddToRoleAsync(user, AppRoles.Doctor);

            if (!addRoleResult.Succeeded)
            {
                var errors = string.Join(" ", addRoleResult.Errors.Select(error => error.Description));
                throw new BadRequestException(errors);
            }

            var doctor = new Doctor
            {
                UserId = user.Id,
                FullName = dto.FullName,
                Specialisation = dto.Specialisation,
                PracticeStartDate = dto.PracticeStartDate,
                ConsultationFee = dto.ConsultationFee,
                IsAvailable = dto.IsAvailable
            };

            var createdDoctor = await doctorRepository.AddAsync(doctor);

            await transaction.CommitAsync();

            var doctorWithUser = await doctorRepository.GetDoctorByIdWithUserAsync(createdDoctor.Id);

            return doctorWithUser == null
                ? throw new NotFoundException(ErrorMessages.DoctorNotFoundAfterCreation)
                : mapper.Map<DoctorDto>(doctorWithUser);
        }
        catch
        {
            await transaction.RollbackAsync();
            throw;
        }
    }

    public async Task<DoctorDto?> UpdateDoctorAsync(int id, UpdateDoctorDto dto)
    {
        var doctor = await doctorRepository.GetDoctorByIdWithUserAsync(id);

        if (doctor == null)
        {
            throw new NotFoundException(ErrorMessages.DoctorNotFound);
        }

        if (doctor.User == null)
        {
            throw new NotFoundException(ErrorMessages.DoctorNotFound);
        }

        await EnsureEmailIsAvailableForUserAsync(dto.Email, doctor.UserId);

        doctor.FullName = dto.FullName;
        doctor.Specialisation = dto.Specialisation;
        doctor.PracticeStartDate = dto.PracticeStartDate;
        doctor.ConsultationFee = dto.ConsultationFee;
        doctor.User.Email = dto.Email.Trim();
        doctor.User.UserName = dto.Email.Trim();
        doctor.User.PhoneNumber = dto.PhoneNumber;
        doctor.User.EmailConfirmed = true;

        var updateUserResult = await userManager.UpdateAsync(doctor.User);

        if (!updateUserResult.Succeeded)
        {
            var errors = string.Join(" ", updateUserResult.Errors.Select(error => error.Description));
            throw new BadRequestException(errors);
        }

        await doctorRepository.UpdateAsync(doctor);

        var updatedDoctor = await doctorRepository.GetDoctorByIdWithUserAsync(id);

        return updatedDoctor == null
            ? throw new NotFoundException(ErrorMessages.DoctorNotFound)
            : mapper.Map<DoctorDto>(updatedDoctor);
    }

    public async Task ResetDoctorPasswordAsync(int id, AdminResetPasswordDto dto)
    {
        var doctor = await doctorRepository.GetDoctorByIdWithUserAsync(id);

        if (doctor == null || doctor.User == null)
        {
            throw new NotFoundException(ErrorMessages.DoctorNotFound);
        }

        await ResetUserPasswordAsync(doctor.User, dto);
    }

    public async Task<PagedResultDto<AppointmentDto>> GetDoctorAppointmentsAsync(int doctorId, AppointmentStatus? status, PaginationQueryDto pagination)
    {
        var doctorExists = await doctorRepository.GetDoctorByIdAsync(doctorId);

        if (doctorExists == null)
        {
            throw new NotFoundException(ErrorMessages.DoctorNotFound);
        }

        return await appointmentService.GetAppointmentsByDoctorIdAsync(doctorId, status, pagination);
    }

    public async Task<PagedResultDto<PatientDto>> GetPatientsAsync(PaginationQueryDto pagination, string? search)
    {
        var patients = await patientRepository.GetAllPatientsWithUserAsync(
            pagination.PageNumber,
            pagination.PageSize,
            search);

        return MapPagedResult<Patient, PatientDto>(patients);
    }

    public async Task<PatientDto?> UpdatePatientAsync(int id, UpdatePatientDto dto)
    {
        var patient = await patientRepository.GetPatientByIdWithUserAsync(id);

        if (patient == null)
        {
            throw new NotFoundException(ErrorMessages.PatientNotFound);
        }

        if (patient.User == null)
        {
            throw new NotFoundException(ErrorMessages.PatientAccountNotFound);
        }

        await EnsureEmailIsAvailableForUserAsync(dto.Email, patient.UserId);

        patient.FullName = dto.FullName;
        patient.DateOfBirth = dto.DateOfBirth;
        patient.Gender = dto.Gender;
        patient.Address = dto.Address;
        patient.User.Email = dto.Email.Trim();
        patient.User.UserName = dto.Email.Trim();
        patient.User.PhoneNumber = dto.PhoneNumber;
        patient.User.EmailConfirmed = true;

        var updateUserResult = await userManager.UpdateAsync(patient.User);

        if (!updateUserResult.Succeeded)
        {
            var errors = string.Join(" ", updateUserResult.Errors.Select(error => error.Description));
            throw new BadRequestException(errors);
        }

        await patientRepository.UpdateAsync(patient);

        var updatedPatient = await patientRepository.GetPatientByIdWithUserAsync(id);

        return updatedPatient == null
            ? throw new NotFoundException(ErrorMessages.PatientNotFound)
            : mapper.Map<PatientDto>(updatedPatient);
    }

    public async Task ResetPatientPasswordAsync(int id, AdminResetPasswordDto dto)
    {
        var patient = await patientRepository.GetPatientByIdWithUserAsync(id);

        if (patient == null)
        {
            throw new NotFoundException(ErrorMessages.PatientNotFound);
        }

        if (patient.User == null)
        {
            throw new NotFoundException(ErrorMessages.PatientAccountNotFound);
        }

        await ResetUserPasswordAsync(patient.User, dto);
    }

    public async Task<PagedResultDto<AppointmentDto>> GetPatientAppointmentsAsync(int patientId, AppointmentStatus? status, PaginationQueryDto pagination)
    {
        return await appointmentService.GetAppointmentsByPatientIdAsync(patientId, status, pagination);
    }

    public async Task<PagedResultDto<AppointmentReportDto>> GetAppointmentReportsAsync(PaginationQueryDto pagination)
    {
        var reports = await appointmentService.GetAppointmentReportsAsync();

        var orderedReports = reports
            .OrderByDescending(report => report.Date)
            .ToList();

        var totalCount = orderedReports.Count;
        var totalPages = (int)Math.Ceiling(totalCount / (double)pagination.PageSize);

        var items = orderedReports
            .Skip((pagination.PageNumber - 1) * pagination.PageSize)
            .Take(pagination.PageSize)
            .ToList();

        return new PagedResultDto<AppointmentReportDto>
        {
            Items = items,
            PageNumber = pagination.PageNumber,
            PageSize = pagination.PageSize,
            TotalCount = totalCount,
            TotalPages = totalPages
        };
    }

    public async Task<PagedResultDto<AppointmentDto>> GetAppointmentReportDetailsAsync(
        DateOnly date,
        AppointmentStatus? status,
        PaginationQueryDto pagination)
    {
        return await appointmentService.GetAppointmentsByDateAndStatusAsync(date, status, pagination);
    }

    private async Task ResetUserPasswordAsync(IdentityUser user, AdminResetPasswordDto dto)
    {
        var resetToken = await userManager.GeneratePasswordResetTokenAsync(user);
        var resetResult = await userManager.ResetPasswordAsync(user, resetToken, dto.NewPassword);

        if (!resetResult.Succeeded)
        {
            var errors = string.Join(" ", resetResult.Errors.Select(error => error.Description));
            throw new BadRequestException(errors);
        }
    }

    private async Task EnsureEmailIsAvailableForUserAsync(string email, string currentUserId)
    {
        var normalizedEmail = email.Trim();
        var existingUser = await userManager.FindByEmailAsync(normalizedEmail);

        if (existingUser != null && existingUser.Id != currentUserId)
        {
            throw new ConflictException(ErrorMessages.EmailAlreadyExists);
        }
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
