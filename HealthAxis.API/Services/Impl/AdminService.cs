using AutoMapper;
using HealthAxis.API.Data;
using HealthAxis.API.Dtos;
using HealthAxis.API.Enums;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using HealthAxis.API.Services;

namespace HealthAxis.API.Services.Impl;

public class AdminService(
    HealthAxisDbContext context,
    IDoctorRepository doctorRepository,
    IUserRepository userRepository,
    IAppointmentService appointmentService,
    IMapper mapper) : IAdminService
{
    public async Task<List<DoctorDto>> GetDoctorsAsync()
    {
        var doctors = await doctorRepository.GetAllAsync();

        var doctorDtos = new List<DoctorDto>();

        foreach (var doctor in doctors)
        {
            var doctorDto = await MapDoctorToDtoAsync(doctor);
            doctorDtos.Add(doctorDto);
        }

        return doctorDtos;
    }

    public async Task<DoctorDto?> CreateDoctorAsync(CreateDoctorDto dto)
    {
        var existingUser = await userRepository.GetByEmailAsync(dto.Email);

        if (existingUser != null)
        {
            return null;
        }

        await using var transaction = await context.Database.BeginTransactionAsync();

        try
        {
            var user = new User
            {
                FullName = dto.FullName,
                Email = dto.Email,
                PasswordHash = dto.Password, // Temporary until password hashing/JWT auth is added.
                Role = UserRole.Doctor,
                IsActive = true
            };

            var createdUser = await userRepository.AddAsync(user);

            var doctor = new Doctor
            {
                UserId = createdUser.Id,
                Specialisation = dto.Specialisation,
                PracticeStartDate = dto.PracticeStartDate,
                ConsultationFee = dto.ConsultationFee,
                IsAvailable = dto.IsAvailable
            };

            var createdDoctor = await doctorRepository.AddAsync(doctor);

            await transaction.CommitAsync();

            return await MapDoctorToDtoAsync(createdDoctor);
        }
        catch
        {
            await transaction.RollbackAsync();
            throw;
        }
    }

    public async Task<DoctorDto?> UpdateDoctorAsync(int id, UpdateDoctorDto dto)
    {
        var doctor = await doctorRepository.GetByIdAsync(id);

        if (doctor == null)
        {
            return null;
        }

        await using var transaction = await context.Database.BeginTransactionAsync();

        try
        {
            doctor.Specialisation = dto.Specialisation;
            doctor.PracticeStartDate = dto.PracticeStartDate;
            doctor.ConsultationFee = dto.ConsultationFee;
            doctor.IsAvailable = dto.IsAvailable;

            var user = await userRepository.GetByIdAsync(doctor.UserId);

            if (user != null)
            {
                user.FullName = dto.FullName;
                await userRepository.UpdateAsync(user);
            }

            var updatedDoctor = await doctorRepository.UpdateAsync(doctor);

            await transaction.CommitAsync();

            if (updatedDoctor == null)
            {
                return null;
            }

            return await MapDoctorToDtoAsync(updatedDoctor);
        }
        catch
        {
            await transaction.RollbackAsync();
            throw;
        }
    }

    public async Task<List<AppointmentReportDto>> GetAppointmentReportsAsync()
    {
        return await appointmentService.GetAppointmentReportsAsync();
    }

    private async Task<DoctorDto> MapDoctorToDtoAsync(Doctor doctor)
    {
        var doctorDto = mapper.Map<DoctorDto>(doctor);

        doctorDto.FullName = await userRepository.GetFullNameByIdAsync(doctor.UserId)
            ?? string.Empty;

        return doctorDto;
    }
}