using System.Security.Claims;
using HealthAxis.API.Constants;
using HealthAxis.Shared.Constants;
using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Dtos.Doctor;
using HealthAxis.Shared.Enums;
using HealthAxis.API.Exceptions;
using HealthAxis.API.Services;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace HealthAxis.API.Controllers;

[ApiController]
[Route("api/doctors")]
public class DoctorsController(IDoctorService doctorService) : ControllerBase
{
    [HttpGet]
    [AllowAnonymous]
    public async Task<IActionResult> GetDoctors(
        [FromQuery] DoctorSpecialisation? specialisation,
        [FromQuery] PaginationQueryDto pagination)
    {
        var doctors = await doctorService.GetAllDoctorsAsync(pagination, specialisation);

        return Ok(doctors);
    }

    [HttpGet("available-slots")]
    [AllowAnonymous]
    public async Task<IActionResult> GetAvailableSlots(
        [FromQuery] DateOnly date,
        [FromQuery] DoctorSpecialisation? specialisation,
        [FromQuery] PaginationQueryDto pagination)
    {
        var doctors = await doctorService.GetAvailableSlotsAsync(date, specialisation, pagination);

        return Ok(doctors);
    }

    [HttpGet("{id:int}")]
    [AllowAnonymous]
    public async Task<IActionResult> GetDoctorById(int id)
    {
        var doctor = await doctorService.GetDoctorByIdAsync(id);

        if (doctor == null)
        {
            throw new NotFoundException(ErrorMessages.DoctorNotFound);
        }

        return Ok(doctor);
    }

    [HttpGet("{id:int}/availability")]
    [AllowAnonymous]
    public async Task<IActionResult> GetAvailability(int id)
    {
        var availability = await doctorService.GetAvailabilityAsync(id);

        if (availability == null)
        {
            throw new NotFoundException(ErrorMessages.DoctorNotFound);
        }

        return Ok(availability);
    }

    [HttpGet("{id:int}/slots")]
    [AllowAnonymous]
    public async Task<IActionResult> GetDoctorSlots(int id, [FromQuery] DateOnly date)
    {
        var slots = await doctorService.GetDoctorSlotsAsync(id, date);

        return Ok(slots);
    }

    [HttpPut("{id:int}/availability")]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = AppRoles.DoctorAdmin)]
    public async Task<IActionResult> UpdateAvailability(int id, UpdateDoctorAvailabilityDto request)
    {
        var currentRole = GetCurrentRole();

        if (currentRole == null)
        {
            return Forbid();
        }

        var availability = await doctorService.UpdateAvailabilityAsync(
            id,
            request,
            currentRole,
            GetDoctorIdFromToken());

        return Ok(availability);
    }

    private string? GetCurrentRole()
    {
        if (User.IsInRole(AppRoles.Admin))
        {
            return AppRoles.Admin;
        }

        if (User.IsInRole(AppRoles.Doctor))
        {
            return AppRoles.Doctor;
        }

        return null;
    }

    private int? GetDoctorIdFromToken()
    {
        var claimValue = User.FindFirstValue(AppClaimTypes.DoctorId);

        return int.TryParse(claimValue, out var doctorId)
            ? doctorId
            : null;
    }
}
