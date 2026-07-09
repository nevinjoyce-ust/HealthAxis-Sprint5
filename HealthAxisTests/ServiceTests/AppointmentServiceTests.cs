using AutoMapper;
using HealthAxis.API.Constants;
using HealthAxis.API.Events;
using HealthAxis.API.Exceptions;
using HealthAxis.API.Messaging;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using HealthAxis.API.Services.Impl;
using HealthAxis.Shared.Constants;
using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Dtos.Appointment;
using HealthAxis.Shared.Enums;
using Microsoft.Extensions.Logging;
using Moq;

namespace HealthAxisTests.ServiceTests;

public class AppointmentServiceTests
{
    private readonly Mock<IAppointmentRepository> _appointmentRepositoryMock;
    private readonly Mock<IPatientRepository> _patientRepositoryMock;
    private readonly Mock<IDoctorRepository> _doctorRepositoryMock;
    private readonly Mock<IMapper> _mapperMock;
    private readonly Mock<IRabbitMqPublisher> _rabbitMqPublisherMock;
    private readonly Mock<ILogger<AppointmentService>> _loggerMock;
    private readonly AppointmentService _appointmentService;

    public AppointmentServiceTests()
    {
        _appointmentRepositoryMock = new Mock<IAppointmentRepository>();
        _patientRepositoryMock = new Mock<IPatientRepository>();
        _doctorRepositoryMock = new Mock<IDoctorRepository>();
        _mapperMock = new Mock<IMapper>();
        _rabbitMqPublisherMock = new Mock<IRabbitMqPublisher>();
        _loggerMock = new Mock<ILogger<AppointmentService>>();

        _appointmentRepositoryMock
            .Setup(repo => repo.GetExpiredPendingAppointmentsAsync(It.IsAny<DateTime>()))
            .ReturnsAsync([]);

        _rabbitMqPublisherMock
            .Setup(publisher => publisher.PublishAppointmentBookedAsync(It.IsAny<AppointmentBookedEvent>()))
            .Returns(Task.CompletedTask);

        _appointmentService = new AppointmentService(
            _appointmentRepositoryMock.Object,
            _patientRepositoryMock.Object,
            _doctorRepositoryMock.Object,
            _mapperMock.Object,
            _rabbitMqPublisherMock.Object);
    }

    [Fact]
    public async Task GetAllAppointmentsAsync_WhenAppointmentsExist_ShouldReturnPagedAppointmentDtos()
    {
        var appointments = new List<Appointment> { CreateAppointment() };
        var pagedAppointments = CreatePagedResult(appointments);
        var mappedDtos = new List<AppointmentDto> { CreateAppointmentDtoFromAppointment(appointments[0]) };
        var pagination = CreatePagination();

        _appointmentRepositoryMock.Setup(repo => repo.GetAllAppointmentsAsync(1, 10)).ReturnsAsync(pagedAppointments);
        _mapperMock.Setup(mapper => mapper.Map<List<AppointmentDto>>(appointments)).Returns(mappedDtos);

        var result = await _appointmentService.GetAllAppointmentsAsync(pagination);

        Assert.Single(result.Items);
        Assert.Equal(1, result.Items[0].Id);
        Assert.Equal(1, result.PageNumber);
        Assert.Equal(10, result.PageSize);
        Assert.Equal(1, result.TotalCount);
        Assert.Equal(1, result.TotalPages);
    }

    [Fact]
    public async Task GetAllAppointmentsAsync_WhenExpiredPendingAppointmentsExist_ShouldAutoCancelThemBeforeReturningResults()
    {
        var expiredAppointment = CreateAppointment(status: AppointmentStatus.Pending);
        _appointmentRepositoryMock
            .Setup(repo => repo.GetExpiredPendingAppointmentsAsync(It.IsAny<DateTime>()))
            .ReturnsAsync([expiredAppointment]);
        _appointmentRepositoryMock.Setup(repo => repo.UpdateAsync(It.IsAny<Appointment>())).ReturnsAsync((Appointment appointment) => appointment);
        _appointmentRepositoryMock.Setup(repo => repo.GetAllAppointmentsAsync(1, 10)).ReturnsAsync(CreatePagedResult(new List<Appointment>()));
        _mapperMock.Setup(mapper => mapper.Map<List<AppointmentDto>>(It.IsAny<List<Appointment>>())).Returns([]);

        await _appointmentService.GetAllAppointmentsAsync(CreatePagination());

        _appointmentRepositoryMock.Verify(repo => repo.UpdateAsync(It.Is<Appointment>(appointment =>
            appointment.Status == AppointmentStatus.Cancelled &&
            appointment.CancellationReason == ErrorMessages.PendingAppointmentAutoCancelledReason)), Times.Once);
    }

    [Fact]
    public async Task GetAllAppointmentsAsync_WhenNoAppointmentsExist_ShouldReturnEmptyPagedResult()
    {
        var appointments = new List<Appointment>();
        _appointmentRepositoryMock.Setup(repo => repo.GetAllAppointmentsAsync(1, 10)).ReturnsAsync(CreatePagedResult(appointments));
        _mapperMock.Setup(mapper => mapper.Map<List<AppointmentDto>>(appointments)).Returns([]);

        var result = await _appointmentService.GetAllAppointmentsAsync(CreatePagination());

        Assert.Empty(result.Items);
        Assert.Equal(0, result.TotalCount);
        Assert.Equal(0, result.TotalPages);
    }

    [Fact]
    public async Task GetAppointmentByIdAsync_WhenAppointmentExists_ShouldReturnAppointmentDto()
    {
        var appointment = CreateAppointment();
        var mappedDto = CreateAppointmentDtoFromAppointment(appointment);
        _appointmentRepositoryMock.Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(1)).ReturnsAsync(appointment);
        _mapperMock.Setup(mapper => mapper.Map<AppointmentDto>(appointment)).Returns(mappedDto);

        var result = await _appointmentService.GetAppointmentByIdAsync(1);

        Assert.Equal(1, result.Id);
        Assert.Equal(appointment.PatientId, result.PatientId);
        Assert.Equal(appointment.DoctorId, result.DoctorId);
    }

    [Fact]
    public async Task GetAppointmentByIdAsync_WhenAppointmentDoesNotExist_ShouldThrowNotFoundException()
    {
        _appointmentRepositoryMock.Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(99)).ReturnsAsync((Appointment?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() => _appointmentService.GetAppointmentByIdAsync(99));

        Assert.Equal(ErrorMessages.AppointmentNotFound, exception.Message);
    }

    [Fact]
    public async Task GetAppointmentsByPatientIdAsync_WhenAppointmentsExist_ShouldReturnPagedAppointmentDtos()
    {
        var appointments = new List<Appointment> { CreateAppointment(patientId: 10) };
        _appointmentRepositoryMock.Setup(repo => repo.GetAppointmentsByPatientIdAsync(10, null, 1, 10)).ReturnsAsync(CreatePagedResult(appointments));
        _mapperMock.Setup(mapper => mapper.Map<List<AppointmentDto>>(appointments)).Returns([CreateAppointmentDtoFromAppointment(appointments[0])]);

        var result = await _appointmentService.GetAppointmentsByPatientIdAsync(10, null, CreatePagination());

        Assert.Single(result.Items);
        Assert.Equal(10, result.Items[0].PatientId);
    }

    [Fact]
    public async Task GetAppointmentsByDoctorIdAsync_WhenAppointmentsExist_ShouldReturnPagedAppointmentDtos()
    {
        var appointments = new List<Appointment> { CreateAppointment(doctorId: 20) };
        _appointmentRepositoryMock.Setup(repo => repo.GetAppointmentsByDoctorIdAsync(20, null, 1, 10)).ReturnsAsync(CreatePagedResult(appointments));
        _mapperMock.Setup(mapper => mapper.Map<List<AppointmentDto>>(appointments)).Returns([CreateAppointmentDtoFromAppointment(appointments[0])]);

        var result = await _appointmentService.GetAppointmentsByDoctorIdAsync(20, null, CreatePagination());

        Assert.Single(result.Items);
        Assert.Equal(20, result.Items[0].DoctorId);
    }

    [Fact]
    public async Task GetAppointmentsByDoctorIdAndDateAsync_WhenAppointmentsExist_ShouldReturnPagedAppointmentDtos()
    {
        var appointmentDate = DateOnly.FromDateTime(GetFutureDateTime());
        var appointments = new List<Appointment> { CreateAppointment(doctorId: 20, date: appointmentDate) };
        _appointmentRepositoryMock.Setup(repo => repo.GetAppointmentsByDoctorIdAndDateAsync(20, appointmentDate, 1, 10)).ReturnsAsync(CreatePagedResult(appointments));
        _mapperMock.Setup(mapper => mapper.Map<List<AppointmentDto>>(appointments)).Returns([CreateAppointmentDtoFromAppointment(appointments[0])]);

        var result = await _appointmentService.GetAppointmentsByDoctorIdAndDateAsync(20, appointmentDate, CreatePagination());

        Assert.Single(result.Items);
        Assert.Equal(appointmentDate, result.Items[0].AppointmentDate);
    }

    [Fact]
    public async Task GetAppointmentsByDateAndStatusAsync_WhenAppointmentsExist_ShouldReturnPagedAppointmentDtos()
    {
        var appointmentDate = DateOnly.FromDateTime(GetFutureDateTime());
        var appointments = new List<Appointment> { CreateAppointment(date: appointmentDate, status: AppointmentStatus.Confirmed) };
        _appointmentRepositoryMock.Setup(repo => repo.GetAppointmentsByDateAndStatusAsync(appointmentDate, AppointmentStatus.Confirmed, 1, 10)).ReturnsAsync(CreatePagedResult(appointments));
        _mapperMock.Setup(mapper => mapper.Map<List<AppointmentDto>>(appointments)).Returns([CreateAppointmentDtoFromAppointment(appointments[0])]);

        var result = await _appointmentService.GetAppointmentsByDateAndStatusAsync(appointmentDate, AppointmentStatus.Confirmed, CreatePagination());

        Assert.Single(result.Items);
        Assert.Equal(AppointmentStatus.Confirmed, result.Items[0].Status);
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenPatientDoesNotExist_ShouldThrowNotFoundException()
    {
        var request = CreateAppointmentRequest();
        _patientRepositoryMock.Setup(repo => repo.GetByIdAsync(request.PatientId)).ReturnsAsync((Patient?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() => _appointmentService.CreateAppointmentAsync(request));

        Assert.Equal(ErrorMessages.PatientNotFound, exception.Message);
        VerifyAppointmentBookedEventWasNotPublished();
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenDoctorDoesNotExist_ShouldThrowNotFoundException()
    {
        var request = CreateAppointmentRequest();
        _patientRepositoryMock.Setup(repo => repo.GetByIdAsync(request.PatientId)).ReturnsAsync(CreatePatient(request.PatientId));
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdAsync(request.DoctorId)).ReturnsAsync((Doctor?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() => _appointmentService.CreateAppointmentAsync(request));

        Assert.Equal(ErrorMessages.DoctorNotFound, exception.Message);
        VerifyAppointmentBookedEventWasNotPublished();
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenDoctorIsUnavailable_ShouldThrowBusinessRuleException()
    {
        var request = CreateAppointmentRequest();
        _patientRepositoryMock.Setup(repo => repo.GetByIdAsync(request.PatientId)).ReturnsAsync(CreatePatient(request.PatientId));
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdAsync(request.DoctorId)).ReturnsAsync(CreateDoctor(request.DoctorId, isAvailable: false));

        var exception = await Assert.ThrowsAsync<BusinessRuleException>(() => _appointmentService.CreateAppointmentAsync(request));

        Assert.Equal(ErrorMessages.DoctorUnavailable, exception.Message);
        VerifyAppointmentBookedEventWasNotPublished();
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenAppointmentIsLessThanFortyEightHoursAway_ShouldThrowBusinessRuleException()
    {
        var tooSoon = DateTime.Now.AddHours(47);
        var request = CreateAppointmentRequest(DateOnly.FromDateTime(tooSoon), TimeOnly.FromDateTime(tooSoon));
        SetupValidPatientAndDoctor(request);

        var exception = await Assert.ThrowsAsync<BusinessRuleException>(() => _appointmentService.CreateAppointmentAsync(request));

        Assert.Equal(ErrorMessages.AppointmentMustBeBookedAtLeast48HoursAhead, exception.Message);
        VerifyAppointmentBookedEventWasNotPublished();
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenAppointmentIsMoreThanSixMonthsAhead_ShouldThrowBusinessRuleException()
    {
        var tooFarDate = DateOnly.FromDateTime(DateTime.Today).AddMonths(6).AddDays(1);
        var request = CreateAppointmentRequest(tooFarDate, new TimeOnly(10, 30));
        SetupValidPatientAndDoctor(request);

        var exception = await Assert.ThrowsAsync<BusinessRuleException>(() => _appointmentService.CreateAppointmentAsync(request));

        Assert.Equal(ErrorMessages.AppointmentCannotBeBookedMoreThanSixMonthsAhead, exception.Message);
        VerifyAppointmentBookedEventWasNotPublished();
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenDoctorSlotIsAlreadyBooked_ShouldThrowConflictException()
    {
        var request = CreateAppointmentRequest();
        SetupValidPatientAndDoctor(request);
        _appointmentRepositoryMock.Setup(repo => repo.DoctorHasNonCancelledAppointmentAtAsync(request.DoctorId, request.AppointmentDate, request.AppointmentTime)).ReturnsAsync(true);

        var exception = await Assert.ThrowsAsync<ConflictException>(() => _appointmentService.CreateAppointmentAsync(request));

        Assert.Equal(ErrorMessages.DoctorSlotAlreadyBooked, exception.Message);
        VerifyAppointmentBookedEventWasNotPublished();
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenPatientSlotIsAlreadyBooked_ShouldThrowConflictException()
    {
        var request = CreateAppointmentRequest();
        SetupValidPatientAndDoctor(request);
        SetupDoctorSlotAvailable(request);
        _appointmentRepositoryMock.Setup(repo => repo.PatientHasNonCancelledAppointmentAtAsync(request.PatientId, request.AppointmentDate, request.AppointmentTime)).ReturnsAsync(true);

        var exception = await Assert.ThrowsAsync<ConflictException>(() => _appointmentService.CreateAppointmentAsync(request));

        Assert.Equal(ErrorMessages.PatientSlotAlreadyBooked, exception.Message);
        VerifyAppointmentBookedEventWasNotPublished();
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenPatientAlreadyHasAppointmentWithDoctorOnDate_ShouldThrowConflictException()
    {
        var request = CreateAppointmentRequest();
        SetupValidPatientAndDoctor(request);
        SetupDoctorSlotAvailable(request);
        _appointmentRepositoryMock.Setup(repo => repo.PatientHasNonCancelledAppointmentAtAsync(request.PatientId, request.AppointmentDate, request.AppointmentTime)).ReturnsAsync(false);
        _appointmentRepositoryMock.Setup(repo => repo.PatientHasNonCancelledAppointmentWithDoctorOnDateAsync(request.PatientId, request.DoctorId, request.AppointmentDate)).ReturnsAsync(true);

        var exception = await Assert.ThrowsAsync<ConflictException>(() => _appointmentService.CreateAppointmentAsync(request));

        Assert.Equal(ErrorMessages.PatientAlreadyHasAppointmentWithDoctorOnDate, exception.Message);
        VerifyAppointmentBookedEventWasNotPublished();
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenCreatedAppointmentCannotBeReloaded_ShouldThrowNotFoundException()
    {
        var request = CreateAppointmentRequest();
        SetupValidPatientAndDoctor(request);
        SetupNoAppointmentConflicts(request);
        _appointmentRepositoryMock.Setup(repo => repo.AddAsync(It.IsAny<Appointment>())).ReturnsAsync(CreateAppointment(id: 1));
        _appointmentRepositoryMock.Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(1)).ReturnsAsync((Appointment?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() => _appointmentService.CreateAppointmentAsync(request));

        Assert.Equal(ErrorMessages.AppointmentNotFoundAfterCreation, exception.Message);
        VerifyAppointmentBookedEventWasNotPublished();
    }

    [Fact]
    public async Task CreateAppointmentAsync_WhenValid_ShouldCreateAppointmentWithPendingStatusAndPublishAppointmentBookedEvent()
    {
        var request = CreateAppointmentRequest();
        var createdAppointment = CreateAppointment(id: 1, patientId: request.PatientId, doctorId: request.DoctorId, date: request.AppointmentDate, time: request.AppointmentTime);
        var mappedDto = CreateAppointmentDtoFromAppointment(createdAppointment);
        SetupValidPatientAndDoctor(request);
        SetupNoAppointmentConflicts(request);
        _appointmentRepositoryMock.Setup(repo => repo.AddAsync(It.IsAny<Appointment>())).ReturnsAsync(createdAppointment);
        _appointmentRepositoryMock.Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(1)).ReturnsAsync(createdAppointment);
        _mapperMock.Setup(mapper => mapper.Map<AppointmentDto>(createdAppointment)).Returns(mappedDto);

        var result = await _appointmentService.CreateAppointmentAsync(request);

        Assert.NotNull(result);
        Assert.Equal(AppointmentStatus.Pending, result!.Status);
        _appointmentRepositoryMock.Verify(repo => repo.AddAsync(It.Is<Appointment>(appointment => appointment.Status == AppointmentStatus.Pending)), Times.Once);
        _rabbitMqPublisherMock.Verify(
            publisher => publisher.PublishAppointmentBookedAsync(It.Is<AppointmentBookedEvent>(appointmentEvent =>
                appointmentEvent.AppointmentId == createdAppointment.Id &&
                appointmentEvent.PatientId == createdAppointment.PatientId &&
                appointmentEvent.DoctorId == createdAppointment.DoctorId &&
                appointmentEvent.ScheduledDate == createdAppointment.AppointmentDate &&
                appointmentEvent.TimeSlot == createdAppointment.AppointmentTime)),
            Times.Once);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenAppointmentDoesNotExist_ShouldThrowNotFoundException()
    {
        _appointmentRepositoryMock.Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(99)).ReturnsAsync((Appointment?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() => _appointmentService.UpdateAppointmentStatusAsync(99, new UpdateAppointmentStatusDto { Status = AppointmentStatus.Confirmed }, AppRoles.Admin, null, null));

        Assert.Equal(ErrorMessages.AppointmentNotFound, exception.Message);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenAdminConfirmsPendingAppointment_ShouldUpdateStatus()
    {
        var appointment = CreateAppointment(status: AppointmentStatus.Pending);
        var confirmedAppointment = CreateAppointment(status: AppointmentStatus.Confirmed);
        SetupAppointmentReload(appointment, confirmedAppointment);
        _mapperMock.Setup(mapper => mapper.Map<AppointmentDto>(confirmedAppointment)).Returns(CreateAppointmentDtoFromAppointment(confirmedAppointment));

        var result = await _appointmentService.UpdateAppointmentStatusAsync(appointment.Id, new UpdateAppointmentStatusDto { Status = AppointmentStatus.Confirmed }, AppRoles.Admin, null, null);

        Assert.Equal(AppointmentStatus.Confirmed, result!.Status);
        _appointmentRepositoryMock.Verify(repo => repo.UpdateAsync(It.Is<Appointment>(updated => updated.Status == AppointmentStatus.Confirmed && updated.CancellationReason == null)), Times.Once);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenConfirmingNonPendingAppointment_ShouldThrowBusinessRuleException()
    {
        var appointment = CreateAppointment(status: AppointmentStatus.Confirmed);
        _appointmentRepositoryMock.Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(appointment.Id)).ReturnsAsync(appointment);

        var exception = await Assert.ThrowsAsync<BusinessRuleException>(() => _appointmentService.UpdateAppointmentStatusAsync(appointment.Id, new UpdateAppointmentStatusDto { Status = AppointmentStatus.Confirmed }, AppRoles.Admin, null, null));

        Assert.Equal(ErrorMessages.OnlyPendingAppointmentsCanBeConfirmed, exception.Message);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenPatientConfirmsAppointment_ShouldThrowForbiddenException()
    {
        var appointment = CreateAppointment(status: AppointmentStatus.Pending);
        _appointmentRepositoryMock.Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(appointment.Id)).ReturnsAsync(appointment);

        var exception = await Assert.ThrowsAsync<ForbiddenException>(() => _appointmentService.UpdateAppointmentStatusAsync(appointment.Id, new UpdateAppointmentStatusDto { Status = AppointmentStatus.Confirmed }, AppRoles.Patient, appointment.PatientId, null));

        Assert.Equal(ErrorMessages.UnsupportedAppointmentStatusTransition, exception.Message);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenDoctorConfirmsAnotherDoctorsAppointment_ShouldThrowForbiddenException()
    {
        var appointment = CreateAppointment(status: AppointmentStatus.Pending, doctorId: 20);
        _appointmentRepositoryMock.Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(appointment.Id)).ReturnsAsync(appointment);

        var exception = await Assert.ThrowsAsync<ForbiddenException>(() => _appointmentService.UpdateAppointmentStatusAsync(appointment.Id, new UpdateAppointmentStatusDto { Status = AppointmentStatus.Confirmed }, AppRoles.Doctor, null, 99));

        Assert.Equal(ErrorMessages.DoctorsCanManageOnlyOwnAppointments, exception.Message);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenCancellationReasonMissing_ShouldThrowBusinessRuleException()
    {
        var appointment = CreateAppointment(status: AppointmentStatus.Pending);
        _appointmentRepositoryMock.Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(appointment.Id)).ReturnsAsync(appointment);

        var exception = await Assert.ThrowsAsync<BusinessRuleException>(() => _appointmentService.UpdateAppointmentStatusAsync(appointment.Id, new UpdateAppointmentStatusDto { Status = AppointmentStatus.Cancelled }, AppRoles.Admin, null, null));

        Assert.Equal(ErrorMessages.CancellationReasonRequired, exception.Message);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenCancellingCompletedAppointment_ShouldThrowBusinessRuleException()
    {
        var appointment = CreateAppointment(status: AppointmentStatus.Completed);
        _appointmentRepositoryMock.Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(appointment.Id)).ReturnsAsync(appointment);

        var exception = await Assert.ThrowsAsync<BusinessRuleException>(() => _appointmentService.UpdateAppointmentStatusAsync(appointment.Id, new UpdateAppointmentStatusDto { Status = AppointmentStatus.Cancelled, CancellationReason = "Reason" }, AppRoles.Admin, null, null));

        Assert.Equal(ErrorMessages.CompletedAppointmentsCannotBeCancelled, exception.Message);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenCancellingAlreadyCancelledAppointment_ShouldThrowBusinessRuleException()
    {
        var appointment = CreateAppointment(status: AppointmentStatus.Cancelled);
        _appointmentRepositoryMock.Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(appointment.Id)).ReturnsAsync(appointment);

        var exception = await Assert.ThrowsAsync<BusinessRuleException>(() => _appointmentService.UpdateAppointmentStatusAsync(appointment.Id, new UpdateAppointmentStatusDto { Status = AppointmentStatus.Cancelled, CancellationReason = "Reason" }, AppRoles.Admin, null, null));

        Assert.Equal(ErrorMessages.CancelledAppointmentsCannotBeCancelledAgain, exception.Message);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenPatientCancelsAnotherPatientsAppointment_ShouldThrowForbiddenException()
    {
        var appointment = CreateAppointment(status: AppointmentStatus.Pending, patientId: 10);
        _appointmentRepositoryMock.Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(appointment.Id)).ReturnsAsync(appointment);

        var exception = await Assert.ThrowsAsync<ForbiddenException>(() => _appointmentService.UpdateAppointmentStatusAsync(appointment.Id, new UpdateAppointmentStatusDto { Status = AppointmentStatus.Cancelled, CancellationReason = "Reason" }, AppRoles.Patient, 99, null));

        Assert.Equal(ErrorMessages.PatientsCanManageOnlyOwnAppointments, exception.Message);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenPatientCancelsConfirmedAppointment_ShouldThrowBusinessRuleException()
    {
        var appointment = CreateAppointment(status: AppointmentStatus.Confirmed, patientId: 10);
        _appointmentRepositoryMock.Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(appointment.Id)).ReturnsAsync(appointment);

        var exception = await Assert.ThrowsAsync<BusinessRuleException>(() => _appointmentService.UpdateAppointmentStatusAsync(appointment.Id, new UpdateAppointmentStatusDto { Status = AppointmentStatus.Cancelled, CancellationReason = "Reason" }, AppRoles.Patient, 10, null));

        Assert.Equal(ErrorMessages.PatientsCanCancelOnlyPendingAppointments, exception.Message);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenPatientCancelsOwnPendingAppointment_ShouldAppendPatientSuffix()
    {
        var appointment = CreateAppointment(status: AppointmentStatus.Pending, patientId: 10);
        var cancelledAppointment = CreateAppointment(status: AppointmentStatus.Cancelled, patientId: 10);
        cancelledAppointment.CancellationReason = "Reason - Cancelled by patient";
        SetupAppointmentReload(appointment, cancelledAppointment);
        _mapperMock.Setup(mapper => mapper.Map<AppointmentDto>(cancelledAppointment)).Returns(CreateAppointmentDtoFromAppointment(cancelledAppointment));

        var result = await _appointmentService.UpdateAppointmentStatusAsync(appointment.Id, new UpdateAppointmentStatusDto { Status = AppointmentStatus.Cancelled, CancellationReason = "Reason" }, AppRoles.Patient, 10, null);

        Assert.Equal(AppointmentStatus.Cancelled, result!.Status);
        _appointmentRepositoryMock.Verify(repo => repo.UpdateAsync(It.Is<Appointment>(updated => updated.CancellationReason == "Reason - Cancelled by patient")), Times.Once);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenDoctorCancelsAnotherDoctorsAppointment_ShouldThrowForbiddenException()
    {
        var appointment = CreateAppointment(status: AppointmentStatus.Pending, doctorId: 20);
        _appointmentRepositoryMock.Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(appointment.Id)).ReturnsAsync(appointment);

        var exception = await Assert.ThrowsAsync<ForbiddenException>(() => _appointmentService.UpdateAppointmentStatusAsync(appointment.Id, new UpdateAppointmentStatusDto { Status = AppointmentStatus.Cancelled, CancellationReason = "Reason" }, AppRoles.Doctor, null, 99));

        Assert.Equal(ErrorMessages.DoctorsCanManageOnlyOwnAppointments, exception.Message);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenDoctorCancelsAppointmentWithin24Hours_ShouldThrowBusinessRuleException()
    {
        var soon = DateTime.Now.AddHours(23);
        var appointment = CreateAppointment(status: AppointmentStatus.Confirmed, doctorId: 20, date: DateOnly.FromDateTime(soon), time: TimeOnly.FromDateTime(soon));
        _appointmentRepositoryMock.Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(appointment.Id)).ReturnsAsync(appointment);

        var exception = await Assert.ThrowsAsync<BusinessRuleException>(() => _appointmentService.UpdateAppointmentStatusAsync(appointment.Id, new UpdateAppointmentStatusDto { Status = AppointmentStatus.Cancelled, CancellationReason = "Reason" }, AppRoles.Doctor, null, 20));

        Assert.Equal(ErrorMessages.AppointmentCannotBeCancelledWithin24Hours, exception.Message);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenDoctorCancelsOwnAppointment_ShouldAppendDoctorSuffix()
    {
        var appointment = CreateAppointment(status: AppointmentStatus.Confirmed, doctorId: 20);
        var cancelledAppointment = CreateAppointment(status: AppointmentStatus.Cancelled, doctorId: 20);
        cancelledAppointment.CancellationReason = "Doctor emergency - Cancelled by doctor";
        SetupAppointmentReload(appointment, cancelledAppointment);
        _mapperMock.Setup(mapper => mapper.Map<AppointmentDto>(cancelledAppointment)).Returns(CreateAppointmentDtoFromAppointment(cancelledAppointment));

        var result = await _appointmentService.UpdateAppointmentStatusAsync(appointment.Id, new UpdateAppointmentStatusDto { Status = AppointmentStatus.Cancelled, CancellationReason = "Doctor emergency" }, AppRoles.Doctor, null, 20);

        Assert.Equal(AppointmentStatus.Cancelled, result!.Status);
        _appointmentRepositoryMock.Verify(repo => repo.UpdateAsync(It.Is<Appointment>(updated => updated.CancellationReason == "Doctor emergency - Cancelled by doctor")), Times.Once);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenAdminCancelsAppointment_ShouldAppendAdminSuffix()
    {
        var appointment = CreateAppointment(status: AppointmentStatus.Confirmed);
        var cancelledAppointment = CreateAppointment(status: AppointmentStatus.Cancelled);
        cancelledAppointment.CancellationReason = "Admin action - Cancelled by admin";
        SetupAppointmentReload(appointment, cancelledAppointment);
        _mapperMock.Setup(mapper => mapper.Map<AppointmentDto>(cancelledAppointment)).Returns(CreateAppointmentDtoFromAppointment(cancelledAppointment));

        var result = await _appointmentService.UpdateAppointmentStatusAsync(appointment.Id, new UpdateAppointmentStatusDto { Status = AppointmentStatus.Cancelled, CancellationReason = "Admin action" }, AppRoles.Admin, null, null);

        Assert.Equal(AppointmentStatus.Cancelled, result!.Status);
        _appointmentRepositoryMock.Verify(repo => repo.UpdateAsync(It.Is<Appointment>(updated => updated.CancellationReason == "Admin action - Cancelled by admin")), Times.Once);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenUnsupportedRoleCancelsAppointment_ShouldThrowForbiddenException()
    {
        var appointment = CreateAppointment(status: AppointmentStatus.Pending);
        _appointmentRepositoryMock.Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(appointment.Id)).ReturnsAsync(appointment);

        var exception = await Assert.ThrowsAsync<ForbiddenException>(() => _appointmentService.UpdateAppointmentStatusAsync(appointment.Id, new UpdateAppointmentStatusDto { Status = AppointmentStatus.Cancelled, CancellationReason = "Reason" }, "Receptionist", null, null));

        Assert.Equal(ErrorMessages.UnsupportedAppointmentStatusTransition, exception.Message);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenCompletedRequested_ShouldThrowBusinessRuleException()
    {
        var appointment = CreateAppointment(status: AppointmentStatus.Confirmed);
        _appointmentRepositoryMock.Setup(repo => repo.GetAppointmentByIdWithDetailsAsync(appointment.Id)).ReturnsAsync(appointment);

        var exception = await Assert.ThrowsAsync<BusinessRuleException>(() => _appointmentService.UpdateAppointmentStatusAsync(appointment.Id, new UpdateAppointmentStatusDto { Status = AppointmentStatus.Completed }, AppRoles.Doctor, null, appointment.DoctorId));

        Assert.Equal(ErrorMessages.AppointmentCompletedOnlyThroughHealthRecord, exception.Message);
    }

    [Fact]
    public async Task UpdateAppointmentStatusAsync_WhenAppointmentCannotBeReloadedAfterUpdate_ShouldThrowNotFoundException()
    {
        var appointment = CreateAppointment(status: AppointmentStatus.Pending);
        _appointmentRepositoryMock.SetupSequence(repo => repo.GetAppointmentByIdWithDetailsAsync(appointment.Id))
            .ReturnsAsync(appointment)
            .ReturnsAsync((Appointment?)null);
        _appointmentRepositoryMock.Setup(repo => repo.UpdateAsync(It.IsAny<Appointment>())).ReturnsAsync(appointment);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() => _appointmentService.UpdateAppointmentStatusAsync(appointment.Id, new UpdateAppointmentStatusDto { Status = AppointmentStatus.Confirmed }, AppRoles.Admin, null, null));

        Assert.Equal(ErrorMessages.AppointmentNotFound, exception.Message);
    }

    [Fact]
    public async Task GetAppointmentReportsAsync_WhenAppointmentsExist_ShouldReturnGroupedReports()
    {
        var reports = new List<AppointmentReportDto>
        {
            new() { Date = new DateOnly(2026, 6, 20), PendingCount = 1, ConfirmedCount = 1, CancelledCount = 1, CompletedCount = 0, TotalCount = 3 },
            new() { Date = new DateOnly(2026, 6, 21), PendingCount = 0, ConfirmedCount = 0, CancelledCount = 0, CompletedCount = 1, TotalCount = 1 }
        };
        _appointmentRepositoryMock.Setup(repo => repo.GetAppointmentReportsAsync()).ReturnsAsync(reports);

        var result = await _appointmentService.GetAppointmentReportsAsync();

        Assert.Equal(2, result.Count);
    }

    [Fact]
    public async Task GetAppointmentReportsAsync_WhenNoAppointmentsExist_ShouldReturnEmptyList()
    {
        _appointmentRepositoryMock.Setup(repo => repo.GetAppointmentReportsAsync()).ReturnsAsync([]);

        var result = await _appointmentService.GetAppointmentReportsAsync();

        Assert.Empty(result);
    }

    private void SetupValidPatientAndDoctor(CreateAppointmentDto request)
    {
        _patientRepositoryMock.Setup(repo => repo.GetByIdAsync(request.PatientId)).ReturnsAsync(CreatePatient(request.PatientId));
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdAsync(request.DoctorId)).ReturnsAsync(CreateDoctor(request.DoctorId, true));
    }

    private void SetupDoctorSlotAvailable(CreateAppointmentDto request)
    {
        _appointmentRepositoryMock.Setup(repo => repo.DoctorHasNonCancelledAppointmentAtAsync(request.DoctorId, request.AppointmentDate, request.AppointmentTime)).ReturnsAsync(false);
    }

    private void SetupNoAppointmentConflicts(CreateAppointmentDto request)
    {
        SetupDoctorSlotAvailable(request);
        _appointmentRepositoryMock.Setup(repo => repo.PatientHasNonCancelledAppointmentAtAsync(request.PatientId, request.AppointmentDate, request.AppointmentTime)).ReturnsAsync(false);
        _appointmentRepositoryMock.Setup(repo => repo.PatientHasNonCancelledAppointmentWithDoctorOnDateAsync(request.PatientId, request.DoctorId, request.AppointmentDate)).ReturnsAsync(false);
    }

    private void SetupAppointmentReload(Appointment appointment, Appointment reloadedAppointment)
    {
        _appointmentRepositoryMock.SetupSequence(repo => repo.GetAppointmentByIdWithDetailsAsync(appointment.Id))
            .ReturnsAsync(appointment)
            .ReturnsAsync(reloadedAppointment);
        _appointmentRepositoryMock.Setup(repo => repo.UpdateAsync(It.IsAny<Appointment>())).ReturnsAsync((Appointment updated) => updated);
    }

    private void VerifyAppointmentBookedEventWasNotPublished()
    {
        _rabbitMqPublisherMock.Verify(
            publisher => publisher.PublishAppointmentBookedAsync(It.IsAny<AppointmentBookedEvent>()),
            Times.Never);
    }

    private static PaginationQueryDto CreatePagination() => new() { PageNumber = 1, PageSize = 10 };

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
        var futureDateTime = GetFutureDateTime();
        return CreateAppointmentRequest(DateOnly.FromDateTime(futureDateTime), TimeOnly.FromDateTime(futureDateTime));
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

    private static AppointmentDto CreateAppointmentDtoFromAppointment(Appointment appointment) => new()
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

    private static Patient CreatePatient(int id) => new() { Id = id, UserId = $"patient-user-id-{id}", FullName = "Patient One" };

    private static Doctor CreateDoctor(int id, bool isAvailable) => new() { Id = id, UserId = $"doctor-user-id-{id}", FullName = "Doctor One", IsAvailable = isAvailable };

    private static DateTime GetFutureDateTime() => DateTime.Now.AddDays(3).Date.AddHours(10).AddMinutes(30);
}
