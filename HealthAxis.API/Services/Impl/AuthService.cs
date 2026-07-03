using HealthAxis.API.Constants;
using HealthAxis.Shared.Constants;
using HealthAxis.API.Data;
using HealthAxis.Shared.Dtos.Auth;
using HealthAxis.API.Models;
using HealthAxis.API.Repositories;
using Microsoft.AspNetCore.Identity;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace HealthAxis.API.Services.Impl;

public class AuthService(
    UserManager<IdentityUser> userManager,
    HealthAxisDbContext context,
    IPatientRepository patientRepository,
    IDoctorRepository doctorRepository,
    IConfiguration configuration) : IAuthService
{
    //private const string RefreshTokenProvider = "HealthAxis";

    //private const string RefreshTokenName = "RefreshToken";

    //private const string RefreshTokenExpiryName = "RefreshTokenExpiryUtc";

    public async Task<(bool Success, string Message, string UserId)> RegisterAsync(RegisterDto request)
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
                var errors = string.Join(", ", createResult.Errors.Select(error => error.Description));
                await transaction.RollbackAsync();
                return (false, errors, string.Empty);
            }

            var roleResult = await userManager.AddToRoleAsync(user, AppRoles.Patient);

            if (!roleResult.Succeeded)
            {
                var errors = string.Join(", ", roleResult.Errors.Select(error => error.Description));
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

    public async Task<(bool Success, string Message, AuthResponseDto? Response)> LoginAsync(LoginDto request)
    {
        var user = await userManager.FindByEmailAsync(request.Email);

        if (user == null)
        {
            return (false, ErrorMessages.InvalidCredentials, null);
        }

        var isPasswordValid = await userManager.CheckPasswordAsync(user, request.Password);

        if (!isPasswordValid)
        {
            return (false, ErrorMessages.InvalidCredentials, null);
        }

        var profileResult = await BuildUserProfileAsync(user);

        if (!profileResult.Success)
        {
            return (false, profileResult.Message, null);
        }

        var response = await GenerateAuthResponseAsync(
            user,
            profileResult.Roles,
            profileResult.Role,
            profileResult.PatientId,
            profileResult.DoctorId,
            "User logged in successfully.");

        return (true, response.Message, response);
    }

    // Refresh token support is intentionally paused for now.
    // Keep this implementation here so refresh support can be restored later if needed.
    /*
    public async Task<(bool Success, string Message, AuthResponseDto? Response)> RefreshTokenAsync(RefreshTokenRequestDto request)
    {
        var user = await userManager.FindByIdAsync(request.UserId);

        if (user == null)
        {
            return (false, ErrorMessages.InvalidRefreshToken, null);
        }

        var storedRefreshTokenHash = await userManager.GetAuthenticationTokenAsync(
            user,
            RefreshTokenProvider,
            RefreshTokenName);

        var storedExpiryValue = await userManager.GetAuthenticationTokenAsync(
            user,
            RefreshTokenProvider,
            RefreshTokenExpiryName);

        if (string.IsNullOrWhiteSpace(storedRefreshTokenHash) || string.IsNullOrWhiteSpace(storedExpiryValue))
        {
            return (false, ErrorMessages.InvalidRefreshToken, null);
        }

        if (!DateTime.TryParse(
            storedExpiryValue,
            CultureInfo.InvariantCulture,
            DateTimeStyles.RoundtripKind,
            out var expiresAtUtc))
        {
            return (false, ErrorMessages.InvalidRefreshToken, null);
        }

        if (DateTime.UtcNow >= expiresAtUtc)
        {
            await RemoveRefreshTokenAsync(user);
            return (false, ErrorMessages.RefreshTokenExpired, null);
        }

        var incomingRefreshTokenHash = HashToken(request.RefreshToken);

        if (!string.Equals(storedRefreshTokenHash, incomingRefreshTokenHash, StringComparison.Ordinal))
        {
            return (false, ErrorMessages.InvalidRefreshToken, null);
        }

        var profileResult = await BuildUserProfileAsync(user);

        if (!profileResult.Success)
        {
            return (false, profileResult.Message, null);
        }

        var response = await GenerateAuthResponseAsync(
            user,
            profileResult.Roles,
            profileResult.Role,
            profileResult.PatientId,
            profileResult.DoctorId,
            "Token refreshed successfully.");

        return (true, response.Message, response);
    }
    */

    private async Task<(bool Success, string Message, IList<string> Roles, string Role, int? PatientId, int? DoctorId)> BuildUserProfileAsync(IdentityUser user)
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
                return (false, ErrorMessages.PatientProfileNotFound, roles, role, null, null);
            }

            patientId = patient.Id;
        }

        if (string.Equals(role, AppRoles.Doctor, StringComparison.OrdinalIgnoreCase))
        {
            var doctor = await doctorRepository.GetDoctorByUserIdAsync(user.Id);

            if (doctor == null)
            {
                return (false, ErrorMessages.DoctorProfileNotFound, roles, role, null, null);
            }

            doctorId = doctor.Id;
        }

        return (true, string.Empty, roles, role, patientId, doctorId);
    }

    private async Task<AuthResponseDto> GenerateAuthResponseAsync(
        IdentityUser user,
        IList<string> roles,
        string role,
        int? patientId,
        int? doctorId,
        string message)
    {
        var expiresIn = int.Parse(configuration.GetSection("Jwt")["AccessTokenExpirationMinutes"]!);
        var token = GenerateToken(user, roles, expiresIn, patientId, doctorId);

        // Refresh token support is intentionally paused for now.
        // var refreshToken = GenerateRefreshToken();
        // await StoreRefreshTokenAsync(user, refreshToken);

        return new AuthResponseDto
        {
            AccessToken = token,
            // RefreshToken = refreshToken,
            Message = message,
            ExpiresIn = expiresIn,
            UserId = user.Id,
            PatientId = patientId,
            DoctorId = doctorId,
            Email = user.Email ?? string.Empty,
            Role = role
        };
    }

    // Refresh token support is intentionally paused for now.
    /*
    private async Task StoreRefreshTokenAsync(IdentityUser user, string refreshToken)
    {
        var refreshTokenExpirationDays = int.TryParse(
            configuration.GetSection("Jwt")["RefreshTokenExpirationDays"],
            out var configuredDays)
            ? configuredDays
            : 7;

        var refreshTokenHash = HashToken(refreshToken);
        var expiresAtUtc = DateTime.UtcNow.AddDays(refreshTokenExpirationDays);

        await userManager.SetAuthenticationTokenAsync(
            user,
            RefreshTokenProvider,
            RefreshTokenName,
            refreshTokenHash);

        await userManager.SetAuthenticationTokenAsync(
            user,
            RefreshTokenProvider,
            RefreshTokenExpiryName,
            expiresAtUtc.ToString("O", CultureInfo.InvariantCulture));
    }

    private async Task RemoveRefreshTokenAsync(IdentityUser user)
    {
        await userManager.RemoveAuthenticationTokenAsync(user, RefreshTokenProvider, RefreshTokenName);
        await userManager.RemoveAuthenticationTokenAsync(user, RefreshTokenProvider, RefreshTokenExpiryName);
    }
    */

    private string GenerateToken(
        IdentityUser user,
        IList<string> roles,
        int expiresIn,
        int? patientId,
        int? doctorId)
    {
        var jwtSettings = configuration.GetSection("Jwt");

        var key = new SymmetricSecurityKey(
            Encoding.UTF8.GetBytes(jwtSettings["Key"]!)
        );

        var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

        var claims = new List<Claim>
        {
            new Claim(AppClaimTypes.UserId, user.Id),
            new Claim(JwtRegisteredClaimNames.Sub, user.Id),
            new Claim(JwtRegisteredClaimNames.Email, user.Email ?? string.Empty),
            new Claim(ClaimTypes.NameIdentifier, user.Id),
            new Claim(ClaimTypes.Email, user.Email ?? string.Empty),
            new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
        };

        foreach (var role in roles)
        {
            claims.Add(new Claim(AppClaimTypes.Role, role));
            claims.Add(new Claim(ClaimTypes.Role, role));
        }

        if (patientId.HasValue)
        {
            claims.Add(new Claim(AppClaimTypes.PatientId, patientId.Value.ToString()));
        }

        if (doctorId.HasValue)
        {
            claims.Add(new Claim(AppClaimTypes.DoctorId, doctorId.Value.ToString()));
        }

        var token = new JwtSecurityToken(
            issuer: jwtSettings["Issuer"],
            audience: jwtSettings["Audience"],
            claims: claims,
            expires: DateTime.UtcNow.AddMinutes(expiresIn),
            signingCredentials: credentials
        );

        return new JwtSecurityTokenHandler().WriteToken(token);
    }

    public async Task<(bool Success, string Message, AuthResponseDto? Response)> CreateAuthResponseForUserIdAsync(string userId)
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

        var response = await GenerateAuthResponseAsync(
            user,
            profileResult.Roles,
            profileResult.Role,
            profileResult.PatientId,
            profileResult.DoctorId,
            "User authenticated successfully.");

        return (true, response.Message, response);
    }
    // Refresh token support is intentionally paused for now.
    /*
    private static string GenerateRefreshToken()
    {
        var randomBytes = RandomNumberGenerator.GetBytes(64);

        return Convert.ToBase64String(randomBytes);
    }

    private static string HashToken(string token)
    {
        var hashBytes = SHA256.HashData(Encoding.UTF8.GetBytes(token));

        return Convert.ToBase64String(hashBytes);
    }
    */
}
