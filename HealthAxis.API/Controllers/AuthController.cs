using HealthAxis.API.Constants;
using HealthAxis.API.Services;
using HealthAxis.Shared.Dtos.Auth;
using Microsoft.AspNetCore.Mvc;

namespace HealthAxis.API.Controllers;

[ApiController]
[Route("api/auth")]
public class AuthController(IAuthService authService) : ControllerBase
{
    [HttpPost("register")]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
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
    [ProducesResponseType(typeof(AuthResponseDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public async Task<IActionResult> Login(LoginDto request)
    {
        var result = await authService.LoginAsync(request);

        if (!result.Success || result.Response == null)
        {
            return Unauthorized(new { message = ErrorMessages.InvalidCredentials });
        }

        return Ok(result.Response);
    }
}