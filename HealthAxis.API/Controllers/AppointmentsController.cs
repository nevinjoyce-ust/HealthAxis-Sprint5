using System.Security.Claims;
using HealthAxis.API.Constants;
using HealthAxis.Shared.Constants;
using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Dtos.Appointment;
using HealthAxis.API.Services;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace HealthAxis.API.Controllers;

[ApiController]
[Route("api/appointments")]
[Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = AppRoles.PatientDoctorAdmin)]
public class AppointmentsController(IAppointmentService appointmentService) : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> GetAppointments(
        [FromQuery] DateOnly? date,
        [FromQuery] PaginationQueryDto pagination)
    {
        if (User.IsInRole(AppRoles.Admin))
        {
            var appointments = await appointmentService.GetAllAppointmentsAsync(pagination);
            return Ok(appointments);
        }

        if (User.IsInRole(AppRoles.Patient))
        {
            var patientId = GetPatientIdFromToken();

            if (patientId == null)
            {
                return Forbid();
            }

            var appointments = await appointmentService.GetAppointmentsByPatientIdAsync(patientId.Value, null, pagination);
            return Ok(appointments);
        }

        if (User.IsInRole(AppRoles.Doctor))
        {
            var doctorId = GetDoctorIdFromToken();

            if (doctorId == null)
            {
                return Forbid();
            }

            var appointments = date.HasValue
                ? await appointmentService.GetAppointmentsByDoctorIdAndDateAsync(doctorId.Value, date.Value, pagination)
                : await appointmentService.GetAppointmentsByDoctorIdAsync(doctorId.Value, null, pagination);

            return Ok(appointments);
        }

        return Forbid();
    }

    [HttpGet("{id:int}")]
    public async Task<IActionResult> GetAppointmentById(int id)
    {
        var appointment = await appointmentService.GetAppointmentByIdAsync(id);

        if (User.IsInRole(AppRoles.Patient) && GetPatientIdFromToken() != appointment.PatientId)
        {
            return Forbid();
        }

        if (User.IsInRole(AppRoles.Doctor) && GetDoctorIdFromToken() != appointment.DoctorId)
        {
            return Forbid();
        }

        return Ok(appointment);
    }

    [HttpPost]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = AppRoles.PatientAdmin)]
    public async Task<IActionResult> CreateAppointment(CreateAppointmentDto request)
    {
        if (User.IsInRole(AppRoles.Patient))
        {
            var patientId = GetPatientIdFromToken();

            if (patientId == null || patientId.Value != request.PatientId)
            {
                return Forbid();
            }
        }

        var appointment = await appointmentService.CreateAppointmentAsync(request);

        return appointment == null
            ? throw new InvalidOperationException(ErrorMessages.UnableToCreateAppointment)
            : CreatedAtAction(nameof(GetAppointmentById), new { id = appointment.Id }, appointment);
    }

    [HttpPut("{id:int}/status")]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = AppRoles.PatientDoctorAdmin)]
    public async Task<IActionResult> UpdateAppointmentStatus(int id, UpdateAppointmentStatusDto request)
    {
        var currentRole = GetCurrentRole();

        if (currentRole == null)
        {
            return Forbid();
        }

        var appointment = await appointmentService.UpdateAppointmentStatusAsync(
            id,
            request,
            currentRole,
            GetPatientIdFromToken(),
            GetDoctorIdFromToken());

        return Ok(appointment);
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

        if (User.IsInRole(AppRoles.Patient))
        {
            return AppRoles.Patient;
        }

        return null;
    }

    private int? GetPatientIdFromToken()
    {
        var claimValue = User.FindFirstValue(AppClaimTypes.PatientId);

        return int.TryParse(claimValue, out var patientId)
            ? patientId
            : null;
    }

    private int? GetDoctorIdFromToken()
    {
        var claimValue = User.FindFirstValue(AppClaimTypes.DoctorId);

        return int.TryParse(claimValue, out var doctorId)
            ? doctorId
            : null;
    }
}
