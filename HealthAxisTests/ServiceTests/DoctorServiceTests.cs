using AutoMapper;
using HealthAxis.API.Constants;
using HealthAxis.Shared.Constants;
using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Dtos.Doctor;
using HealthAxis.Shared.Enums;
using HealthAxis.API.Exceptions;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using HealthAxis.API.Services.Impl;
using Moq;

namespace HealthAxisTests.ServiceTests;

public class DoctorServiceTests
{
    private readonly Mock<IDoctorRepository> _doctorRepositoryMock;
    private readonly Mock<IAppointmentRepository> _appointmentRepositoryMock;
    private readonly Mock<IMapper> _mapperMock;
    private readonly DoctorService _doctorService;

    public DoctorServiceTests()
    {
        _doctorRepositoryMock = new Mock<IDoctorRepository>();
        _appointmentRepositoryMock = new Mock<IAppointmentRepository>();
        _mapperMock = new Mock<IMapper>();

        _doctorService = new DoctorService(
            _doctorRepositoryMock.Object,
            _mapperMock.Object,
            _appointmentRepositoryMock.Object
        );
    }

    [Fact]
    public async Task GetAllDoctorsAsync_WhenDoctorsExist_ShouldReturnPagedPublicDoctorDtos()
    {
        // Arrange
        var doctors = new List<Doctor>
    {
        new Doctor
        {
            Id = 1,
            UserId = "doctor-user-id-1",
            FullName = "Dr. Anjali Menon",
            Specialisation = DoctorSpecialisation.Cardiology,
            PracticeStartDate = new DateOnly(2015, 1, 1),
            ConsultationFee = 600,
            IsAvailable = true
        }
    };

        var pagedDoctors = new PagedResult<Doctor>
        {
            Items = doctors,
            PageNumber = 1,
            PageSize = 10,
            TotalCount = 1,
            TotalPages = 1
        };

        var mappedDoctorDtos = new List<PublicDoctorDto>
    {
        new PublicDoctorDto
        {
            Id = 1,
            FullName = "Dr. Anjali Menon",
            Specialisation = DoctorSpecialisation.Cardiology,
            YearsOfExperience = 10,
            ConsultationFee = 600,
            IsAvailable = true
        }
    };

        var pagination = new PaginationQueryDto
        {
            PageNumber = 1,
            PageSize = 10
        };

        _doctorRepositoryMock
            .Setup(repo => repo.GetAllDoctorsAsync(1, 10, null))
            .ReturnsAsync(pagedDoctors);

        _mapperMock
            .Setup(mapper => mapper.Map<List<PublicDoctorDto>>(doctors))
            .Returns(mappedDoctorDtos);

        // Act
        var result = await _doctorService.GetAllDoctorsAsync(pagination, null);

        // Assert
        Assert.NotNull(result);
        Assert.Single(result.Items);
        Assert.Equal(1, result.Items[0].Id);
        Assert.Equal("Dr. Anjali Menon", result.Items[0].FullName);
        Assert.Equal(DoctorSpecialisation.Cardiology, result.Items[0].Specialisation);
        Assert.Equal(10, result.Items[0].YearsOfExperience);
        Assert.Equal(600, result.Items[0].ConsultationFee);
        Assert.True(result.Items[0].IsAvailable);

        Assert.Equal(1, result.PageNumber);
        Assert.Equal(10, result.PageSize);
        Assert.Equal(1, result.TotalCount);
        Assert.Equal(1, result.TotalPages);
        Assert.False(result.HasPreviousPage);
        Assert.False(result.HasNextPage);
    }
    [Fact]
    public async Task GetAllDoctorsAsync_WhenNoDoctorsExist_ShouldReturnEmptyPagedResult()
    {
        // Arrange
        var doctors = new List<Doctor>();

        var pagedDoctors = new PagedResult<Doctor>
        {
            Items = doctors,
            PageNumber = 1,
            PageSize = 10,
            TotalCount = 0,
            TotalPages = 0
        };

        var mappedDoctorDtos = new List<PublicDoctorDto>();

        var pagination = new PaginationQueryDto
        {
            PageNumber = 1,
            PageSize = 10
        };

        _doctorRepositoryMock
            .Setup(repo => repo.GetAllDoctorsAsync(1, 10, null))
            .ReturnsAsync(pagedDoctors);

        _mapperMock
            .Setup(mapper => mapper.Map<List<PublicDoctorDto>>(doctors))
            .Returns(mappedDoctorDtos);

        // Act
        var result = await _doctorService.GetAllDoctorsAsync(pagination, null);

        // Assert
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
    public async Task GetDoctorByIdAsync_WhenDoctorExists_ShouldReturnPublicDoctorDto()
    {
        // Arrange
        var doctor = new Doctor
        {
            Id = 1,
            UserId = "doctor-user-id-1",
            FullName = "Dr. Anjali Menon",
            Specialisation = DoctorSpecialisation.Cardiology,
            PracticeStartDate = new DateOnly(2015, 1, 1),
            ConsultationFee = 600,
            IsAvailable = true
        };

        var mappedDoctorDto = new PublicDoctorDto
        {
            Id = 1,
            FullName = "Dr. Anjali Menon",
            Specialisation = DoctorSpecialisation.Cardiology,
            YearsOfExperience = 10,
            ConsultationFee = 600,
            IsAvailable = true
        };

        _doctorRepositoryMock
            .Setup(repo => repo.GetDoctorByIdAsync(1))
            .ReturnsAsync(doctor);

        _mapperMock
            .Setup(mapper => mapper.Map<PublicDoctorDto>(doctor))
            .Returns(mappedDoctorDto);

        // Act
        var result = await _doctorService.GetDoctorByIdAsync(1);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(1, result!.Id);
        Assert.Equal("Dr. Anjali Menon", result.FullName);
        Assert.Equal(DoctorSpecialisation.Cardiology, result.Specialisation);
        Assert.Equal(10, result.YearsOfExperience);
        Assert.Equal(600, result.ConsultationFee);
        Assert.True(result.IsAvailable);
    }

    [Fact]
    public async Task GetDoctorByIdAsync_WhenDoctorDoesNotExist_ShouldReturnNull()
    {
        // Arrange
        _doctorRepositoryMock
            .Setup(repo => repo.GetDoctorByIdAsync(99))
            .ReturnsAsync((Doctor?)null);

        // Act
        var result = await _doctorService.GetDoctorByIdAsync(99);

        // Assert
        Assert.Null(result);
    }

    [Fact]
    public async Task GetDoctorByUserIdAsync_WhenDoctorExists_ShouldReturnPublicDoctorDto()
    {
        // Arrange
        const string userId = "doctor-user-id-2";

        var doctor = new Doctor
        {
            Id = 1,
            UserId = userId,
            FullName = "Dr. Rahul Nair",
            Specialisation = DoctorSpecialisation.Dermatology,
            PracticeStartDate = new DateOnly(2019, 1, 1),
            ConsultationFee = 500,
            IsAvailable = true
        };

        var mappedDoctorDto = new PublicDoctorDto
        {
            Id = 1,
            FullName = "Dr. Rahul Nair",
            Specialisation = DoctorSpecialisation.Dermatology,
            YearsOfExperience = 6,
            ConsultationFee = 500,
            IsAvailable = true
        };

        _doctorRepositoryMock
            .Setup(repo => repo.GetDoctorByUserIdAsync(userId))
            .ReturnsAsync(doctor);

        _mapperMock
            .Setup(mapper => mapper.Map<PublicDoctorDto>(doctor))
            .Returns(mappedDoctorDto);

        // Act
        var result = await _doctorService.GetDoctorByUserIdAsync(userId);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(doctor.Id, result!.Id);
        Assert.Equal(doctor.FullName, result.FullName);
        Assert.Equal(doctor.Specialisation, result.Specialisation);
        Assert.Equal(6, result.YearsOfExperience);
        Assert.Equal(doctor.ConsultationFee, result.ConsultationFee);
        Assert.Equal(doctor.IsAvailable, result.IsAvailable);
    }

    [Fact]
    public async Task GetDoctorByUserIdAsync_WhenDoctorDoesNotExist_ShouldReturnNull()
    {
        // Arrange
        const string userId = "missing-doctor-user-id";

        _doctorRepositoryMock
            .Setup(repo => repo.GetDoctorByUserIdAsync(userId))
            .ReturnsAsync((Doctor?)null);

        // Act
        var result = await _doctorService.GetDoctorByUserIdAsync(userId);

        // Assert
        Assert.Null(result);
    }

    [Fact]
    public async Task GetAvailabilityAsync_WhenDoctorIsAvailable_ShouldReturnAvailableDto()
    {
        // Arrange
        _doctorRepositoryMock
            .Setup(repo => repo.GetAvailabilityAsync(1))
            .ReturnsAsync(true);

        // Act
        var result = await _doctorService.GetAvailabilityAsync(1);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(1, result!.DoctorId);
        Assert.True(result.IsAvailable);
        Assert.Equal(ErrorMessages.DoctorAvailableMessage, result.Message);
    }

    [Fact]
    public async Task GetAvailabilityAsync_WhenDoctorIsNotAvailable_ShouldReturnUnavailableDto()
    {
        // Arrange
        _doctorRepositoryMock
            .Setup(repo => repo.GetAvailabilityAsync(1))
            .ReturnsAsync(false);

        // Act
        var result = await _doctorService.GetAvailabilityAsync(1);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(1, result!.DoctorId);
        Assert.False(result.IsAvailable);
        Assert.Equal(ErrorMessages.DoctorUnavailableMessage, result.Message);
    }

    [Fact]
    public async Task GetAvailabilityAsync_WhenDoctorDoesNotExist_ShouldReturnNull()
    {
        // Arrange
        _doctorRepositoryMock
            .Setup(repo => repo.GetAvailabilityAsync(99))
            .ReturnsAsync((bool?)null);

        // Act
        var result = await _doctorService.GetAvailabilityAsync(99);

        // Assert
        Assert.Null(result);
    }

    [Fact]
    public async Task UpdateAvailabilityAsync_WhenDoctorDoesNotExist_ShouldThrowNotFoundException()
    {
        // Arrange
        var dto = new UpdateDoctorAvailabilityDto { IsAvailable = false };

        _doctorRepositoryMock
            .Setup(repo => repo.GetDoctorByIdAsync(99))
            .ReturnsAsync((Doctor?)null);

        // Act
        var exception = await Assert.ThrowsAsync<NotFoundException>(() =>
            _doctorService.UpdateAvailabilityAsync(99, dto, AppRoles.Doctor, 99));

        // Assert
        Assert.Equal(ErrorMessages.DoctorNotFound, exception.Message);
    }

    [Fact]
    public async Task UpdateAvailabilityAsync_WhenDoctorUpdatesAnotherDoctor_ShouldThrowForbiddenException()
    {
        // Arrange
        var dto = new UpdateDoctorAvailabilityDto { IsAvailable = false };
        var doctor = CreateDoctor(isAvailable: true);

        _doctorRepositoryMock
            .Setup(repo => repo.GetDoctorByIdAsync(1))
            .ReturnsAsync(doctor);

        // Act
        var exception = await Assert.ThrowsAsync<ForbiddenException>(() =>
            _doctorService.UpdateAvailabilityAsync(1, dto, AppRoles.Doctor, 99));

        // Assert
        Assert.Equal(ErrorMessages.DoctorsCanUpdateOnlyOwnAvailability, exception.Message);
    }

    [Fact]
    public async Task UpdateAvailabilityAsync_WhenDoctorActivatesSelf_ShouldUpdateAvailability()
    {
        // Arrange
        var dto = new UpdateDoctorAvailabilityDto { IsAvailable = true };
        var doctor = CreateDoctor(isAvailable: false);
        var updatedDoctor = CreateDoctor(isAvailable: true);

        _doctorRepositoryMock
            .Setup(repo => repo.GetDoctorByIdAsync(1))
            .ReturnsAsync(doctor);

        _doctorRepositoryMock
            .Setup(repo => repo.UpdateAsync(It.IsAny<Doctor>()))
            .ReturnsAsync(updatedDoctor);

        // Act
        var result = await _doctorService.UpdateAvailabilityAsync(1, dto, AppRoles.Doctor, 1);

        // Assert
        Assert.Equal(1, result.DoctorId);
        Assert.True(result.IsAvailable);
        Assert.Equal(ErrorMessages.DoctorAvailableMessage, result.Message);

        _appointmentRepositoryMock.Verify(
            repo => repo.DoctorHasConfirmedAppointmentsOnDateAsync(It.IsAny<int>(), It.IsAny<DateOnly>()),
            Times.Never);

        _appointmentRepositoryMock.Verify(
            repo => repo.GetPendingOrConfirmedAppointmentsByDoctorIdAndDateAsync(It.IsAny<int>(), It.IsAny<DateOnly>()),
            Times.Never);

        _doctorRepositoryMock.Verify(repo => repo.UpdateAsync(It.Is<Doctor>(updated =>
            updated.Id == 1 && updated.IsAvailable)), Times.Once);
    }

    [Fact]
    public async Task UpdateAvailabilityAsync_WhenDoctorDeactivatesSelfWithoutConfirmedAppointmentsToday_ShouldUpdateAvailability()
    {
        // Arrange
        var dto = new UpdateDoctorAvailabilityDto { IsAvailable = false };
        var doctor = CreateDoctor(isAvailable: true);
        var updatedDoctor = CreateDoctor(isAvailable: false);
        var today = DateOnly.FromDateTime(DateTime.Today);

        _doctorRepositoryMock
            .Setup(repo => repo.GetDoctorByIdAsync(1))
            .ReturnsAsync(doctor);

        _appointmentRepositoryMock
            .Setup(repo => repo.DoctorHasConfirmedAppointmentsOnDateAsync(1, today))
            .ReturnsAsync(false);

        _doctorRepositoryMock
            .Setup(repo => repo.UpdateAsync(It.IsAny<Doctor>()))
            .ReturnsAsync(updatedDoctor);

        // Act
        var result = await _doctorService.UpdateAvailabilityAsync(1, dto, AppRoles.Doctor, 1);

        // Assert
        Assert.Equal(1, result.DoctorId);
        Assert.False(result.IsAvailable);
        Assert.Equal(ErrorMessages.DoctorUnavailableMessage, result.Message);

        _doctorRepositoryMock.Verify(repo => repo.UpdateAsync(It.Is<Doctor>(updated =>
            updated.Id == 1 && !updated.IsAvailable)), Times.Once);
    }

    [Fact]
    public async Task UpdateAvailabilityAsync_WhenDoctorDeactivatesSelfWithConfirmedAppointmentsToday_ShouldThrowBusinessRuleException()
    {
        // Arrange
        var dto = new UpdateDoctorAvailabilityDto { IsAvailable = false };
        var doctor = CreateDoctor(isAvailable: true);
        var today = DateOnly.FromDateTime(DateTime.Today);

        _doctorRepositoryMock
            .Setup(repo => repo.GetDoctorByIdAsync(1))
            .ReturnsAsync(doctor);

        _appointmentRepositoryMock
            .Setup(repo => repo.DoctorHasConfirmedAppointmentsOnDateAsync(1, today))
            .ReturnsAsync(true);

        // Act
        var exception = await Assert.ThrowsAsync<BusinessRuleException>(() =>
            _doctorService.UpdateAvailabilityAsync(1, dto, AppRoles.Doctor, 1));

        // Assert
        Assert.Equal(ErrorMessages.DoctorCannotDeactivateWithConfirmedAppointmentsToday, exception.Message);

        _doctorRepositoryMock.Verify(repo => repo.UpdateAsync(It.IsAny<Doctor>()), Times.Never);
    }

    [Fact]
    public async Task UpdateAvailabilityAsync_WhenAdminDeactivatesDoctor_ShouldCancelTodaysPendingAndConfirmedAppointments()
    {
        // Arrange
        var dto = new UpdateDoctorAvailabilityDto { IsAvailable = false };
        var doctor = CreateDoctor(isAvailable: true);
        var updatedDoctor = CreateDoctor(isAvailable: false);
        var today = DateOnly.FromDateTime(DateTime.Today);

        var appointments = new List<Appointment>
        {
            new Appointment
            {
                Id = 10,
                DoctorId = 1,
                AppointmentDate = today,
                Status = AppointmentStatus.Pending
            },
            new Appointment
            {
                Id = 11,
                DoctorId = 1,
                AppointmentDate = today,
                Status = AppointmentStatus.Confirmed
            }
        };

        _doctorRepositoryMock
            .Setup(repo => repo.GetDoctorByIdAsync(1))
            .ReturnsAsync(doctor);

        _appointmentRepositoryMock
            .Setup(repo => repo.GetPendingOrConfirmedAppointmentsByDoctorIdAndDateAsync(1, today))
            .ReturnsAsync(appointments);

        _appointmentRepositoryMock
            .Setup(repo => repo.UpdateAsync(It.IsAny<Appointment>()))
            .ReturnsAsync((Appointment appointment) => appointment);

        _doctorRepositoryMock
            .Setup(repo => repo.UpdateAsync(It.IsAny<Doctor>()))
            .ReturnsAsync(updatedDoctor);

        // Act
        var result = await _doctorService.UpdateAvailabilityAsync(1, dto, AppRoles.Admin, null);

        // Assert
        Assert.Equal(1, result.DoctorId);
        Assert.False(result.IsAvailable);
        Assert.Equal(ErrorMessages.DoctorUnavailableMessage, result.Message);

        _appointmentRepositoryMock.Verify(repo => repo.UpdateAsync(It.Is<Appointment>(appointment =>
            appointment.Id == 10 &&
            appointment.Status == AppointmentStatus.Cancelled &&
            appointment.CancellationReason == ErrorMessages.DoctorEmergencyCancellationReason)), Times.Once);

        _appointmentRepositoryMock.Verify(repo => repo.UpdateAsync(It.Is<Appointment>(appointment =>
            appointment.Id == 11 &&
            appointment.Status == AppointmentStatus.Cancelled &&
            appointment.CancellationReason == ErrorMessages.DoctorEmergencyCancellationReason)), Times.Once);

        _doctorRepositoryMock.Verify(repo => repo.UpdateAsync(It.Is<Doctor>(updated =>
            updated.Id == 1 && !updated.IsAvailable)), Times.Once);
    }

    [Fact]
    public async Task UpdateAvailabilityAsync_WhenAdminActivatesDoctor_ShouldUpdateAvailability()
    {
        // Arrange
        var dto = new UpdateDoctorAvailabilityDto { IsAvailable = true };
        var doctor = CreateDoctor(isAvailable: false);
        var updatedDoctor = CreateDoctor(isAvailable: true);

        _doctorRepositoryMock
            .Setup(repo => repo.GetDoctorByIdAsync(1))
            .ReturnsAsync(doctor);

        _doctorRepositoryMock
            .Setup(repo => repo.UpdateAsync(It.IsAny<Doctor>()))
            .ReturnsAsync(updatedDoctor);

        // Act
        var result = await _doctorService.UpdateAvailabilityAsync(1, dto, AppRoles.Admin, null);

        // Assert
        Assert.Equal(1, result.DoctorId);
        Assert.True(result.IsAvailable);
        Assert.Equal(ErrorMessages.DoctorAvailableMessage, result.Message);

        _appointmentRepositoryMock.Verify(
            repo => repo.GetPendingOrConfirmedAppointmentsByDoctorIdAndDateAsync(It.IsAny<int>(), It.IsAny<DateOnly>()),
            Times.Never);

        _doctorRepositoryMock.Verify(repo => repo.UpdateAsync(It.Is<Doctor>(updated =>
            updated.Id == 1 && updated.IsAvailable)), Times.Once);
    }

    private static Doctor CreateDoctor(bool isAvailable)
    {
        return new Doctor
        {
            Id = 1,
            UserId = "doctor-user-id-1",
            FullName = "Dr. Anjali Menon",
            Specialisation = DoctorSpecialisation.Cardiology,
            PracticeStartDate = new DateOnly(2015, 1, 1),
            ConsultationFee = 600,
            IsAvailable = isAvailable
        };
    }
}
