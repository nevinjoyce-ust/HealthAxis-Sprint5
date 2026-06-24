using AutoMapper;
using HealthAxis.API.Constants;
using HealthAxis.Shared.Dtos.Patient;
using HealthAxis.API.Exceptions;
using HealthAxis.API.Repositories;
using Microsoft.AspNetCore.Identity;

namespace HealthAxis.API.Services.Impl;

public class PatientService(
    IPatientRepository patientRepository,
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

        if (updatedPatient == null)
        {
            throw new NotFoundException(ErrorMessages.PatientNotFound);
        }

        return mapper.Map<PatientDto>(updatedPatient);
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
}
