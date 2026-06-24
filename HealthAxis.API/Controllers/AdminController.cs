using HealthAxis.API.Constants;
using HealthAxis.Shared.Constants;
using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Dtos.Auth;
using HealthAxis.Shared.Dtos.Doctor;
using HealthAxis.Shared.Dtos.Patient;
using HealthAxis.Shared.Enums;
using HealthAxis.API.Services;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace HealthAxis.API.Controllers;

[ApiController]
[Route("api/admin")]
[Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = AppRoles.Admin)]
public class AdminController(IAdminService adminService) : ControllerBase
{
    [HttpGet("dashboard-summary")]
    public async Task<IActionResult> GetDashboardSummary()
    {
        var summary = await adminService.GetDashboardSummaryAsync();

        return Ok(summary);
    }

    [HttpGet("doctors")]
    public async Task<IActionResult> GetDoctors(
        [FromQuery] string? search,
        [FromQuery] DoctorSpecialisation? specialisation,
        [FromQuery] PaginationQueryDto pagination)
    {
        var doctors = await adminService.GetDoctorsAsync(pagination, search, specialisation);

        return Ok(doctors);
    }

    [HttpPost("doctors")]
    public async Task<IActionResult> CreateDoctor(CreateDoctorDto request)
    {
        var doctor = await adminService.CreateDoctorAsync(request);

        return doctor == null
            ? throw new InvalidOperationException(ErrorMessages.UnableToCreateDoctor)
            : Created($"/api/admin/doctors/{doctor.Id}", doctor);
    }

    [HttpPut("doctors/{id:int}")]
    public async Task<IActionResult> UpdateDoctor(int id, UpdateDoctorDto request)
    {
        var doctor = await adminService.UpdateDoctorAsync(id, request);

        return Ok(doctor);
    }

    [HttpPut("doctors/{id:int}/password")]
    public async Task<IActionResult> ResetDoctorPassword(int id, AdminResetPasswordDto request)
    {
        await adminService.ResetDoctorPasswordAsync(id, request);

        return Ok(new { message = "Doctor password reset successfully." });
    }

    [HttpGet("doctors/{id:int}/appointments")]
    public async Task<IActionResult> GetDoctorAppointments(
    int id,
    [FromQuery] AppointmentStatus? status,
    [FromQuery] PaginationQueryDto pagination)
    {
        var appointments = await adminService.GetDoctorAppointmentsAsync(id, status, pagination);

        return Ok(appointments);

    }

    [HttpGet("patients")]
    public async Task<IActionResult> GetPatients(
        [FromQuery] string? search,
        [FromQuery] PaginationQueryDto pagination)
    {
        var patients = await adminService.GetPatientsAsync(pagination, search);

        return Ok(patients);
    }

    [HttpPut("patients/{id:int}")]
    public async Task<IActionResult> UpdatePatient(int id, UpdatePatientDto request)
    {
        var patient = await adminService.UpdatePatientAsync(id, request);

        return Ok(patient);
    }

    [HttpPut("patients/{id:int}/password")]
    public async Task<IActionResult> ResetPatientPassword(int id, AdminResetPasswordDto request)
    {
        await adminService.ResetPatientPasswordAsync(id, request);

        return Ok(new { message = "Patient password reset successfully." });
    }

    [HttpGet("patients/{id:int}/appointments")]
    public async Task<IActionResult> GetPatientAppointments(
        int id,
        [FromQuery] AppointmentStatus? status,
        [FromQuery] PaginationQueryDto pagination)
    {
        var appointments = await adminService.GetPatientAppointmentsAsync(id, status, pagination);

        return Ok(appointments);
    }

    [HttpGet("reports/appointments")]
    public async Task<IActionResult> GetAppointmentReports([FromQuery] PaginationQueryDto pagination)
    {
        var reports = await adminService.GetAppointmentReportsAsync(pagination);

        return Ok(reports);
    }

    [HttpGet("reports/appointments/details")]
    public async Task<IActionResult> GetAppointmentReportDetails(
        [FromQuery] DateOnly date,
        [FromQuery] AppointmentStatus? status,
        [FromQuery] PaginationQueryDto pagination)
    {
        var appointments = await adminService.GetAppointmentReportDetailsAsync(
            date,
            status,
            pagination);

        return Ok(appointments);
    }
}
