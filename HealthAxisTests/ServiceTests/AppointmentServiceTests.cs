using AutoMapper;
using HealthAxis.API.Constants;
using HealthAxis.API.Exceptions;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using HealthAxis.API.Repositories.Impl;
using HealthAxis.API.Services.Impl;
using HealthAxis.Shared.Constants;
using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Dtos.Appointment;
using HealthAxis.Shared.Enums;
using Moq;

namespace HealthAxisTests.ServiceTests;

public class AppointmentServiceTests
{
    private readonly Mock<IAppointmentRepository> _appointmentRepositoryMock;
    private readonly Mock<IPatientRepository> _patientRepositoryMock;
    private readonly Mock<IDoctorRepository> _doctorRepositoryMock;
    private readonly Mock<IMapper> _mapperMock;
    private readonly AppointmentService _appointmentService;

    public AppointmentServiceTests()
    {
        _appointmentRepositoryMock = new Mock<IAppointmentRepository>();
        _patientRepositoryMock = new Mock<IPatientRepository>();
        _doctorRepositoryMock = new Mock<IDoctorRepository>();
        _mapperMock = new Mock<IMapper>();

        _appointmentRepositoryMock
            .Setup(repo => repo.GetExpiredPendingAppointmentsAsync(It.IsAny<DateTime>()))
            .ReturnsAsync(new List<Appointment>());

        _appointmentService = new AppointmentService(
            _appointmentRepositoryMock.Object,
            _patientRepositoryMock.Object,
            _doctorRepositoryMock.Object,
            _mapperMock.Object
        );
    }

    [Fact]
    public async Task GetAllAppointmentsAsync_WhenAppointmentsExist_ShouldReturnPagedAppointmentDtos()
    {
        var futureDateTime = GetFutureDateTime();

        var appointments = new List<Appointment>
        {
            new Appointment
            {
                Id = 1,
                PatientId = 10,
                DoctorId = 20,
                AppointmentDate = DateOnly.FromDateTime(futureDateTime),
                AppointmentTime = TimeOnly.FromDateTime(futureDateTime),
                Status = AppointmentStatus.Pending,
                Patient = new Patient { Id = 10, UserId = "patient-user-id", FullName = "Patient One" },
                Doctor = new Doctor { Id = 20, UserId = "doctor-user-id", FullName = "Doctor One" }
            }
        };

        var pagedAppointments = new PagedResult<Appointment>
        {
            Items = appointments,
            PageNumber = 1,
            PageSize = 10,
            TotalCount = 1,
            TotalPages = 1
        };

        var mappedAppointmentDtos = new List<AppointmentDto>
        {
            new AppointmentDto
            {
                Id = 1,
                PatientId = 10,
                DoctorId = 20,
                PatientName = "Patient One",
                DoctorName = "Doctor One",
                AppointmentDate = DateOnly.FromDateTime(futureDateTime),
                AppointmentTime = TimeOnly.FromDateTime(futureDateTime),
                Status = AppointmentStatus.Pending
            }
        };

        var pagination = new PaginationQueryDto
        {
            PageNumber = 1,
            PageSize = 10
        };

        _appointmentRepositoryMock
            .Setup(repo => repo.GetAllAppointmentsAsync(1, 10))
            .ReturnsAsync(pagedAppointments);

        _mapperMock
            .Setup(mapper => mapper.Map<List<AppointmentDto>>(appointments))
            .Returns(mappedAppointmentDtos);

        var result = await _appointmentService.GetAllAppointmentsAsync(pagination);

        Assert.NotNull(result);
        Assert.Single(result.Items);
        Assert.Equal(1, result.Items[0].Id);
        Assert.Equal("Patient One", result.Items[0].PatientName);
        Assert.Equal("Doctor One", result.Items[0].DoctorName);
        Assert.Equal(AppointmentStatus.Pending, result.Items[0].Status);
        Assert.Equal(1, result.PageNumber);
        Assert.Equal(10, result.PageSize);
        Assert.Equal(1, result.TotalCount);
        Assert.Equal(1, result.TotalPages);
        Assert.False(result.HasPreviousPage);
        Assert.False(result.HasNextPage);
    }

    [Fact]
    public async Task GetAllAppointmentsAsync_WhenNoAppointmentsExist_ShouldReturnEmptyPagedResult()
    {
        var appointments = new List<Appointment>();

        var pagedAppointments = new PagedResult<Appointment>
        {
            Items = appointments,
            PageNumber = 1,
            PageSize = 10,
            TotalCount = 0,
            TotalPages = 0
        };

        var mappedAppointmentDtos = new List<AppointmentDto>();

        var pagination = new PaginationQueryDto
        {
            PageNumber = 1,
            PageSize = 10
        };

        _appointmentRepositoryMock
            .Setup(repo => repo.GetAllAppointmentsAsync(1, 10))
            .ReturnsAsync(pagedAppointments);

        _mapperMock
            .Setup(mapper => mapper.Map<List<AppointmentDto>>(appointments))
            .Returns(mappedAppointmentDtos);

        var result = await _appointmentService.GetAllAppointmentsAsync(pagination);

        Assert.NotNull(result);
        Assert.Empty(result.Items);
        Assert.Equal(1, result.PageNumber);
        Assert.Equal(10, result.PageSize);
        Assert.Equal(0, result.TotalCount);
        Assert.Equal(0, result.TotalPages);
        Assert.False(result.HasPreviousPage);
        Assert.False(result.HasNextPage);
    }

    [Fact]
    public async Task GetAppointmentsByPatientIdAsync_WhenAppointmentsExist_ShouldReturnPagedAppointmentDtos()
    {
        var futureDateTime = GetFutureDateTime();

        var appointments = new List<Appointment>
        {
            new Appointment
            {
                Id = 1,
                PatientId = 10,
                DoctorId = 20,
                AppointmentDate = DateOnly.FromDateTime(futureDateTime),
                AppointmentTime = TimeOnly.FromDateTime(futureDateTime),
                Status = AppointmentStatus.Pending
            }
        };

        var pagedAppointments = new PagedResult<Appointment>
        {
            Items = appointments,
            PageNumber = 1,
            PageSize = 10,
            TotalCount = 1,
            TotalPages = 1
        };

        var mappedAppointmentDtos = new List<AppointmentDto>
        {
            new AppointmentDto
            {
                Id = 1,
                PatientId = 10,
                DoctorId = 20,
                AppointmentDate = DateOnly.FromDateTime(futureDateTime),
                AppointmentTime = TimeOnly.FromDateTime(futureDateTime),
                Status = AppointmentStatus.Pending
            }
        };

        var pagination = new PaginationQueryDto
        {
            PageNumber = 1,
            PageSize = 10
        };

        _appointmentRepositoryMock
            .Setup(repo => repo.GetAppointmentsByPatientIdAsync(10, null, 1, 10))
            .ReturnsAsync(pagedAppointments);

        _mapperMock
            .Setup(mapper => mapper.Map<List<AppointmentDto>>(appointments))
            .Returns(mappedAppointmentDtos);

        var result = await _appointmentService.GetAppointmentsByPatientIdAsync(10, null, pagination);

        Assert.NotNull(result);
        Assert.Single(result.Items);
        Assert.Equal(10, result.Items[0].PatientId);
        Assert.Equal(1, result.PageNumber);
        Assert.Equal(10, result.PageSize);
        Assert.Equal(1, result.TotalCount);
        Assert.Equal(1, result.TotalPages);
    }

    [Fact]
    public async Task GetAppointmentsByDoctorIdAsync_WhenAppointmentsExist_ShouldReturnPagedAppointmentDtos()
    {
        var futureDateTime = GetFutureDateTime();

        var appointments = new List<Appointment>
        {
            new Appointment
            {
                Id = 1,
                PatientId = 10,
                DoctorId = 20,
                AppointmentDate = DateOnly.FromDateTime(futureDateTime),
                AppointmentTime = TimeOnly.FromDateTime(futureDateTime),
                Status = AppointmentStatus.Pending
            }
        };

        var pagedAppointments = new PagedResult<Appointment>
        {
            Items = appointments,
            PageNumber = 1,
            PageSize = 10,
            TotalCount = 1,
            TotalPages = 1
        };

        var mappedAppointmentDtos = new List<AppointmentDto>
        {
            new AppointmentDto
            {
                Id = 1,
                PatientId = 10,
                DoctorId = 20,
                AppointmentDate = DateOnly.FromDateTime(futureDateTime),
                AppointmentTime = TimeOnly.FromDateTime(futureDateTime),
                Status = AppointmentStatus.Pending
            }
        };

        var pagination = new PaginationQueryDto
        {
            PageNumber = 1,
            PageSize = 10
        };

        _appointmentRepositoryMock
            .Setup(repo => repo.GetAppointmentsByDoctorIdAsync(20, null, 1, 10))
            .ReturnsAsync(pagedAppointments);

        _mapperMock
            .Setup(mapper => mapper.Map<List<AppointmentDto>>(appointments))
            .Returns(mappedAppointmentDtos);

        var result = await _appointmentService.GetAppointmentsByDoctorIdAsync(20,null, pagination);

        Assert.NotNull(result);
        Assert.Single(result.Items);
        Assert.Equal(20, result.Items[0].DoctorId);
        Assert.Equal(1, result.PageNumber);
        Assert.Equal(10, result.PageSize);
        Assert.Equal(1, result.TotalCount);
        Assert.Equal(1, result.TotalPages);
    }

    [Fact]
    public async Task GetAppointmentsByDoctorIdAndDateAsync_WhenAppointmentsExist_ShouldReturnPagedAppointmentDtos()
    {
        var futureDateTime = GetFutureDateTime();
        var appointmentDate = DateOnly.FromDateTime(futureDateTime);

        var appointments = new List<Appointment>
        {
            new Appointment
            {
                Id = 1,
                PatientId = 10,
                DoctorId = 20,
                AppointmentDate = appointmentDate,
                AppointmentTime = TimeOnly.FromDateTime(futureDateTime),
                Status = AppointmentStatus.Pending
            }
        };

        var pagedAppointments = new PagedResult<Appointment>
        {
            Items = appointments,
            PageNumber = 1,
            PageSize = 10,
            TotalCount = 1,
            TotalPages = 1
        };

        var mappedAppointmentDtos = new List<AppointmentDto>
        {
            new AppointmentDto
            {
                Id = 1,
                PatientId = 10,
                DoctorId = 20,
                AppointmentDate = appointmentDate,
                AppointmentTime = TimeOnly.FromDateTime(futureDateTime),
                Status = AppointmentStatus.Pending
            }
        };

        var pagination = new PaginationQueryDto
        {
            PageNumber = 1,
            PageSize = 10
        };

        _appointmentRepositoryMock
            .Setup(repo => repo.GetAppointmentsByDoctorIdAndDateAsync(20, appointmentDate, 1, 10))
            .ReturnsAsync(pagedAppointments);

        _mapperMock
            .Setup(mapper => mapper.Map<List<AppointmentDto>>(appointments))
            .Returns(mappedAppointmentDtos);

        var result = await _appointmentService.GetAppointmentsByDoctorIdAndDateAsync(20, appointmentDate, pagination);

        Assert.NotNull(result);
        Assert.Single(result.Items);
        Assert.Equal(20, result.Items[0].DoctorId);
        Assert.Equal(appointmentDate, result.Items[0].AppointmentDate);
        Assert.Equal(1, result.PageNumber);
        Assert.Equal(10, result.PageSize);
        Assert.Equal(1, result.TotalCount);
        Assert.Equal(1, result.TotalPages);
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenPatientDoesNotExist_ShouldThrowNotFoundException()
    {
        var dto = CreateAppointmentDto();
        _patientRepositoryMock.Setup(repo => repo.GetByIdAsync(10)).ReturnsAsync((Patient?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() =>
            _appointmentService.CreateAppointmentAsync(dto));

        Assert.Equal(ErrorMessages.PatientNotFound, exception.Message);
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenDoctorDoesNotExist_ShouldThrowNotFoundException()
    {
        var dto = CreateAppointmentDto();
        _patientRepositoryMock.Setup(repo => repo.GetByIdAsync(10)).ReturnsAsync(new Patient { Id = 10, UserId = "patient-user-id", FullName = "Patient One" });
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdAsync(20)).ReturnsAsync((Doctor?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() =>
            _appointmentService.CreateAppointmentAsync(dto));

        Assert.Equal(ErrorMessages.DoctorNotFound, exception.Message);
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenDoctorIsUnavailable_ShouldThrowBusinessRuleException()
    {
        var dto = CreateAppointmentDto();
        _patientRepositoryMock.Setup(repo => repo.GetByIdAsync(10)).ReturnsAsync(new Patient { Id = 10, UserId = "patient-user-id", FullName = "Patient One" });
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdAsync(20)).ReturnsAsync(new Doctor { Id = 20, UserId = "doctor-user-id", FullName = "Doctor One", IsAvailable = false });

        var exception = await Assert.ThrowsAsync<BusinessRuleException>(() =>
            _appointmentService.CreateAppointmentAsync(dto));

        Assert.Equal(ErrorMessages.DoctorUnavailable, exception.Message);
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenAppointmentIsLessThanTwentyFourHoursAway_ShouldThrowBusinessRuleException()
    {
        var tooSoon = DateTime.Now.AddHours(23);
        var dto = new CreateAppointmentDto
        {
            PatientId = 10,
            DoctorId = 20,
            AppointmentDate = DateOnly.FromDateTime(tooSoon),
            AppointmentTime = TimeOnly.FromDateTime(tooSoon)
        };

        _patientRepositoryMock.Setup(repo => repo.GetByIdAsync(10)).ReturnsAsync(new Patient { Id = 10, UserId = "patient-user-id", FullName = "Patient One" });
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdAsync(20)).ReturnsAsync(new Doctor { Id = 20, UserId = "doctor-user-id", FullName = "Doctor One", IsAvailable = true });

        var exception = await Assert.ThrowsAsync<BusinessRuleException>(() =>
            _appointmentService.CreateAppointmentAsync(dto));

        Assert.Equal(ErrorMessages.AppointmentMustBeBookedAtLeast24HoursAhead, exception.Message);
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenDoctorSlotIsAlreadyBooked_ShouldThrowConflictException()
    {
        var dto = CreateAppointmentDto();
        SetupValidPatientAndDoctor();

        _appointmentRepositoryMock
            .Setup(repo => repo.DoctorHasNonCancelledAppointmentAtAsync(dto.DoctorId, dto.AppointmentDate, dto.AppointmentTime))
            .ReturnsAsync(true);

        var exception = await Assert.ThrowsAsync<ConflictException>(() =>
            _appointmentService.CreateAppointmentAsync(dto));

        Assert.Equal(ErrorMessages.DoctorSlotAlreadyBooked, exception.Message);
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenPatientSlotIsAlreadyBooked_ShouldThrowConflictException()
    {
        var dto = CreateAppointmentDto();
        SetupValidPatientAndDoctor();

        _appointmentRepositoryMock
            .Setup(repo => repo.DoctorHasNonCancelledAppointmentAtAsync(dto.DoctorId, dto.AppointmentDate, dto.AppointmentTime))
            .ReturnsAsync(false);

        _appointmentRepositoryMock
            .Setup(repo => repo.PatientHasNonCancelledAppointmentAtAsync(dto.PatientId, dto.AppointmentDate, dto.AppointmentTime))
            .ReturnsAsync(true);

        var exception = await Assert.ThrowsAsync<ConflictException>(() =>
            _appointmentService.CreateAppointmentAsync(dto));

        Assert.Equal(ErrorMessages.PatientSlotAlreadyBooked, exception.Message);
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenPatientAlreadyHasAppointmentWithDoctorOnDate_ShouldThrowConflictException()
    {
        var dto = CreateAppointmentDto();
        SetupValidPatientAndDoctor();

        _appointmentRepositoryMock
            .Setup(repo => repo.DoctorHasNonCancelledAppointmentAtAsync(dto.DoctorId, dto.AppointmentDate, dto.AppointmentTime))
            .ReturnsAsync(false);

        _appointmentRepositoryMock
            .Setup(repo => repo.PatientHasNonCancelledAppointmentAtAsync(dto.PatientId, dto.AppointmentDate, dto.AppointmentTime))
            .ReturnsAsync(false);

        _appointmentRepositoryMock
            .Setup(repo => repo.PatientHasNonCancelledAppointmentWithDoctorOnDateAsync(dto.PatientId, dto.DoctorId, dto.AppointmentDate))
            .ReturnsAsync(true);

        var exception = await Assert.ThrowsAsync<ConflictException>(() =>
            _appointmentService.CreateAppointmentAsync(dto));

        Assert.Equal(ErrorMessages.PatientAlreadyHasAppointmentWithDoctorOnDate, exception.Message);
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenValid_ShouldCreateAppointmentWithPendingStatus()
    {
        var dto = CreateAppointmentDto();
        var createdAppointment = new Appointment
        {
            Id = 1,
            PatientId = 10,
            DoctorId = 20,
            AppointmentDate = dto.AppointmentDate,
            AppointmentTime = dto.AppointmentTime,
            Status = AppointmentStatus.Pending
        };

        var appointmentWithDetails = new Appointment
        {
            Id = 1,
            PatientId = 10,
            DoctorId = 20,
            AppointmentDate = dto.AppointmentDate,
            AppointmentTime = dto.AppointmentTime,
            Status = AppointmentStatus.Pending,
            Patient = new Patient { Id = 10, UserId = "patient-user-id", FullName = "Patient One" },
            Doctor = new Doctor { Id = 20, UserId = "doctor-user-id", FullName = "Doctor One" }
        };

        var mappedAppointmentDto = new AppointmentDto
        {
            Id = 1,
            PatientId = 10,
            DoctorId = 20,
            PatientName = "Patient One",
            DoctorName = "Doctor One",
            AppointmentDate = dto.AppointmentDate,
            AppointmentTime = dto.AppointmentTime,
            Status = AppointmentStatus.Pending
        };

        SetupValidPatientAndDoctor();
        SetupNoAppointmentConflicts(dto);

        _appointmentRepositoryMock.Setup(repo => repo.AddAsync(It.IsAny<Appointment>())).ReturnsAsync(createdAppointment);
        _appointmentRepositoryMock.Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(1)).ReturnsAsync(appointmentWithDetails);
        _mapperMock.Setup(mapper => mapper.Map<AppointmentDto>(appointmentWithDetails)).Returns(mappedAppointmentDto);

        var result = await _appointmentService.CreateAppointmentAsync(dto);

        Assert.NotNull(result);
        Assert.Equal(1, result!.Id);
        Assert.Equal(10, result.PatientId);
        Assert.Equal(20, result.DoctorId);
        Assert.Equal(AppointmentStatus.Pending, result.Status);
        Assert.Equal("Patient One", result.PatientName);
        Assert.Equal("Doctor One", result.DoctorName);

        _appointmentRepositoryMock.Verify(repo => repo.AddAsync(It.Is<Appointment>(appointment =>
            appointment.PatientId == 10 && appointment.DoctorId == 20 && appointment.Status == AppointmentStatus.Pending)), Times.Once);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenAppointmentDoesNotExist_ShouldThrowNotFoundException()
    {
        var dto = new UpdateAppointmentStatusDto { Status = AppointmentStatus.Confirmed };

        _appointmentRepositoryMock
            .Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(99))
            .ReturnsAsync((Appointment?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() =>
            _appointmentService.UpdateAppointmentStatusAsync(99, dto, AppRoles.Admin, null, null));

        Assert.Equal(ErrorMessages.AppointmentNotFound, exception.Message);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenAdminConfirmsPendingAppointment_ShouldUpdateStatus()
    {
        var futureDateTime = GetFutureDateTime();
        var appointment = new Appointment
        {
            Id = 1,
            PatientId = 10,
            DoctorId = 20,
            AppointmentDate = DateOnly.FromDateTime(futureDateTime),
            AppointmentTime = TimeOnly.FromDateTime(futureDateTime),
            Status = AppointmentStatus.Pending
        };

        var appointmentWithDetails = new Appointment
        {
            Id = 1,
            PatientId = 10,
            DoctorId = 20,
            AppointmentDate = appointment.AppointmentDate,
            AppointmentTime = appointment.AppointmentTime,
            Status = AppointmentStatus.Confirmed
        };

        var dto = new UpdateAppointmentStatusDto { Status = AppointmentStatus.Confirmed };

        var mappedAppointmentDto = new AppointmentDto
        {
            Id = 1,
            PatientId = 10,
            DoctorId = 20,
            AppointmentDate = appointment.AppointmentDate,
            AppointmentTime = appointment.AppointmentTime,
            Status = AppointmentStatus.Confirmed
        };

        _appointmentRepositoryMock
            .SetupSequence(repo => repo.GetAppointmentByIdWithDetailsAsync(1))
            .ReturnsAsync(appointment)
            .ReturnsAsync(appointmentWithDetails);
        _appointmentRepositoryMock.Setup(repo => repo.UpdateAsync(It.IsAny<Appointment>())).ReturnsAsync(appointment);
        _mapperMock.Setup(mapper => mapper.Map<AppointmentDto>(appointmentWithDetails)).Returns(mappedAppointmentDto);

        var result = await _appointmentService.UpdateAppointmentStatusAsync(1, dto, AppRoles.Admin, null, null);

        Assert.NotNull(result);
        Assert.Equal(AppointmentStatus.Confirmed, result!.Status);

        _appointmentRepositoryMock.Verify(repo => repo.UpdateAsync(It.Is<Appointment>(updatedAppointment =>
            updatedAppointment.Id == 1 && updatedAppointment.Status == AppointmentStatus.Confirmed)), Times.Once);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenDoctorCancelsOwnAppointment_ShouldAppendDoctorSuffix()
    {
        var futureDateTime = GetFutureDateTime();
        var appointment = new Appointment
        {
            Id = 1,
            PatientId = 10,
            DoctorId = 20,
            AppointmentDate = DateOnly.FromDateTime(futureDateTime),
            AppointmentTime = TimeOnly.FromDateTime(futureDateTime),
            Status = AppointmentStatus.Confirmed
        };

        var appointmentWithDetails = new Appointment
        {
            Id = 1,
            PatientId = 10,
            DoctorId = 20,
            AppointmentDate = appointment.AppointmentDate,
            AppointmentTime = appointment.AppointmentTime,
            Status = AppointmentStatus.Cancelled,
            CancellationReason = "Doctor emergency - Cancelled by doctor"
        };

        var dto = new UpdateAppointmentStatusDto
        {
            Status = AppointmentStatus.Cancelled,
            CancellationReason = "Doctor emergency"
        };

        var mappedAppointmentDto = new AppointmentDto
        {
            Id = 1,
            PatientId = 10,
            DoctorId = 20,
            AppointmentDate = appointment.AppointmentDate,
            AppointmentTime = appointment.AppointmentTime,
            Status = AppointmentStatus.Cancelled,
            CancellationReason = "Doctor emergency - Cancelled by doctor"
        };

        _appointmentRepositoryMock
            .SetupSequence(repo => repo.GetAppointmentByIdWithDetailsAsync(1))
            .ReturnsAsync(appointment)
            .ReturnsAsync(appointmentWithDetails);
        _appointmentRepositoryMock.Setup(repo => repo.UpdateAsync(It.IsAny<Appointment>())).ReturnsAsync(appointment);
        _mapperMock.Setup(mapper => mapper.Map<AppointmentDto>(appointmentWithDetails)).Returns(mappedAppointmentDto);

        var result = await _appointmentService.UpdateAppointmentStatusAsync(1, dto, AppRoles.Doctor, null, 20);

        Assert.NotNull(result);
        Assert.Equal(AppointmentStatus.Cancelled, result!.Status);
        Assert.Equal("Doctor emergency - Cancelled by doctor", result.CancellationReason);

        _appointmentRepositoryMock.Verify(repo => repo.UpdateAsync(It.Is<Appointment>(updatedAppointment =>
            updatedAppointment.Id == 1 &&
            updatedAppointment.Status == AppointmentStatus.Cancelled &&
            updatedAppointment.CancellationReason == "Doctor emergency - Cancelled by doctor")), Times.Once);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenCompletedRequested_ShouldThrowBusinessRuleException()
    {
        var futureDateTime = GetFutureDateTime();
        var appointment = new Appointment
        {
            Id = 1,
            PatientId = 10,
            DoctorId = 20,
            AppointmentDate = DateOnly.FromDateTime(futureDateTime),
            AppointmentTime = TimeOnly.FromDateTime(futureDateTime),
            Status = AppointmentStatus.Confirmed
        };

        var dto = new UpdateAppointmentStatusDto { Status = AppointmentStatus.Completed };

        _appointmentRepositoryMock.Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(1)).ReturnsAsync(appointment);

        var exception = await Assert.ThrowsAsync<BusinessRuleException>(() =>
            _appointmentService.UpdateAppointmentStatusAsync(1, dto, AppRoles.Doctor, null, 20));

        Assert.Equal(ErrorMessages.AppointmentCompletedOnlyThroughHealthRecord, exception.Message);
    }



    [Fact]
    public async Task GetAppointmentReportsAsync_WhenAppointmentsExist_ShouldReturnGroupedReports()
    {
        var reports = new List<AppointmentReportDto>
    {
        new AppointmentReportDto
        {
            Date = new DateOnly(2026, 6, 20),
            PendingCount = 1,
            ConfirmedCount = 1,
            CancelledCount = 1,
            CompletedCount = 0,
            TotalCount = 3
        },
        new AppointmentReportDto
        {
            Date = new DateOnly(2026, 6, 21),
            PendingCount = 0,
            ConfirmedCount = 0,
            CancelledCount = 0,
            CompletedCount = 1,
            TotalCount = 1
        }
    };

        _appointmentRepositoryMock
            .Setup(repo => repo.GetAppointmentReportsAsync())
            .ReturnsAsync(reports);

        var result = await _appointmentService.GetAppointmentReportsAsync();

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
        _appointmentRepositoryMock
            .Setup(repo => repo.GetAppointmentReportsAsync())
            .ReturnsAsync(new List<AppointmentReportDto>());

        var result = await _appointmentService.GetAppointmentReportsAsync();

        Assert.NotNull(result);
        Assert.Empty(result);
    }


    [Fact]
    public async Task GetAppointmentByIdAsync_WhenAppointmentExists_ShouldReturnAppointmentDto()
    {
        var futureDateTime = GetFutureDateTime();

        var appointment = new Appointment
        {
            Id = 1,
            PatientId = 10,
            DoctorId = 20,
            AppointmentDate = DateOnly.FromDateTime(futureDateTime),
            AppointmentTime = TimeOnly.FromDateTime(futureDateTime),
            Status = AppointmentStatus.Pending,
            Patient = new Patient { Id = 10, UserId = "patient-user-id", FullName = "Patient One" },
            Doctor = new Doctor { Id = 20, UserId = "doctor-user-id", FullName = "Doctor One" }
        };

        var mappedAppointmentDto = new AppointmentDto
        {
            Id = 1,
            PatientId = 10,
            DoctorId = 20,
            PatientName = "Patient One",
            DoctorName = "Doctor One",
            AppointmentDate = DateOnly.FromDateTime(futureDateTime),
            AppointmentTime = TimeOnly.FromDateTime(futureDateTime),
            Status = AppointmentStatus.Pending
        };

        _appointmentRepositoryMock
            .Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(1))
            .ReturnsAsync(appointment);

        _mapperMock
            .Setup(mapper => mapper.Map<AppointmentDto>(appointment))
            .Returns(mappedAppointmentDto);

        var result = await _appointmentService.GetAppointmentByIdAsync(1);

        Assert.NotNull(result);
        Assert.Equal(1, result.Id);
        Assert.Equal(10, result.PatientId);
        Assert.Equal(20, result.DoctorId);
        Assert.Equal("Patient One", result.PatientName);
        Assert.Equal("Doctor One", result.DoctorName);
        Assert.Equal(AppointmentStatus.Pending, result.Status);
    }

    [Fact]
    public async Task GetAppointmentByIdAsync_WhenAppointmentDoesNotExist_ShouldThrowNotFoundException()
    {
        _appointmentRepositoryMock
            .Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(99))
            .ReturnsAsync((Appointment?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() =>
            _appointmentService.GetAppointmentByIdAsync(99));

        Assert.Equal(ErrorMessages.AppointmentNotFound, exception.Message);
    }

    private void SetupValidPatientAndDoctor()
    {
        _patientRepositoryMock
            .Setup(repo => repo.GetByIdAsync(10))
            .ReturnsAsync(new Patient { Id = 10, UserId = "patient-user-id", FullName = "Patient One" });

        _doctorRepositoryMock
            .Setup(repo => repo.GetDoctorByIdAsync(20))
            .ReturnsAsync(new Doctor { Id = 20, UserId = "doctor-user-id", FullName = "Doctor One", IsAvailable = true });
    }

    private void SetupNoAppointmentConflicts(CreateAppointmentDto dto)
    {
        _appointmentRepositoryMock
            .Setup(repo => repo.DoctorHasNonCancelledAppointmentAtAsync(dto.DoctorId, dto.AppointmentDate, dto.AppointmentTime))
            .ReturnsAsync(false);

        _appointmentRepositoryMock
            .Setup(repo => repo.PatientHasNonCancelledAppointmentAtAsync(dto.PatientId, dto.AppointmentDate, dto.AppointmentTime))
            .ReturnsAsync(false);

        _appointmentRepositoryMock
            .Setup(repo => repo.PatientHasNonCancelledAppointmentWithDoctorOnDateAsync(dto.PatientId, dto.DoctorId, dto.AppointmentDate))
            .ReturnsAsync(false);
    }

    private static CreateAppointmentDto CreateAppointmentDto()
    {
        var futureDateTime = GetFutureDateTime();

        return new CreateAppointmentDto
        {
            PatientId = 10,
            DoctorId = 20,
            AppointmentDate = DateOnly.FromDateTime(futureDateTime),
            AppointmentTime = TimeOnly.FromDateTime(futureDateTime)
        };
    }

    private static DateTime GetFutureDateTime()
    {
        return DateTime.Now.AddDays(3).Date.AddHours(10).AddMinutes(30);
    }
}
