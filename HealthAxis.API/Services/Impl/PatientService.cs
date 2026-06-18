using AutoMapper;
using HealthAxis.API.Constants;
using HealthAxis.API.Dtos;
using HealthAxis.API.Exceptions;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using Microsoft.AspNetCore.Identity;

namespace HealthAxis.API.Services.Impl;

public class PatientService(
    IPatientRepository patientRepository,
    IHealthRecordRepository healthRecordRepository,
    UserManager<IdentityUser> userManager,
    IMapper mapper) : IPatientService
{
    public async Task<PatientDto> GetPatientByIdAsync(int id)
    {
        var patient = await patientRepository.GetPatientByIdWithUserAsync(id);

        if (patient == null)
        {
            throw new NotFoundException(ErrorMessages.PatientNotFound);
        }

        return mapper.Map<PatientDto>(patient);
    }

    public async Task<PatientDto> GetPatientByUserIdAsync(string userId)
    {
        var patient = await patientRepository.GetPatientByUserIdAsync(userId);

        if (patient == null)
        {
            throw new NotFoundException(ErrorMessages.PatientNotFound);
        }

        var patientWithUser = await patientRepository.GetPatientByIdWithUserAsync(patient.Id);

        if (patientWithUser == null)
        {
            throw new NotFoundException(ErrorMessages.PatientNotFound);
        }

        return mapper.Map<PatientDto>(patientWithUser);
    }

    public async Task<PatientDto> UpdatePatientAsync(int id, UpdatePatientDto dto)
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

        patient.FullName = dto.FullName;
        patient.DateOfBirth = dto.DateOfBirth;
        patient.Gender = dto.Gender;
        patient.Address = dto.Address;
        patient.User.PhoneNumber = dto.PhoneNumber;

        var updateUserResult = await userManager.UpdateAsync(patient.User);

        if (!updateUserResult.Succeeded)
        {
            var errors = string.Join(" ", updateUserResult.Errors.Select(error => error.Description));
            throw new BadRequestException(errors);
        }

        await patientRepository.UpdateAsync(patient);

        var updatedPatient = await patientRepository.GetPatientByIdWithUserAsync(id);

        if (updatedPatient == null)
        {
            throw new NotFoundException(ErrorMessages.PatientNotFound);
        }

        return mapper.Map<PatientDto>(updatedPatient);
    }

    public async Task<PagedResultDto<HealthRecordDto>> GetPatientHealthRecordsAsync(
        int patientId,
        PaginationQueryDto pagination)
    {
        var patient = await patientRepository.GetByIdAsync(patientId);

        if (patient == null)
        {
            throw new NotFoundException(ErrorMessages.PatientNotFound);
        }

        var records = await healthRecordRepository.GetHealthRecordsByPatientIdAsync(
            patientId,
            pagination.PageNumber,
            pagination.PageSize);

        return MapPagedResult<HealthRecord, HealthRecordDto>(records);
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
