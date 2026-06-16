using AutoMapper;
using HealthAxis.API.Dtos;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using HealthAxis.API.Services.Impl;
using Moq;

namespace HealthAxisTests;

public class PatientServiceTests
{
    private readonly Mock<IPatientRepository> _patientRepositoryMock;
    private readonly Mock<IUserRepository> _userRepositoryMock;
    private readonly Mock<IHealthRecordRepository> _healthRecordRepositoryMock;
    private readonly Mock<IMapper> _mapperMock;
    private readonly PatientService _patientService;

    public PatientServiceTests()
    {
        _patientRepositoryMock = new Mock<IPatientRepository>();
        _userRepositoryMock = new Mock<IUserRepository>();
        _healthRecordRepositoryMock = new Mock<IHealthRecordRepository>();
        _mapperMock = new Mock<IMapper>();

        _patientService = new PatientService(
            _patientRepositoryMock.Object,
            _userRepositoryMock.Object,
            _healthRecordRepositoryMock.Object,
            _mapperMock.Object
        );
    }

    [Fact]
    public async Task GetPatientByIdAsync_WhenPatientExists_ShouldReturnPatientDto()
    {
        // Arrange
        var patient = new Patient
        {
            Id = 1,
            UserId = 10,
            DateOfBirth = new DateOnly(1998, 5, 20),
            Gender = "Male",
            PhoneNumber = "9999999999",
            Address = "Trivandrum"
        };

        var mappedPatientDto = new PatientDto
        {
            Id = 1,
            UserId = 10,
            DateOfBirth = new DateOnly(1998, 5, 20),
            Gender = "Male",
            PhoneNumber = "9999999999",
            Address = "Trivandrum"
        };

        _patientRepositoryMock
            .Setup(repo => repo.GetByIdAsync(1))
            .ReturnsAsync(patient);

        _mapperMock
            .Setup(mapper => mapper.Map<PatientDto>(patient))
            .Returns(mappedPatientDto);

        _userRepositoryMock
            .Setup(repo => repo.GetFullNameByIdAsync(10))
            .ReturnsAsync("Nevin Joyce");

        // Act
        var result = await _patientService.GetPatientByIdAsync(1);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(1, result!.Id);
        Assert.Equal(10, result.UserId);
        Assert.Equal("Nevin Joyce", result.FullName);
        Assert.Equal("Male", result.Gender);
        Assert.Equal("9999999999", result.PhoneNumber);
        Assert.Equal("Trivandrum", result.Address);
    }

    [Fact]
    public async Task GetPatientByIdAsync_WhenPatientDoesNotExist_ShouldReturnNull()
    {
        // Arrange
        _patientRepositoryMock
            .Setup(repo => repo.GetByIdAsync(99))
            .ReturnsAsync((Patient?)null);

        // Act
        var result = await _patientService.GetPatientByIdAsync(99);

        // Assert
        Assert.Null(result);
    }

    [Fact]
    public async Task GetPatientByUserIdAsync_WhenPatientExists_ShouldReturnPatientDto()
    {
        // Arrange
        var patient = new Patient
        {
            Id = 1,
            UserId = 10,
            DateOfBirth = new DateOnly(1998, 5, 20),
            Gender = "Female",
            PhoneNumber = "8888888888",
            Address = "Kochi"
        };

        var mappedPatientDto = new PatientDto
        {
            Id = 1,
            UserId = 10,
            DateOfBirth = new DateOnly(1998, 5, 20),
            Gender = "Female",
            PhoneNumber = "8888888888",
            Address = "Kochi"
        };

        _patientRepositoryMock
            .Setup(repo => repo.GetPatientByUserIdAsync(10))
            .ReturnsAsync(patient);

        _mapperMock
            .Setup(mapper => mapper.Map<PatientDto>(patient))
            .Returns(mappedPatientDto);

        _userRepositoryMock
            .Setup(repo => repo.GetFullNameByIdAsync(10))
            .ReturnsAsync("Patient One");

        // Act
        var result = await _patientService.GetPatientByUserIdAsync(10);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(1, result!.Id);
        Assert.Equal(10, result.UserId);
        Assert.Equal("Patient One", result.FullName);
        Assert.Equal("Female", result.Gender);
        Assert.Equal("Kochi", result.Address);
    }

    [Fact]
    public async Task GetPatientByUserIdAsync_WhenPatientDoesNotExist_ShouldReturnNull()
    {
        // Arrange
        _patientRepositoryMock
            .Setup(repo => repo.GetPatientByUserIdAsync(99))
            .ReturnsAsync((Patient?)null);

        // Act
        var result = await _patientService.GetPatientByUserIdAsync(99);

        // Assert
        Assert.Null(result);
    }

    [Fact]
    public async Task UpdatePatientAsync_WhenPatientDoesNotExist_ShouldReturnNull()
    {
        // Arrange
        var updateDto = new UpdatePatientDto
        {
            FullName = "Updated Patient",
            DateOfBirth = new DateOnly(1995, 1, 1),
            Gender = "Female",
            PhoneNumber = "7777777777",
            Address = "Updated Address"
        };

        _patientRepositoryMock
            .Setup(repo => repo.GetByIdAsync(99))
            .ReturnsAsync((Patient?)null);

        // Act
        var result = await _patientService.UpdatePatientAsync(99, updateDto);

        // Assert
        Assert.Null(result);
    }

    [Fact]
    public async Task UpdatePatientAsync_WhenPatientExists_ShouldUpdatePatientAndUser()
    {
        // Arrange
        var patient = new Patient
        {
            Id = 1,
            UserId = 10,
            DateOfBirth = new DateOnly(1990, 1, 1),
            Gender = "Male",
            PhoneNumber = "1111111111",
            Address = "Old Address"
        };

        var user = new User
        {
            Id = 10,
            FullName = "Old Name",
            Email = "patient@test.com"
        };

        var updateDto = new UpdatePatientDto
        {
            FullName = "New Name",
            DateOfBirth = new DateOnly(1995, 2, 2),
            Gender = "Female",
            PhoneNumber = "9999999999",
            Address = "New Address"
        };

        var mappedPatientDto = new PatientDto
        {
            Id = 1,
            UserId = 10,
            DateOfBirth = updateDto.DateOfBirth,
            Gender = updateDto.Gender,
            PhoneNumber = updateDto.PhoneNumber,
            Address = updateDto.Address
        };

        _patientRepositoryMock
            .Setup(repo => repo.GetByIdAsync(1))
            .ReturnsAsync(patient);

        _userRepositoryMock
            .Setup(repo => repo.GetByIdAsync(10))
            .ReturnsAsync(user);

        _userRepositoryMock
            .Setup(repo => repo.UpdateAsync(It.IsAny<User>()))
            .ReturnsAsync(user);

        _patientRepositoryMock
            .Setup(repo => repo.UpdateAsync(It.IsAny<Patient>()))
            .ReturnsAsync(patient);

        _mapperMock
            .Setup(mapper => mapper.Map<PatientDto>(patient))
            .Returns(mappedPatientDto);

        _userRepositoryMock
            .Setup(repo => repo.GetFullNameByIdAsync(10))
            .ReturnsAsync("New Name");

        // Act
        var result = await _patientService.UpdatePatientAsync(1, updateDto);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(1, result!.Id);
        Assert.Equal("New Name", result.FullName);
        Assert.Equal(new DateOnly(1995, 2, 2), result.DateOfBirth);
        Assert.Equal("Female", result.Gender);
        Assert.Equal("9999999999", result.PhoneNumber);
        Assert.Equal("New Address", result.Address);

        _userRepositoryMock.Verify(
            repo => repo.UpdateAsync(It.Is<User>(user =>
                user.Id == 10 &&
                user.FullName == "New Name")),
            Times.Once);

        _patientRepositoryMock.Verify(
            repo => repo.UpdateAsync(It.Is<Patient>(patient =>
                patient.Id == 1 &&
                patient.DateOfBirth == updateDto.DateOfBirth &&
                patient.Gender == updateDto.Gender &&
                patient.PhoneNumber == updateDto.PhoneNumber &&
                patient.Address == updateDto.Address)),
            Times.Once);
    }

    [Fact]
    public async Task UpdatePatientAsync_WhenUserDoesNotExist_ShouldStillUpdatePatient()
    {
        // Arrange
        var patient = new Patient
        {
            Id = 1,
            UserId = 10,
            DateOfBirth = new DateOnly(1990, 1, 1),
            Gender = "Male",
            PhoneNumber = "1111111111",
            Address = "Old Address"
        };

        var updateDto = new UpdatePatientDto
        {
            FullName = "New Name",
            DateOfBirth = new DateOnly(1995, 2, 2),
            Gender = "Male",
            PhoneNumber = "9999999999",
            Address = "New Address"
        };

        var mappedPatientDto = new PatientDto
        {
            Id = 1,
            UserId = 10,
            DateOfBirth = updateDto.DateOfBirth,
            Gender = updateDto.Gender,
            PhoneNumber = updateDto.PhoneNumber,
            Address = updateDto.Address
        };

        _patientRepositoryMock
            .Setup(repo => repo.GetByIdAsync(1))
            .ReturnsAsync(patient);

        _userRepositoryMock
            .Setup(repo => repo.GetByIdAsync(10))
            .ReturnsAsync((User?)null);

        _patientRepositoryMock
            .Setup(repo => repo.UpdateAsync(It.IsAny<Patient>()))
            .ReturnsAsync(patient);

        _mapperMock
            .Setup(mapper => mapper.Map<PatientDto>(patient))
            .Returns(mappedPatientDto);

        _userRepositoryMock
            .Setup(repo => repo.GetFullNameByIdAsync(10))
            .ReturnsAsync(string.Empty);

        // Act
        var result = await _patientService.UpdatePatientAsync(1, updateDto);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(1, result!.Id);
        Assert.Equal("New Address", result.Address);

        _userRepositoryMock.Verify(
            repo => repo.UpdateAsync(It.IsAny<User>()),
            Times.Never);

        _patientRepositoryMock.Verify(
            repo => repo.UpdateAsync(It.IsAny<Patient>()),
            Times.Once);
    }

    [Fact]
    public async Task GetPatientHealthRecordsAsync_WhenRecordsExist_ShouldReturnHealthRecordDtos()
    {
        // Arrange
        var records = new List<HealthRecord>
        {
            new HealthRecord
            {
                Id = 1,
                PatientId = 1,
                DoctorId = 2,
                VisitDate = new DateOnly(2026, 6, 20),
                Diagnosis = "Fever",
                Prescription = "Paracetamol",
                Notes = "Rest advised"
            }
        };

        var mappedHealthRecordDto = new HealthRecordDto
        {
            Id = 1,
            PatientId = 1,
            DoctorId = 2,
            VisitDate = new DateOnly(2026, 6, 20),
            Diagnosis = "Fever",
            Prescription = "Paracetamol",
            Notes = "Rest advised"
        };

        _healthRecordRepositoryMock
            .Setup(repo => repo.GetHealthRecordsByPatientIdAsync(1))
            .ReturnsAsync(records);

        _mapperMock
            .Setup(mapper => mapper.Map<HealthRecordDto>(It.IsAny<HealthRecord>()))
            .Returns(mappedHealthRecordDto);

        // Act
        var result = await _patientService.GetPatientHealthRecordsAsync(1);

        // Assert
        Assert.NotNull(result);
        Assert.Single(result);
        Assert.Equal(1, result[0].Id);
        Assert.Equal("Fever", result[0].Diagnosis);
        Assert.Equal("Paracetamol", result[0].Prescription);
        Assert.Equal("Rest advised", result[0].Notes);
    }

    [Fact]
    public async Task GetPatientHealthRecordsAsync_WhenNoRecordsExist_ShouldReturnEmptyList()
    {
        // Arrange
        _healthRecordRepositoryMock
            .Setup(repo => repo.GetHealthRecordsByPatientIdAsync(1))
            .ReturnsAsync(new List<HealthRecord>());

        // Act
        var result = await _patientService.GetPatientHealthRecordsAsync(1);

        // Assert
        Assert.NotNull(result);
        Assert.Empty(result);
    }
}