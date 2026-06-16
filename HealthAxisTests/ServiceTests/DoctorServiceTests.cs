using AutoMapper;
using HealthAxis.API.Dtos;
using HealthAxis.API.Enums;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using HealthAxis.API.Services.Impl;
using Moq;

namespace HealthAxisTests;

public class DoctorServiceTests
{
    private readonly Mock<IDoctorRepository> _doctorRepositoryMock;
    private readonly Mock<IUserRepository> _userRepositoryMock;
    private readonly Mock<IMapper> _mapperMock;
    private readonly DoctorService _doctorService;

    public DoctorServiceTests()
    {
        _doctorRepositoryMock = new Mock<IDoctorRepository>();
        _userRepositoryMock = new Mock<IUserRepository>();
        _mapperMock = new Mock<IMapper>();

        _doctorService = new DoctorService(
            _doctorRepositoryMock.Object,
            _userRepositoryMock.Object,
            _mapperMock.Object
        );
    }

    [Fact]
    public async Task GetAllDoctorsAsync_WhenDoctorsExist_ShouldReturnDoctorDtos()
    {
        // Arrange
        var doctors = new List<Doctor>
        {
            new Doctor
            {
                Id = 1,
                UserId = 2,
                Specialisation = DoctorSpecialisation.Cardiology,
                PracticeStartDate = new DateOnly(2015, 1, 1),
                ConsultationFee = 600,
                IsAvailable = true
            }
        };

        var mappedDoctorDto = new DoctorDto
        {
            Id = 1,
            UserId = 2,
            Specialisation = DoctorSpecialisation.Cardiology,
            YearsOfExperience = 10,
            ConsultationFee = 600,
            IsAvailable = true
        };

        _doctorRepositoryMock
            .Setup(repo => repo.GetAllAsync())
            .ReturnsAsync(doctors);

        _mapperMock
            .Setup(mapper => mapper.Map<DoctorDto>(It.IsAny<Doctor>()))
            .Returns(mappedDoctorDto);

        _userRepositoryMock
            .Setup(repo => repo.GetFullNameByIdAsync(2))
            .ReturnsAsync("Dr. Anjali Menon");

        // Act
        var result = await _doctorService.GetAllDoctorsAsync();

        // Assert
        Assert.NotNull(result);
        Assert.Single(result);
        Assert.Equal(1, result[0].Id);
        Assert.Equal(2, result[0].UserId);
        Assert.Equal("Dr. Anjali Menon", result[0].FullName);
        Assert.Equal(DoctorSpecialisation.Cardiology, result[0].Specialisation);
        Assert.Equal(600, result[0].ConsultationFee);
        Assert.True(result[0].IsAvailable);
    }

    [Fact]
    public async Task GetAllDoctorsAsync_WhenNoDoctorsExist_ShouldReturnEmptyList()
    {
        // Arrange
        _doctorRepositoryMock
            .Setup(repo => repo.GetAllAsync())
            .ReturnsAsync(new List<Doctor>());

        // Act
        var result = await _doctorService.GetAllDoctorsAsync();

        // Assert
        Assert.NotNull(result);
        Assert.Empty(result);
    }

    [Fact]
    public async Task GetDoctorByIdAsync_WhenDoctorExists_ShouldReturnDoctorDto()
    {
        // Arrange
        var doctor = new Doctor
        {
            Id = 1,
            UserId = 2,
            Specialisation = DoctorSpecialisation.Cardiology,
            PracticeStartDate = new DateOnly(2015, 1, 1),
            ConsultationFee = 600,
            IsAvailable = true
        };

        var mappedDoctorDto = new DoctorDto
        {
            Id = 1,
            UserId = 2,
            Specialisation = DoctorSpecialisation.Cardiology,
            YearsOfExperience = 10,
            ConsultationFee = 600,
            IsAvailable = true
        };

        _doctorRepositoryMock
            .Setup(repo => repo.GetByIdAsync(1))
            .ReturnsAsync(doctor);

        _mapperMock
            .Setup(mapper => mapper.Map<DoctorDto>(doctor))
            .Returns(mappedDoctorDto);

        _userRepositoryMock
            .Setup(repo => repo.GetFullNameByIdAsync(2))
            .ReturnsAsync("Dr. Anjali Menon");

        // Act
        var result = await _doctorService.GetDoctorByIdAsync(1);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(1, result!.Id);
        Assert.Equal(2, result.UserId);
        Assert.Equal("Dr. Anjali Menon", result.FullName);
        Assert.Equal(DoctorSpecialisation.Cardiology, result.Specialisation);
        Assert.Equal(600, result.ConsultationFee);
        Assert.True(result.IsAvailable);
    }

    [Fact]
    public async Task GetDoctorByIdAsync_WhenDoctorDoesNotExist_ShouldReturnNull()
    {
        // Arrange
        _doctorRepositoryMock
            .Setup(repo => repo.GetByIdAsync(99))
            .ReturnsAsync((Doctor?)null);

        // Act
        var result = await _doctorService.GetDoctorByIdAsync(99);

        // Assert
        Assert.Null(result);
    }

    [Fact]
    public async Task GetDoctorByUserIdAsync_WhenDoctorExists_ShouldReturnDoctorDto()
    {
        // Arrange
        var doctor = new Doctor
        {
            Id = 1,
            UserId = 2,
            Specialisation = DoctorSpecialisation.Dermatology,
            PracticeStartDate = new DateOnly(2019, 1, 1),
            ConsultationFee = 500,
            IsAvailable = true
        };

        var mappedDoctorDto = new DoctorDto
        {
            Id = 1,
            UserId = 2,
            Specialisation = DoctorSpecialisation.Dermatology,
            YearsOfExperience = 6,
            ConsultationFee = 500,
            IsAvailable = true
        };

        _doctorRepositoryMock
            .Setup(repo => repo.GetDoctorByUserIdAsync(2))
            .ReturnsAsync(doctor);

        _mapperMock
            .Setup(mapper => mapper.Map<DoctorDto>(doctor))
            .Returns(mappedDoctorDto);

        _userRepositoryMock
            .Setup(repo => repo.GetFullNameByIdAsync(2))
            .ReturnsAsync("Dr. Rahul Nair");

        // Act
        var result = await _doctorService.GetDoctorByUserIdAsync(2);

        // Assert
        Assert.NotNull(result);
        Assert.Equal(1, result!.Id);
        Assert.Equal(2, result.UserId);
        Assert.Equal("Dr. Rahul Nair", result.FullName);
        Assert.Equal(DoctorSpecialisation.Dermatology, result.Specialisation);
    }

    [Fact]
    public async Task GetDoctorByUserIdAsync_WhenDoctorDoesNotExist_ShouldReturnNull()
    {
        // Arrange
        _doctorRepositoryMock
            .Setup(repo => repo.GetDoctorByUserIdAsync(99))
            .ReturnsAsync((Doctor?)null);

        // Act
        var result = await _doctorService.GetDoctorByUserIdAsync(99);

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
        Assert.Equal("Doctor is available.", result.Message);
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
        Assert.Equal("Doctor is not available.", result.Message);
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
}