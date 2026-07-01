using HealthAxis.API.Constants;
using HealthAxis.API.Services;
using HealthAxis.Shared.Constants;
using HealthAxis.Shared.Dtos.Auth;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace HealthAxis.API.Controllers;

[ApiController]
[Route("api/auth")]
public class AuthController(
    IAuthService authService,
    UserManager<IdentityUser> userManager,
    IAdminHandoffService adminHandoffService) : ControllerBase
{
    [HttpPost("register")]
    public async Task<IActionResult> Register(RegisterDto request)
    {
        var result = await authService.RegisterAsync(request);

        if (!result.Success)
        {
            return BadRequest(new { message = result.Message });
        }

        return Created(string.Empty, new
        {
            message = result.Message,
            userId = result.UserId
        });
    }

    [HttpPost("login")]
    public async Task<IActionResult> Login(LoginDto request)
    {
        var result = await authService.LoginAsync(request);

        if (!result.Success || result.Response == null)
        {
            return Unauthorized(new { message = ErrorMessages.InvalidCredentials });
        }

        return Ok(result.Response);
    }

    // Refresh token support is intentionally paused for now.
    // Keep RefreshTokenRequestDto and AuthService refresh-token notes around so this can be restored later if needed.
    //
    // [HttpPost("refresh-token")]
    // public async Task<IActionResult> RefreshToken(RefreshTokenRequestDto request)
    // {
    //     var result = await authService.RefreshTokenAsync(request);
    //
    //     if (!result.Success || result.Response == null)
    //     {
    //         return Unauthorized(new { message = result.Message });
    //     }
    //
    //     return Ok(result.Response);
    // }

    [HttpPut("change-password")]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public async Task<IActionResult> ChangePassword(ChangePasswordDto request)
    {
        var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);

        if (string.IsNullOrWhiteSpace(userId))
        {
            return Forbid();
        }

        var user = await userManager.FindByIdAsync(userId);

        if (user == null)
        {
            return NotFound(new { message = "User account not found." });
        }

        var result = await userManager.ChangePasswordAsync(
            user,
            request.CurrentPassword,
            request.NewPassword);

        if (!result.Succeeded)
        {
            var errors = string.Join(" ", result.Errors.Select(error => error.Description));
            return BadRequest(new { message = errors });
        }

        return Ok(new { message = "Password changed successfully." });
    }

    [HttpPost("admin-handoff-code")]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = AppRoles.Admin)]
    public IActionResult CreateAdminHandoffCode()
    {
        var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);

        if (string.IsNullOrWhiteSpace(userId))
        {
            return Forbid();
        }

        var code = adminHandoffService.CreateCode(userId);

        return Ok(new AdminHandoffCodeResponseDto
        {
            Code = code,
            ExpiresInSeconds = 60
        });
    }
    [HttpPost("admin-handoff-exchange")]
    [AllowAnonymous]
    public async Task<IActionResult> ExchangeAdminHandoffCode(AdminHandoffExchangeDto request)
    {
        var userId = adminHandoffService.ConsumeCode(request.Code);

        if (string.IsNullOrWhiteSpace(userId))
        {
            return Unauthorized(new { message = "Invalid or expired admin handoff code." });
        }

        var result = await authService.CreateAuthResponseForUserIdAsync(userId);

        if (!result.Success || result.Response == null)
        {
            return Unauthorized(new { message = result.Message });
        }

        if (!string.Equals(result.Response.Role, AppRoles.Admin, StringComparison.OrdinalIgnoreCase))
        {
            return Forbid();
        }

        return Ok(result.Response);
    }
}
