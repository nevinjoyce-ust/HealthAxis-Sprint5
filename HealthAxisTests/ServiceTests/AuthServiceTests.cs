using HealthAxis.API.Constants;
using HealthAxis.Shared.Constants;
using HealthAxis.API.Data;
using HealthAxis.Shared.Dtos.Auth;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using HealthAxis.API.Services.Impl;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Moq;

namespace HealthAxisTests;

public class AuthServiceTests
{
    private readonly HealthAxisDbContext _context;
    private readonly Mock<UserManager<IdentityUser>> _userManagerMock;
    private readonly Mock<IPatientRepository> _patientRepositoryMock;
    private readonly Mock<IDoctorRepository> _doctorRepositoryMock;
    private readonly IConfiguration _configuration;
    private readonly AuthService _authService;

    public AuthServiceTests()
    {
        _context = CreateDbContext();
        _userManagerMock = CreateUserManagerMock();
        _patientRepositoryMock = new Mock<IPatientRepository>();
        _doctorRepositoryMock = new Mock<IDoctorRepository>();
        _configuration = CreateConfiguration();

        _authService = new AuthService(
            _userManagerMock.Object,
            _context,
            _patientRepositoryMock.Object,
            _doctorRepositoryMock.Object,
            _configuration
        );
    }

    [Fact]
    public async Task RegisterAsync_WhenPasswordsDoNotMatch_ShouldReturnFailure()
    {
        var request = CreateRegisterDto();
        request.ConfirmPassword = "Different@123";

        var result = await _authService.RegisterAsync(request);

        Assert.False(result.Success);
        Assert.Equal(ErrorMessages.PasswordsDoNotMatch, result.Message);
        Assert.Equal(string.Empty, result.UserId);
    }

   

    [Fact]
    public async Task RegisterAsync_WhenEmailAlreadyRegistered_ShouldReturnFailure()
    {
        var request = CreateRegisterDto();

        _userManagerMock
            .Setup(manager => manager.FindByEmailAsync(request.Email))
            .ReturnsAsync(new IdentityUser { Email = request.Email });

        var result = await _authService.RegisterAsync(request);

        Assert.False(result.Success);
        Assert.Equal(ErrorMessages.EmailAlreadyRegistered, result.Message);
        Assert.Equal(string.Empty, result.UserId);
    }

    [Fact]
    public async Task RegisterAsync_WhenIdentityCreateFails_ShouldReturnFailure()
    {
        var request = CreateRegisterDto();

        _userManagerMock
            .Setup(manager => manager.FindByEmailAsync(request.Email))
            .ReturnsAsync((IdentityUser?)null);

        _userManagerMock
            .Setup(manager => manager.CreateAsync(It.IsAny<IdentityUser>(), request.Password))
            .ReturnsAsync(IdentityResult.Failed(new IdentityError { Description = "Password failed." }));

        var result = await _authService.RegisterAsync(request);

        Assert.False(result.Success);
        Assert.Equal("Password failed.", result.Message);
        Assert.Equal(string.Empty, result.UserId);
    }

    [Fact]
    public async Task RegisterAsync_WhenAddToRoleFails_ShouldReturnFailure()
    {
        var request = CreateRegisterDto();

        _userManagerMock
            .Setup(manager => manager.FindByEmailAsync(request.Email))
            .ReturnsAsync((IdentityUser?)null);

        _userManagerMock
            .Setup(manager => manager.CreateAsync(It.IsAny<IdentityUser>(), request.Password))
            .ReturnsAsync(IdentityResult.Success);

        _userManagerMock
            .Setup(manager => manager.AddToRoleAsync(It.IsAny<IdentityUser>(), AppRoles.Patient))
            .ReturnsAsync(IdentityResult.Failed(new IdentityError { Description = "Role failed." }));

        var result = await _authService.RegisterAsync(request);

        Assert.False(result.Success);
        Assert.Equal("Role failed.", result.Message);
        Assert.Equal(string.Empty, result.UserId);
    }

    [Fact]
    public async Task RegisterAsync_WhenValid_ShouldCreatePatientAndReturnSuccess()
    {
        var request = CreateRegisterDto();

        _userManagerMock
            .Setup(manager => manager.FindByEmailAsync(request.Email))
            .ReturnsAsync((IdentityUser?)null);

        _userManagerMock
            .Setup(manager => manager.CreateAsync(It.IsAny<IdentityUser>(), request.Password))
            .Callback<IdentityUser, string>((user, _) => user.Id = "created-user-id")
            .ReturnsAsync(IdentityResult.Success);

        _userManagerMock
            .Setup(manager => manager.AddToRoleAsync(It.IsAny<IdentityUser>(), AppRoles.Patient))
            .ReturnsAsync(IdentityResult.Success);

        var result = await _authService.RegisterAsync(request);

        Assert.True(result.Success);
        Assert.Equal("User registered successfully.", result.Message);
        Assert.Equal("created-user-id", result.UserId);

        var patient = await _context.Patients.FirstOrDefaultAsync(patient => patient.UserId == "created-user-id");
        Assert.NotNull(patient);
        Assert.Equal(request.FullName, patient!.FullName);
        Assert.Equal(request.DateOfBirth, patient.DateOfBirth);
        Assert.Equal(request.Gender, patient.Gender);
        Assert.Equal(request.Address, patient.Address);
    }

    [Fact]
    public async Task LoginAsync_WhenUserDoesNotExist_ShouldReturnInvalidCredentials()
    {
        var request = new LoginDto { Email = "missing@test.com", Password = "Password@123" };

        _userManagerMock
            .Setup(manager => manager.FindByEmailAsync(request.Email))
            .ReturnsAsync((IdentityUser?)null);

        var result = await _authService.LoginAsync(request);

        Assert.False(result.Success);
        Assert.Equal(ErrorMessages.InvalidCredentials, result.Message);
        Assert.Null(result.Response);
    }

    [Fact]
    public async Task LoginAsync_WhenPasswordIsInvalid_ShouldReturnInvalidCredentials()
    {
        var request = new LoginDto { Email = "patient@test.com", Password = "WrongPassword" };
        var user = new IdentityUser { Id = "user-id", Email = request.Email };

        _userManagerMock
            .Setup(manager => manager.FindByEmailAsync(request.Email))
            .ReturnsAsync(user);

        _userManagerMock
            .Setup(manager => manager.CheckPasswordAsync(user, request.Password))
            .ReturnsAsync(false);

        var result = await _authService.LoginAsync(request);

        Assert.False(result.Success);
        Assert.Equal(ErrorMessages.InvalidCredentials, result.Message);
        Assert.Null(result.Response);
    }

    [Fact]
    public async Task LoginAsync_WhenPatientProfileMissing_ShouldReturnFailure()
    {
        var request = new LoginDto { Email = "patient@test.com", Password = "Password@123" };
        var user = new IdentityUser { Id = "patient-user-id", Email = request.Email };

        _userManagerMock
            .Setup(manager => manager.FindByEmailAsync(request.Email))
            .ReturnsAsync(user);

        _userManagerMock
            .Setup(manager => manager.CheckPasswordAsync(user, request.Password))
            .ReturnsAsync(true);

        _userManagerMock
            .Setup(manager => manager.GetRolesAsync(user))
            .ReturnsAsync(new List<string> { AppRoles.Patient });

        _patientRepositoryMock
            .Setup(repo => repo.GetPatientByUserIdAsync(user.Id))
            .ReturnsAsync((Patient?)null);

        var result = await _authService.LoginAsync(request);

        Assert.False(result.Success);
        Assert.Equal(ErrorMessages.PatientProfileNotFound, result.Message);
        Assert.Null(result.Response);
    }

    [Fact]
    public async Task LoginAsync_WhenDoctorProfileMissing_ShouldReturnFailure()
    {
        var request = new LoginDto { Email = "doctor@test.com", Password = "Password@123" };
        var user = new IdentityUser { Id = "doctor-user-id", Email = request.Email };

        _userManagerMock
            .Setup(manager => manager.FindByEmailAsync(request.Email))
            .ReturnsAsync(user);

        _userManagerMock
            .Setup(manager => manager.CheckPasswordAsync(user, request.Password))
            .ReturnsAsync(true);

        _userManagerMock
            .Setup(manager => manager.GetRolesAsync(user))
            .ReturnsAsync(new List<string> { AppRoles.Doctor });

        _doctorRepositoryMock
            .Setup(repo => repo.GetDoctorByUserIdAsync(user.Id))
            .ReturnsAsync((Doctor?)null);

        var result = await _authService.LoginAsync(request);

        Assert.False(result.Success);
        Assert.Equal(ErrorMessages.DoctorProfileNotFound, result.Message);
        Assert.Null(result.Response);
    }

    [Fact]
    public async Task LoginAsync_WhenValidPatient_ShouldReturnTokenAndPatientDetails()
    {
        var request = new LoginDto { Email = "patient@test.com", Password = "Password@123" };
        var user = new IdentityUser { Id = "patient-user-id", Email = request.Email };
        var patient = new Patient { Id = 10, UserId = user.Id, FullName = "Patient One" };

        _userManagerMock
            .Setup(manager => manager.FindByEmailAsync(request.Email))
            .ReturnsAsync(user);

        _userManagerMock
            .Setup(manager => manager.CheckPasswordAsync(user, request.Password))
            .ReturnsAsync(true);

        _userManagerMock
            .Setup(manager => manager.GetRolesAsync(user))
            .ReturnsAsync(new List<string> { AppRoles.Patient });

        _patientRepositoryMock
            .Setup(repo => repo.GetPatientByUserIdAsync(user.Id))
            .ReturnsAsync(patient);

        var result = await _authService.LoginAsync(request);

        Assert.True(result.Success);
        Assert.NotNull(result.Response);
        Assert.False(string.IsNullOrWhiteSpace(result.Response!.AccessToken));
        Assert.Equal("User logged in successfully.", result.Message);
        Assert.Equal(user.Id, result.Response.UserId);
        Assert.Equal(patient.Id, result.Response.PatientId);
        Assert.Null(result.Response.DoctorId);
        Assert.Equal(request.Email, result.Response.Email);
        Assert.Equal(AppRoles.Patient, result.Response.Role);
    }

    [Fact]
    public async Task LoginAsync_WhenValidDoctor_ShouldReturnTokenAndDoctorDetails()
    {
        var request = new LoginDto { Email = "doctor@test.com", Password = "Password@123" };
        var user = new IdentityUser { Id = "doctor-user-id", Email = request.Email };
        var doctor = new Doctor { Id = 20, UserId = user.Id, FullName = "Doctor One" };

        _userManagerMock
            .Setup(manager => manager.FindByEmailAsync(request.Email))
            .ReturnsAsync(user);

        _userManagerMock
            .Setup(manager => manager.CheckPasswordAsync(user, request.Password))
            .ReturnsAsync(true);

        _userManagerMock
            .Setup(manager => manager.GetRolesAsync(user))
            .ReturnsAsync(new List<string> { AppRoles.Doctor });

        _doctorRepositoryMock
            .Setup(repo => repo.GetDoctorByUserIdAsync(user.Id))
            .ReturnsAsync(doctor);

        var result = await _authService.LoginAsync(request);

        Assert.True(result.Success);
        Assert.NotNull(result.Response);
        Assert.False(string.IsNullOrWhiteSpace(result.Response!.AccessToken));
        Assert.Equal(user.Id, result.Response.UserId);
        Assert.Null(result.Response.PatientId);
        Assert.Equal(doctor.Id, result.Response.DoctorId);
        Assert.Equal(request.Email, result.Response.Email);
        Assert.Equal(AppRoles.Doctor, result.Response.Role);
    }

    private static RegisterDto CreateRegisterDto()
    {
        return new RegisterDto
        {
            FullName = "Patient One",
            Email = "patient@test.com",
            PhoneNumber = "9999999999",
            Password = "Password@123",
            ConfirmPassword = "Password@123",
            DateOfBirth = new DateOnly(1998, 1, 1),
            Gender = "Female",
            Address = "Trivandrum"
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

    private static IConfiguration CreateConfiguration()
    {
        var settings = new Dictionary<string, string?>
        {
            ["Jwt:Key"] = "ThisIsASecretKeyForHealthAxisJwtTests12345",
            ["Jwt:Issuer"] = "HealthAxis.Tests",
            ["Jwt:Audience"] = "HealthAxis.Tests",
            ["Jwt:AccessTokenExpirationMinutes"] = "60"
        };

        return new ConfigurationBuilder()
            .AddInMemoryCollection(settings)
            .Build();
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
