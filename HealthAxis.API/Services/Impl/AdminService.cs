using AutoMapper;
using HealthAxis.API.Constants;
using HealthAxis.API.Data;
using HealthAxis.API.Dtos;
using HealthAxis.API.Exceptions;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace HealthAxis.API.Services.Impl;

public class AdminService(
    HealthAxisDbContext context,
    IDoctorRepository doctorRepository,
    IAppointmentService appointmentService,
    IMapper mapper,
    UserManager<IdentityUser> userManager) : IAdminService
{
    public async Task<PagedResultDto<DoctorDto>> GetDoctorsAsync(PaginationQueryDto pagination)
    {
        var doctors = await doctorRepository.GetAllDoctorsWithUserAsync(
            pagination.PageNumber,
            pagination.PageSize);

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
        var doctor = await doctorRepository.GetDoctorByIdAsync(id);

        if (doctor == null)
        {
            throw new NotFoundException(ErrorMessages.DoctorNotFound);
        }

        doctor.FullName = dto.FullName;
        doctor.Specialisation = dto.Specialisation;
        doctor.PracticeStartDate = dto.PracticeStartDate;
        doctor.ConsultationFee = dto.ConsultationFee;

        var updatedDoctor = await doctorRepository.UpdateAsync(doctor);

        if (updatedDoctor == null)
        {
            throw new NotFoundException(ErrorMessages.DoctorNotFound);
        }

        var doctorWithUser = await doctorRepository.GetDoctorByIdWithUserAsync(updatedDoctor.Id);

        return doctorWithUser == null
            ? throw new NotFoundException(ErrorMessages.DoctorNotFound)
            : mapper.Map<DoctorDto>(doctorWithUser);
    }

    public async Task<List<AppointmentReportDto>> GetAppointmentReportsAsync()
    {
        return await appointmentService.GetAppointmentReportsAsync();
    }

    public async Task<List<AppointmentHealthRecordReportDto>> GetAppointmentHealthRecordReportsAsync()
    {
        return await context.Appointments
            .Include(appointment => appointment.Patient)
            .Include(appointment => appointment.Doctor)
            .Include(appointment => appointment.HealthRecord)
            .OrderBy(appointment => appointment.AppointmentDate)
            .ThenBy(appointment => appointment.AppointmentTime)
            .Select(appointment => new AppointmentHealthRecordReportDto
            {
                AppointmentId = appointment.Id,
                PatientId = appointment.PatientId,
                DoctorId = appointment.DoctorId,
                PatientName = appointment.Patient != null ? appointment.Patient.FullName : string.Empty,
                DoctorName = appointment.Doctor != null ? appointment.Doctor.FullName : string.Empty,
                AppointmentDate = appointment.AppointmentDate,
                AppointmentTime = appointment.AppointmentTime,
                AppointmentStatus = appointment.Status,
                HasHealthRecord = appointment.HealthRecord != null,
                HealthRecordId = appointment.HealthRecord != null ? appointment.HealthRecord.Id : null,
                HealthRecordVisitDate = appointment.HealthRecord != null ? appointment.HealthRecord.VisitDate : null
            })
            .ToListAsync();
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
