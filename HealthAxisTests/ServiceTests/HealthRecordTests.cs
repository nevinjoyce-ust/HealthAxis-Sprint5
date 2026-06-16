using AutoMapper;
using HealthAxis.API.Dtos;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using HealthAxis.API.Services.Impl;
using Moq;

namespace HealthAxisTests;

public class HealthRecordServiceTests
{
    private readonly Mock<IHealthRecordRepository> _healthRecordRepositoryMock;
    private readonly Mock<IPatientRepository> _patientRepositoryMock;
    private readonly Mock<IDoctorRepository> _doctorRepositoryMock;
    private readonly Mock<IUserRepository> _userRepositoryMock;
    private readonly Mock<IMapper> _mapperMock;
    private readonly HealthRecordService _healthRecordService;

    public HealthRecordServiceTests()
    {
        _healthRecordRepositoryMock = new Mock<IHealthRecordRepository>();
        _patientRepositoryMock = new Mock<IPatientRepository>();
        _doctorRepositoryMock = new Mock<IDoctorRepository>();
        _userRepositoryMock = new Mock<IUserRepository>();
        _mapperMock = new Mock<IMapper>();

        _healthRecordService = new HealthRecordService(
            _healthRecordRepositoryMock.Object,
            _patientRepositoryMock.Object,
            _doctorRepositoryMock.Object,
            _userRepositoryMock.Object,
            _mapperMock.Object
        );
    }

    [Fact]
    public async Task GetHealthRecordsByPatientIdAsync_WhenRecordsExist_ShouldReturnHealthRecordDtos()
    {
        // Arrange
        var records = new List<HealthRecord>
        {
            new HealthRecord
            {
                Id = 1,
                PatientId = 10,
                DoctorId = 20,
                VisitDate = new DateOnly(2026, 6, 20),
                Diagnosis = "Fever",
                Prescription = "Paracetamol",
                Notes = "Rest advised"
            }
        };

        var mappedDto = new HealthRecordDto
        {
            Id = 1,
            PatientId = 10,
            DoctorId = 20,
            VisitDate = new DateOnly(2026, 6, 20),
            Diagnosis = "Fever",
            Prescription = "Paracetamol",
            Notes = "Rest advised"
        };

        _healthRecordRepositoryMock
            .Setup(repo => repo.GetHealthRecordsByPatientIdAsync(10))
            .ReturnsAsync(records);

        _mapperMock
            .Setup(mapper => mapper.Map<HealthRecordDto>(It.IsAny<HealthRecord>()))
            .Returns(mappedDto);

        _patientRepositoryMock
            .Setup(repo => repo.GetByIdAsync(10))
            .ReturnsAsync(new Patient { Id = 10, UserId = 100 });

        _doctorRepositoryMock
            .Setup(repo => repo.GetByIdAsync(20))
            .ReturnsAsync(new Doctor { Id = 20, UserId = 200 });

        _userRepositoryMock
            .Setup(repo => repo.GetFullNameByIdAsync(100))
            .ReturnsAsync("Patient One");

        _userRepositoryMock
            .Setup(repo => repo.GetFullNameByIdAsync(200))
            .ReturnsAsync("Doctor One");

        // Act
        var result = await _healthRecordService.GetHealthRecordsByPatientIdAsync(10);

        // Assert
        Assert.NotNull(result);
        Assert.Single(result);
        Assert.Equal(1, result[0].Id);
        Assert.Equal(10, result[0].PatientId);
        Assert.Equal(20, result[0].DoctorId);
        Assert.Equal("Patient One", result[0].PatientName);
        Assert.Equal("Doctor One", result[0].DoctorName);
        Assert.Equal("Fever", result[0].Diagnosis);
        Assert.Equal("Paracetamol", result[0].Prescription);
    }

    [Fact]
    public async Task GetHealthRecordsByPatientIdAsync_WhenNoRecordsExist_ShouldReturnEmptyList()
    {
        // Arrange
        _healthRecordRepositoryMock
            .Setup(repo => repo.GetHealthRecordsByPatientIdAsync(10))
            .ReturnsAsync(new List<HealthRecord>());

        // Act
        var result = await _healthRecordService.GetHealthRecordsByPatientIdAsync(10);

        // Assert
        Assert.NotNull(result);
        Assert.Empty(result);
    }

    [Fact]
    public async Task GetHealthRecordByIdAsync_WhenRecordExists_ShouldReturnHealthRecordDto()
    {
        // Arrange
        var record = new HealthRecord
        {
            Id = 1,
            PatientId = 10,
            DoctorId = 20,
            VisitDate = new DateOnly(2026, 6, 20),
            Diagnosis = "Migraine",
            Prescription = "Pain relief medicine",
            Notes = "Follow up after one week"
        };

        var mappedDto = new HealthRecordDto
        {
            Id = 1,
            PatientId = 10,
            DoctorId = 20,
            VisitDate = new DateOnly(2026, 6, 20),
            Diagnosis = "Migraine",
            Prescription = "Pain relief medicine",
            Notes = "Follow up after one week"
        };

        _healthRecordRepositoryMock
            .Setup(repo => repo.GetByIdAsync(1))
            .ReturnsAsync(record);

        _mapperMock
            .Setup(mapper => mapper.Map<HealthRecordDto>(record))
            .Returns(mappedDto);

        _patientRepositoryMock
            .Setup(repo => repo.GetByIdAsync(10))
            .ReturnsAsync(new Patient { Id = 10, UserId = 100 });

        _doctorRepositoryMock
            .Setup(repo => repo.GetByIdAsync(20))
            .ReturnsAsync(new Doctor { Id = 20, UserId = 200 });

        _userRepositoryMock
            .Setup(repo => repo.GetFullNameByIdAsync(100))
            .ReturnsAsync("Patient One");

        _userRepositoryMock
            .Setup(repo => repo.GetFullNameByIdAsync(200))
            .ReturnsAsync("Doctor One");

        // Act
        var result = await _healthRecordService.GetHealthRecordByIdAsync(1);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(1, result!.Id);
        Assert.Equal("Patient One", result.PatientName);
        Assert.Equal("Doctor One", result.DoctorName);
        Assert.Equal("Migraine", result.Diagnosis);
        Assert.Equal("Pain relief medicine", result.Prescription);
        Assert.Equal("Follow up after one week", result.Notes);
    }

    [Fact]
    public async Task GetHealthRecordByIdAsync_WhenRecordDoesNotExist_ShouldReturnNull()
    {
        // Arrange
        _healthRecordRepositoryMock
            .Setup(repo => repo.GetByIdAsync(99))
            .ReturnsAsync((HealthRecord?)null);

        // Act
        var result = await _healthRecordService.GetHealthRecordByIdAsync(99);

        // Assert
        Assert.Null(result);
    }

    [Fact]
    public async Task CreateHealthRecordAsync_WhenPatientDoesNotExist_ShouldReturnNull()
    {
        // Arrange
        var dto = new CreateHealthRecordDto
        {
            PatientId = 10,
            DoctorId = 20,
            VisitDate = new DateOnly(2026, 6, 20),
            Diagnosis = "Fever",
            Prescription = "Paracetamol",
            Notes = "Rest advised"
        };

        _patientRepositoryMock
            .Setup(repo => repo.GetByIdAsync(10))
            .ReturnsAsync((Patient?)null);

        // Act
        var result = await _healthRecordService.CreateHealthRecordAsync(dto);

        // Assert
        Assert.Null(result);
    }

    [Fact]
    public async Task CreateHealthRecordAsync_WhenDoctorDoesNotExist_ShouldReturnNull()
    {
        // Arrange
        var dto = new CreateHealthRecordDto
        {
            PatientId = 10,
            DoctorId = 20,
            VisitDate = new DateOnly(2026, 6, 20),
            Diagnosis = "Fever",
            Prescription = "Paracetamol",
            Notes = "Rest advised"
        };

        _patientRepositoryMock
            .Setup(repo => repo.GetByIdAsync(10))
            .ReturnsAsync(new Patient { Id = 10, UserId = 100 });

        _doctorRepositoryMock
            .Setup(repo => repo.GetByIdAsync(20))
            .ReturnsAsync((Doctor?)null);

        // Act
        var result = await _healthRecordService.CreateHealthRecordAsync(dto);

        // Assert
        Assert.Null(result);
    }

    [Fact]
    public async Task CreateHealthRecordAsync_WhenValid_ShouldCreateHealthRecord()
    {
        // Arrange
        var dto = new CreateHealthRecordDto
        {
            PatientId = 10,
            DoctorId = 20,
            VisitDate = new DateOnly(2026, 6, 20),
            Diagnosis = "Fever",
            Prescription = "Paracetamol",
            Notes = "Rest advised"
        };

        var healthRecord = new HealthRecord
        {
            PatientId = 10,
            DoctorId = 20,
            VisitDate = new DateOnly(2026, 6, 20),
            Diagnosis = "Fever",
            Prescription = "Paracetamol",
            Notes = "Rest advised"
        };

        var createdRecord = new HealthRecord
        {
            Id = 1,
            PatientId = 10,
            DoctorId = 20,
            VisitDate = new DateOnly(2026, 6, 20),
            Diagnosis = "Fever",
            Prescription = "Paracetamol",
            Notes = "Rest advised"
        };

        var mappedDto = new HealthRecordDto
        {
            Id = 1,
            PatientId = 10,
            DoctorId = 20,
            VisitDate = new DateOnly(2026, 6, 20),
            Diagnosis = "Fever",
            Prescription = "Paracetamol",
            Notes = "Rest advised"
        };

        _patientRepositoryMock
            .Setup(repo => repo.GetByIdAsync(10))
            .ReturnsAsync(new Patient { Id = 10, UserId = 100 });

        _doctorRepositoryMock
            .Setup(repo => repo.GetByIdAsync(20))
            .ReturnsAsync(new Doctor { Id = 20, UserId = 200 });

        _mapperMock
            .Setup(mapper => mapper.Map<HealthRecord>(dto))
            .Returns(healthRecord);

        _healthRecordRepositoryMock
            .Setup(repo => repo.AddAsync(healthRecord))
            .ReturnsAsync(createdRecord);

        _mapperMock
            .Setup(mapper => mapper.Map<HealthRecordDto>(createdRecord))
            .Returns(mappedDto);

        _userRepositoryMock
            .Setup(repo => repo.GetFullNameByIdAsync(100))
            .ReturnsAsync("Patient One");

        _userRepositoryMock
            .Setup(repo => repo.GetFullNameByIdAsync(200))
            .ReturnsAsync("Doctor One");

        // Act
        var result = await _healthRecordService.CreateHealthRecordAsync(dto);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(1, result!.Id);
        Assert.Equal(10, result.PatientId);
        Assert.Equal(20, result.DoctorId);
        Assert.Equal("Patient One", result.PatientName);
        Assert.Equal("Doctor One", result.DoctorName);
        Assert.Equal("Fever", result.Diagnosis);
        Assert.Equal("Paracetamol", result.Prescription);

        _healthRecordRepositoryMock.Verify(
            repo => repo.AddAsync(It.Is<HealthRecord>(record =>
                record.PatientId == 10 &&
                record.DoctorId == 20 &&
                record.Diagnosis == "Fever" &&
                record.Prescription == "Paracetamol")),
            Times.Once);
    }
}