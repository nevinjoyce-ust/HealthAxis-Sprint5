using AutoMapper;
using HealthAxis.API.Dtos;
using HealthAxis.API.Exceptions;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using HealthAxis.API.Services.Impl;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Moq;

namespace HealthAxisTests;

public class PatientServiceTests
{
    private readonly Mock<IPatientRepository> _patientRepositoryMock;
    private readonly Mock<IHealthRecordRepository> _healthRecordRepositoryMock;
    private readonly Mock<IMapper> _mapperMock;
    private readonly Mock<UserManager<IdentityUser>> _userManagerMock;
    private readonly PatientService _patientService;

    public PatientServiceTests()
    {
        _patientRepositoryMock = new Mock<IPatientRepository>();
        _healthRecordRepositoryMock = new Mock<IHealthRecordRepository>();
        _mapperMock = new Mock<IMapper>();
        _userManagerMock = CreateUserManagerMock();

        _patientService = new PatientService(
            _patientRepositoryMock.Object,
            _healthRecordRepositoryMock.Object,
            _userManagerMock.Object,
            _mapperMock.Object
        );
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
            User = new IdentityUser { Id = "patient-user-id", PhoneNumber = "9999999999" }
        };

        var mappedPatientDto = new PatientDto
        {
            Id = 1,
            UserId = "patient-user-id",
            FullName = "Nevin Joyce",
            DateOfBirth = new DateOnly(1998, 5, 20),
            Gender = "Male",
            PhoneNumber = "9999999999",
            Address = "Trivandrum"
        };

        _patientRepositoryMock.Setup(repo => repo.GetPatientByIdWithUserAsync(1)).ReturnsAsync(patient);
        _mapperMock.Setup(mapper => mapper.Map<PatientDto>(patient)).Returns(mappedPatientDto);

        var result = await _patientService.GetPatientByIdAsync(1);

        Assert.NotNull(result);
        Assert.Equal(1, result.Id);
        Assert.Equal("patient-user-id", result.UserId);
        Assert.Equal("Nevin Joyce", result.FullName);
        Assert.Equal("Male", result.Gender);
        Assert.Equal("9999999999", result.PhoneNumber);
        Assert.Equal("Trivandrum", result.Address);
    }

    [Fact]
    public async Task GetPatientByIdAsync_WhenPatientDoesNotExist_ShouldThrowNotFoundException()
    {
        _patientRepositoryMock.Setup(repo => repo.GetPatientByIdWithUserAsync(99)).ReturnsAsync((Patient?)null);

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
            User = new IdentityUser { Id = userId, PhoneNumber = "8888888888" }
        };

        var mappedPatientDto = new PatientDto
        {
            Id = 1,
            UserId = userId,
            FullName = "Patient One",
            DateOfBirth = new DateOnly(1998, 5, 20),
            Gender = "Female",
            PhoneNumber = "8888888888",
            Address = "Kochi"
        };

        _patientRepositoryMock.Setup(repo => repo.GetPatientByUserIdAsync(userId)).ReturnsAsync(patient);
        _patientRepositoryMock.Setup(repo => repo.GetPatientByIdWithUserAsync(1)).ReturnsAsync(patientWithUser);
        _mapperMock.Setup(mapper => mapper.Map<PatientDto>(patientWithUser)).Returns(mappedPatientDto);

        var result = await _patientService.GetPatientByUserIdAsync(userId);

        Assert.NotNull(result);
        Assert.Equal(1, result.Id);
        Assert.Equal(userId, result.UserId);
        Assert.Equal("Patient One", result.FullName);
        Assert.Equal("Female", result.Gender);
        Assert.Equal("Kochi", result.Address);
    }

    [Fact]
    public async Task GetPatientByUserIdAsync_WhenPatientDoesNotExist_ShouldThrowNotFoundException()
    {
        const string userId = "missing-patient-user-id";
        _patientRepositoryMock.Setup(repo => repo.GetPatientByUserIdAsync(userId)).ReturnsAsync((Patient?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() =>
            _patientService.GetPatientByUserIdAsync(userId));

        Assert.Equal("Patient not found.", exception.Message);
    }

    [Fact]
    public async Task UpdatePatientAsync_WhenPatientDoesNotExist_ShouldThrowNotFoundException()
    {
        var updateDto = CreateUpdatePatientDto();
        _patientRepositoryMock.Setup(repo => repo.GetPatientByIdWithUserAsync(99)).ReturnsAsync((Patient?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() =>
            _patientService.UpdatePatientAsync(99, updateDto));

        Assert.Equal("Patient not found.", exception.Message);
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
        _patientRepositoryMock.Setup(repo => repo.GetPatientByIdWithUserAsync(1)).ReturnsAsync(patient);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() =>
            _patientService.UpdatePatientAsync(1, updateDto));

        Assert.Equal("Patient account not found.", exception.Message);
    }

    [Fact]
    public async Task UpdatePatientAsync_WhenUserManagerFails_ShouldThrowBadRequestException()
    {
        var identityUser = new IdentityUser { Id = "patient-user-id", PhoneNumber = "1111111111" };
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

        _patientRepositoryMock.Setup(repo => repo.GetPatientByIdWithUserAsync(1)).ReturnsAsync(patient);
        _userManagerMock.Setup(manager => manager.UpdateAsync(identityUser))
            .ReturnsAsync(IdentityResult.Failed(new IdentityError { Description = "Phone number update failed." }));

        var exception = await Assert.ThrowsAsync<BadRequestException>(() =>
            _patientService.UpdatePatientAsync(1, updateDto));

        Assert.Equal("Phone number update failed.", exception.Message);
    }

    [Fact]
    public async Task UpdatePatientAsync_WhenPatientExists_ShouldUpdatePatientAndIdentityPhoneNumber()
    {
        var identityUser = new IdentityUser { Id = "patient-user-id", PhoneNumber = "1111111111" };
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
            DateOfBirth = updateDto.DateOfBirth,
            Gender = updateDto.Gender,
            PhoneNumber = updateDto.PhoneNumber,
            Address = updateDto.Address
        };

        _patientRepositoryMock.SetupSequence(repo => repo.GetPatientByIdWithUserAsync(1))
            .ReturnsAsync(patient)
            .ReturnsAsync(updatedPatient);
        _userManagerMock.Setup(manager => manager.UpdateAsync(identityUser)).ReturnsAsync(IdentityResult.Success);
        _patientRepositoryMock.Setup(repo => repo.UpdateAsync(It.IsAny<Patient>())).ReturnsAsync(patient);
        _mapperMock.Setup(mapper => mapper.Map<PatientDto>(updatedPatient)).Returns(mappedPatientDto);

        var result = await _patientService.UpdatePatientAsync(1, updateDto);

        Assert.NotNull(result);
        Assert.Equal(1, result.Id);
        Assert.Equal("patient-user-id", result.UserId);
        Assert.Equal("New Name", result.FullName);
        Assert.Equal(new DateOnly(1995, 2, 2), result.DateOfBirth);
        Assert.Equal("Female", result.Gender);
        Assert.Equal("9999999999", result.PhoneNumber);
        Assert.Equal("New Address", result.Address);

        _userManagerMock.Verify(manager => manager.UpdateAsync(It.Is<IdentityUser>(user =>
            user.Id == "patient-user-id" && user.PhoneNumber == "9999999999")), Times.Once);

        _patientRepositoryMock.Verify(repo => repo.UpdateAsync(It.Is<Patient>(updated =>
            updated.Id == 1 &&
            updated.FullName == updateDto.FullName &&
            updated.DateOfBirth == updateDto.DateOfBirth &&
            updated.Gender == updateDto.Gender &&
            updated.Address == updateDto.Address)), Times.Once);
    }

    [Fact]
    public async Task GetPatientHealthRecordsAsync_WhenPatientDoesNotExist_ShouldThrowNotFoundException()
    {
        var pagination = new PaginationQueryDto { PageNumber = 1, PageSize = 10 };
        _patientRepositoryMock.Setup(repo => repo.GetByIdAsync(99)).ReturnsAsync((Patient?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() =>
            _patientService.GetPatientHealthRecordsAsync(99, pagination));

        Assert.Equal("Patient not found.", exception.Message);
    }

    [Fact]
    public async Task GetPatientHealthRecordsAsync_WhenRecordsExist_ShouldReturnPagedHealthRecordDtos()
    {
        var patient = new Patient { Id = 1, UserId = "patient-user-id", FullName = "Patient One" };
        var records = new List<HealthRecord>
        {
            new HealthRecord
            {
                Id = 1,
                AppointmentId = 100,
                VisitDate = new DateOnly(2026, 6, 20),
                Diagnosis = "Fever",
                Prescription = "Paracetamol",
                Notes = "Rest advised",
                Appointment = new Appointment
                {
                    Id = 100,
                    PatientId = 1,
                    DoctorId = 2
                }
            }
        };

        var pagedRecords = new PagedResult<HealthRecord>
        {
            Items = records,
            PageNumber = 1,
            PageSize = 10,
            TotalCount = 1,
            TotalPages = 1
        };

        var mappedHealthRecordDtos = new List<HealthRecordDto>
        {
            new HealthRecordDto
            {
                Id = 1,
                AppointmentId = 100,
                PatientId = 1,
                DoctorId = 2,
                VisitDate = new DateOnly(2026, 6, 20),
                Diagnosis = "Fever",
                Prescription = "Paracetamol",
                Notes = "Rest advised"
            }
        };

        var pagination = new PaginationQueryDto { PageNumber = 1, PageSize = 10 };

        _patientRepositoryMock.Setup(repo => repo.GetByIdAsync(1)).ReturnsAsync(patient);
        _healthRecordRepositoryMock.Setup(repo => repo.GetHealthRecordsByPatientIdAsync(1, 1, 10)).ReturnsAsync(pagedRecords);
        _mapperMock.Setup(mapper => mapper.Map<List<HealthRecordDto>>(records)).Returns(mappedHealthRecordDtos);

        var result = await _patientService.GetPatientHealthRecordsAsync(1, pagination);

        Assert.NotNull(result);
        Assert.Single(result.Items);
        Assert.Equal(1, result.Items[0].Id);
        Assert.Equal(100, result.Items[0].AppointmentId);
        Assert.Equal("Fever", result.Items[0].Diagnosis);
        Assert.Equal("Paracetamol", result.Items[0].Prescription);
        Assert.Equal("Rest advised", result.Items[0].Notes);
        Assert.Equal(1, result.PageNumber);
        Assert.Equal(10, result.PageSize);
        Assert.Equal(1, result.TotalCount);
        Assert.Equal(1, result.TotalPages);
    }

    [Fact]
    public async Task GetPatientHealthRecordsAsync_WhenNoRecordsExist_ShouldReturnEmptyPagedResult()
    {
        var patient = new Patient { Id = 1, UserId = "patient-user-id", FullName = "Patient One" };
        var records = new List<HealthRecord>();
        var pagedRecords = new PagedResult<HealthRecord>
        {
            Items = records,
            PageNumber = 1,
            PageSize = 10,
            TotalCount = 0,
            TotalPages = 0
        };
        var mappedHealthRecordDtos = new List<HealthRecordDto>();
        var pagination = new PaginationQueryDto { PageNumber = 1, PageSize = 10 };

        _patientRepositoryMock.Setup(repo => repo.GetByIdAsync(1)).ReturnsAsync(patient);
        _healthRecordRepositoryMock.Setup(repo => repo.GetHealthRecordsByPatientIdAsync(1, 1, 10)).ReturnsAsync(pagedRecords);
        _mapperMock.Setup(mapper => mapper.Map<List<HealthRecordDto>>(records)).Returns(mappedHealthRecordDtos);

        var result = await _patientService.GetPatientHealthRecordsAsync(1, pagination);

        Assert.NotNull(result);
        Assert.Empty(result.Items);
        Assert.Equal(1, result.PageNumber);
        Assert.Equal(10, result.PageSize);
        Assert.Equal(0, result.TotalCount);
        Assert.Equal(0, result.TotalPages);
    }

    private static UpdatePatientDto CreateUpdatePatientDto()
    {
        return new UpdatePatientDto
        {
            FullName = "New Name",
            DateOfBirth = new DateOnly(1995, 2, 2),
            Gender = "Female",
            PhoneNumber = "9999999999",
            Address = "New Address"
        };
    }

    private static Mock<UserManager<IdentityUser>> CreateUserManagerMock()
    {
        var store = new Mock<IUserStore<IdentityUser>>();
        var options = new Mock<IOptions<IdentityOptions>>();
        var passwordHasher = new Mock<IPasswordHasher<IdentityUser>>();
        var userValidators = new List<IUserValidator<IdentityUser>>();
        var passwordValidators = new List<IPasswordValidator<IdentityUser>>();
        var keyNormalizer = new Mock<ILookupNormalizer>();
        var errors = new IdentityErrorDescriber();
        var services = new Mock<IServiceProvider>();
        var logger = new Mock<ILogger<UserManager<IdentityUser>>>();

        return new Mock<UserManager<IdentityUser>>(
            store.Object,
            options.Object,
            passwordHasher.Object,
            userValidators,
            passwordValidators,
            keyNormalizer.Object,
            errors,
            services.Object,
            logger.Object
        );
    }
}
