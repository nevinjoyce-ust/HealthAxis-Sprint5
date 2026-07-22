using AutoMapper;
using HealthAxis.API.Constants;
using HealthAxis.API.Events;
using HealthAxis.API.Exceptions;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using HealthAxis.API.Services.Impl;
using HealthAxis.Shared.Constants;
using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Dtos.Appointment;
using HealthAxis.Shared.Enums;
using MassTransit;
using Moq;

namespace HealthAxisTests.ServiceTests;

public class AppointmentServiceTests
{
    private readonly Mock<IAppointmentRepository> _appointmentRepositoryMock = new();
    private readonly Mock<IPatientRepository> _patientRepositoryMock = new();
    private readonly Mock<IDoctorRepository> _doctorRepositoryMock = new();
    private readonly Mock<IMapper> _mapperMock = new();
    private readonly Mock<IPublishEndpoint> _publisherMock = new();
    private readonly AppointmentService _appointmentService;

    public AppointmentServiceTests()
    {
        _publisherMock
            .Setup(publisher => publisher.Publish(It.IsAny<AppointmentBookedEvent>()))
            .Returns(Task.CompletedTask);

        _appointmentService = new AppointmentService(
            _appointmentRepositoryMock.Object,
            _patientRepositoryMock.Object,
            _doctorRepositoryMock.Object,
            _mapperMock.Object,
            _publisherMock.Object);
    }

    [Fact]
    public async Task GetAllAppointmentsAsync_WhenAppointmentsExist_ShouldReturnPagedDtos()
    {
        var appointments = new List<Appointment> { CreateAppointment() };
        _appointmentRepositoryMock.Setup(repository => repository.GetAllAppointmentsAsync(1, 10))
            .ReturnsAsync(CreatePagedResult(appointments));
        _mapperMock.Setup(mapper => mapper.Map<List<AppointmentDto>>(appointments))
            .Returns([CreateAppointmentDtoFromAppointment(appointments[0])]);

        var result = await _appointmentService.GetAllAppointmentsAsync(CreatePagination());

        Assert.Single(result.Items);
        Assert.Equal(1, result.TotalCount);
    }

    [Fact]
    public async Task GetAppointmentByIdAsync_WhenMissing_ShouldThrowNotFoundException()
    {
        _appointmentRepositoryMock
            .Setup(repository => repository.GetAppointmentByIdWithDetailsAsync(99))
            .ReturnsAsync((Appointment?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() =>
            _appointmentService.GetAppointmentByIdAsync(99));

        Assert.Equal(ErrorMessages.AppointmentNotFound, exception.Message);
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenPatientMissing_ShouldThrowAndNotPublish()
    {
        var request = CreateAppointmentRequest();
        _patientRepositoryMock.Setup(repository => repository.GetByIdAsync(request.PatientId))
            .ReturnsAsync((Patient?)null);

        await Assert.ThrowsAsync<NotFoundException>(() =>
            _appointmentService.CreateAppointmentAsync(request));

        VerifyEventWasNotPublished();
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenDoctorMissing_ShouldThrowAndNotPublish()
    {
        var request = CreateAppointmentRequest();
        _patientRepositoryMock.Setup(repository => repository.GetByIdAsync(request.PatientId))
            .ReturnsAsync(CreatePatient(request.PatientId));
        _doctorRepositoryMock.Setup(repository => repository.GetDoctorByIdAsync(request.DoctorId))
            .ReturnsAsync((Doctor?)null);

        await Assert.ThrowsAsync<NotFoundException>(() =>
            _appointmentService.CreateAppointmentAsync(request));

        VerifyEventWasNotPublished();
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenDoctorUnavailable_ShouldThrowAndNotPublish()
    {
        var request = CreateAppointmentRequest();
        SetupValidPatientAndDoctor(request, doctorAvailable: false);

        var exception = await Assert.ThrowsAsync<BusinessRuleException>(() =>
            _appointmentService.CreateAppointmentAsync(request));

        Assert.Equal(ErrorMessages.DoctorUnavailable, exception.Message);
        VerifyEventWasNotPublished();
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenLessThanFortyEightHoursAway_ShouldThrow()
    {
        var tooSoon = DateTime.Now.AddHours(47);
        var request = CreateAppointmentRequest(
            DateOnly.FromDateTime(tooSoon), TimeOnly.FromDateTime(tooSoon));
        SetupValidPatientAndDoctor(request);

        var exception = await Assert.ThrowsAsync<BusinessRuleException>(() =>
            _appointmentService.CreateAppointmentAsync(request));

        Assert.Equal(ErrorMessages.AppointmentMustBeBookedAtLeast48HoursAhead, exception.Message);
        VerifyEventWasNotPublished();
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenMoreThanSixMonthsAhead_ShouldThrow()
    {
        var request = CreateAppointmentRequest(
            DateOnly.FromDateTime(DateTime.Today).AddMonths(6).AddDays(1),
            new TimeOnly(10, 30));
        SetupValidPatientAndDoctor(request);

        var exception = await Assert.ThrowsAsync<BusinessRuleException>(() =>
            _appointmentService.CreateAppointmentAsync(request));

        Assert.Equal(ErrorMessages.AppointmentCannotBeBookedMoreThanSixMonthsAhead, exception.Message);
        VerifyEventWasNotPublished();
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenDoctorSlotBooked_ShouldThrowConflictException()
    {
        var request = CreateAppointmentRequest();
        SetupValidPatientAndDoctor(request);
        _appointmentRepositoryMock
            .Setup(repository => repository.DoctorHasNonCancelledAppointmentAtAsync(
                request.DoctorId, request.AppointmentDate, request.AppointmentTime))
            .ReturnsAsync(true);

        var exception = await Assert.ThrowsAsync<ConflictException>(() =>
            _appointmentService.CreateAppointmentAsync(request));

        Assert.Equal(ErrorMessages.DoctorSlotAlreadyBooked, exception.Message);
        VerifyEventWasNotPublished();
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenValid_ShouldCreatePendingAndPublishEvent()
    {
        var request = CreateAppointmentRequest();
        var created = CreateAppointment(
            patientId: request.PatientId,
            doctorId: request.DoctorId,
            date: request.AppointmentDate,
            time: request.AppointmentTime);
        SetupValidPatientAndDoctor(request);
        SetupNoConflicts(request);
        _appointmentRepositoryMock.Setup(repository => repository.AddAsync(It.IsAny<Appointment>()))
            .ReturnsAsync(created);
        _appointmentRepositoryMock
            .Setup(repository => repository.GetAppointmentByIdWithDetailsAsync(created.Id))
            .ReturnsAsync(created);
        _mapperMock.Setup(mapper => mapper.Map<AppointmentDto>(created))
            .Returns(CreateAppointmentDtoFromAppointment(created));

        var result = await _appointmentService.CreateAppointmentAsync(request);

        Assert.NotNull(result);
        Assert.Equal(AppointmentStatus.Pending, result.Status);
        _publisherMock.Verify(publisher => publisher.Publish(
            It.Is<AppointmentBookedEvent>(message =>
                message.AppointmentId == created.Id &&
                message.PatientId == created.PatientId &&
                message.DoctorId == created.DoctorId &&
                message.ScheduledDate == created.AppointmentDate &&
                message.TimeSlot == created.AppointmentTime)), Times.Once);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenAdminConfirmsPending_ShouldUpdate()
    {
        var appointment = CreateAppointment(status: AppointmentStatus.Pending);
        var reloaded = CreateAppointment(status: AppointmentStatus.Confirmed);
        SetupAppointmentReload(appointment, reloaded);
        _mapperMock.Setup(mapper => mapper.Map<AppointmentDto>(reloaded))
            .Returns(CreateAppointmentDtoFromAppointment(reloaded));

        var result = await _appointmentService.UpdateAppointmentStatusAsync(
            appointment.Id,
            new UpdateAppointmentStatusDto { Status = AppointmentStatus.Confirmed },
            AppRoles.Admin, null, null);

        Assert.Equal(AppointmentStatus.Confirmed, result!.Status);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenPatientConfirms_ShouldThrowForbidden()
    {
        var appointment = CreateAppointment(status: AppointmentStatus.Pending);
        _appointmentRepositoryMock
            .Setup(repository => repository.GetAppointmentByIdWithDetailsAsync(appointment.Id))
            .ReturnsAsync(appointment);

        await Assert.ThrowsAsync<ForbiddenException>(() =>
            _appointmentService.UpdateAppointmentStatusAsync(
                appointment.Id,
                new UpdateAppointmentStatusDto { Status = AppointmentStatus.Confirmed },
                AppRoles.Patient, appointment.PatientId, null));
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenPatientCancelsOwnPending_ShouldAppendSuffix()
    {
        var appointment = CreateAppointment(status: AppointmentStatus.Pending, patientId: 10);
        var reloaded = CreateAppointment(status: AppointmentStatus.Cancelled, patientId: 10);
        reloaded.CancellationReason = "Reason - Cancelled by patient";
        SetupAppointmentReload(appointment, reloaded);
        _mapperMock.Setup(mapper => mapper.Map<AppointmentDto>(reloaded))
            .Returns(CreateAppointmentDtoFromAppointment(reloaded));

        var result = await _appointmentService.UpdateAppointmentStatusAsync(
            appointment.Id,
            new UpdateAppointmentStatusDto
            {
                Status = AppointmentStatus.Cancelled,
                CancellationReason = "Reason"
            },
            AppRoles.Patient, 10, null);

        Assert.Equal(AppointmentStatus.Cancelled, result!.Status);
        _appointmentRepositoryMock.Verify(repository => repository.UpdateAsync(
            It.Is<Appointment>(updated =>
                updated.CancellationReason == "Reason - Cancelled by patient")), Times.Once);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenDoctorCancelsWithin24Hours_ShouldThrow()
    {
        var soon = DateTime.Now.AddHours(23);
        var appointment = CreateAppointment(
            doctorId: 20,
            date: DateOnly.FromDateTime(soon),
            time: TimeOnly.FromDateTime(soon),
            status: AppointmentStatus.Confirmed);
        _appointmentRepositoryMock
            .Setup(repository => repository.GetAppointmentByIdWithDetailsAsync(appointment.Id))
            .ReturnsAsync(appointment);

        var exception = await Assert.ThrowsAsync<BusinessRuleException>(() =>
            _appointmentService.UpdateAppointmentStatusAsync(
                appointment.Id,
                new UpdateAppointmentStatusDto
                {
                    Status = AppointmentStatus.Cancelled,
                    CancellationReason = "Reason"
                },
                AppRoles.Doctor, null, 20));

        Assert.Equal(ErrorMessages.AppointmentCannotBeCancelledWithin24Hours, exception.Message);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenCompletedRequested_ShouldThrow()
    {
        var appointment = CreateAppointment(status: AppointmentStatus.Confirmed);
        _appointmentRepositoryMock
            .Setup(repository => repository.GetAppointmentByIdWithDetailsAsync(appointment.Id))
            .ReturnsAsync(appointment);

        var exception = await Assert.ThrowsAsync<BusinessRuleException>(() =>
            _appointmentService.UpdateAppointmentStatusAsync(
                appointment.Id,
                new UpdateAppointmentStatusDto { Status = AppointmentStatus.Completed },
                AppRoles.Doctor, null, appointment.DoctorId));

        Assert.Equal(ErrorMessages.AppointmentCompletedOnlyThroughHealthRecord, exception.Message);
    }

    [Fact]
    public async Task GetAppointmentReportsAsync_WhenReportsExist_ShouldReturnReports()
    {
        var reports = new List<AppointmentReportDto>
        {
            new() { Date = new DateOnly(2026, 6, 20), PendingCount = 1, TotalCount = 1 }
        };
        _appointmentRepositoryMock.Setup(repository => repository.GetAppointmentReportsAsync())
            .ReturnsAsync(reports);

        var result = await _appointmentService.GetAppointmentReportsAsync();

        Assert.Single(result);
    }

    private void SetupValidPatientAndDoctor(
        CreateAppointmentDto request, bool doctorAvailable = true)
    {
        _patientRepositoryMock.Setup(repository => repository.GetByIdAsync(request.PatientId))
            .ReturnsAsync(CreatePatient(request.PatientId));
        _doctorRepositoryMock.Setup(repository => repository.GetDoctorByIdAsync(request.DoctorId))
            .ReturnsAsync(CreateDoctor(request.DoctorId, doctorAvailable));
    }

    private void SetupNoConflicts(CreateAppointmentDto request)
    {
        _appointmentRepositoryMock
            .Setup(repository => repository.DoctorHasNonCancelledAppointmentAtAsync(
                request.DoctorId, request.AppointmentDate, request.AppointmentTime))
            .ReturnsAsync(false);
        _appointmentRepositoryMock
            .Setup(repository => repository.PatientHasNonCancelledAppointmentAtAsync(
                request.PatientId, request.AppointmentDate, request.AppointmentTime))
            .ReturnsAsync(false);
        _appointmentRepositoryMock
            .Setup(repository => repository.PatientHasNonCancelledAppointmentWithDoctorOnDateAsync(
                request.PatientId, request.DoctorId, request.AppointmentDate))
            .ReturnsAsync(false);
    }

    private void SetupAppointmentReload(Appointment appointment, Appointment reloaded)
    {
        _appointmentRepositoryMock
            .SetupSequence(repository => repository.GetAppointmentByIdWithDetailsAsync(appointment.Id))
            .ReturnsAsync(appointment)
            .ReturnsAsync(reloaded);
        _appointmentRepositoryMock.Setup(repository => repository.UpdateAsync(It.IsAny<Appointment>()))
            .ReturnsAsync((Appointment updated) => updated);
    }

    private void VerifyEventWasNotPublished()
    {
        _publisherMock.Verify(
            publisher => publisher.Publish(It.IsAny<AppointmentBookedEvent>()),
            Times.Never);
    }

    private static PaginationQueryDto CreatePagination() => new()
    {
        PageNumber = 1,
        PageSize = 10
    };

    private static PagedResult<Appointment> CreatePagedResult(List<Appointment> appointments) => new()
    {
        Items = appointments,
        PageNumber = 1,
        PageSize = 10,
        TotalCount = appointments.Count,
        TotalPages = appointments.Count == 0 ? 0 : 1
    };

    private static CreateAppointmentDto CreateAppointmentRequest()
    {
        var future = GetFutureDateTime();
        return CreateAppointmentRequest(
            DateOnly.FromDateTime(future), TimeOnly.FromDateTime(future));
    }

    private static CreateAppointmentDto CreateAppointmentRequest(DateOnly date, TimeOnly time) => new()
    {
        PatientId = 10,
        DoctorId = 20,
        AppointmentDate = date,
        AppointmentTime = time
    };

    private static Appointment CreateAppointment(
        int id = 1,
        int patientId = 10,
        int doctorId = 20,
        DateOnly? date = null,
        TimeOnly? time = null,
        AppointmentStatus status = AppointmentStatus.Pending) => new()
    {
        Id = id,
        PatientId = patientId,
        DoctorId = doctorId,
        AppointmentDate = date ?? DateOnly.FromDateTime(GetFutureDateTime()),
        AppointmentTime = time ?? TimeOnly.FromDateTime(GetFutureDateTime()),
        Status = status,
        Patient = CreatePatient(patientId),
        Doctor = CreateDoctor(doctorId, true)
    };

    private static AppointmentDto CreateAppointmentDtoFromAppointment(
        Appointment appointment) => new()
    {
        Id = appointment.Id,
        PatientId = appointment.PatientId,
        DoctorId = appointment.DoctorId,
        PatientName = appointment.Patient?.FullName ?? string.Empty,
        DoctorName = appointment.Doctor?.FullName ?? string.Empty,
        AppointmentDate = appointment.AppointmentDate,
        AppointmentTime = appointment.AppointmentTime,
        Status = appointment.Status,
        CancellationReason = appointment.CancellationReason
    };

    private static Patient CreatePatient(int id) => new()
    {
        Id = id,
        UserId = $"patient-user-id-{id}",
        FullName = "Patient One"
    };

    private static Doctor CreateDoctor(int id, bool isAvailable) => new()
    {
        Id = id,
        UserId = $"doctor-user-id-{id}",
        FullName = "Doctor One",
        IsAvailable = isAvailable
    };

    private static DateTime GetFutureDateTime() =>
        DateTime.Now.AddDays(3).Date.AddHours(10).AddMinutes(30);
}
