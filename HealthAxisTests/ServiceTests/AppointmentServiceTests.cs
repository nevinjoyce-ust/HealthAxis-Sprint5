using AutoMapper;
using HealthAxis.API.Dtos;
using HealthAxis.API.Enums;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using HealthAxis.API.Services.Impl;
using Moq;

namespace HealthAxisTests;

public class AppointmentServiceTests
{
    private readonly Mock<IAppointmentRepository> _appointmentRepositoryMock;
    private readonly Mock<IPatientRepository> _patientRepositoryMock;
    private readonly Mock<IDoctorRepository> _doctorRepositoryMock;
    private readonly Mock<IUserRepository> _userRepositoryMock;
    private readonly Mock<IMapper> _mapperMock;
    private readonly AppointmentService _appointmentService;

    public AppointmentServiceTests()
    {
        _appointmentRepositoryMock = new Mock<IAppointmentRepository>();
        _patientRepositoryMock = new Mock<IPatientRepository>();
        _doctorRepositoryMock = new Mock<IDoctorRepository>();
        _userRepositoryMock = new Mock<IUserRepository>();
        _mapperMock = new Mock<IMapper>();

        _appointmentService = new AppointmentService(
            _appointmentRepositoryMock.Object,
            _patientRepositoryMock.Object,
            _doctorRepositoryMock.Object,
            _userRepositoryMock.Object,
            _mapperMock.Object
        );
    }

    [Fact]
    public async Task GetAllAppointmentsAsync_WhenAppointmentsExist_ShouldReturnAppointmentDtos()
    {
        // Arrange
        var appointments = new List<Appointment>
        {
            new Appointment
            {
                Id = 1,
                PatientId = 10,
                DoctorId = 20,
                AppointmentDate = new DateOnly(2026, 6, 20),
                AppointmentTime = new TimeOnly(10, 30),
                Status = AppointmentStatus.Pending
            }
        };

        var mappedAppointmentDto = new AppointmentDto
        {
            Id = 1,
            PatientId = 10,
            DoctorId = 20,
            AppointmentDate = new DateOnly(2026, 6, 20),
            AppointmentTime = new TimeOnly(10, 30),
            Status = AppointmentStatus.Pending
        };

        _appointmentRepositoryMock
            .Setup(repo => repo.GetAllAsync())
            .ReturnsAsync(appointments);

        _mapperMock
            .Setup(mapper => mapper.Map<AppointmentDto>(It.IsAny<Appointment>()))
            .Returns(mappedAppointmentDto);

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
        var result = await _appointmentService.GetAllAppointmentsAsync();

        // Assert
        Assert.NotNull(result);
        Assert.Single(result);
        Assert.Equal(1, result[0].Id);
        Assert.Equal("Patient One", result[0].PatientName);
        Assert.Equal("Doctor One", result[0].DoctorName);
        Assert.Equal(AppointmentStatus.Pending, result[0].Status);
    }

    [Fact]
    public async Task GetAllAppointmentsAsync_WhenNoAppointmentsExist_ShouldReturnEmptyList()
    {
        // Arrange
        _appointmentRepositoryMock
            .Setup(repo => repo.GetAllAsync())
            .ReturnsAsync(new List<Appointment>());

        // Act
        var result = await _appointmentService.GetAllAppointmentsAsync();

        // Assert
        Assert.NotNull(result);
        Assert.Empty(result);
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenPatientDoesNotExist_ShouldReturnNull()
    {
        // Arrange
        var dto = new CreateAppointmentDto
        {
            PatientId = 10,
            DoctorId = 20,
            AppointmentDate = new DateOnly(2026, 6, 20),
            AppointmentTime = new TimeOnly(10, 30)
        };

        _patientRepositoryMock
            .Setup(repo => repo.GetByIdAsync(10))
            .ReturnsAsync((Patient?)null);

        // Act
        var result = await _appointmentService.CreateAppointmentAsync(dto);

        // Assert
        Assert.Null(result);
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenDoctorDoesNotExist_ShouldReturnNull()
    {
        // Arrange
        var dto = new CreateAppointmentDto
        {
            PatientId = 10,
            DoctorId = 20,
            AppointmentDate = new DateOnly(2026, 6, 20),
            AppointmentTime = new TimeOnly(10, 30)
        };

        _patientRepositoryMock
            .Setup(repo => repo.GetByIdAsync(10))
            .ReturnsAsync(new Patient { Id = 10, UserId = 100 });

        _doctorRepositoryMock
            .Setup(repo => repo.GetByIdAsync(20))
            .ReturnsAsync((Doctor?)null);

        // Act
        var result = await _appointmentService.CreateAppointmentAsync(dto);

        // Assert
        Assert.Null(result);
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenDoctorIsUnavailable_ShouldReturnNull()
    {
        // Arrange
        var dto = new CreateAppointmentDto
        {
            PatientId = 10,
            DoctorId = 20,
            AppointmentDate = new DateOnly(2026, 6, 20),
            AppointmentTime = new TimeOnly(10, 30)
        };

        _patientRepositoryMock
            .Setup(repo => repo.GetByIdAsync(10))
            .ReturnsAsync(new Patient { Id = 10, UserId = 100 });

        _doctorRepositoryMock
            .Setup(repo => repo.GetByIdAsync(20))
            .ReturnsAsync(new Doctor
            {
                Id = 20,
                UserId = 200,
                IsAvailable = false
            });

        // Act
        var result = await _appointmentService.CreateAppointmentAsync(dto);

        // Assert
        Assert.Null(result);
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenValid_ShouldCreateAppointmentWithPendingStatus()
    {
        // Arrange
        var dto = new CreateAppointmentDto
        {
            PatientId = 10,
            DoctorId = 20,
            AppointmentDate = new DateOnly(2026, 6, 20),
            AppointmentTime = new TimeOnly(10, 30)
        };

        var createdAppointment = new Appointment
        {
            Id = 1,
            PatientId = 10,
            DoctorId = 20,
            AppointmentDate = dto.AppointmentDate,
            AppointmentTime = dto.AppointmentTime,
            Status = AppointmentStatus.Pending
        };

        var mappedAppointmentDto = new AppointmentDto
        {
            Id = 1,
            PatientId = 10,
            DoctorId = 20,
            AppointmentDate = dto.AppointmentDate,
            AppointmentTime = dto.AppointmentTime,
            Status = AppointmentStatus.Pending
        };

        _patientRepositoryMock
            .Setup(repo => repo.GetByIdAsync(10))
            .ReturnsAsync(new Patient { Id = 10, UserId = 100 });

        _doctorRepositoryMock
            .Setup(repo => repo.GetByIdAsync(20))
            .ReturnsAsync(new Doctor
            {
                Id = 20,
                UserId = 200,
                IsAvailable = true
            });

        _appointmentRepositoryMock
            .Setup(repo => repo.AddAsync(It.IsAny<Appointment>()))
            .ReturnsAsync(createdAppointment);

        _mapperMock
            .Setup(mapper => mapper.Map<AppointmentDto>(createdAppointment))
            .Returns(mappedAppointmentDto);

        _userRepositoryMock
            .Setup(repo => repo.GetFullNameByIdAsync(100))
            .ReturnsAsync("Patient One");

        _userRepositoryMock
            .Setup(repo => repo.GetFullNameByIdAsync(200))
            .ReturnsAsync("Doctor One");

        // Act
        var result = await _appointmentService.CreateAppointmentAsync(dto);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(1, result!.Id);
        Assert.Equal(10, result.PatientId);
        Assert.Equal(20, result.DoctorId);
        Assert.Equal(AppointmentStatus.Pending, result.Status);
        Assert.Equal("Patient One", result.PatientName);
        Assert.Equal("Doctor One", result.DoctorName);

        _appointmentRepositoryMock.Verify(
            repo => repo.AddAsync(It.Is<Appointment>(appointment =>
                appointment.PatientId == 10 &&
                appointment.DoctorId == 20 &&
                appointment.Status == AppointmentStatus.Pending)),
            Times.Once);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenAppointmentDoesNotExist_ShouldReturnNull()
    {
        // Arrange
        var dto = new UpdateAppointmentStatusDto
        {
            Status = AppointmentStatus.Confirmed
        };

        _appointmentRepositoryMock
            .Setup(repo => repo.GetByIdAsync(99))
            .ReturnsAsync((Appointment?)null);

        // Act
        var result = await _appointmentService.UpdateAppointmentStatusAsync(99, dto);

        // Assert
        Assert.Null(result);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenAppointmentExists_ShouldUpdateStatus()
    {
        // Arrange
        var appointment = new Appointment
        {
            Id = 1,
            PatientId = 10,
            DoctorId = 20,
            AppointmentDate = new DateOnly(2026, 6, 20),
            AppointmentTime = new TimeOnly(10, 30),
            Status = AppointmentStatus.Pending
        };

        var dto = new UpdateAppointmentStatusDto
        {
            Status = AppointmentStatus.Cancelled,
            CancellationReason = "Patient requested cancellation"
        };

        var mappedAppointmentDto = new AppointmentDto
        {
            Id = 1,
            PatientId = 10,
            DoctorId = 20,
            AppointmentDate = appointment.AppointmentDate,
            AppointmentTime = appointment.AppointmentTime,
            Status = AppointmentStatus.Cancelled,
            CancellationReason = "Patient requested cancellation"
        };

        _appointmentRepositoryMock
            .Setup(repo => repo.GetByIdAsync(1))
            .ReturnsAsync(appointment);

        _appointmentRepositoryMock
            .Setup(repo => repo.UpdateAsync(It.IsAny<Appointment>()))
            .ReturnsAsync(appointment);

        _mapperMock
            .Setup(mapper => mapper.Map<AppointmentDto>(appointment))
            .Returns(mappedAppointmentDto);

        // Act
        var result = await _appointmentService.UpdateAppointmentStatusAsync(1, dto);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(AppointmentStatus.Cancelled, result!.Status);
        Assert.Equal("Patient requested cancellation", result.CancellationReason);

        _appointmentRepositoryMock.Verify(
            repo => repo.UpdateAsync(It.Is<Appointment>(appointment =>
                appointment.Id == 1 &&
                appointment.Status == AppointmentStatus.Cancelled &&
                appointment.CancellationReason == "Patient requested cancellation")),
            Times.Once);
    }

    [Fact]
    public async Task DeleteAppointmentAsync_WhenAppointmentDoesNotExist_ShouldReturnNull()
    {
        // Arrange
        _appointmentRepositoryMock
            .Setup(repo => repo.DeleteAppointmentAsync(99))
            .ReturnsAsync((Appointment?)null);

        // Act
        var result = await _appointmentService.DeleteAppointmentAsync(99);

        // Assert
        Assert.Null(result);
    }

    [Fact]
    public async Task DeleteAppointmentAsync_WhenAppointmentExists_ShouldReturnDeletedAppointmentDto()
    {
        // Arrange
        var deletedAppointment = new Appointment
        {
            Id = 1,
            PatientId = 10,
            DoctorId = 20,
            AppointmentDate = new DateOnly(2026, 6, 20),
            AppointmentTime = new TimeOnly(10, 30),
            Status = AppointmentStatus.Cancelled
        };

        var mappedAppointmentDto = new AppointmentDto
        {
            Id = 1,
            PatientId = 10,
            DoctorId = 20,
            AppointmentDate = deletedAppointment.AppointmentDate,
            AppointmentTime = deletedAppointment.AppointmentTime,
            Status = AppointmentStatus.Cancelled
        };

        _appointmentRepositoryMock
            .Setup(repo => repo.DeleteAppointmentAsync(1))
            .ReturnsAsync(deletedAppointment);

        _mapperMock
            .Setup(mapper => mapper.Map<AppointmentDto>(deletedAppointment))
            .Returns(mappedAppointmentDto);

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
        var result = await _appointmentService.DeleteAppointmentAsync(1);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(1, result!.Id);
        Assert.Equal("Patient One", result.PatientName);
        Assert.Equal("Doctor One", result.DoctorName);
    }

    [Fact]
    public async Task GetAppointmentReportsAsync_WhenAppointmentsExist_ShouldReturnGroupedReports()
    {
        // Arrange
        var appointments = new List<Appointment>
        {
            new Appointment
            {
                Id = 1,
                AppointmentDate = new DateOnly(2026, 6, 20),
                Status = AppointmentStatus.Confirmed
            },
            new Appointment
            {
                Id = 2,
                AppointmentDate = new DateOnly(2026, 6, 20),
                Status = AppointmentStatus.Cancelled
            },
            new Appointment
            {
                Id = 3,
                AppointmentDate = new DateOnly(2026, 6, 20),
                Status = AppointmentStatus.Pending
            },
            new Appointment
            {
                Id = 4,
                AppointmentDate = new DateOnly(2026, 6, 21),
                Status = AppointmentStatus.Completed
            }
        };

        _appointmentRepositoryMock
            .Setup(repo => repo.GetAllAsync())
            .ReturnsAsync(appointments);

        // Act
        var result = await _appointmentService.GetAppointmentReportsAsync();

        // Assert
        Assert.NotNull(result);
        Assert.Equal(2, result.Count);

        var firstDayReport = result.First(report => report.Date == new DateOnly(2026, 6, 20));

        Assert.Equal(1, firstDayReport.ConfirmedCount);
        Assert.Equal(1, firstDayReport.CancelledCount);
        Assert.Equal(1, firstDayReport.PendingCount);
        Assert.Equal(0, firstDayReport.CompletedCount);
        Assert.Equal(3, firstDayReport.TotalCount);

        var secondDayReport = result.First(report => report.Date == new DateOnly(2026, 6, 21));

        Assert.Equal(0, secondDayReport.ConfirmedCount);
        Assert.Equal(0, secondDayReport.CancelledCount);
        Assert.Equal(0, secondDayReport.PendingCount);
        Assert.Equal(1, secondDayReport.CompletedCount);
        Assert.Equal(1, secondDayReport.TotalCount);
    }

    [Fact]
    public async Task GetAppointmentReportsAsync_WhenNoAppointmentsExist_ShouldReturnEmptyList()
    {
        // Arrange
        _appointmentRepositoryMock
            .Setup(repo => repo.GetAllAsync())
            .ReturnsAsync(new List<Appointment>());

        // Act
        var result = await _appointmentService.GetAppointmentReportsAsync();

        // Assert
        Assert.NotNull(result);
        Assert.Empty(result);
    }
}
