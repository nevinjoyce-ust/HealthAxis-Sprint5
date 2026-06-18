using System.Security.Claims;
using HealthAxis.API.Constants;
using HealthAxis.API.Dtos;
using HealthAxis.API.Services;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace HealthAxis.API.Controllers;

[ApiController]
[Route("api/patients")]
[Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
public class PatientsController(IPatientService patientService) : ControllerBase
{
    [HttpGet("{id:int}")]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = AppRoles.PatientAdmin)]
    public async Task<IActionResult> GetPatientById(int id)
    {
        if (User.IsInRole(AppRoles.Patient) && !IsOwnPatientId(id))
        {
            return Forbid();
        }

        var patient = await patientService.GetPatientByIdAsync(id);

        return Ok(patient);
    }

    [HttpPut("{id:int}")]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = AppRoles.PatientAdmin)]
    public async Task<IActionResult> UpdatePatient(int id, UpdatePatientDto request)
    {
        if (User.IsInRole(AppRoles.Patient) && !IsOwnPatientId(id))
        {
            return Forbid();
        }

        var patient = await patientService.UpdatePatientAsync(id, request);

        return Ok(patient);
    }

    [HttpGet("{id:int}/health-records")]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = AppRoles.PatientDoctor)]
    public async Task<IActionResult> GetPatientHealthRecords(
        int id,
        [FromQuery] PaginationQueryDto pagination)
    {
        if (User.IsInRole(AppRoles.Patient) && !IsOwnPatientId(id))
        {
            return Forbid();
        }

        var records = await patientService.GetPatientHealthRecordsAsync(id, pagination);

        return Ok(records);
    }

    private bool IsOwnPatientId(int patientId)
    {
        var claimValue = User.FindFirstValue(AppClaimTypes.PatientId);

        return int.TryParse(claimValue, out var loggedInPatientId) &&
               loggedInPatientId == patientId;
    }
}
