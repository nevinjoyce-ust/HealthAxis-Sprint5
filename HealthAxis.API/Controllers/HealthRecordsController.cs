using System.Security.Claims;
using HealthAxis.API.Constants;
using HealthAxis.API.Dtos;
using HealthAxis.API.Services;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace HealthAxis.API.Controllers;

[ApiController]
[Route("api/health-records")]
[Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = AppRoles.PatientDoctor)]
public class HealthRecordsController(IHealthRecordService healthRecordService) : ControllerBase
{
    [HttpGet("patient/{patientId:int}")]
    public async Task<IActionResult> GetHealthRecordsByPatientId(
        int patientId,
        [FromQuery] PaginationQueryDto pagination)
    {
        if (User.IsInRole(AppRoles.Patient))
        {
            if (!IsOwnPatientId(patientId))
            {
                return Forbid();
            }

            var patientRecords = await healthRecordService.GetHealthRecordsByPatientIdAsync(patientId, pagination);
            return Ok(patientRecords);
        }

        if (User.IsInRole(AppRoles.Doctor))
        {
            var doctorId = GetDoctorIdFromToken();

            if (doctorId == null)
            {
                return Forbid();
            }

            var doctorRecords = await healthRecordService.GetHealthRecordsForDoctorPatientViewAsync(
                patientId,
                doctorId.Value,
                pagination
            );

            return Ok(doctorRecords);
        }

        return Forbid();
    }

    [HttpGet("{id:int}")]
    public async Task<IActionResult> GetHealthRecordById(int id)
    {
        var record = await healthRecordService.GetHealthRecordByIdAsync(id);

        if (User.IsInRole(AppRoles.Patient) && !IsOwnPatientId(record.PatientId))
        {
            return Forbid();
        }

        if (User.IsInRole(AppRoles.Doctor))
        {
            var doctorId = GetDoctorIdFromToken();

            if (doctorId == null || doctorId.Value != record.DoctorId)
            {
                return Forbid();
            }
        }

        return Ok(record);
    }

    [HttpPost]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = AppRoles.Doctor)]
    public async Task<IActionResult> CreateHealthRecord(CreateHealthRecordDto request)
    {
        var doctorId = GetDoctorIdFromToken();

        if (doctorId == null)
        {
            return Forbid();
        }

        var record = await healthRecordService.CreateHealthRecordAsync(request, doctorId.Value);

        return CreatedAtAction(nameof(GetHealthRecordById), new { id = record.Id }, record);
    }

    private bool IsOwnPatientId(int patientId)
    {
        var claimValue = User.FindFirstValue(AppClaimTypes.PatientId);

        return int.TryParse(claimValue, out var loggedInPatientId) &&
               loggedInPatientId == patientId;
    }

    private int? GetDoctorIdFromToken()
    {
        var claimValue = User.FindFirstValue(AppClaimTypes.DoctorId);

        return int.TryParse(claimValue, out var doctorId)
            ? doctorId
            : null;
    }
}
