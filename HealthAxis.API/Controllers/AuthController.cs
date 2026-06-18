using HealthAxis.API.Dtos.Auth;
using HealthAxis.API.Services;
using Microsoft.AspNetCore.Mvc;

namespace HealthAxis.API.Controllers;

[ApiController]
[Route("api/auth")]
public class AuthController(IAuthService authService) : ControllerBase
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
            return Unauthorized(new { message = result.Message });
        }

        return Ok(result.Response);
    }

    [HttpPost("refresh-token")]
    public async Task<IActionResult> RefreshToken(RefreshTokenRequestDto request)
    {
        var result = await authService.RefreshTokenAsync(request);

        if (!result.Success || result.Response == null)
        {
            return Unauthorized(new { message = result.Message });
        }

        return Ok(result.Response);
    }
}
