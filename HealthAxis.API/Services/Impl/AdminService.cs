using AutoMapper;
using HealthAxis.API.Dtos;
using HealthAxis.API.Enums;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories.Impl;
using HealthAxis.API.Repositories.Interfaces;
using HealthAxis.API.Services.Interfaces;
usingService.GetAppointmentReportsAsync();using HealthAxis.API.Models;
    }

    private async Task<DoctorDto> MapDoctorToDtoAsync(Doctor doctor)
{
    var doctorDto = mapper.Map<DoctorDto>(doctor);

    doctorDto.FullName = await userRepository.GetFullNameByIdAsync(doctor.UserId)
        ?? string.Empty;

    return doctorDto;
}
}
using HealthAxis.API.Repositories.Interfaces;
using HealthAxis.API.Services.Interfaces;

namespace HealthAxis.API.Services.Impl;

public class AdminService(
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
            doctorDtos.Add(await MapDoctorToDtoAsync(doctor));
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

        var user = new User
        {
            FullName = dto.FullName,
            Email = dto.Email,
            PasswordHash = dto.Password,
            Role = Roles.Doctor,
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

        return await MapDoctorToDtoAsync(createdDoctor);
    }

    public async Task<DoctorDto?> UpdateDoctorAsync(int id, UpdateDoctorDto dto)
    {
        var doctor = await doctorRepository.GetByIdAsync(id);

        if (doctor == null)
        {
            return null;
        }

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

        await doctorRepository.UpdateAsync(doctor);

        return await MapDoctorToDtoAsync(doctor);
    }

    public async Task<List<AppointmentReportDto>> GetAppointmentReportsAsync()
    {
