using AutoMapper;
using HealthAxis.API.Dtos;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using HealthAxis.API.Services;

namespace HealthAxis.API.Services.Impl;

public class PatientService(
    IPatientRepository patientRepository,
    IUserRepository userRepository,
    IHealthRecordRepository healthRecordRepository,
    IMapper mapper) : IPatientService
{
    public async Task<PatientDto?> GetPatientByIdAsync(int id)
    {
        var patient = await patientRepository.GetByIdAsync(id);

        if (patient == null)
        {
            return null;
        }

        return await MapPatientToDtoAsync(patient);
    }

    public async Task<PatientDto?> GetPatientByUserIdAsync(int userId)
    {
        var patient = await patientRepository.GetPatientByUserIdAsync(userId);

        if (patient == null)
        {
            return null;
        }

        return await MapPatientToDtoAsync(patient);
    }

    public async Task<PatientDto?> UpdatePatientAsync(int id, UpdatePatientDto dto)
    {
        var patient = await patientRepository.GetByIdAsync(id);

        if (patient == null)
        {
            return null;
        }

        patient.DateOfBirth = dto.DateOfBirth;
        patient.Gender = dto.Gender;
        patient.PhoneNumber = dto.PhoneNumber;
        patient.Address = dto.Address;

        var user = await userRepository.GetByIdAsync(patient.UserId);

        if (user != null)
        {
            user.FullName = dto.FullName;
            await userRepository.UpdateAsync(user);
        }

        await patientRepository.UpdateAsync(patient);

        return await MapPatientToDtoAsync(patient);
    }

    public async Task<List<HealthRecordDto>> GetPatientHealthRecordsAsync(int patientId)
    {
        var records = await healthRecordRepository.GetHealthRecordsByPatientIdAsync(patientId);

        var recordDtos = new List<HealthRecordDto>();

        foreach (var record in records)
        {
            var dto = mapper.Map<HealthRecordDto>(record);

            dto.PatientName = await userRepository.GetFullNameByIdAsync(record.Patient?.UserId ?? 0) ?? string.Empty;
            dto.DoctorName = await userRepository.GetFullNameByIdAsync(record.Doctor?.UserId ?? 0) ?? string.Empty;

            recordDtos.Add(dto);
        }

        return recordDtos;
    }

    private async Task<PatientDto> MapPatientToDtoAsync(Patient patient)
    {
        var patientDto = mapper.Map<PatientDto>(patient);

        patientDto.FullName = await userRepository.GetFullNameByIdAsync(patient.UserId)
            ?? string.Empty;

        return patientDto;
    }
}