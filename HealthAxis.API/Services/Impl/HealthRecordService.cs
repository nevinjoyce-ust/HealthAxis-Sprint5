using AutoMapper;
using HealthAxis.API.Dtos;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using HealthAxis.API.Services;

namespace HealthAxis.API.Services.Impl;

public class HealthRecordService(
    IHealthRecordRepository healthRecordRepository,
    IPatientRepository patientRepository,
    IDoctorRepository doctorRepository,
    IUserRepository userRepository,
    IMapper mapper) : IHealthRecordService
{
    public async Task<List<HealthRecordDto>> GetHealthRecordsByPatientIdAsync(int patientId)
    {
        var records = await healthRecordRepository.GetHealthRecordsByPatientIdAsync(patientId);

        var recordDtos = new List<HealthRecordDto>();

        foreach (var record in records)
        {
            recordDtos.Add(await MapHealthRecordToDtoAsync(record));
        }

        return recordDtos;
    }

    public async Task<HealthRecordDto?> GetHealthRecordByIdAsync(int id)
    {
        var record = await healthRecordRepository.GetByIdAsync(id);

        if (record == null)
        {
            return null;
        }

        return await MapHealthRecordToDtoAsync(record);
    }

    public async Task<HealthRecordDto?> CreateHealthRecordAsync(CreateHealthRecordDto dto)
    {
        var patient = await patientRepository.GetByIdAsync(dto.PatientId);
        var doctor = await doctorRepository.GetByIdAsync(dto.DoctorId);

        if (patient == null || doctor == null)
        {
            return null;
        }

        var healthRecord = mapper.Map<HealthRecord>(dto);

        var createdRecord = await healthRecordRepository.AddAsync(healthRecord);

        return await MapHealthRecordToDtoAsync(createdRecord);
    }

    private async Task<HealthRecordDto> MapHealthRecordToDtoAsync(HealthRecord record)
    {
        var recordDto = mapper.Map<HealthRecordDto>(record);

        var patient = await patientRepository.GetByIdAsync(record.PatientId);
        var doctor = await doctorRepository.GetByIdAsync(record.DoctorId);

        recordDto.PatientName = patient == null
            ? string.Empty
            : await userRepository.GetFullNameByIdAsync(patient.UserId) ?? string.Empty;

        recordDto.DoctorName = doctor == null
            ? string.Empty
            : await userRepository.GetFullNameByIdAsync(doctor.UserId) ?? string.Empty;

        return recordDto;
    }
}