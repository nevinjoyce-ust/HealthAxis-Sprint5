using AutoMapper;
using HealthAxis.API.Constants;
using HealthAxis.API.Exceptions;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
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
    private readonly Mock<IDoctorRepository> _doctorRepositoryMock = new();
    private readonly Mock<IAppointmentRepository> _appointmentRepositoryMock = new();
    private readonly Mock<IMapper> _mapperMock = new();
    private readonly DoctorService _doctorService;

    public DoctorServiceTests()
    {
        _doctorService = new DoctorService(
            _doctorRepositoryMock.Object,
            _mapperMock.Object,
            _appointmentRepositoryMock.Object);
    }

    [Fact]
    public async Task GetAllDoctorsAsync_WhenDoctorsExist_ShouldReturnPagedPublicDoctorDtos()
    {
        var doctors = new List<Doctor> { CreateDoctor() };
        var query = CreateDoctorSearchQuery();
        var mappedDtos = new List<PublicDoctorDto> { CreatePublicDoctorDto(doctors[0]) };

        _doctorRepositoryMock
            .Setup(repository => repository.GetAllDoctorsAsync(
                query.PageNumber, query.PageSize, query.Search,
                query.Specialisation, query.IsAvailable,
                query.SortBy, query.SortDirection))
            .ReturnsAsync(CreatePagedDoctorResult(doctors));
        _mapperMock.Setup(mapper => mapper.Map<List<PublicDoctorDto>>(doctors))
            .Returns(mappedDtos);

        var result = await _doctorService.GetAllDoctorsAsync(query);

        Assert.Single(result.Items);
        Assert.Equal(1, result.TotalCount);
    }

    [Fact]
    public async Task GetAllDoctorsAsync_WhenNoDoctorsExist_ShouldReturnEmptyPagedResult()
    {
        var doctors = new List<Doctor>();
        var query = CreateDoctorSearchQuery();

        _doctorRepositoryMock
            .Setup(repository => repository.GetAllDoctorsAsync(
                query.PageNumber, query.PageSize, query.Search,
                query.Specialisation, query.IsAvailable,
                query.SortBy, query.SortDirection))
            .ReturnsAsync(CreatePagedDoctorResult(doctors));
        _mapperMock.Setup(mapper => mapper.Map<List<PublicDoctorDto>>(doctors))
            .Returns([]);

        var result = await _doctorService.GetAllDoctorsAsync(query);

        Assert.Empty(result.Items);
        Assert.Equal(0, result.TotalPages);
    }

    [Fact]
    public async Task GetDoctorByIdAsync_WhenDoctorExists_ShouldReturnDto()
    {
        var doctor = CreateDoctor();
        _doctorRepositoryMock.Setup(repository => repository.GetDoctorByIdAsync(1))
            .ReturnsAsync(doctor);
        _mapperMock.Setup(mapper => mapper.Map<PublicDoctorDto>(doctor))
            .Returns(CreatePublicDoctorDto(doctor));

        var result = await _doctorService.GetDoctorByIdAsync(1);

        Assert.NotNull(result);
        Assert.Equal(1, result.Id);
    }

    [Fact]
    public async Task GetDoctorByIdAsync_WhenDoctorMissing_ShouldReturnNull()
    {
        _doctorRepositoryMock.Setup(repository => repository.GetDoctorByIdAsync(99))
            .ReturnsAsync((Doctor?)null);

        Assert.Null(await _doctorService.GetDoctorByIdAsync(99));
    }

    [Fact]
    public async Task GetDoctorByUserIdAsync_WhenDoctorExists_ShouldReturnDto()
    {
        var doctor = CreateDoctor();
        _doctorRepositoryMock.Setup(repository => repository.GetDoctorByUserIdAsync(doctor.UserId))
            .ReturnsAsync(doctor);
        _mapperMock.Setup(mapper => mapper.Map<PublicDoctorDto>(doctor))
            .Returns(CreatePublicDoctorDto(doctor));

        var result = await _doctorService.GetDoctorByUserIdAsync(doctor.UserId);

        Assert.NotNull(result);
        Assert.Equal(doctor.Id, result.Id);
    }

    [Fact]
    public async Task GetDoctorProfileByIdAsync_WhenDoctorExists_ShouldReturnDoctorDto()
    {
        var doctor = CreateDoctor();
        doctor.User = new IdentityUser
        {
            Id = doctor.UserId,
            Email = "doctor@test.com",
            PhoneNumber = "9999999999"
        };
        var dto = new DoctorDto
        {
            Id = doctor.Id,
            UserId = doctor.UserId,
            FullName = doctor.FullName,
            Email = doctor.User.Email,
            PhoneNumber = doctor.User.PhoneNumber
        };
        _doctorRepositoryMock.Setup(repository => repository.GetDoctorByIdWithUserAsync(1))
            .ReturnsAsync(doctor);
        _mapperMock.Setup(mapper => mapper.Map<DoctorDto>(doctor)).Returns(dto);

        var result = await _doctorService.GetDoctorProfileByIdAsync(1);

        Assert.NotNull(result);
        Assert.Equal("doctor@test.com", result.Email);
    }

    [Theory]
    [InlineData(true, ErrorMessages.DoctorAvailableMessage)]
    [InlineData(false, ErrorMessages.DoctorUnavailableMessage)]
    public async Task GetAvailabilityAsync_WhenDoctorExists_ShouldReturnAvailability(
        bool isAvailable, string expectedMessage)
    {
        _doctorRepositoryMock.Setup(repository => repository.GetAvailabilityAsync(1))
            .ReturnsAsync(isAvailable);

        var result = await _doctorService.GetAvailabilityAsync(1);

        Assert.NotNull(result);
        Assert.Equal(isAvailable, result.IsAvailable);
        Assert.Equal(expectedMessage, result.Message);
    }

    [Fact]
    public async Task GetDoctorSlotsAsync_WhenDoctorMissing_ShouldThrowNotFoundException()
    {
        _doctorRepositoryMock.Setup(repository => repository.GetDoctorByIdAsync(99))
            .ReturnsAsync((Doctor?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() =>
            _doctorService.GetDoctorSlotsAsync(
                99, DateOnly.FromDateTime(DateTime.Today.AddDays(5))));

        Assert.Equal(ErrorMessages.DoctorNotFound, exception.Message);
    }

    [Fact]
    public async Task GetDoctorSlotsAsync_WhenDoctorAvailable_ShouldReadAppointmentsAndBuildSlots()
    {
        var date = DateOnly.FromDateTime(DateTime.Today.AddDays(5));
        var doctor = CreateDoctor();
        _doctorRepositoryMock.Setup(repository => repository.GetDoctorByIdAsync(1))
            .ReturnsAsync(doctor);
        _appointmentRepositoryMock
            .Setup(repository => repository.GetNonCancelledAppointmentsByDoctorIdAndDateAsync(1, date))
            .ReturnsAsync([
                new Appointment
                {
                    DoctorId = 1,
                    AppointmentDate = date,
                    AppointmentTime = new TimeOnly(9, 0),
                    Status = AppointmentStatus.Confirmed
                }
            ]);

        var result = await _doctorService.GetDoctorSlotsAsync(1, date);

        Assert.DoesNotContain(new TimeOnly(9, 0), result.AvailableSlots);
        Assert.DoesNotContain(new TimeOnly(12, 0), result.AvailableSlots);
        Assert.Contains(new TimeOnly(9, 30), result.AvailableSlots);
        _appointmentRepositoryMock.Verify(repository =>
            repository.GetNonCancelledAppointmentsByDoctorIdAndDateAsync(1, date), Times.Once);
    }

    [Fact]
    public async Task GetDoctorSlotsAsync_WhenDoctorUnavailable_ShouldReturnNoSlots()
    {
        var date = DateOnly.FromDateTime(DateTime.Today.AddDays(5));
        var doctor = CreateDoctor(isAvailable: false);
        _doctorRepositoryMock.Setup(repository => repository.GetDoctorByIdAsync(1))
            .ReturnsAsync(doctor);
        _appointmentRepositoryMock
            .Setup(repository => repository.GetNonCancelledAppointmentsByDoctorIdAndDateAsync(1, date))
            .ReturnsAsync([]);

        var result = await _doctorService.GetDoctorSlotsAsync(1, date);

        Assert.Empty(result.AvailableSlots);
    }

    [Fact]
    public async Task GetAvailableSlotsAsync_ShouldReturnDoctorsWithSlotsAndApplyPagination()
    {
        var date = DateOnly.FromDateTime(DateTime.Today.AddDays(5));
        var doctors = new List<Doctor>
        {
            CreateDoctor(1), CreateDoctor(2), CreateDoctor(3)
        };
        _doctorRepositoryMock.Setup(repository => repository.GetAvailableDoctorsAsync(null))
            .ReturnsAsync(doctors);
        _appointmentRepositoryMock
            .Setup(repository => repository.GetNonCancelledAppointmentsByDoctorIdAndDateAsync(
                It.IsAny<int>(), date))
            .ReturnsAsync([]);

        var result = await _doctorService.GetAvailableSlotsAsync(
            date, null, new PaginationQueryDto { PageNumber = 2, PageSize = 2 });

        Assert.Single(result.Items);
        Assert.Equal(3, result.TotalCount);
        Assert.Equal(2, result.TotalPages);
    }

    [Fact]
    public async Task UpdateAvailabilityAsync_WhenDoctorMissing_ShouldThrowNotFoundException()
    {
        _doctorRepositoryMock.Setup(repository => repository.GetDoctorByIdAsync(99))
            .ReturnsAsync((Doctor?)null);

        await Assert.ThrowsAsync<NotFoundException>(() =>
            _doctorService.UpdateAvailabilityAsync(
                99, new UpdateDoctorAvailabilityDto { IsAvailable = false },
                AppRoles.Doctor, 99));
    }

    [Fact]
    public async Task UpdateAvailabilityAsync_WhenDoctorActivatesSelf_ShouldUpdateAvailability()
    {
        _doctorRepositoryMock.Setup(repository => repository.GetDoctorByIdAsync(1))
            .ReturnsAsync(CreateDoctor(isAvailable: false));
        _doctorRepositoryMock.Setup(repository => repository.UpdateAsync(It.IsAny<Doctor>()))
            .ReturnsAsync(CreateDoctor(isAvailable: true));

        var result = await _doctorService.UpdateAvailabilityAsync(
            1, new UpdateDoctorAvailabilityDto { IsAvailable = true },
            AppRoles.Doctor, 1);

        Assert.True(result.IsAvailable);
        _doctorRepositoryMock.Verify(repository => repository.UpdateAsync(
            It.Is<Doctor>(doctor => doctor.IsAvailable)), Times.Once);
    }

    [Fact]
    public async Task UpdateAvailabilityAsync_WhenDoctorDeactivatesWithConfirmedAppointment_ShouldThrow()
    {
        var today = DateOnly.FromDateTime(DateTime.Today);
        _doctorRepositoryMock.Setup(repository => repository.GetDoctorByIdAsync(1))
            .ReturnsAsync(CreateDoctor());
        _appointmentRepositoryMock
            .Setup(repository => repository.DoctorHasConfirmedAppointmentsOnDateAsync(1, today))
            .ReturnsAsync(true);

        var exception = await Assert.ThrowsAsync<BusinessRuleException>(() =>
            _doctorService.UpdateAvailabilityAsync(
                1, new UpdateDoctorAvailabilityDto { IsAvailable = false },
                AppRoles.Doctor, 1));

        Assert.Equal(
            ErrorMessages.DoctorCannotDeactivateWithConfirmedAppointmentsToday,
            exception.Message);
        _doctorRepositoryMock.Verify(repository =>
            repository.UpdateAsync(It.IsAny<Doctor>()), Times.Never);
    }

    [Fact]
    public async Task UpdateAvailabilityAsync_WhenAdminDeactivatesDoctor_ShouldCancelTodaysAppointments()
    {
        var today = DateOnly.FromDateTime(DateTime.Today);
        var appointments = new List<Appointment>
        {
            new() { Id = 10, DoctorId = 1, AppointmentDate = today, Status = AppointmentStatus.Pending },
            new() { Id = 11, DoctorId = 1, AppointmentDate = today, Status = AppointmentStatus.Confirmed }
        };
        _doctorRepositoryMock.Setup(repository => repository.GetDoctorByIdAsync(1))
            .ReturnsAsync(CreateDoctor());
        _appointmentRepositoryMock
            .Setup(repository => repository.GetPendingOrConfirmedAppointmentsByDoctorIdAndDateAsync(1, today))
            .ReturnsAsync(appointments);
        _appointmentRepositoryMock.Setup(repository => repository.UpdateAsync(It.IsAny<Appointment>()))
            .ReturnsAsync((Appointment appointment) => appointment);
        _doctorRepositoryMock.Setup(repository => repository.UpdateAsync(It.IsAny<Doctor>()))
            .ReturnsAsync(CreateDoctor(isAvailable: false));

        var result = await _doctorService.UpdateAvailabilityAsync(
            1, new UpdateDoctorAvailabilityDto { IsAvailable = false },
            AppRoles.Admin, null);

        Assert.False(result.IsAvailable);
        _appointmentRepositoryMock.Verify(repository => repository.UpdateAsync(
            It.Is<Appointment>(appointment =>
                appointment.Status == AppointmentStatus.Cancelled &&
                appointment.CancellationReason == ErrorMessages.DoctorEmergencyCancellationReason)),
            Times.Exactly(2));
    }

    private static DoctorSearchQueryDto CreateDoctorSearchQuery() => new()
    {
        PageNumber = 1,
        PageSize = 10,
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
