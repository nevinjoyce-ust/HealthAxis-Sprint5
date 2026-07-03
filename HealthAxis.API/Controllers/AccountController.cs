using HealthAxis.Shared.Dtos.Auth;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace HealthAxis.API.Controllers;

[ApiController]
[Route("api/account")]
[Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
public class AccountController(UserManager<IdentityUser> userManager) : ControllerBase
{
    [HttpPut("change-password")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> ChangePassword(ChangePasswordDto request)
    {
        if (request.CurrentPassword == request.NewPassword)
        {
            return BadRequest(new { message = "New password must be different from the current password." });
        }

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
}