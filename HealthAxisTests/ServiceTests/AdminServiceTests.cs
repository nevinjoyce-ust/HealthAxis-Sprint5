using AutoMapper;
using HealthAxis.API.Constants;
using HealthAxis.Shared.Constants;
using HealthAxis.API.Data;
using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Dtos.Doctor;
using HealthAxis.Shared.Dtos.Appointment;
using HealthAxis.Shared.Enums;
using HealthAxis.API.Exceptions;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using HealthAxis.API.Services;
using HealthAxis.API.Services.Impl;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Moq;

namespace HealthAxisTests;

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
            _userManagerMock.Object
        );
    }

    [Fact]
    public async Task GetDoctorsAsync_WhenDoctorsExist_ShouldReturnPagedDoctorDtos()
    {
        // Arrange
        var doctors = new List<Doctor>
        {
            new Doctor
            {
                Id = 1,
                UserId = "doctor-user-id",
                FullName = "Dr. Admin Test",
                Specialisation = DoctorSpecialisation.Cardiology,
                PracticeStartDate = new DateOnly(2015, 1, 1),
                ConsultationFee = 600,
                IsAvailable = true,
                User = new IdentityUser
                {
                    Id = "doctor-user-id",
                    Email = "doctor@test.com",
                    PhoneNumber = "9999999999"
                }
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

        var mappedDtos = new List<DoctorDto>
        {
            new DoctorDto
            {
                Id = 1,
                UserId = "doctor-user-id",
                FullName = "Dr. Admin Test",
                Email = "doctor@test.com",
                PhoneNumber = "9999999999",
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
            .Setup(repo => repo.GetAllDoctorsWithUserAsync(1, 10))
            .ReturnsAsync(pagedDoctors);

        _mapperMock
            .Setup(mapper => mapper.Map<List<DoctorDto>>(doctors))
            .Returns(mappedDtos);

        // Act
        var result = await _adminService.GetDoctorsAsync(pagination);

        // Assert
        Assert.NotNull(result);
        Assert.Single(result.Items);
        Assert.Equal("Dr. Admin Test", result.Items[0].FullName);
        Assert.Equal("doctor@test.com", result.Items[0].Email);
        Assert.Equal(1, result.PageNumber);
        Assert.Equal(10, result.PageSize);
        Assert.Equal(1, result.TotalCount);
        Assert.Equal(1, result.TotalPages);
        Assert.False(result.HasPreviousPage);
        Assert.False(result.HasNextPage);
    }

    [Fact]
    public async Task CreateDoctorAsync_WhenEmailAlreadyExists_ShouldThrowConflictException()
    {
        var dto = CreateDoctorDto();

        _userManagerMock
            .Setup(manager => manager.FindByEmailAsync(dto.Email))
            .ReturnsAsync(new IdentityUser { Email = dto.Email });

        var exception = await Assert.ThrowsAsync<ConflictException>(() =>
            _adminService.CreateDoctorAsync(dto));

        Assert.Equal(ErrorMessages.EmailAlreadyExists, exception.Message);
    }

    [Fact]
    public async Task CreateDoctorAsync_WhenIdentityCreateFails_ShouldThrowBadRequestException()
    {
        var dto = CreateDoctorDto();

        _userManagerMock
            .Setup(manager => manager.FindByEmailAsync(dto.Email))
            .ReturnsAsync((IdentityUser?)null);

        _userManagerMock
            .Setup(manager => manager.CreateAsync(It.IsAny<IdentityUser>(), dto.Password))
            .ReturnsAsync(IdentityResult.Failed(new IdentityError { Description = "Password is invalid." }));

        var exception = await Assert.ThrowsAsync<BadRequestException>(() =>
            _adminService.CreateDoctorAsync(dto));

        Assert.Equal("Password is invalid.", exception.Message);
    }

    [Fact]
    public async Task CreateDoctorAsync_WhenAddRoleFails_ShouldThrowBadRequestException()
    {
        var dto = CreateDoctorDto();

        _userManagerMock
            .Setup(manager => manager.FindByEmailAsync(dto.Email))
            .ReturnsAsync((IdentityUser?)null);

        _userManagerMock
            .Setup(manager => manager.CreateAsync(It.IsAny<IdentityUser>(), dto.Password))
            .ReturnsAsync(IdentityResult.Success);

        _userManagerMock
            .Setup(manager => manager.AddToRoleAsync(It.IsAny<IdentityUser>(), AppRoles.Doctor))
            .ReturnsAsync(IdentityResult.Failed(new IdentityError { Description = "Role assignment failed." }));

        var exception = await Assert.ThrowsAsync<BadRequestException>(() =>
            _adminService.CreateDoctorAsync(dto));

        Assert.Equal("Role assignment failed.", exception.Message);
    }

    [Fact]
    public async Task CreateDoctorAsync_WhenValid_ShouldCreateDoctorAndReturnDoctorDto()
    {
        var dto = CreateDoctorDto();
        var createdDoctor = new Doctor
        {
            Id = 1,
            UserId = "created-user-id",
            FullName = dto.FullName,
            Specialisation = dto.Specialisation,
            PracticeStartDate = dto.PracticeStartDate,
            ConsultationFee = dto.ConsultationFee,
            IsAvailable = dto.IsAvailable
        };

        var doctorWithUser = new Doctor
        {
            Id = 1,
            UserId = "created-user-id",
            FullName = dto.FullName,
            Specialisation = dto.Specialisation,
            PracticeStartDate = dto.PracticeStartDate,
            ConsultationFee = dto.ConsultationFee,
            IsAvailable = dto.IsAvailable,
            User = new IdentityUser
            {
                Id = "created-user-id",
                Email = dto.Email,
                PhoneNumber = dto.PhoneNumber
            }
        };

        var mappedDto = new DoctorDto
        {
            Id = 1,
            UserId = "created-user-id",
            FullName = dto.FullName,
            Email = dto.Email,
            PhoneNumber = dto.PhoneNumber,
            Specialisation = dto.Specialisation,
            ConsultationFee = dto.ConsultationFee,
            IsAvailable = dto.IsAvailable
        };

        _userManagerMock
            .Setup(manager => manager.FindByEmailAsync(dto.Email))
            .ReturnsAsync((IdentityUser?)null);

        _userManagerMock
            .Setup(manager => manager.CreateAsync(It.IsAny<IdentityUser>(), dto.Password))
            .Callback<IdentityUser, string>((user, _) => user.Id = "created-user-id")
            .ReturnsAsync(IdentityResult.Success);

        _userManagerMock
            .Setup(manager => manager.AddToRoleAsync(It.IsAny<IdentityUser>(), AppRoles.Doctor))
            .ReturnsAsync(IdentityResult.Success);

        _doctorRepositoryMock
            .Setup(repo => repo.AddAsync(It.IsAny<Doctor>()))
            .ReturnsAsync(createdDoctor);

        _doctorRepositoryMock
            .Setup(repo => repo.GetDoctorByIdWithUserAsync(1))
            .ReturnsAsync(doctorWithUser);

        _mapperMock
            .Setup(mapper => mapper.Map<DoctorDto>(doctorWithUser))
            .Returns(mappedDto);

        var result = await _adminService.CreateDoctorAsync(dto);

        Assert.NotNull(result);
        Assert.Equal(1, result!.Id);
        Assert.Equal(dto.Email, result.Email);
        Assert.Equal(dto.PhoneNumber, result.PhoneNumber);

        _userManagerMock.Verify(manager => manager.CreateAsync(It.Is<IdentityUser>(user =>
            user.UserName == dto.Email &&
            user.Email == dto.Email &&
            user.PhoneNumber == dto.PhoneNumber &&
            user.EmailConfirmed), dto.Password), Times.Once);

        _userManagerMock.Verify(manager => manager.AddToRoleAsync(It.IsAny<IdentityUser>(), AppRoles.Doctor), Times.Once);

        _doctorRepositoryMock.Verify(repo => repo.AddAsync(It.Is<Doctor>(doctor =>
            doctor.UserId == "created-user-id" &&
            doctor.FullName == dto.FullName &&
            doctor.IsAvailable == dto.IsAvailable)), Times.Once);
    }

    [Fact]
    public async Task UpdateDoctorAsync_WhenDoctorDoesNotExist_ShouldThrowNotFoundException()
    {
        var dto = CreateUpdateDoctorDto();

        _doctorRepositoryMock
            .Setup(repo => repo.GetDoctorByIdAsync(99))
            .ReturnsAsync((Doctor?)null);

        var exception = await Assert.ThrowsAsync<NotFoundException>(() =>
            _adminService.UpdateDoctorAsync(99, dto));

        Assert.Equal(ErrorMessages.DoctorNotFound, exception.Message);
    }

    [Fact]
    public async Task UpdateDoctorAsync_WhenValid_ShouldUpdateProfileFieldsOnlyAndPreserveAvailability()
    {
        var dto = CreateUpdateDoctorDto();
        var doctor = new Doctor
        {
            Id = 1,
            UserId = "doctor-user-id",
            FullName = "Old Name",
            Specialisation = DoctorSpecialisation.Cardiology,
            PracticeStartDate = new DateOnly(2010, 1, 1),
            ConsultationFee = 500,
            IsAvailable = false
        };

        var updatedDoctor = new Doctor
        {
            Id = 1,
            UserId = "doctor-user-id",
            FullName = dto.FullName,
            Specialisation = dto.Specialisation,
            PracticeStartDate = dto.PracticeStartDate,
            ConsultationFee = dto.ConsultationFee,
            IsAvailable = false
        };

        var doctorWithUser = new Doctor
        {
            Id = 1,
            UserId = "doctor-user-id",
            FullName = dto.FullName,
            Specialisation = dto.Specialisation,
            PracticeStartDate = dto.PracticeStartDate,
            ConsultationFee = dto.ConsultationFee,
            IsAvailable = false,
            User = new IdentityUser
            {
                Id = "doctor-user-id",
                Email = "doctor@test.com",
                PhoneNumber = "9999999999"
            }
        };

        var mappedDto = new DoctorDto
        {
            Id = 1,
            UserId = "doctor-user-id",
            FullName = dto.FullName,
            Email = "doctor@test.com",
            PhoneNumber = "9999999999",
            Specialisation = dto.Specialisation,
            ConsultationFee = dto.ConsultationFee,
            IsAvailable = false
        };

        _doctorRepositoryMock
            .Setup(repo => repo.GetDoctorByIdAsync(1))
            .ReturnsAsync(doctor);

        _doctorRepositoryMock
            .Setup(repo => repo.UpdateAsync(It.IsAny<Doctor>()))
            .ReturnsAsync(updatedDoctor);

        _doctorRepositoryMock
            .Setup(repo => repo.GetDoctorByIdWithUserAsync(1))
            .ReturnsAsync(doctorWithUser);

        _mapperMock
            .Setup(mapper => mapper.Map<DoctorDto>(doctorWithUser))
            .Returns(mappedDto);

        var result = await _adminService.UpdateDoctorAsync(1, dto);

        Assert.NotNull(result);
        Assert.Equal(dto.FullName, result!.FullName);
        Assert.False(result.IsAvailable);

        _doctorRepositoryMock.Verify(repo => repo.UpdateAsync(It.Is<Doctor>(updated =>
            updated.Id == 1 &&
            updated.FullName == dto.FullName &&
            updated.Specialisation == dto.Specialisation &&
            updated.PracticeStartDate == dto.PracticeStartDate &&
            updated.ConsultationFee == dto.ConsultationFee &&
            updated.IsAvailable == false)), Times.Once);
    }

    [Fact]
    public async Task GetAppointmentReportsAsync_ShouldReturnReportsFromAppointmentService()
    {
        var reports = new List<AppointmentReportDto>
    {
        new AppointmentReportDto
        {
            Date = DateOnly.FromDateTime(DateTime.Today),
            PendingCount = 1,
            ConfirmedCount = 2,
            CancelledCount = 3,
            CompletedCount = 4,
            TotalCount = 10
        }
    };

        _appointmentServiceMock
            .Setup(service => service.GetAppointmentReportsAsync())
            .ReturnsAsync(reports);

        var pagination = new PaginationQueryDto
        {
            PageNumber = 1,
            PageSize = 10
        };

        var result = await _adminService.GetAppointmentReportsAsync(pagination);

        Assert.NotNull(result);
        Assert.Equal(1, result.PageNumber);
        Assert.Equal(10, result.PageSize);
        Assert.Equal(1, result.TotalCount);
        Assert.Equal(1, result.TotalPages);
        Assert.Single(result.Items);
        Assert.Contains(result.Items, report => report.Date == DateOnly.FromDateTime(DateTime.Today));
    }

   
    private static CreateDoctorDto CreateDoctorDto()
    {
        return new CreateDoctorDto
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
    }

    private static UpdateDoctorDto CreateUpdateDoctorDto()
    {
        return new UpdateDoctorDto
        {
            FullName = "Updated Doctor",
            Specialisation = DoctorSpecialisation.Dermatology,
            PracticeStartDate = new DateOnly(2018, 1, 1),
            ConsultationFee = 700
        };
    }

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
            logger.Object
        );
    }
}
