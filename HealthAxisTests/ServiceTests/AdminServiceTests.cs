using AutoMapper;
using HealthAxis.API.Constants;
using HealthAxis.API.Data;
using HealthAxis.API.Exceptions;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using HealthAxis.API.Services;
using HealthAxis.API.Services.Impl;
using HealthAxis.Shared.Constants;
using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Dtos.Appointment;
using HealthAxis.Shared.Dtos.Auth;
using HealthAxis.Shared.Dtos.Doctor;
using HealthAxis.Shared.Dtos.Patient;
using HealthAxis.Shared.Enums;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Moq;

namespace HealthAxisTests.ServiceTests;

public class AdminServiceTests
{
    private readonly HealthAxisDbContext _context;
    private readonly Mock<IDoctorRepository> _doctorRepositoryMock;
    private readonly Mock<IPatientRepository> _patientRepositoryMock;
    private readonly Mock<IAppointmentService> _appointmentServiceMock;
    private readonly Mock<IMapper> _mapperMock;
    private readonly Mock<UserManager<IdentityUser>> _userManagerMock;
    private readonly AdminService _adminService;

    public AdminServiceTests()
    {
        _context = CreateDbContext();
        _doctorRepositoryMock = new Mock<IDoctorRepository>();
        _patientRepositoryMock = new Mock<IPatientRepository>();
        _appointmentServiceMock = new Mock<IAppointmentService>();
        _mapperMock = new Mock<IMapper>();
        _userManagerMock = CreateUserManagerMock();

        _adminService = new AdminService(
            _context,
            _doctorRepositoryMock.Object,
            _patientRepositoryMock.Object,
            _appointmentServiceMock.Object,
            _mapperMock.Object,
            _userManagerMock.Object);
    }

    [Fact]
    public async Task GetDashboardSummaryAsync_ShouldReturnExpectedCounts()
    {
        var today = DateOnly.FromDateTime(DateTime.Today);
        _context.Doctors.AddRange(CreateDoctor(1, true), CreateDoctor(2, false));
        _context.Patients.AddRange(CreatePatient(1), CreatePatient(2), CreatePatient(3));
        _context.Appointments.AddRange(
            CreateAppointment(1, today, AppointmentStatus.Pending),
            CreateAppointment(2, today, AppointmentStatus.Confirmed),
            CreateAppointment(3, today, AppointmentStatus.Completed),
            CreateAppointment(4, today, AppointmentStatus.Cancelled),
            CreateAppointment(5, today.AddDays(1), AppointmentStatus.Pending));
        await _context.SaveChangesAsync();

        var result = await _adminService.GetDashboardSummaryAsync();

        Assert.Equal(1, result.ActiveDoctorsCount);
        Assert.Equal(3, result.RegisteredPatientsCount);
        Assert.Equal(2, result.PendingAppointmentsCount);
        Assert.Equal(1, result.ConfirmedAppointmentsCount);
        Assert.Equal(1, result.CompletedAppointmentsCount);
        Assert.Equal(1, result.CancelledAppointmentsCount);
        Assert.Equal(4, result.TodaysAppointmentsCount);
        Assert.Equal(1, result.TodaysPendingAppointmentsCount);
        Assert.Equal(1, result.TodaysConfirmedAppointmentsCount);
        Assert.Equal(1, result.TodaysCompletedAppointmentsCount);
        Assert.Equal(1, result.TodaysCancelledAppointmentsCount);
    }

    [Fact]
    public async Task GetDoctorsAsync_WhenDoctorsExist_ShouldReturnPagedDoctorDtos()
    {
        var doctors = new List<Doctor> { CreateDoctorWithUser() };
        var pagedDoctors = CreatePagedResult(doctors);
        var mappedDtos = new List<DoctorDto> { CreateDoctorDtoFromDoctor(doctors[0]) };
        var pagination = CreatePagination();

        _doctorRepositoryMock.Setup(repo => repo.GetAllDoctorsWithUserAsync(1, 10, "cardio", DoctorSpecialisation.Cardiology)).ReturnsAsync(pagedDoctors);
        _mapperMock.Setup(mapper => mapper.Map<List<DoctorDto>>(doctors)).Returns(mappedDtos);

        var result = await _adminService.GetDoctorsAsync(pagination, "cardio", DoctorSpecialisation.Cardiology);

        Assert.Single(result.Items);
        Assert.Equal("doctor@test.com", result.Items[0].Email);
        Assert.Equal(1, result.TotalCount);
    }

    [Fact]
    public async Task CreateDoctorAsync_WhenEmailAlreadyExists_ShouldThrowConflictException()
    {
        var dto = CreateDoctorDto();
        _userManagerMock.Setup(manager => manager.FindByEmailAsync(dto.Email)).ReturnsAsync(new IdentityUser { Email = dto.Email });

        var exception = await Assert.ThrowsAsync<ConflictException>(() => _adminService.CreateDoctorAsync(dto));

        Assert.Equal(ErrorMessages.EmailAlreadyExists, exception.Message);
    }

    [Fact]
    public async Task CreateDoctorAsync_WhenIdentityCreateFails_ShouldThrowBadRequestException()
    {
        var dto = CreateDoctorDto();
        _userManagerMock.Setup(manager => manager.FindByEmailAsync(dto.Email)).ReturnsAsync((IdentityUser?)null);
        _userManagerMock.Setup(manager => manager.CreateAsync(It.IsAny<IdentityUser>(), dto.Password))
            .ReturnsAsync(IdentityResult.Failed(new IdentityError { Description = "Password is invalid." }));

        var exception = await Assert.ThrowsAsync<BadRequestException>(() => _adminService.CreateDoctorAsync(dto));

        Assert.Equal("Password is invalid.", exception.Message);
    }

    [Fact]
    public async Task CreateDoctorAsync_WhenAddRoleFails_ShouldThrowBadRequestException()
    {
        var dto = CreateDoctorDto();
        _userManagerMock.Setup(manager => manager.FindByEmailAsync(dto.Email)).ReturnsAsync((IdentityUser?)null);
        _userManagerMock.Setup(manager => manager.CreateAsync(It.IsAny<IdentityUser>(), dto.Password)).ReturnsAsync(IdentityResult.Success);
        _userManagerMock.Setup(manager => manager.AddToRoleAsync(It.IsAny<IdentityUser>(), AppRoles.Doctor))
            .ReturnsAsync(IdentityResult.Failed(new IdentityError { Description = "Role assignment failed." }));

        var exception = await Assert.ThrowsAsync<BadRequestException>(() => _adminService.CreateDoctorAsync(dto));

        Assert.Equal("Role assignment failed.", exception.Message);
    }

    [Fact]
    public async Task CreateDoctorAsync_WhenDoctorCannotBeReloadedAfterCreation_ShouldThrowNotFoundException()
    {
        var dto = CreateDoctorDto();
        SetupSuccessfulIdentityDoctorCreation(dto, "created-user-id");
        _doctorRepositoryMock.Setup(repo => repo.AddAsync(It.IsAny<Doctor>())).ReturnsAsync(CreateDoctor(1, true));
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdWithUserAsync(1)).ReturnsAsync((Doctor?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() => _adminService.CreateDoctorAsync(dto));

        Assert.Equal(ErrorMessages.DoctorNotFoundAfterCreation, exception.Message);
    }

    [Fact]
    public async Task CreateDoctorAsync_WhenValid_ShouldCreateDoctorAndReturnDoctorDto()
    {
        var dto = CreateDoctorDto();
        var createdDoctor = CreateDoctor(1, dto.IsAvailable);
        createdDoctor.UserId = "created-user-id";
        var doctorWithUser = CreateDoctorWithUser(1, "created-user-id", dto.Email, dto.PhoneNumber);
        var mappedDto = CreateDoctorDtoFromDoctor(doctorWithUser);

        SetupSuccessfulIdentityDoctorCreation(dto, "created-user-id");
        _doctorRepositoryMock.Setup(repo => repo.AddAsync(It.IsAny<Doctor>())).ReturnsAsync(createdDoctor);
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdWithUserAsync(1)).ReturnsAsync(doctorWithUser);
        _mapperMock.Setup(mapper => mapper.Map<DoctorDto>(doctorWithUser)).Returns(mappedDto);

        var result = await _adminService.CreateDoctorAsync(dto);

        Assert.NotNull(result);
        Assert.Equal(dto.Email, result!.Email);
        _doctorRepositoryMock.Verify(repo => repo.AddAsync(It.Is<Doctor>(doctor => doctor.UserId == "created-user-id" && doctor.FullName == dto.FullName)), Times.Once);
    }

    [Fact]
    public async Task UpdateDoctorAsync_WhenDoctorDoesNotExist_ShouldThrowNotFoundException()
    {
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdWithUserAsync(99)).ReturnsAsync((Doctor?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() => _adminService.UpdateDoctorAsync(99, CreateUpdateDoctorDto()));

        Assert.Equal(ErrorMessages.DoctorNotFound, exception.Message);
    }

    [Fact]
    public async Task UpdateDoctorAsync_WhenDoctorUserMissing_ShouldThrowNotFoundException()
    {
        var doctor = CreateDoctor(1, true);
        doctor.User = null;
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdWithUserAsync(1)).ReturnsAsync(doctor);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() => _adminService.UpdateDoctorAsync(1, CreateUpdateDoctorDto()));

        Assert.Equal(ErrorMessages.DoctorNotFound, exception.Message);
    }

    [Fact]
    public async Task UpdateDoctorAsync_WhenEmailBelongsToAnotherUser_ShouldThrowConflictException()
    {
        var dto = CreateUpdateDoctorDto();
        var doctor = CreateDoctorWithUser(userId: "current-user-id");
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdWithUserAsync(1)).ReturnsAsync(doctor);
        _userManagerMock.Setup(manager => manager.FindByEmailAsync(dto.Email.Trim())).ReturnsAsync(new IdentityUser { Id = "other-user-id", Email = dto.Email });

        var exception = await Assert.ThrowsAsync<ConflictException>(() => _adminService.UpdateDoctorAsync(1, dto));

        Assert.Equal(ErrorMessages.EmailAlreadyExists, exception.Message);
    }

    [Fact]
    public async Task UpdateDoctorAsync_WhenIdentityUpdateFails_ShouldThrowBadRequestException()
    {
        var dto = CreateUpdateDoctorDto();
        var doctor = CreateDoctorWithUser(userId: "current-user-id");
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdWithUserAsync(1)).ReturnsAsync(doctor);
        _userManagerMock.Setup(manager => manager.FindByEmailAsync(dto.Email.Trim())).ReturnsAsync((IdentityUser?)null);
        _userManagerMock.Setup(manager => manager.UpdateAsync(doctor.User!))
            .ReturnsAsync(IdentityResult.Failed(new IdentityError { Description = "Update failed." }));

        var exception = await Assert.ThrowsAsync<BadRequestException>(() => _adminService.UpdateDoctorAsync(1, dto));

        Assert.Equal("Update failed.", exception.Message);
    }

    [Fact]
    public async Task UpdateDoctorAsync_WhenUpdatedDoctorCannotBeReloaded_ShouldThrowNotFoundException()
    {
        var dto = CreateUpdateDoctorDto();
        var doctor = CreateDoctorWithUser(userId: "current-user-id");
        _doctorRepositoryMock.SetupSequence(repo => repo.GetDoctorByIdWithUserAsync(1))
            .ReturnsAsync(doctor)
            .ReturnsAsync((Doctor?)null);
        _userManagerMock.Setup(manager => manager.FindByEmailAsync(dto.Email.Trim())).ReturnsAsync((IdentityUser?)null);
        _userManagerMock.Setup(manager => manager.UpdateAsync(doctor.User!)).ReturnsAsync(IdentityResult.Success);
        _doctorRepositoryMock.Setup(repo => repo.UpdateAsync(It.IsAny<Doctor>())).ReturnsAsync(doctor);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() => _adminService.UpdateDoctorAsync(1, dto));

        Assert.Equal(ErrorMessages.DoctorNotFound, exception.Message);
    }

    [Fact]
    public async Task UpdateDoctorAsync_WhenValid_ShouldUpdateDoctorAndIdentityUser()
    {
        var dto = CreateUpdateDoctorDto();
        var doctor = CreateDoctorWithUser(userId: "current-user-id");
        var updatedDoctor = CreateDoctorWithUser(userId: "current-user-id", email: dto.Email, phoneNumber: dto.PhoneNumber);
        var mappedDto = CreateDoctorDtoFromDoctor(updatedDoctor);
        _doctorRepositoryMock.SetupSequence(repo => repo.GetDoctorByIdWithUserAsync(1)).ReturnsAsync(doctor).ReturnsAsync(updatedDoctor);
        _userManagerMock.Setup(manager => manager.FindByEmailAsync(dto.Email.Trim())).ReturnsAsync((IdentityUser?)null);
        _userManagerMock.Setup(manager => manager.UpdateAsync(doctor.User!)).ReturnsAsync(IdentityResult.Success);
        _doctorRepositoryMock.Setup(repo => repo.UpdateAsync(It.IsAny<Doctor>())).ReturnsAsync(doctor);
        _mapperMock.Setup(mapper => mapper.Map<DoctorDto>(updatedDoctor)).Returns(mappedDto);

        var result = await _adminService.UpdateDoctorAsync(1, dto);

        Assert.Equal(dto.Email, result!.Email);
        _userManagerMock.Verify(manager => manager.UpdateAsync(It.Is<IdentityUser>(user => user.Email == dto.Email.Trim() && user.PhoneNumber == dto.PhoneNumber)), Times.Once);
    }

    [Fact]
    public async Task ResetDoctorPasswordAsync_WhenDoctorMissing_ShouldThrowNotFoundException()
    {
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdWithUserAsync(99)).ReturnsAsync((Doctor?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() => _adminService.ResetDoctorPasswordAsync(99, CreateResetPasswordDto()));

        Assert.Equal(ErrorMessages.DoctorNotFound, exception.Message);
    }

    [Fact]
    public async Task ResetDoctorPasswordAsync_WhenResetFails_ShouldThrowBadRequestException()
    {
        var doctor = CreateDoctorWithUser();
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdWithUserAsync(1)).ReturnsAsync(doctor);
        _userManagerMock.Setup(manager => manager.GeneratePasswordResetTokenAsync(doctor.User!)).ReturnsAsync("token");
        _userManagerMock.Setup(manager => manager.ResetPasswordAsync(doctor.User!, "token", "New@12345"))
            .ReturnsAsync(IdentityResult.Failed(new IdentityError { Description = "Reset failed." }));

        var exception = await Assert.ThrowsAsync<BadRequestException>(() => _adminService.ResetDoctorPasswordAsync(1, CreateResetPasswordDto()));

        Assert.Equal("Reset failed.", exception.Message);
    }

    [Fact]
    public async Task ResetDoctorPasswordAsync_WhenValid_ShouldResetPassword()
    {
        var doctor = CreateDoctorWithUser();
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdWithUserAsync(1)).ReturnsAsync(doctor);
        _userManagerMock.Setup(manager => manager.GeneratePasswordResetTokenAsync(doctor.User!)).ReturnsAsync("token");
        _userManagerMock.Setup(manager => manager.ResetPasswordAsync(doctor.User!, "token", "New@12345")).ReturnsAsync(IdentityResult.Success);

        await _adminService.ResetDoctorPasswordAsync(1, CreateResetPasswordDto());

        _userManagerMock.Verify(manager => manager.ResetPasswordAsync(doctor.User!, "token", "New@12345"), Times.Once);
    }

    [Fact]
    public async Task GetDoctorAppointmentsAsync_WhenDoctorMissing_ShouldThrowNotFoundException()
    {
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdAsync(99)).ReturnsAsync((Doctor?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() => _adminService.GetDoctorAppointmentsAsync(99, null, CreatePagination()));

        Assert.Equal(ErrorMessages.DoctorNotFound, exception.Message);
    }

    [Fact]
    public async Task GetDoctorAppointmentsAsync_WhenDoctorExists_ShouldDelegateToAppointmentService()
    {
        var expected = new PagedResultDto<AppointmentDto> { Items = [], PageNumber = 1, PageSize = 10 };
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdAsync(1)).ReturnsAsync(CreateDoctor(1, true));
        _appointmentServiceMock.Setup(service => service.GetAppointmentsByDoctorIdAsync(1, AppointmentStatus.Confirmed, It.IsAny<PaginationQueryDto>())).ReturnsAsync(expected);

        var result = await _adminService.GetDoctorAppointmentsAsync(1, AppointmentStatus.Confirmed, CreatePagination());

        Assert.Same(expected, result);
    }

    [Fact]
    public async Task GetPatientsAsync_WhenPatientsExist_ShouldReturnPagedPatientDtos()
    {
        var patients = new List<Patient> { CreatePatientWithUser() };
        var mappedDtos = new List<PatientDto> { CreatePatientDtoFromPatient(patients[0]) };
        _patientRepositoryMock.Setup(repo => repo.GetAllPatientsWithUserAsync(1, 10, "asha")).ReturnsAsync(CreatePagedResult(patients));
        _mapperMock.Setup(mapper => mapper.Map<List<PatientDto>>(patients)).Returns(mappedDtos);

        var result = await _adminService.GetPatientsAsync(CreatePagination(), "asha");

        Assert.Single(result.Items);
        Assert.Equal("patient@test.com", result.Items[0].Email);
    }

    [Fact]
    public async Task UpdatePatientAsync_WhenPatientMissing_ShouldThrowNotFoundException()
    {
        _patientRepositoryMock.Setup(repo => repo.GetPatientByIdWithUserAsync(99)).ReturnsAsync((Patient?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() => _adminService.UpdatePatientAsync(99, CreateUpdatePatientDto()));

        Assert.Equal(ErrorMessages.PatientNotFound, exception.Message);
    }

    [Fact]
    public async Task UpdatePatientAsync_WhenPatientUserMissing_ShouldThrowNotFoundException()
    {
        var patient = CreatePatient(1);
        patient.User = null;
        _patientRepositoryMock.Setup(repo => repo.GetPatientByIdWithUserAsync(1)).ReturnsAsync(patient);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() => _adminService.UpdatePatientAsync(1, CreateUpdatePatientDto()));

        Assert.Equal(ErrorMessages.PatientAccountNotFound, exception.Message);
    }

    [Fact]
    public async Task UpdatePatientAsync_WhenEmailBelongsToAnotherUser_ShouldThrowConflictException()
    {
        var dto = CreateUpdatePatientDto();
        var patient = CreatePatientWithUser(userId: "current-user-id");
        _patientRepositoryMock.Setup(repo => repo.GetPatientByIdWithUserAsync(1)).ReturnsAsync(patient);
        _userManagerMock.Setup(manager => manager.FindByEmailAsync(dto.Email.Trim())).ReturnsAsync(new IdentityUser { Id = "other-user-id", Email = dto.Email });

        var exception = await Assert.ThrowsAsync<ConflictException>(() => _adminService.UpdatePatientAsync(1, dto));

        Assert.Equal(ErrorMessages.EmailAlreadyExists, exception.Message);
    }

    [Fact]
    public async Task UpdatePatientAsync_WhenIdentityUpdateFails_ShouldThrowBadRequestException()
    {
        var dto = CreateUpdatePatientDto();
        var patient = CreatePatientWithUser(userId: "current-user-id");
        _patientRepositoryMock.Setup(repo => repo.GetPatientByIdWithUserAsync(1)).ReturnsAsync(patient);
        _userManagerMock.Setup(manager => manager.FindByEmailAsync(dto.Email.Trim())).ReturnsAsync((IdentityUser?)null);
        _userManagerMock.Setup(manager => manager.UpdateAsync(patient.User!)).ReturnsAsync(IdentityResult.Failed(new IdentityError { Description = "Update failed." }));

        var exception = await Assert.ThrowsAsync<BadRequestException>(() => _adminService.UpdatePatientAsync(1, dto));

        Assert.Equal("Update failed.", exception.Message);
    }

    [Fact]
    public async Task UpdatePatientAsync_WhenUpdatedPatientCannotBeReloaded_ShouldThrowNotFoundException()
    {
        var dto = CreateUpdatePatientDto();
        var patient = CreatePatientWithUser(userId: "current-user-id");
        _patientRepositoryMock.SetupSequence(repo => repo.GetPatientByIdWithUserAsync(1)).ReturnsAsync(patient).ReturnsAsync((Patient?)null);
        _userManagerMock.Setup(manager => manager.FindByEmailAsync(dto.Email.Trim())).ReturnsAsync((IdentityUser?)null);
        _userManagerMock.Setup(manager => manager.UpdateAsync(patient.User!)).ReturnsAsync(IdentityResult.Success);
        _patientRepositoryMock.Setup(repo => repo.UpdateAsync(It.IsAny<Patient>())).ReturnsAsync(patient);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() => _adminService.UpdatePatientAsync(1, dto));

        Assert.Equal(ErrorMessages.PatientNotFound, exception.Message);
    }

    [Fact]
    public async Task UpdatePatientAsync_WhenValid_ShouldUpdatePatientAndIdentityUser()
    {
        var dto = CreateUpdatePatientDto();
        var patient = CreatePatientWithUser(userId: "current-user-id");
        var updatedPatient = CreatePatientWithUser(userId: "current-user-id", email: dto.Email, phoneNumber: dto.PhoneNumber);
        var mappedDto = CreatePatientDtoFromPatient(updatedPatient);
        _patientRepositoryMock.SetupSequence(repo => repo.GetPatientByIdWithUserAsync(1)).ReturnsAsync(patient).ReturnsAsync(updatedPatient);
        _userManagerMock.Setup(manager => manager.FindByEmailAsync(dto.Email.Trim())).ReturnsAsync((IdentityUser?)null);
        _userManagerMock.Setup(manager => manager.UpdateAsync(patient.User!)).ReturnsAsync(IdentityResult.Success);
        _patientRepositoryMock.Setup(repo => repo.UpdateAsync(It.IsAny<Patient>())).ReturnsAsync(patient);
        _mapperMock.Setup(mapper => mapper.Map<PatientDto>(updatedPatient)).Returns(mappedDto);

        var result = await _adminService.UpdatePatientAsync(1, dto);

        Assert.Equal(dto.Email, result!.Email);
        _userManagerMock.Verify(manager => manager.UpdateAsync(It.Is<IdentityUser>(user => user.Email == dto.Email.Trim() && user.PhoneNumber == dto.PhoneNumber)), Times.Once);
    }

    [Fact]
    public async Task ResetPatientPasswordAsync_WhenPatientMissing_ShouldThrowNotFoundException()
    {
        _patientRepositoryMock.Setup(repo => repo.GetPatientByIdWithUserAsync(99)).ReturnsAsync((Patient?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() => _adminService.ResetPatientPasswordAsync(99, CreateResetPasswordDto()));

        Assert.Equal(ErrorMessages.PatientNotFound, exception.Message);
    }

    [Fact]
    public async Task ResetPatientPasswordAsync_WhenPatientUserMissing_ShouldThrowNotFoundException()
    {
        var patient = CreatePatient(1);
        patient.User = null;
        _patientRepositoryMock.Setup(repo => repo.GetPatientByIdWithUserAsync(1)).ReturnsAsync(patient);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() => _adminService.ResetPatientPasswordAsync(1, CreateResetPasswordDto()));

        Assert.Equal(ErrorMessages.PatientAccountNotFound, exception.Message);
    }

    [Fact]
    public async Task ResetPatientPasswordAsync_WhenValid_ShouldResetPassword()
    {
        var patient = CreatePatientWithUser();
        _patientRepositoryMock.Setup(repo => repo.GetPatientByIdWithUserAsync(1)).ReturnsAsync(patient);
        _userManagerMock.Setup(manager => manager.GeneratePasswordResetTokenAsync(patient.User!)).ReturnsAsync("token");
        _userManagerMock.Setup(manager => manager.ResetPasswordAsync(patient.User!, "token", "New@12345")).ReturnsAsync(IdentityResult.Success);

        await _adminService.ResetPatientPasswordAsync(1, CreateResetPasswordDto());

        _userManagerMock.Verify(manager => manager.ResetPasswordAsync(patient.User!, "token", "New@12345"), Times.Once);
    }

    [Fact]
    public async Task GetPatientAppointmentsAsync_ShouldDelegateToAppointmentService()
    {
        var expected = new PagedResultDto<AppointmentDto> { Items = [], PageNumber = 1, PageSize = 10 };
        _appointmentServiceMock.Setup(service => service.GetAppointmentsByPatientIdAsync(1, AppointmentStatus.Pending, It.IsAny<PaginationQueryDto>())).ReturnsAsync(expected);

        var result = await _adminService.GetPatientAppointmentsAsync(1, AppointmentStatus.Pending, CreatePagination());

        Assert.Same(expected, result);
    }

    [Fact]
    public async Task GetAppointmentReportsAsync_ShouldReturnOrderedPagedReports()
    {
        var reports = new List<AppointmentReportDto>
        {
            new() { Date = new DateOnly(2026, 1, 1), TotalCount = 1 },
            new() { Date = new DateOnly(2026, 1, 3), TotalCount = 3 },
            new() { Date = new DateOnly(2026, 1, 2), TotalCount = 2 }
        };
        _appointmentServiceMock.Setup(service => service.GetAppointmentReportsAsync()).ReturnsAsync(reports);

        var result = await _adminService.GetAppointmentReportsAsync(new PaginationQueryDto { PageNumber = 1, PageSize = 2 });

        Assert.Equal(3, result.TotalCount);
        Assert.Equal(2, result.TotalPages);
        Assert.Equal(new DateOnly(2026, 1, 3), result.Items[0].Date);
        Assert.Equal(new DateOnly(2026, 1, 2), result.Items[1].Date);
    }

    [Fact]
    public async Task GetAppointmentReportDetailsAsync_ShouldDelegateToAppointmentService()
    {
        var date = DateOnly.FromDateTime(DateTime.Today);
        var expected = new PagedResultDto<AppointmentDto> { Items = [], PageNumber = 1, PageSize = 10 };
        _appointmentServiceMock.Setup(service => service.GetAppointmentsByDateAndStatusAsync(date, AppointmentStatus.Confirmed, It.IsAny<PaginationQueryDto>())).ReturnsAsync(expected);

        var result = await _adminService.GetAppointmentReportDetailsAsync(date, AppointmentStatus.Confirmed, CreatePagination());

        Assert.Same(expected, result);
    }

    private void SetupSuccessfulIdentityDoctorCreation(CreateDoctorDto dto, string userId)
    {
        _userManagerMock.Setup(manager => manager.FindByEmailAsync(dto.Email)).ReturnsAsync((IdentityUser?)null);
        _userManagerMock.Setup(manager => manager.CreateAsync(It.IsAny<IdentityUser>(), dto.Password))
            .Callback<IdentityUser, string>((user, _) => user.Id = userId)
            .ReturnsAsync(IdentityResult.Success);
        _userManagerMock.Setup(manager => manager.AddToRoleAsync(It.IsAny<IdentityUser>(), AppRoles.Doctor)).ReturnsAsync(IdentityResult.Success);
    }

    private static CreateDoctorDto CreateDoctorDto() => new()
    {
        FullName = "Dr. Admin Test",
        Email = "doctor@test.com",
        PhoneNumber = "9999999999",
        Password = "Password@123",
        Specialisation = DoctorSpecialisation.Cardiology,
        PracticeStartDate = new DateOnly(2015, 1, 1),
        ConsultationFee = 600,
        IsAvailable = true
    };

    private static UpdateDoctorDto CreateUpdateDoctorDto() => new()
    {
        FullName = "Updated Doctor",
        Email = "updated.doctor@test.com",
        PhoneNumber = "9999999999",
        Specialisation = DoctorSpecialisation.Dermatology,
        PracticeStartDate = new DateOnly(2018, 1, 1),
        ConsultationFee = 700
    };

    private static UpdatePatientDto CreateUpdatePatientDto() => new()
    {
        FullName = "Updated Patient",
        Email = "updated.patient@test.com",
        PhoneNumber = "9999999998",
        DateOfBirth = new DateOnly(1995, 1, 1),
        Gender = "Female",
        Address = "Updated address"
    };

    private static AdminResetPasswordDto CreateResetPasswordDto() => new()
    {
        NewPassword = "New@12345",
        ConfirmNewPassword = "New@12345"
    };

    private static PaginationQueryDto CreatePagination() => new() { PageNumber = 1, PageSize = 10 };

    private static Doctor CreateDoctor(int id, bool isAvailable) => new()
    {
        Id = id,
        UserId = $"doctor-user-id-{id}",
        FullName = "Doctor Test",
        Specialisation = DoctorSpecialisation.Cardiology,
        PracticeStartDate = new DateOnly(2015, 1, 1),
        ConsultationFee = 600,
        IsAvailable = isAvailable
    };

    private static Doctor CreateDoctorWithUser(int id = 1, string userId = "doctor-user-id", string email = "doctor@test.com", string phoneNumber = "9999999999")
    {
        var doctor = CreateDoctor(id, true);
        doctor.UserId = userId;
        doctor.User = new IdentityUser { Id = userId, UserName = email, Email = email, PhoneNumber = phoneNumber, EmailConfirmed = true };
        return doctor;
    }

    private static Patient CreatePatient(int id) => new()
    {
        Id = id,
        UserId = $"patient-user-id-{id}",
        FullName = "Patient Test",
        DateOfBirth = new DateOnly(1990, 1, 1),
        Gender = "Male",
        Address = "Patient address"
    };

    private static Patient CreatePatientWithUser(int id = 1, string userId = "patient-user-id", string email = "patient@test.com", string phoneNumber = "9999999998")
    {
        var patient = CreatePatient(id);
        patient.UserId = userId;
        patient.User = new IdentityUser { Id = userId, UserName = email, Email = email, PhoneNumber = phoneNumber, EmailConfirmed = true };
        return patient;
    }

    private static Appointment CreateAppointment(int id, DateOnly date, AppointmentStatus status) => new()
    {
        Id = id,
        PatientId = 1,
        DoctorId = 1,
        AppointmentDate = date,
        AppointmentTime = new TimeOnly(10, 0),
        Status = status
    };

    private static DoctorDto CreateDoctorDtoFromDoctor(Doctor doctor) => new()
    {
        Id = doctor.Id,
        UserId = doctor.UserId,
        FullName = doctor.FullName,
        Email = doctor.User?.Email ?? string.Empty,
        PhoneNumber = doctor.User?.PhoneNumber ?? string.Empty,
        Specialisation = doctor.Specialisation,
        ConsultationFee = doctor.ConsultationFee,
        IsAvailable = doctor.IsAvailable
    };

    private static PatientDto CreatePatientDtoFromPatient(Patient patient) => new()
    {
        Id = patient.Id,
        UserId = patient.UserId,
        FullName = patient.FullName,
        Email = patient.User?.Email ?? string.Empty,
        PhoneNumber = patient.User?.PhoneNumber ?? string.Empty,
        DateOfBirth = patient.DateOfBirth,
        Gender = patient.Gender,
        Address = patient.Address
    };

    private static PagedResult<T> CreatePagedResult<T>(List<T> items) => new()
    {
        Items = items,
        PageNumber = 1,
        PageSize = 10,
        TotalCount = items.Count,
        TotalPages = items.Count == 0 ? 0 : 1
    };

    private static HealthAxisDbContext CreateDbContext()
    {
        var options = new DbContextOptionsBuilder<HealthAxisDbContext>()
            .UseInMemoryDatabase(Guid.NewGuid().ToString())
            .ConfigureWarnings(warnings => warnings.Ignore(InMemoryEventId.TransactionIgnoredWarning))
            .Options;

        return new HealthAxisDbContext(options);
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
            logger.Object);
    }
}
