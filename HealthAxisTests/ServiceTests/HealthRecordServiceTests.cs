using AutoMapper;
using HealthAxis.API.Constants;
using HealthAxis.API.Data;
using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Dtos.HealthRecord;
using HealthAxis.Shared.Enums;
using HealthAxis.API.Exceptions;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using HealthAxis.API.Services.Impl;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Moq;

namespace HealthAxisTests;

public class HealthRecordServiceTests
{
    private readonly HealthAxisDbContext _context;
    private readonly Mock<IHealthRecordRepository> _healthRecordRepositoryMock;
    private readonly Mock<IAppointmentRepository> _appointmentRepositoryMock;
    private readonly Mock<IMapper> _mapperMock;
    private readonly HealthRecordService _healthRecordService;

    public HealthRecordServiceTests()
    {
        _context = CreateDbContext();
        _healthRecordRepositoryMock = new Mock<IHealthRecordRepository>();
        _appointmentRepositoryMock = new Mock<IAppointmentRepository>();
        _mapperMock = new Mock<IMapper>();

        _healthRecordService = new HealthRecordService(
            _context,
            _healthRecordRepositoryMock.Object,
            _appointmentRepositoryMock.Object,
            _mapperMock.Object
        );
    }

    [Fact]
    public async Task GetHealthRecordsByPatientIdAsync_WhenRecordsExist_ShouldReturnPagedHealthRecordDtos()
    {
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
                    PatientId = 10,
                    DoctorId = 20,
                    Patient = new Patient { Id = 10, UserId = "patient-user-id", FullName = "Patient One" },
                    Doctor = new Doctor { Id = 20, UserId = "doctor-user-id", FullName = "Doctor One" }
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

        var mappedDtos = new List<HealthRecordDto>
        {
            new HealthRecordDto
            {
                Id = 1,
                AppointmentId = 100,
                PatientId = 10,
                DoctorId = 20,
                PatientName = "Patient One",
                DoctorName = "Doctor One",
                VisitDate = new DateOnly(2026, 6, 20),
                Diagnosis = "Fever",
                Prescription = "Paracetamol",
                Notes = "Rest advised"
            }
        };

        var pagination = new PaginationQueryDto { PageNumber = 1, PageSize = 10 };

        _healthRecordRepositoryMock
            .Setup(repo => repo.GetHealthRecordsByPatientIdAsync(10, 1, 10))
            .ReturnsAsync(pagedRecords);

        _mapperMock
            .Setup(mapper => mapper.Map<List<HealthRecordDto>>(records))
            .Returns(mappedDtos);

        var result = await _healthRecordService.GetHealthRecordsByPatientIdAsync(10, pagination);

        Assert.NotNull(result);
        Assert.Single(result.Items);
        Assert.Equal(1, result.Items[0].Id);
        Assert.Equal(100, result.Items[0].AppointmentId);
        Assert.Equal(10, result.Items[0].PatientId);
        Assert.Equal(20, result.Items[0].DoctorId);
        Assert.Equal("Patient One", result.Items[0].PatientName);
        Assert.Equal("Doctor One", result.Items[0].DoctorName);
        Assert.Equal("Fever", result.Items[0].Diagnosis);
        Assert.Equal("Paracetamol", result.Items[0].Prescription);
        Assert.Equal(1, result.PageNumber);
        Assert.Equal(10, result.PageSize);
        Assert.Equal(1, result.TotalCount);
        Assert.Equal(1, result.TotalPages);
    }

    [Fact]
    public async Task GetHealthRecordsByPatientIdAsync_WhenNoRecordsExist_ShouldReturnEmptyPagedResult()
    {
        var records = new List<HealthRecord>();
        var pagedRecords = new PagedResult<HealthRecord>
        {
            Items = records,
            PageNumber = 1,
            PageSize = 10,
            TotalCount = 0,
            TotalPages = 0
        };
        var mappedDtos = new List<HealthRecordDto>();
        var pagination = new PaginationQueryDto { PageNumber = 1, PageSize = 10 };

        _healthRecordRepositoryMock
            .Setup(repo => repo.GetHealthRecordsByPatientIdAsync(10, 1, 10))
            .ReturnsAsync(pagedRecords);

        _mapperMock
            .Setup(mapper => mapper.Map<List<HealthRecordDto>>(records))
            .Returns(mappedDtos);

        var result = await _healthRecordService.GetHealthRecordsByPatientIdAsync(10, pagination);

        Assert.NotNull(result);
        Assert.Empty(result.Items);
        Assert.Equal(1, result.PageNumber);
        Assert.Equal(10, result.PageSize);
        Assert.Equal(0, result.TotalCount);
        Assert.Equal(0, result.TotalPages);
    }

    [Fact]
    public async Task GetHealthRecordsByPatientIdAndDoctorIdAsync_WhenRecordsExist_ShouldReturnMatchingPagedHealthRecordDtos()
    {
        var records = new List<HealthRecord>
        {
            new HealthRecord
            {
                Id = 1,
                AppointmentId = 100,
                Diagnosis = "Fever",
                Appointment = new Appointment { Id = 100, PatientId = 10, DoctorId = 20 }
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

        var mappedDtos = new List<HealthRecordDto>
        {
            new HealthRecordDto
            {
                Id = 1,
                AppointmentId = 100,
                PatientId = 10,
                DoctorId = 20,
                Diagnosis = "Fever"
            }
        };

        var pagination = new PaginationQueryDto { PageNumber = 1, PageSize = 10 };

        _healthRecordRepositoryMock
            .Setup(repo => repo.GetHealthRecordsByPatientIdAndDoctorIdAsync(10, 20, 1, 10))
            .ReturnsAsync(pagedRecords);

        _mapperMock
            .Setup(mapper => mapper.Map<List<HealthRecordDto>>(records))
            .Returns(mappedDtos);

        var result = await _healthRecordService.GetHealthRecordsByPatientIdAndDoctorIdAsync(10, 20, pagination);

        Assert.NotNull(result);
        Assert.Single(result.Items);
        Assert.Equal(100, result.Items[0].AppointmentId);
        Assert.Equal(10, result.Items[0].PatientId);
        Assert.Equal(20, result.Items[0].DoctorId);
        Assert.Equal(1, result.PageNumber);
        Assert.Equal(10, result.PageSize);
        Assert.Equal(1, result.TotalCount);
        Assert.Equal(1, result.TotalPages);
    }

    [Fact]
    public async Task GetHealthRecordByIdAsync_WhenRecordExists_ShouldReturnHealthRecordDto()
    {
        var record = new HealthRecord
        {
            Id = 1,
            AppointmentId = 100,
            VisitDate = new DateOnly(2026, 6, 20),
            Diagnosis = "Migraine",
            Prescription = "Pain relief medicine",
            Notes = "Follow up after one week",
            Appointment = new Appointment
            {
                Id = 100,
                PatientId = 10,
                DoctorId = 20,
                Patient = new Patient { Id = 10, UserId = "patient-user-id", FullName = "Patient One" },
                Doctor = new Doctor { Id = 20, UserId = "doctor-user-id", FullName = "Doctor One" }
            }
        };

        var mappedDto = new HealthRecordDto
        {
            Id = 1,
            AppointmentId = 100,
            PatientId = 10,
            DoctorId = 20,
            PatientName = "Patient One",
            DoctorName = "Doctor One",
            VisitDate = new DateOnly(2026, 6, 20),
            Diagnosis = "Migraine",
            Prescription = "Pain relief medicine",
            Notes = "Follow up after one week"
        };

        _healthRecordRepositoryMock
            .Setup(repo => repo.GetHealthRecordByIdWithDetailsAsync(1))
            .ReturnsAsync(record);

        _mapperMock
            .Setup(mapper => mapper.Map<HealthRecordDto>(record))
            .Returns(mappedDto);

        var result = await _healthRecordService.GetHealthRecordByIdAsync(1);

        Assert.NotNull(result);
        Assert.Equal(1, result.Id);
        Assert.Equal(100, result.AppointmentId);
        Assert.Equal("Patient One", result.PatientName);
        Assert.Equal("Doctor One", result.DoctorName);
        Assert.Equal("Migraine", result.Diagnosis);
        Assert.Equal("Pain relief medicine", result.Prescription);
        Assert.Equal("Follow up after one week", result.Notes);
    }

    [Fact]
    public async Task GetHealthRecordByIdAsync_WhenRecordDoesNotExist_ShouldThrowNotFoundException()
    {
        _healthRecordRepositoryMock
            .Setup(repo => repo.GetHealthRecordByIdWithDetailsAsync(99))
            .ReturnsAsync((HealthRecord?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() =>
            _healthRecordService.GetHealthRecordByIdAsync(99));

        Assert.Equal(ErrorMessages.HealthRecordNotFound, exception.Message);
    }

    [Fact]
    public async Task CreateHealthRecordAsync_WhenAppointmentDoesNotExist_ShouldThrowNotFoundException()
    {
        var dto = CreateHealthRecordDto();

        _appointmentRepositoryMock
            .Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(dto.AppointmentId))
            .ReturnsAsync((Appointment?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() =>
            _healthRecordService.CreateHealthRecordAsync(dto, doctorId: 20));

        Assert.Equal(ErrorMessages.AppointmentNotFound, exception.Message);
    }

    [Fact]
    public async Task CreateHealthRecordAsync_WhenDoctorDoesNotOwnAppointment_ShouldThrowForbiddenException()
    {
        var dto = CreateHealthRecordDto();
        var appointment = CreateConfirmedAppointmentToday();
        appointment.DoctorId = 99;

        _appointmentRepositoryMock
            .Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(dto.AppointmentId))
            .ReturnsAsync(appointment);

        var exception = await Assert.ThrowsAsync<ForbiddenException>(() =>
            _healthRecordService.CreateHealthRecordAsync(dto, doctorId: 20));

        Assert.Equal(ErrorMessages.DoctorCanCreateHealthRecordOnlyForOwnAppointment, exception.Message);
    }

    [Fact]
    public async Task CreateHealthRecordAsync_WhenAppointmentIsNotConfirmed_ShouldThrowBusinessRuleException()
    {
        var dto = CreateHealthRecordDto();
        var appointment = CreateConfirmedAppointmentToday();
        appointment.Status = AppointmentStatus.Pending;

        _appointmentRepositoryMock
            .Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(dto.AppointmentId))
            .ReturnsAsync(appointment);

        var exception = await Assert.ThrowsAsync<BusinessRuleException>(() =>
            _healthRecordService.CreateHealthRecordAsync(dto, doctorId: 20));

        Assert.Equal(ErrorMessages.OnlyConfirmedAppointmentsCanBeCompleted, exception.Message);
    }

    [Fact]
    public async Task CreateHealthRecordAsync_WhenAppointmentIsNotToday_ShouldThrowBusinessRuleException()
    {
        var dto = CreateHealthRecordDto();
        var appointment = CreateConfirmedAppointmentToday();
        appointment.AppointmentDate = DateOnly.FromDateTime(DateTime.Today.AddDays(1));
        dto.VisitDate = appointment.AppointmentDate;

        _appointmentRepositoryMock
            .Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(dto.AppointmentId))
            .ReturnsAsync(appointment);

        var exception = await Assert.ThrowsAsync<BusinessRuleException>(() =>
            _healthRecordService.CreateHealthRecordAsync(dto, doctorId: 20));

        Assert.Equal(ErrorMessages.HealthRecordCanBeCreatedOnlyOnAppointmentDate, exception.Message);
    }

    [Fact]
    public async Task CreateHealthRecordAsync_WhenVisitDateDoesNotMatchAppointmentDate_ShouldThrowBusinessRuleException()
    {
        var dto = CreateHealthRecordDto();
        dto.VisitDate = DateOnly.FromDateTime(DateTime.Today.AddDays(1));
        var appointment = CreateConfirmedAppointmentToday();

        _appointmentRepositoryMock
            .Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(dto.AppointmentId))
            .ReturnsAsync(appointment);

        var exception = await Assert.ThrowsAsync<BusinessRuleException>(() =>
            _healthRecordService.CreateHealthRecordAsync(dto, doctorId: 20));

        Assert.Equal(ErrorMessages.VisitDateMustMatchAppointmentDate, exception.Message);
    }

    [Fact]
    public async Task CreateHealthRecordAsync_WhenHealthRecordAlreadyExists_ShouldThrowConflictException()
    {
        var dto = CreateHealthRecordDto();
        var appointment = CreateConfirmedAppointmentToday();
        var existingRecord = new HealthRecord { Id = 5, AppointmentId = dto.AppointmentId };

        _appointmentRepositoryMock
            .Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(dto.AppointmentId))
            .ReturnsAsync(appointment);

        _healthRecordRepositoryMock
            .Setup(repo => repo.GetHealthRecordByAppointmentIdAsync(dto.AppointmentId))
            .ReturnsAsync(existingRecord);

        var exception = await Assert.ThrowsAsync<ConflictException>(() =>
            _healthRecordService.CreateHealthRecordAsync(dto, doctorId: 20));

        Assert.Equal(ErrorMessages.HealthRecordAlreadyExistsForAppointment, exception.Message);
    }

    [Fact]
    public async Task CreateHealthRecordAsync_WhenValid_ShouldCreateHealthRecordAndCompleteAppointment()
    {
        var dto = CreateHealthRecordDto();
        var appointment = CreateConfirmedAppointmentToday();

        var createdRecord = new HealthRecord
        {
            Id = 1,
            AppointmentId = dto.AppointmentId,
            VisitDate = dto.VisitDate,
            Diagnosis = dto.Diagnosis,
            Prescription = dto.Prescription,
            Notes = dto.Notes
        };

        var recordWithDetails = new HealthRecord
        {
            Id = 1,
            AppointmentId = dto.AppointmentId,
            VisitDate = dto.VisitDate,
            Diagnosis = dto.Diagnosis,
            Prescription = dto.Prescription,
            Notes = dto.Notes,
            Appointment = appointment
        };

        var mappedDto = new HealthRecordDto
        {
            Id = 1,
            AppointmentId = dto.AppointmentId,
            PatientId = 10,
            DoctorId = 20,
            PatientName = "Patient One",
            DoctorName = "Doctor One",
            VisitDate = dto.VisitDate,
            Diagnosis = dto.Diagnosis,
            Prescription = dto.Prescription,
            Notes = dto.Notes
        };

        _appointmentRepositoryMock
            .Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(dto.AppointmentId))
            .ReturnsAsync(appointment);

        _healthRecordRepositoryMock
            .Setup(repo => repo.GetHealthRecordByAppointmentIdAsync(dto.AppointmentId))
            .ReturnsAsync((HealthRecord?)null);

        _healthRecordRepositoryMock
            .Setup(repo => repo.AddAsync(It.IsAny<HealthRecord>()))
            .ReturnsAsync(createdRecord);

        _appointmentRepositoryMock
            .Setup(repo => repo.UpdateAsync(It.IsAny<Appointment>()))
            .ReturnsAsync(appointment);

        _healthRecordRepositoryMock
            .Setup(repo => repo.GetHealthRecordByIdWithDetailsAsync(1))
            .ReturnsAsync(recordWithDetails);

        _mapperMock
            .Setup(mapper => mapper.Map<HealthRecordDto>(recordWithDetails))
            .Returns(mappedDto);

        var result = await _healthRecordService.CreateHealthRecordAsync(dto, doctorId: 20);

        Assert.NotNull(result);
        Assert.Equal(1, result.Id);
        Assert.Equal(dto.AppointmentId, result.AppointmentId);
        Assert.Equal(10, result.PatientId);
        Assert.Equal(20, result.DoctorId);
        Assert.Equal("Patient One", result.PatientName);
        Assert.Equal("Doctor One", result.DoctorName);
        Assert.Equal("Fever", result.Diagnosis);
        Assert.Equal("Paracetamol", result.Prescription);

        _healthRecordRepositoryMock.Verify(repo => repo.AddAsync(It.Is<HealthRecord>(record =>
            record.AppointmentId == dto.AppointmentId &&
            record.Diagnosis == "Fever" &&
            record.Prescription == "Paracetamol")), Times.Once);

        _appointmentRepositoryMock.Verify(repo => repo.UpdateAsync(It.Is<Appointment>(updatedAppointment =>
            updatedAppointment.Id == dto.AppointmentId &&
            updatedAppointment.Status == AppointmentStatus.Completed)), Times.Once);
    }
    [Fact]
    public async Task GetHealthRecordsForDoctorPatientViewAsync_WhenDoctorHasConfirmedAppointment_ShouldReturnAllPatientRecords()
    {
        // Arrange
        const int patientId = 10;
        const int doctorId = 20;

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
                PatientId = patientId,
                DoctorId = 99
            }
        },
        new HealthRecord
        {
            Id = 2,
            AppointmentId = 101,
            VisitDate = new DateOnly(2026, 6, 21),
            Diagnosis = "Migraine",
            Prescription = "Pain relief medicine",
            Notes = "Follow up advised",
            Appointment = new Appointment
            {
                Id = 101,
                PatientId = patientId,
                DoctorId = doctorId
            }
        }
    };

        var pagedRecords = new PagedResult<HealthRecord>
        {
            Items = records,
            PageNumber = 1,
            PageSize = 10,
            TotalCount = 2,
            TotalPages = 1
        };

        var mappedDtos = new List<HealthRecordDto>
    {
        new HealthRecordDto
        {
            Id = 1,
            AppointmentId = 100,
            PatientId = patientId,
            DoctorId = 99,
            VisitDate = new DateOnly(2026, 6, 20),
            Diagnosis = "Fever",
            Prescription = "Paracetamol",
            Notes = "Rest advised"
        },
        new HealthRecordDto
        {
            Id = 2,
            AppointmentId = 101,
            PatientId = patientId,
            DoctorId = doctorId,
            VisitDate = new DateOnly(2026, 6, 21),
            Diagnosis = "Migraine",
            Prescription = "Pain relief medicine",
            Notes = "Follow up advised"
        }
    };

        var pagination = new PaginationQueryDto
        {
            PageNumber = 1,
            PageSize = 10
        };

        _appointmentRepositoryMock
            .Setup(repo => repo.DoctorHasConfirmedAppointmentWithPatientAsync(doctorId, patientId))
            .ReturnsAsync(true);

        _healthRecordRepositoryMock
            .Setup(repo => repo.GetHealthRecordsByPatientIdAsync(patientId, 1, 10))
            .ReturnsAsync(pagedRecords);

        _mapperMock
            .Setup(mapper => mapper.Map<List<HealthRecordDto>>(records))
            .Returns(mappedDtos);

        // Act
        var result = await _healthRecordService.GetHealthRecordsForDoctorPatientViewAsync(
            patientId,
            doctorId,
            pagination);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(2, result.Items.Count);
        Assert.Equal(1, result.PageNumber);
        Assert.Equal(10, result.PageSize);
        Assert.Equal(2, result.TotalCount);
        Assert.Equal(1, result.TotalPages);

        _healthRecordRepositoryMock.Verify(repo =>
            repo.GetHealthRecordsByPatientIdAsync(patientId, 1, 10),
            Times.Once);

        _healthRecordRepositoryMock.Verify(repo =>
            repo.GetHealthRecordsByPatientIdAndDoctorIdAsync(
                It.IsAny<int>(),
                It.IsAny<int>(),
                It.IsAny<int>(),
                It.IsAny<int>()),
            Times.Never);
    }

    [Fact]
    public async Task GetHealthRecordsForDoctorPatientViewAsync_WhenAppointmentIsCompleted_ShouldReturnOnlyDoctorLinkedRecords()
    {
        // Arrange
        const int patientId = 10;
        const int doctorId = 20;

        var records = new List<HealthRecord>
    {
        new HealthRecord
        {
            Id = 3,
            AppointmentId = 102,
            VisitDate = DateOnly.FromDateTime(DateTime.Today),
            Diagnosis = "Completed appointment diagnosis",
            Prescription = "Completed appointment prescription",
            Notes = "Completed appointment notes",
            Appointment = new Appointment
            {
                Id = 102,
                PatientId = patientId,
                DoctorId = doctorId,
                Status = AppointmentStatus.Completed
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

        var mappedDtos = new List<HealthRecordDto>
    {
        new HealthRecordDto
        {
            Id = 3,
            AppointmentId = 102,
            PatientId = patientId,
            DoctorId = doctorId,
            VisitDate = DateOnly.FromDateTime(DateTime.Today),
            Diagnosis = "Completed appointment diagnosis",
            Prescription = "Completed appointment prescription",
            Notes = "Completed appointment notes"
        }
    };

        var pagination = new PaginationQueryDto
        {
            PageNumber = 1,
            PageSize = 10
        };

        _appointmentRepositoryMock
            .Setup(repo => repo.DoctorHasConfirmedAppointmentWithPatientAsync(doctorId, patientId))
            .ReturnsAsync(false);

        _healthRecordRepositoryMock
            .Setup(repo => repo.GetHealthRecordsByPatientIdAndDoctorIdAsync(patientId, doctorId, 1, 10))
            .ReturnsAsync(pagedRecords);

        _mapperMock
            .Setup(mapper => mapper.Map<List<HealthRecordDto>>(records))
            .Returns(mappedDtos);

        // Act
        var result = await _healthRecordService.GetHealthRecordsForDoctorPatientViewAsync(
            patientId,
            doctorId,
            pagination);

        // Assert
        Assert.NotNull(result);
        Assert.Single(result.Items);
        Assert.Equal(doctorId, result.Items[0].DoctorId);
        Assert.Equal(AppointmentStatus.Completed, records[0].Appointment!.Status);

        _appointmentRepositoryMock.Verify(repo =>
            repo.DoctorHasConfirmedAppointmentWithPatientAsync(doctorId, patientId),
            Times.Once);

        _healthRecordRepositoryMock.Verify(repo =>
            repo.GetHealthRecordsByPatientIdAndDoctorIdAsync(patientId, doctorId, 1, 10),
            Times.Once);

        _healthRecordRepositoryMock.Verify(repo =>
            repo.GetHealthRecordsByPatientIdAsync(
                It.IsAny<int>(),
                It.IsAny<int>(),
                It.IsAny<int>()),
            Times.Never);
    }
    [Fact]
    public async Task GetHealthRecordsForDoctorPatientViewAsync_WhenDoctorHasNoConfirmedAppointment_ShouldReturnDoctorLinkedRecords()
    {
        // Arrange
        const int patientId = 10;
        const int doctorId = 20;

        var records = new List<HealthRecord>
    {
        new HealthRecord
        {
            Id = 2,
            AppointmentId = 101,
            VisitDate = new DateOnly(2026, 6, 21),
            Diagnosis = "Migraine",
            Prescription = "Pain relief medicine",
            Notes = "Follow up advised",
            Appointment = new Appointment
            {
                Id = 101,
                PatientId = patientId,
                DoctorId = doctorId
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

        var mappedDtos = new List<HealthRecordDto>
    {
        new HealthRecordDto
        {
            Id = 2,
            AppointmentId = 101,
            PatientId = patientId,
            DoctorId = doctorId,
            VisitDate = new DateOnly(2026, 6, 21),
            Diagnosis = "Migraine",
            Prescription = "Pain relief medicine",
            Notes = "Follow up advised"
        }
    };

        var pagination = new PaginationQueryDto
        {
            PageNumber = 1,
            PageSize = 10
        };

        _appointmentRepositoryMock
            .Setup(repo => repo.DoctorHasConfirmedAppointmentWithPatientAsync(doctorId, patientId))
            .ReturnsAsync(false);

        _healthRecordRepositoryMock
            .Setup(repo => repo.GetHealthRecordsByPatientIdAndDoctorIdAsync(patientId, doctorId, 1, 10))
            .ReturnsAsync(pagedRecords);

        _mapperMock
            .Setup(mapper => mapper.Map<List<HealthRecordDto>>(records))
            .Returns(mappedDtos);

        // Act
        var result = await _healthRecordService.GetHealthRecordsForDoctorPatientViewAsync(
            patientId,
            doctorId,
            pagination);

        // Assert
        Assert.NotNull(result);
        Assert.Single(result.Items);
        Assert.Equal(doctorId, result.Items[0].DoctorId);
        Assert.Equal(1, result.PageNumber);
        Assert.Equal(10, result.PageSize);
        Assert.Equal(1, result.TotalCount);
        Assert.Equal(1, result.TotalPages);

        _healthRecordRepositoryMock.Verify(repo =>
            repo.GetHealthRecordsByPatientIdAndDoctorIdAsync(patientId, doctorId, 1, 10),
            Times.Once);

        _healthRecordRepositoryMock.Verify(repo =>
            repo.GetHealthRecordsByPatientIdAsync(
                It.IsAny<int>(),
                It.IsAny<int>(),
                It.IsAny<int>()),
            Times.Never);
    }

    private static HealthAxisDbContext CreateDbContext()
    {
        var options = new DbContextOptionsBuilder<HealthAxisDbContext>()
            .UseInMemoryDatabase(Guid.NewGuid().ToString())
            .ConfigureWarnings(warnings => warnings.Ignore(InMemoryEventId.TransactionIgnoredWarning))
            .Options;

        return new HealthAxisDbContext(options);
    }

    private static Appointment CreateConfirmedAppointmentToday()
    {
        return new Appointment
        {
            Id = 100,
            PatientId = 10,
            DoctorId = 20,
            AppointmentDate = DateOnly.FromDateTime(DateTime.Today),
            AppointmentTime = new TimeOnly(10, 30),
            Status = AppointmentStatus.Confirmed,
            Patient = new Patient { Id = 10, UserId = "patient-user-id", FullName = "Patient One" },
            Doctor = new Doctor { Id = 20, UserId = "doctor-user-id", FullName = "Doctor One" }
        };
    }

    private static CreateHealthRecordDto CreateHealthRecordDto()
    {
        return new CreateHealthRecordDto
        {
            AppointmentId = 100,
            VisitDate = DateOnly.FromDateTime(DateTime.Today),
            Diagnosis = "Fever",
            Prescription = "Paracetamol",
            Notes = "Rest advised"
        };
    }
}
