using HealthAxis.API.Constants;
using HealthAxis.API.Exceptions;
using HealthAxis.API.Extensions;
using HealthAxis.API.Services;
using HealthAxis.Shared.Constants;
using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Dtos.Doctor;
using HealthAxis.Shared.Enums;
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
    [HttpGet("me")]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = AppRoles.Doctor)]
    public async Task<IActionResult> GetCurrentDoctor()
    {
        var doctorId = User.GetDoctorId();

        if (doctorId == null)
        {
            return Forbid();
        }

        var doctor = await doctorService.GetDoctorByIdAsync(doctorId.Value);

        if (doctor == null)
        {
            throw new NotFoundException(ErrorMessages.DoctorNotFound);
        }

        return Ok(doctor);
    }

    [HttpPut("me/availability")]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = AppRoles.Doctor)]
    public async Task<IActionResult> UpdateCurrentDoctorAvailability(UpdateDoctorAvailabilityDto request)
    {
        var doctorId = User.GetDoctorId();

        if (doctorId == null)
        {
            return Forbid();
        }

        var availability = await doctorService.UpdateAvailabilityAsync(
            doctorId.Value,
            request,
            AppRoles.Doctor,
            doctorId.Value);

        return Ok(availability);
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
        var currentRole = User.GetCurrentRole();

        if (currentRole == null)
        {
            return Forbid();
        }

        var availability = await doctorService.UpdateAvailabilityAsync(
            id,
            request,
            currentRole,
            User.GetDoctorId());

        return Ok(availability);
    }
}
