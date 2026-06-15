using AutoMapper;
using HealthAxis.API.Dtos;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using HealthAxis.API.Repositories.Interfaces;
using HealthAxis.API.Services.Interfaces;

namespace HealthAxis.API.Services.Impl;

public class DoctorService(
    IDoctorRepository doctorRepository,
    IUserRepository userRepository,
    IMapper mapper) : IDoctorService
{
    public async Task<List<DoctorDto>> GetAllDoctorsAsync()
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

    public async Task<DoctorDto?> GetDoctorByIdAsync(int id)
    {
        var doctor = await doctorRepository.GetByIdAsync(id);

        if (doctor == null)
        {
            return null;
        }

        return await MapDoctorToDtoAsync(doctor);
    }

    public async Task<DoctorDto?> GetDoctorByUserIdAsync(int userId)
    {
        var doctor = await doctorRepository.GetDoctorByUserIdAsync(userId);

        if (doctor == null)
        {
            return null;
        }

        return await MapDoctorToDtoAsync(doctor);
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
                ? "Doctor is available."
                : "Doctor is not available."
        };
    }

    private async Task<DoctorDto> MapDoctorToDtoAsync(Doctor doctor)
    {
        var doctorDto = mapper.Map<DoctorDto>(doctor);

        doctorDto.FullName = await userRepository.GetFullNameByIdAsync(doctor.UserId)
            ?? string.Empty;

        return doctorDto;
    }
}