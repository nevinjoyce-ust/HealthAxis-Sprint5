using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using HealthAxis.API.Constants;
using HealthAxis.API.Data;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using HealthAxis.Shared.Constants;
using HealthAxis.Shared.Dtos.Auth;
using Microsoft.AspNetCore.Identity;
using Microsoft.IdentityModel.Tokens;

namespace HealthAxis.API.Services.Impl;

public class AuthService(
    UserManager<IdentityUser> userManager,
    HealthAxisDbContext context,
    IPatientRepository patientRepository,
    IDoctorRepository doctorRepository,
    IConfiguration configuration) : IAuthService
{
    public async Task<(bool Success, string Message, string UserId)> RegisterAsync(
        RegisterDto request)
    {
        if (request.Password != request.ConfirmPassword)
        {
            return (false, ErrorMessages.PasswordsDoNotMatch, string.Empty);
        }

        var existingUser = await userManager.FindByEmailAsync(request.Email);

        if (existingUser != null)
        {
            return (false, ErrorMessages.EmailAlreadyRegistered, string.Empty);
        }

        await using var transaction = await context.Database.BeginTransactionAsync();

        try
        {
            var user = new IdentityUser
            {
                UserName = request.Email,
                Email = request.Email,
                EmailConfirmed = true,
                PhoneNumber = request.PhoneNumber
            };

            var createResult = await userManager.CreateAsync(user, request.Password);

            if (!createResult.Succeeded)
            {
                var errors = string.Join(
                    ", ",
                    createResult.Errors.Select(error => error.Description));

                await transaction.RollbackAsync();
                return (false, errors, string.Empty);
            }

            var roleResult = await userManager.AddToRoleAsync(user, AppRoles.Patient);

            if (!roleResult.Succeeded)
            {
                var errors = string.Join(
                    ", ",
                    roleResult.Errors.Select(error => error.Description));

                await transaction.RollbackAsync();
                return (false, errors, string.Empty);
            }

            var patient = new Patient
            {
                UserId = user.Id,
                FullName = request.FullName,
                DateOfBirth = request.DateOfBirth,
                Gender = request.Gender,
                Address = request.Address
            };

            await context.Patients.AddAsync(patient);
            await context.SaveChangesAsync();
            await transaction.CommitAsync();

            return (true, "User registered successfully.", user.Id);
        }
        catch
        {
            await transaction.RollbackAsync();
            throw;
        }
    }

    public async Task<(bool Success, string Message, AuthResponseDto? Response)>
        LoginAsync(LoginDto request)
    {
        var user = await userManager.FindByEmailAsync(request.Email);

        if (user == null)
        {
            return (false, ErrorMessages.InvalidCredentials, null);
        }

        var isPasswordValid = await userManager.CheckPasswordAsync(
            user,
            request.Password);

        if (!isPasswordValid)
        {
            return (false, ErrorMessages.InvalidCredentials, null);
        }

        var profileResult = await BuildUserProfileAsync(user);

        if (!profileResult.Success)
        {
            return (false, profileResult.Message, null);
        }

        var response = GenerateAuthResponse(
            user,
            profileResult.Roles,
            profileResult.Role,
            profileResult.PatientId,
            profileResult.DoctorId,
            "User logged in successfully.");

        return (true, response.Message, response);
    }

    private async Task<(
        bool Success,
        string Message,
        IList<string> Roles,
        string Role,
        int? PatientId,
        int? DoctorId)> BuildUserProfileAsync(IdentityUser user)
    {
        var roles = await userManager.GetRolesAsync(user);
        var role = roles.FirstOrDefault() ?? string.Empty;

        int? patientId = null;
        int? doctorId = null;

        if (string.Equals(role, AppRoles.Patient, StringComparison.OrdinalIgnoreCase))
        {
            var patient = await patientRepository.GetPatientByUserIdAsync(user.Id);

            if (patient == null)
            {
                return (
                    false,
                    ErrorMessages.PatientProfileNotFound,
                    roles,
                    role,
                    null,
                    null);
            }

            patientId = patient.Id;
        }

        if (string.Equals(role, AppRoles.Doctor, StringComparison.OrdinalIgnoreCase))
        {
            var doctor = await doctorRepository.GetDoctorByUserIdAsync(user.Id);

            if (doctor == null)
            {
                return (
                    false,
                    ErrorMessages.DoctorProfileNotFound,
                    roles,
                    role,
                    null,
                    null);
            }

            doctorId = doctor.Id;
        }

        return (true, string.Empty, roles, role, patientId, doctorId);
    }

    private AuthResponseDto GenerateAuthResponse(
        IdentityUser user,
        IList<string> roles,
        string role,
        int? patientId,
        int? doctorId,
        string message)
    {
        var expiresIn = int.Parse(
            configuration.GetSection("Jwt")["AccessTokenExpirationMinutes"]!);

        var token = GenerateToken(
            user,
            roles,
            expiresIn,
            patientId,
            doctorId);

        return new AuthResponseDto
        {
            AccessToken = token,
            Message = message,
            ExpiresIn = expiresIn,
            UserId = user.Id,
            PatientId = patientId,
            DoctorId = doctorId,
            Email = user.Email ?? string.Empty,
            Role = role
        };
    }

    private string GenerateToken(
        IdentityUser user,
        IList<string> roles,
        int expiresIn,
        int? patientId,
        int? doctorId)
    {
        var jwtSettings = configuration.GetSection("Jwt");

        var key = new SymmetricSecurityKey(
            Encoding.UTF8.GetBytes(jwtSettings["Key"]!));

        var credentials = new SigningCredentials(
            key,
            SecurityAlgorithms.HmacSha256);

        var claims = new List<Claim>
        {
            new(AppClaimTypes.UserId, user.Id),
            new(JwtRegisteredClaimNames.Sub, user.Id),
            new(JwtRegisteredClaimNames.Email, user.Email ?? string.Empty),
            new(ClaimTypes.NameIdentifier, user.Id),
            new(ClaimTypes.Email, user.Email ?? string.Empty),
            new(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
        };

        foreach (var userRole in roles)
        {
            claims.Add(new Claim(AppClaimTypes.Role, userRole));
            claims.Add(new Claim(ClaimTypes.Role, userRole));
        }

        if (patientId.HasValue)
        {
            claims.Add(new Claim(
                AppClaimTypes.PatientId,
                patientId.Value.ToString()));
        }

        if (doctorId.HasValue)
        {
            claims.Add(new Claim(
                AppClaimTypes.DoctorId,
                doctorId.Value.ToString()));
        }

        var token = new JwtSecurityToken(
            issuer: jwtSettings["Issuer"],
            audience: jwtSettings["Audience"],
            claims: claims,
            expires: DateTime.UtcNow.AddMinutes(expiresIn),
            signingCredentials: credentials);

        return new JwtSecurityTokenHandler().WriteToken(token);
    }

    public async Task<(bool Success, string Message, AuthResponseDto? Response)>
        CreateAuthResponseForUserIdAsync(string userId)
    {
        var user = await userManager.FindByIdAsync(userId);

        if (user == null)
        {
            return (false, "User account not found.", null);
        }

        var profileResult = await BuildUserProfileAsync(user);

        if (!profileResult.Success)
        {
            return (false, profileResult.Message, null);
        }

        var response = GenerateAuthResponse(
            user,
            profileResult.Roles,
            profileResult.Role,
            profileResult.PatientId,
            profileResult.DoctorId,
            "User authenticated successfully.");

        return (true, response.Message, response);
    }
}
