using HealthAxis.API.Extensions;
using HealthAxis.API.Services;
using HealthAxis.Shared.Constants;
using HealthAxis.Shared.Dtos.Patient;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace HealthAxis.API.Controllers;

[ApiController]
[Route("api/patients")]
[Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
public class PatientsController(IPatientService patientService) : ControllerBase
{
    [HttpGet("me")]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = AppRoles.Patient)]
    public async Task<IActionResult> GetCurrentPatient()
    {
        var patientId = User.GetPatientId();

        if (patientId == null)
        {
            return Forbid();
        }

        var patient = await patientService.GetPatientByIdAsync(patientId.Value);

        return Ok(patient);
    }

    [HttpPut("me")]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = AppRoles.Patient)]
    public async Task<IActionResult> UpdateCurrentPatient(UpdatePatientDto request)
    {
        var patientId = User.GetPatientId();

        if (patientId == null)
        {
            return Forbid();
        }

        var patient = await patientService.UpdatePatientAsync(patientId.Value, request);

        return Ok(patient);
    }

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

    private bool IsOwnPatientId(int patientId)
    {
        return User.GetPatientId() == patientId;
    }
}
