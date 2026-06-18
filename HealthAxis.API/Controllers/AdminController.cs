using HealthAxis.API.Constants;
using HealthAxis.API.Dtos;
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
    [HttpGet("doctors")]
    public async Task<IActionResult> GetDoctors([FromQuery] PaginationQueryDto pagination)
    {
        var doctors = await adminService.GetDoctorsAsync(pagination);

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

    [HttpGet("reports/appointments")]
    public async Task<IActionResult> GetAppointmentReports()
    {
        var reports = await adminService.GetAppointmentReportsAsync();

        return Ok(reports);
    }

    [HttpGet("reports/appointments-health-records")]
    public async Task<IActionResult> GetAppointmentHealthRecordReports()
    {
        var reports = await adminService.GetAppointmentHealthRecordReportsAsync();

        return Ok(reports);
    }
}
