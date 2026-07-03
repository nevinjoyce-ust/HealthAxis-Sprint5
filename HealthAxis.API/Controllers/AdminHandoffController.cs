using HealthAxis.API.Services;
using HealthAxis.Shared.Constants;
using HealthAxis.Shared.Dtos.Auth;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace HealthAxis.API.Controllers;

[ApiController]
[Route("api/admin-handoff")]
public class AdminHandoffController(
    IAuthService authService,
    IAdminHandoffService adminHandoffService) : ControllerBase
{
    [HttpPost("code")]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = AppRoles.Admin)]
    [ProducesResponseType(typeof(AdminHandoffCodeResponseDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
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

    [HttpPost("exchange")]
    [AllowAnonymous]
    [ProducesResponseType(typeof(AuthResponseDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
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