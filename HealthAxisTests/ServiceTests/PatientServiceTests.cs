using AutoMapper;
using HealthAxis.API.Exceptions;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using HealthAxis.API.Services.Impl;
using HealthAxis.Shared.Dtos.Patient;
using Microsoft.AspNetCore.Identity;
using Moq;

namespace HealthAxisTests.ServiceTests;

public class PatientServiceTests
{
    private readonly Mock<IPatientRepository> _patientRepositoryMock;
    private readonly Mock<IMapper> _mapperMock;
    private readonly Mock<UserManager<IdentityUser>> _userManagerMock;
    private readonly PatientService _patientService;

    public PatientServiceTests()
    {
        _patientRepositoryMock = new Mock<IPatientRepository>();
        _userManagerMock = CreateUserManagerMock();
        _mapperMock = new Mock<IMapper>();

        _patientService = new PatientService(
            _patientRepositoryMock.Object,
            _userManagerMock.Object,
            _mapperMock.Object);
    }

    private static Mock<UserManager<IdentityUser>> CreateUserManagerMock()
    {
        var userStoreMock = new Mock<IUserStore<IdentityUser>>();

        return new Mock<UserManager<IdentityUser>>(
            userStoreMock.Object,
            null!,
            null!,
            null!,
            null!,
            null!,
            null!,
            null!,
            null!);
    }

    private static UpdatePatientDto CreateUpdatePatientDto()
    {
        return new UpdatePatientDto
        {
            FullName = "Updated Patient",
            Email = "updated.patient@example.com",
            DateOfBirth = new DateOnly(1995, 2, 2),
            Gender = "Female",
            PhoneNumber = "9876543210",
            Address = "Updated Address"
        };
    }

    [Fact]
    public async Task GetPatientByIdAsync_WhenPatientExists_ShouldReturnPatientDto()
    {
        var patient = new Patient
        {
            Id = 1,
            UserId = "patient-user-id",
            FullName = "Nevin Joyce",
            DateOfBirth = new DateOnly(1998, 5, 20),
            Gender = "Male",
            Address = "Trivandrum",
            User = new IdentityUser
            {
                Id = "patient-user-id",
                Email = "nevin@example.com",
                PhoneNumber = "9999999999"
            }
        };

        var mappedPatientDto = new PatientDto
        {
            Id = 1,
            UserId = "patient-user-id",
            FullName = "Nevin Joyce",
            Email = "nevin@example.com",
            DateOfBirth = new DateOnly(1998, 5, 20),
            Gender = "Male",
            PhoneNumber = "9999999999",
            Address = "Trivandrum"
        };

        _patientRepositoryMock
            .Setup(repo => repo.GetPatientByIdWithUserAsync(1))
            .ReturnsAsync(patient);

        _mapperMock
            .Setup(mapper => mapper.Map<PatientDto>(patient))
            .Returns(mappedPatientDto);

        var result = await _patientService.GetPatientByIdAsync(1);

        Assert.NotNull(result);
        Assert.Equal(1, result.Id);
        Assert.Equal("patient-user-id", result.UserId);
        Assert.Equal("Nevin Joyce", result.FullName);
        Assert.Equal("nevin@example.com", result.Email);
        Assert.Equal("Male", result.Gender);
        Assert.Equal("9999999999", result.PhoneNumber);
        Assert.Equal("Trivandrum", result.Address);
    }

    [Fact]
    public async Task GetPatientByIdAsync_WhenPatientDoesNotExist_ShouldThrowNotFoundException()
    {
        _patientRepositoryMock
            .Setup(repo => repo.GetPatientByIdWithUserAsync(99))
            .ReturnsAsync((Patient?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() =>
            _patientService.GetPatientByIdAsync(99));

        Assert.Equal("Patient not found.", exception.Message);
    }

    [Fact]
    public async Task GetPatientByUserIdAsync_WhenPatientExists_ShouldReturnPatientDto()
    {
        const string userId = "patient-user-id";

        var patient = new Patient
        {
            Id = 1,
            UserId = userId,
            FullName = "Patient One",
            DateOfBirth = new DateOnly(1998, 5, 20),
            Gender = "Female",
            Address = "Kochi"
        };

        var patientWithUser = new Patient
        {
            Id = 1,
            UserId = userId,
            FullName = "Patient One",
            DateOfBirth = new DateOnly(1998, 5, 20),
            Gender = "Female",
            Address = "Kochi",
            User = new IdentityUser
            {
                Id = userId,
                Email = "patient.one@example.com",
                PhoneNumber = "8888888888"
            }
        };

        var mappedPatientDto = new PatientDto
        {
            Id = 1,
            UserId = userId,
            FullName = "Patient One",
            Email = "patient.one@example.com",
            DateOfBirth = new DateOnly(1998, 5, 20),
            Gender = "Female",
            PhoneNumber = "8888888888",
            Address = "Kochi"
        };

        _patientRepositoryMock
            .Setup(repo => repo.GetPatientByUserIdAsync(userId))
            .ReturnsAsync(patient);

        _patientRepositoryMock
            .Setup(repo => repo.GetPatientByIdWithUserAsync(1))
            .ReturnsAsync(patientWithUser);

        _mapperMock
            .Setup(mapper => mapper.Map<PatientDto>(patientWithUser))
            .Returns(mappedPatientDto);

        var result = await _patientService.GetPatientByUserIdAsync(userId);

        Assert.NotNull(result);
        Assert.Equal(1, result.Id);
        Assert.Equal(userId, result.UserId);
        Assert.Equal("Patient One", result.FullName);
        Assert.Equal("patient.one@example.com", result.Email);
        Assert.Equal("Female", result.Gender);
        Assert.Equal("Kochi", result.Address);
    }

    [Fact]
    public async Task GetPatientByUserIdAsync_WhenPatientDoesNotExist_ShouldThrowNotFoundException()
    {
        const string userId = "missing-patient-user-id";

        _patientRepositoryMock
            .Setup(repo => repo.GetPatientByUserIdAsync(userId))
            .ReturnsAsync((Patient?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() =>
            _patientService.GetPatientByUserIdAsync(userId));

        Assert.Equal("Patient not found.", exception.Message);
    }

    [Fact]
    public async Task UpdatePatientAsync_WhenPatientDoesNotExist_ShouldThrowNotFoundException()
    {
        var updateDto = CreateUpdatePatientDto();

        _patientRepositoryMock
            .Setup(repo => repo.GetPatientByIdWithUserAsync(99))
            .ReturnsAsync((Patient?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() =>
            _patientService.UpdatePatientAsync(99, updateDto));

        Assert.Equal("Patient not found.", exception.Message);

        _userManagerMock.Verify(
            manager => manager.FindByEmailAsync(It.IsAny<string>()),
            Times.Never);

        _userManagerMock.Verify(
            manager => manager.UpdateAsync(It.IsAny<IdentityUser>()),
            Times.Never);
    }

    [Fact]
    public async Task UpdatePatientAsync_WhenPatientAccountDoesNotExist_ShouldThrowNotFoundException()
    {
        var patient = new Patient
        {
            Id = 1,
            UserId = "patient-user-id",
            FullName = "Old Name",
            DateOfBirth = new DateOnly(1990, 1, 1),
            Gender = "Male",
            Address = "Old Address",
            User = null
        };

        var updateDto = CreateUpdatePatientDto();

        _patientRepositoryMock
            .Setup(repo => repo.GetPatientByIdWithUserAsync(1))
            .ReturnsAsync(patient);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() =>
            _patientService.UpdatePatientAsync(1, updateDto));

        Assert.Equal("Patient account not found.", exception.Message);

        _userManagerMock.Verify(
            manager => manager.FindByEmailAsync(It.IsAny<string>()),
            Times.Never);

        _userManagerMock.Verify(
            manager => manager.UpdateAsync(It.IsAny<IdentityUser>()),
            Times.Never);
    }

    [Fact]
    public async Task UpdatePatientAsync_WhenEmailBelongsToAnotherUser_ShouldThrowConflictException()
    {
        var identityUser = new IdentityUser
        {
            Id = "patient-user-id",
            Email = "old.patient@example.com",
            UserName = "old.patient@example.com",
            PhoneNumber = "1111111111"
        };

        var patient = new Patient
        {
            Id = 1,
            UserId = "patient-user-id",
            FullName = "Old Name",
            DateOfBirth = new DateOnly(1990, 1, 1),
            Gender = "Male",
            Address = "Old Address",
            User = identityUser
        };

        var existingUser = new IdentityUser
        {
            Id = "another-user-id",
            Email = "updated.patient@example.com"
        };

        var updateDto = CreateUpdatePatientDto();

        _patientRepositoryMock
            .Setup(repo => repo.GetPatientByIdWithUserAsync(1))
            .ReturnsAsync(patient);

        _userManagerMock
            .Setup(manager => manager.FindByEmailAsync(updateDto.Email))
            .ReturnsAsync(existingUser);

        var exception = await Assert.ThrowsAsync<ConflictException>(() =>
            _patientService.UpdatePatientAsync(1, updateDto));

        Assert.Equal("A user with this email already exists.", exception.Message);

        _userManagerMock.Verify(
            manager => manager.UpdateAsync(It.IsAny<IdentityUser>()),
            Times.Never);

        _patientRepositoryMock.Verify(
            repo => repo.UpdateAsync(It.IsAny<Patient>()),
            Times.Never);
    }

    [Fact]
    public async Task UpdatePatientAsync_WhenUserManagerFails_ShouldThrowBadRequestException()
    {
        var identityUser = new IdentityUser
        {
            Id = "patient-user-id",
            Email = "old.patient@example.com",
            UserName = "old.patient@example.com",
            PhoneNumber = "1111111111"
        };

        var patient = new Patient
        {
            Id = 1,
            UserId = "patient-user-id",
            FullName = "Old Name",
            DateOfBirth = new DateOnly(1990, 1, 1),
            Gender = "Male",
            Address = "Old Address",
            User = identityUser
        };

        var updateDto = CreateUpdatePatientDto();

        _patientRepositoryMock
            .Setup(repo => repo.GetPatientByIdWithUserAsync(1))
            .ReturnsAsync(patient);

        _userManagerMock
            .Setup(manager => manager.FindByEmailAsync(updateDto.Email))
            .ReturnsAsync((IdentityUser?)null);

        _userManagerMock
            .Setup(manager => manager.UpdateAsync(identityUser))
            .ReturnsAsync(IdentityResult.Failed(new IdentityError
            {
                Description = "Identity update failed."
            }));

        var exception = await Assert.ThrowsAsync<BadRequestException>(() =>
            _patientService.UpdatePatientAsync(1, updateDto));

        Assert.Equal("Identity update failed.", exception.Message);
    }

    [Fact]
    public async Task UpdatePatientAsync_WhenPatientExists_ShouldUpdatePatientAndIdentityUser()
    {
        var identityUser = new IdentityUser
        {
            Id = "patient-user-id",
            Email = "old.patient@example.com",
            UserName = "old.patient@example.com",
            PhoneNumber = "1111111111",
            EmailConfirmed = false
        };

        var patient = new Patient
        {
            Id = 1,
            UserId = "patient-user-id",
            FullName = "Old Name",
            DateOfBirth = new DateOnly(1990, 1, 1),
            Gender = "Male",
            Address = "Old Address",
            User = identityUser
        };

        var updateDto = CreateUpdatePatientDto();

        var updatedPatient = new Patient
        {
            Id = 1,
            UserId = "patient-user-id",
            FullName = updateDto.FullName,
            DateOfBirth = updateDto.DateOfBirth,
            Gender = updateDto.Gender,
            Address = updateDto.Address,
            User = identityUser
        };

        var mappedPatientDto = new PatientDto
        {
            Id = 1,
            UserId = "patient-user-id",
            FullName = updateDto.FullName,
            Email = updateDto.Email,
            DateOfBirth = updateDto.DateOfBirth,
            Gender = updateDto.Gender,
            PhoneNumber = updateDto.PhoneNumber,
            Address = updateDto.Address
        };

        _patientRepositoryMock
            .SetupSequence(repo => repo.GetPatientByIdWithUserAsync(1))
            .ReturnsAsync(patient)
            .ReturnsAsync(updatedPatient);

        _userManagerMock
            .Setup(manager => manager.FindByEmailAsync(updateDto.Email))
            .ReturnsAsync((IdentityUser?)null);

        _userManagerMock
            .Setup(manager => manager.UpdateAsync(identityUser))
            .ReturnsAsync(IdentityResult.Success);

        _patientRepositoryMock
            .Setup(repo => repo.UpdateAsync(It.IsAny<Patient>()))
            .ReturnsAsync(patient);

        _mapperMock
            .Setup(mapper => mapper.Map<PatientDto>(updatedPatient))
            .Returns(mappedPatientDto);

        var result = await _patientService.UpdatePatientAsync(1, updateDto);

        Assert.NotNull(result);
        Assert.Equal(1, result.Id);
        Assert.Equal("patient-user-id", result.UserId);
        Assert.Equal("Updated Patient", result.FullName);
        Assert.Equal("updated.patient@example.com", result.Email);
        Assert.Equal(new DateOnly(1995, 2, 2), result.DateOfBirth);
        Assert.Equal("Female", result.Gender);
        Assert.Equal("9876543210", result.PhoneNumber);
        Assert.Equal("Updated Address", result.Address);

        _userManagerMock.Verify(manager => manager.UpdateAsync(It.Is<IdentityUser>(user =>
            user.Id == "patient-user-id" &&
            user.Email == updateDto.Email &&
            user.UserName == updateDto.Email &&
            user.PhoneNumber == updateDto.PhoneNumber &&
            user.EmailConfirmed)), Times.Once);

        _patientRepositoryMock.Verify(repo => repo.UpdateAsync(It.Is<Patient>(updated =>
            updated.Id == 1 &&
            updated.FullName == updateDto.FullName &&
            updated.DateOfBirth == updateDto.DateOfBirth &&
            updated.Gender == updateDto.Gender &&
            updated.Address == updateDto.Address)), Times.Once);
    }
}
