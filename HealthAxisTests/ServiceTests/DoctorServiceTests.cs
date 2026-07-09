using AutoMapper;
using HealthAxis.API.Constants;
using HealthAxis.API.Exceptions;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using HealthAxis.API.Services;
using HealthAxis.API.Services.Impl;
using HealthAxis.Shared.Constants;
using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Dtos.Doctor;
using HealthAxis.Shared.Enums;
using Microsoft.AspNetCore.Identity;
using Moq;

namespace HealthAxisTests.ServiceTests;

public class DoctorServiceTests
{
    private readonly Mock<IDoctorRepository> _doctorRepositoryMock;
    private readonly Mock<IAppointmentRepository> _appointmentRepositoryMock;
    private readonly Mock<IMapper> _mapperMock;
    private readonly Mock<IDoctorAvailabilityCacheService> _availabilityCacheServiceMock;
    private readonly DoctorService _doctorService;

    public DoctorServiceTests()
    {
        _doctorRepositoryMock = new Mock<IDoctorRepository>();
        _appointmentRepositoryMock = new Mock<IAppointmentRepository>();
        _mapperMock = new Mock<IMapper>();
        _availabilityCacheServiceMock = new Mock<IDoctorAvailabilityCacheService>();

        _availabilityCacheServiceMock
            .Setup(service => service.GetDoctorSlotsAsync(It.IsAny<int>(), It.IsAny<DateOnly>()))
            .ReturnsAsync((DoctorAvailableSlotsDto?)null);

        _availabilityCacheServiceMock
            .Setup(service => service.SetDoctorSlotsAsync(
                It.IsAny<int>(),
                It.IsAny<DateOnly>(),
                It.IsAny<DoctorAvailableSlotsDto>()))
            .Returns(Task.CompletedTask);

        _availabilityCacheServiceMock
            .Setup(service => service.RemoveDoctorSlotsAsync(
                It.IsAny<int>(),
                It.IsAny<DateOnly>()))
            .Returns(Task.CompletedTask);

        _availabilityCacheServiceMock
            .Setup(service => service.RemoveDoctorAvailabilityRangeAsync(
                It.IsAny<int>(),
                It.IsAny<int>()))
            .Returns(Task.CompletedTask);

        _doctorService = new DoctorService(
            _doctorRepositoryMock.Object,
            _mapperMock.Object,
            _appointmentRepositoryMock.Object,
            _availabilityCacheServiceMock.Object);
    }

    [Fact]
    public async Task GetAllDoctorsAsync_WhenDoctorsExist_ShouldReturnPagedPublicDoctorDtos()
    {
        var doctors = new List<Doctor> { CreateDoctor(isAvailable: true) };
        var pagedDoctors = CreatePagedDoctorResult(doctors);
        var mappedDoctorDtos = new List<PublicDoctorDto> { CreatePublicDoctorDto(doctors[0]) };
        var query = CreateDoctorSearchQuery();

        _doctorRepositoryMock
            .Setup(repo => repo.GetAllDoctorsAsync(query.PageNumber, query.PageSize, query.Search, query.Specialisation, query.IsAvailable, query.SortBy, query.SortDirection))
            .ReturnsAsync(pagedDoctors);
        _mapperMock.Setup(mapper => mapper.Map<List<PublicDoctorDto>>(doctors)).Returns(mappedDoctorDtos);

        var result = await _doctorService.GetAllDoctorsAsync(query);

        Assert.Single(result.Items);
        Assert.Equal(1, result.Items[0].Id);
        Assert.Equal(1, result.TotalCount);
    }

    [Fact]
    public async Task GetAllDoctorsAsync_WhenNoDoctorsExist_ShouldReturnEmptyPagedResult()
    {
        var doctors = new List<Doctor>();
        var query = CreateDoctorSearchQuery();
        _doctorRepositoryMock
            .Setup(repo => repo.GetAllDoctorsAsync(query.PageNumber, query.PageSize, query.Search, query.Specialisation, query.IsAvailable, query.SortBy, query.SortDirection))
            .ReturnsAsync(CreatePagedDoctorResult(doctors));
        _mapperMock.Setup(mapper => mapper.Map<List<PublicDoctorDto>>(doctors)).Returns([]);

        var result = await _doctorService.GetAllDoctorsAsync(query);

        Assert.Empty(result.Items);
        Assert.Equal(0, result.TotalCount);
        Assert.Equal(0, result.TotalPages);
    }

    [Fact]
    public async Task GetDoctorByIdAsync_WhenDoctorExists_ShouldReturnPublicDoctorDto()
    {
        var doctor = CreateDoctor(isAvailable: true);
        var mappedDoctorDto = CreatePublicDoctorDto(doctor);
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdAsync(1)).ReturnsAsync(doctor);
        _mapperMock.Setup(mapper => mapper.Map<PublicDoctorDto>(doctor)).Returns(mappedDoctorDto);

        var result = await _doctorService.GetDoctorByIdAsync(1);

        Assert.NotNull(result);
        Assert.Equal(1, result!.Id);
    }

    [Fact]
    public async Task GetDoctorByIdAsync_WhenDoctorDoesNotExist_ShouldReturnNull()
    {
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdAsync(99)).ReturnsAsync((Doctor?)null);

        var result = await _doctorService.GetDoctorByIdAsync(99);

        Assert.Null(result);
    }

    [Fact]
    public async Task GetDoctorByUserIdAsync_WhenDoctorExists_ShouldReturnPublicDoctorDto()
    {
        var doctor = CreateDoctor(isAvailable: true);
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByUserIdAsync("doctor-user-id-1")).ReturnsAsync(doctor);
        _mapperMock.Setup(mapper => mapper.Map<PublicDoctorDto>(doctor)).Returns(CreatePublicDoctorDto(doctor));

        var result = await _doctorService.GetDoctorByUserIdAsync("doctor-user-id-1");

        Assert.NotNull(result);
        Assert.Equal(doctor.Id, result!.Id);
    }

    [Fact]
    public async Task GetDoctorByUserIdAsync_WhenDoctorDoesNotExist_ShouldReturnNull()
    {
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByUserIdAsync("missing")).ReturnsAsync((Doctor?)null);

        var result = await _doctorService.GetDoctorByUserIdAsync("missing");

        Assert.Null(result);
    }

    [Fact]
    public async Task GetDoctorProfileByIdAsync_WhenDoctorExists_ShouldReturnDoctorDto()
    {
        var doctor = CreateDoctor(isAvailable: true);
        doctor.User = new IdentityUser { Id = doctor.UserId, Email = "doctor@test.com", PhoneNumber = "9999999999" };
        var dto = new DoctorDto { Id = doctor.Id, UserId = doctor.UserId, FullName = doctor.FullName, Email = "doctor@test.com", PhoneNumber = "9999999999" };
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdWithUserAsync(1)).ReturnsAsync(doctor);
        _mapperMock.Setup(mapper => mapper.Map<DoctorDto>(doctor)).Returns(dto);

        var result = await _doctorService.GetDoctorProfileByIdAsync(1);

        Assert.NotNull(result);
        Assert.Equal("doctor@test.com", result!.Email);
    }

    [Fact]
    public async Task GetDoctorProfileByIdAsync_WhenDoctorMissing_ShouldReturnNull()
    {
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdWithUserAsync(99)).ReturnsAsync((Doctor?)null);

        var result = await _doctorService.GetDoctorProfileByIdAsync(99);

        Assert.Null(result);
    }

    [Theory]
    [InlineData(true, ErrorMessages.DoctorAvailableMessage)]
    [InlineData(false, ErrorMessages.DoctorUnavailableMessage)]
    public async Task GetAvailabilityAsync_WhenDoctorExists_ShouldReturnAvailabilityDto(bool isAvailable, string expectedMessage)
    {
        _doctorRepositoryMock.Setup(repo => repo.GetAvailabilityAsync(1)).ReturnsAsync(isAvailable);

        var result = await _doctorService.GetAvailabilityAsync(1);

        Assert.NotNull(result);
        Assert.Equal(isAvailable, result!.IsAvailable);
        Assert.Equal(expectedMessage, result.Message);
    }

    [Fact]
    public async Task GetAvailabilityAsync_WhenDoctorDoesNotExist_ShouldReturnNull()
    {
        _doctorRepositoryMock.Setup(repo => repo.GetAvailabilityAsync(99)).ReturnsAsync((bool?)null);

        var result = await _doctorService.GetAvailabilityAsync(99);

        Assert.Null(result);
    }

    [Fact]
    public async Task GetDoctorSlotsAsync_WhenCachedSlotsExist_ShouldReturnCachedSlots()
    {
        var date = DateOnly.FromDateTime(DateTime.Today.AddDays(5));
        var cachedSlots = new DoctorAvailableSlotsDto
        {
            DoctorId = 1,
            DoctorName = "Cached Doctor",
            IsAvailable = true,
            AvailableSlots = [new TimeOnly(10, 0)]
        };

        _availabilityCacheServiceMock
            .Setup(service => service.GetDoctorSlotsAsync(1, date))
            .ReturnsAsync(cachedSlots);

        var result = await _doctorService.GetDoctorSlotsAsync(1, date);

        Assert.Equal(cachedSlots, result);
        _doctorRepositoryMock.Verify(repo => repo.GetDoctorByIdAsync(It.IsAny<int>()), Times.Never);
        _appointmentRepositoryMock.Verify(repo => repo.GetNonCancelledAppointmentsByDoctorIdAndDateAsync(It.IsAny<int>(), It.IsAny<DateOnly>()), Times.Never);
    }

    [Fact]
    public async Task GetDoctorSlotsAsync_WhenDoctorDoesNotExist_ShouldThrowNotFoundException()
    {
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdAsync(99)).ReturnsAsync((Doctor?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() => _doctorService.GetDoctorSlotsAsync(99, DateOnly.FromDateTime(DateTime.Today.AddDays(5))));

        Assert.Equal(ErrorMessages.DoctorNotFound, exception.Message);
    }

    [Fact]
    public async Task GetDoctorSlotsAsync_WhenDoctorIsAvailable_ShouldExcludeLunchAndBookedSlotsAndCacheResult()
    {
        var date = DateOnly.FromDateTime(DateTime.Today.AddDays(5));
        var doctor = CreateDoctor(isAvailable: true);
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdAsync(1)).ReturnsAsync(doctor);
        _appointmentRepositoryMock.Setup(repo => repo.GetNonCancelledAppointmentsByDoctorIdAndDateAsync(1, date)).ReturnsAsync([
            new Appointment { DoctorId = 1, AppointmentDate = date, AppointmentTime = new TimeOnly(9, 0), Status = AppointmentStatus.Confirmed }
        ]);

        var result = await _doctorService.GetDoctorSlotsAsync(1, date);

        Assert.DoesNotContain(new TimeOnly(9, 0), result.AvailableSlots);
        Assert.DoesNotContain(new TimeOnly(12, 0), result.AvailableSlots);
        Assert.Contains(new TimeOnly(9, 30), result.AvailableSlots);
        _availabilityCacheServiceMock.Verify(service => service.SetDoctorSlotsAsync(1, date, It.IsAny<DoctorAvailableSlotsDto>()), Times.Once);
    }

    [Fact]
    public async Task GetDoctorSlotsAsync_WhenDoctorIsUnavailable_ShouldReturnNoSlots()
    {
        var date = DateOnly.FromDateTime(DateTime.Today.AddDays(5));
        var doctor = CreateDoctor(isAvailable: false);
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdAsync(1)).ReturnsAsync(doctor);
        _appointmentRepositoryMock.Setup(repo => repo.GetNonCancelledAppointmentsByDoctorIdAndDateAsync(1, date)).ReturnsAsync([]);

        var result = await _doctorService.GetDoctorSlotsAsync(1, date);

        Assert.Empty(result.AvailableSlots);
    }

    [Fact]
    public async Task GetAvailableSlotsAsync_ShouldReturnOnlyDoctorsWithAvailableSlotsAndApplyPagination()
    {
        var date = DateOnly.FromDateTime(DateTime.Today.AddDays(5));
        var doctors = new List<Doctor>
        {
            CreateDoctor(id: 1, isAvailable: true),
            CreateDoctor(id: 2, isAvailable: true),
            CreateDoctor(id: 3, isAvailable: true)
        };
        _doctorRepositoryMock.Setup(repo => repo.GetAvailableDoctorsAsync(null)).ReturnsAsync(doctors);
        _appointmentRepositoryMock
            .Setup(repo => repo.GetNonCancelledAppointmentsByDoctorIdAndDateAsync(It.IsAny<int>(), date))
            .ReturnsAsync([]);

        var result = await _doctorService.GetAvailableSlotsAsync(date, null, new PaginationQueryDto { PageNumber = 2, PageSize = 2 });

        Assert.Single(result.Items);
        Assert.Equal(3, result.TotalCount);
        Assert.Equal(2, result.TotalPages);
        Assert.Equal(2, result.PageNumber);
    }

    [Fact]
    public async Task GetAvailableSlotsAsync_WhenDateIsTooSoon_ShouldReturnNoDoctorsWithSlots()
    {
        var date = DateOnly.FromDateTime(DateTime.Today);
        _doctorRepositoryMock.Setup(repo => repo.GetAvailableDoctorsAsync(null)).ReturnsAsync([CreateDoctor(isAvailable: true)]);
        _appointmentRepositoryMock
            .Setup(repo => repo.GetNonCancelledAppointmentsByDoctorIdAndDateAsync(It.IsAny<int>(), date))
            .ReturnsAsync([]);

        var result = await _doctorService.GetAvailableSlotsAsync(date, null, new PaginationQueryDto { PageNumber = 1, PageSize = 10 });

        Assert.Empty(result.Items);
        Assert.Equal(0, result.TotalCount);
        Assert.Equal(0, result.TotalPages);
    }

    [Fact]
    public async Task UpdateAvailabilityAsync_WhenDoctorDoesNotExist_ShouldThrowNotFoundException()
    {
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdAsync(99)).ReturnsAsync((Doctor?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() => _doctorService.UpdateAvailabilityAsync(99, new UpdateDoctorAvailabilityDto { IsAvailable = false }, AppRoles.Doctor, 99));

        Assert.Equal(ErrorMessages.DoctorNotFound, exception.Message);
    }

    [Fact]
    public async Task UpdateAvailabilityAsync_WhenDoctorUpdatesAnotherDoctor_ShouldThrowForbiddenException()
    {
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdAsync(1)).ReturnsAsync(CreateDoctor(isAvailable: true));

        var exception = await Assert.ThrowsAsync<ForbiddenException>(() => _doctorService.UpdateAvailabilityAsync(1, new UpdateDoctorAvailabilityDto { IsAvailable = false }, AppRoles.Doctor, 99));

        Assert.Equal(ErrorMessages.DoctorsCanUpdateOnlyOwnAvailability, exception.Message);
    }

    [Fact]
    public async Task UpdateAvailabilityAsync_WhenUnsupportedRoleUpdatesAvailability_ShouldThrowForbiddenException()
    {
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdAsync(1)).ReturnsAsync(CreateDoctor(isAvailable: true));

        var exception = await Assert.ThrowsAsync<ForbiddenException>(() => _doctorService.UpdateAvailabilityAsync(1, new UpdateDoctorAvailabilityDto { IsAvailable = false }, AppRoles.Patient, null));

        Assert.Equal(ErrorMessages.UnsupportedAppointmentStatusTransition, exception.Message);
    }

    [Fact]
    public async Task UpdateAvailabilityAsync_WhenUpdateReturnsNull_ShouldThrowNotFoundException()
    {
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdAsync(1)).ReturnsAsync(CreateDoctor(isAvailable: false));
        _doctorRepositoryMock.Setup(repo => repo.UpdateAsync(It.IsAny<Doctor>())).ReturnsAsync((Doctor?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() => _doctorService.UpdateAvailabilityAsync(1, new UpdateDoctorAvailabilityDto { IsAvailable = true }, AppRoles.Admin, null));

        Assert.Equal(ErrorMessages.DoctorNotFound, exception.Message);
    }

    [Fact]
    public async Task UpdateAvailabilityAsync_WhenDoctorActivatesSelf_ShouldUpdateAvailabilityAndInvalidateCache()
    {
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdAsync(1)).ReturnsAsync(CreateDoctor(isAvailable: false));
        _doctorRepositoryMock.Setup(repo => repo.UpdateAsync(It.IsAny<Doctor>())).ReturnsAsync(CreateDoctor(isAvailable: true));

        var result = await _doctorService.UpdateAvailabilityAsync(1, new UpdateDoctorAvailabilityDto { IsAvailable = true }, AppRoles.Doctor, 1);

        Assert.True(result.IsAvailable);
        _appointmentRepositoryMock.Verify(repo => repo.DoctorHasConfirmedAppointmentsOnDateAsync(It.IsAny<int>(), It.IsAny<DateOnly>()), Times.Never);
        _availabilityCacheServiceMock.Verify(service => service.RemoveDoctorAvailabilityRangeAsync(1, 6), Times.Once);
    }

    [Fact]
    public async Task UpdateAvailabilityAsync_WhenDoctorDeactivatesSelfWithoutConfirmedAppointmentsToday_ShouldUpdateAvailability()
    {
        var today = DateOnly.FromDateTime(DateTime.Today);
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdAsync(1)).ReturnsAsync(CreateDoctor(isAvailable: true));
        _appointmentRepositoryMock.Setup(repo => repo.DoctorHasConfirmedAppointmentsOnDateAsync(1, today)).ReturnsAsync(false);
        _doctorRepositoryMock.Setup(repo => repo.UpdateAsync(It.IsAny<Doctor>())).ReturnsAsync(CreateDoctor(isAvailable: false));

        var result = await _doctorService.UpdateAvailabilityAsync(1, new UpdateDoctorAvailabilityDto { IsAvailable = false }, AppRoles.Doctor, 1);

        Assert.False(result.IsAvailable);
        _availabilityCacheServiceMock.Verify(service => service.RemoveDoctorAvailabilityRangeAsync(1, 6), Times.Once);
    }

    [Fact]
    public async Task UpdateAvailabilityAsync_WhenDoctorDeactivatesSelfWithConfirmedAppointmentsToday_ShouldThrowBusinessRuleException()
    {
        var today = DateOnly.FromDateTime(DateTime.Today);
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdAsync(1)).ReturnsAsync(CreateDoctor(isAvailable: true));
        _appointmentRepositoryMock.Setup(repo => repo.DoctorHasConfirmedAppointmentsOnDateAsync(1, today)).ReturnsAsync(true);

        var exception = await Assert.ThrowsAsync<BusinessRuleException>(() => _doctorService.UpdateAvailabilityAsync(1, new UpdateDoctorAvailabilityDto { IsAvailable = false }, AppRoles.Doctor, 1));

        Assert.Equal(ErrorMessages.DoctorCannotDeactivateWithConfirmedAppointmentsToday, exception.Message);
        _availabilityCacheServiceMock.Verify(service => service.RemoveDoctorAvailabilityRangeAsync(It.IsAny<int>(), It.IsAny<int>()), Times.Never);
    }

    [Fact]
    public async Task UpdateAvailabilityAsync_WhenAdminDeactivatesDoctor_ShouldCancelTodaysPendingAndConfirmedAppointments()
    {
        var today = DateOnly.FromDateTime(DateTime.Today);
        var appointments = new List<Appointment>
        {
            new() { Id = 10, DoctorId = 1, AppointmentDate = today, Status = AppointmentStatus.Pending },
            new() { Id = 11, DoctorId = 1, AppointmentDate = today, Status = AppointmentStatus.Confirmed }
        };
        _doctorRepositoryMock.Setup(repo => repo.GetDoctorByIdAsync(1)).ReturnsAsync(CreateDoctor(isAvailable: true));
        _appointmentRepositoryMock.Setup(repo => repo.GetPendingOrConfirmedAppointmentsByDoctorIdAndDateAsync(1, today)).ReturnsAsync(appointments);
        _appointmentRepositoryMock.Setup(repo => repo.UpdateAsync(It.IsAny<Appointment>())).ReturnsAsync((Appointment appointment) => appointment);
        _doctorRepositoryMock.Setup(repo => repo.UpdateAsync(It.IsAny<Doctor>())).ReturnsAsync(CreateDoctor(isAvailable: false));

        var result = await _doctorService.UpdateAvailabilityAsync(1, new UpdateDoctorAvailabilityDto { IsAvailable = false }, AppRoles.Admin, null);

        Assert.False(result.IsAvailable);
        _appointmentRepositoryMock.Verify(repo => repo.UpdateAsync(It.Is<Appointment>(appointment =>
            appointment.Status == AppointmentStatus.Cancelled &&
            appointment.CancellationReason == ErrorMessages.DoctorEmergencyCancellationReason)), Times.Exactly(2));
        _availabilityCacheServiceMock.Verify(service => service.RemoveDoctorAvailabilityRangeAsync(1, 6), Times.Once);
    }

    private static DoctorSearchQueryDto CreateDoctorSearchQuery() => new()
    {
        PageNumber = 1,
        PageSize = 10,
        Search = null,
        Specialisation = null,
        IsAvailable = null,
        SortBy = DoctorSortBy.Name,
        SortDirection = SortDirection.Asc
    };

    private static PagedResult<Doctor> CreatePagedDoctorResult(List<Doctor> doctors) => new()
    {
        Items = doctors,
        PageNumber = 1,
        PageSize = 10,
        TotalCount = doctors.Count,
        TotalPages = doctors.Count == 0 ? 0 : 1
    };

    private static Doctor CreateDoctor(int id = 1, bool isAvailable = true) => new()
    {
        Id = id,
        UserId = $"doctor-user-id-{id}",
        FullName = "Dr. Anjali Menon",
        Specialisation = DoctorSpecialisation.Cardiology,
        PracticeStartDate = new DateOnly(2015, 1, 1),
        ConsultationFee = 600,
        IsAvailable = isAvailable
    };

    private static PublicDoctorDto CreatePublicDoctorDto(Doctor doctor) => new()
    {
        Id = doctor.Id,
        FullName = doctor.FullName,
        Specialisation = doctor.Specialisation,
        YearsOfExperience = 10,
        ConsultationFee = doctor.ConsultationFee,
        IsAvailable = doctor.IsAvailable
    };
}
