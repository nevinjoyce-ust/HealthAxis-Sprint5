using HealthAxis.API.Extensions;
using HealthAxis.API.Services;
using HealthAxis.Shared.Constants;
using HealthAxis.Shared.Dtos;
using HealthAxis.Shared.Dtos.HealthRecord;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace HealthAxis.API.Controllers;

[ApiController]
[Route("api/health-records")]
[Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme, Roles = AppRoles.PatientDoctor)]
public class HealthRecordsController(IHealthRecordService healthRecordService) : ControllerBase
{
    [HttpGet("me")]
    public async Task<IActionResult> GetCurrentUserHealthRecords(
    [FromQuery] PaginationQueryDto pagination)
    {
        if (User.IsInRole(AppRoles.Patient))
        {
            var patientId = User.GetPatientId();

            if (patientId == null)
            {
                return Forbid();
            }

            var records = await healthRecordService.GetHealthRecordsByPatientIdAsync(
                patientId.Value,
                pagination);

            return Ok(records);
        }

        if (User.IsInRole(AppRoles.Doctor))
        {
            var doctorId = User.GetDoctorId();

            if (doctorId == null)
            {
                return Forbid();
            }

            var records = await healthRecordService.GetHealthRecordsByDoctorIdAsync(
                doctorId.Value,
                pagination);

            return Ok(records);
        }

        return Forbid();
    }

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
            var doctorId = User.GetDoctorId();

            if (doctorId == null)
            {
                return Forbid();
            }

            var doctorRecords = await healthRecordService.GetHealthRecordsForDoctorPatientViewAsync(
                patientId,
                doctorId.Value,
                pagination);

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
            var doctorId = User.GetDoctorId();

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
        var doctorId = User.GetDoctorId();

        if (doctorId == null)
        {
            return Forbid();
        }

        var record = await healthRecordService.CreateHealthRecordAsync(request, doctorId.Value);

        return CreatedAtAction(nameof(GetHealthRecordById), new { id = record.Id }, record);
    }

    private bool IsOwnPatientId(int patientId)
    {
        return User.GetPatientId() == patientId;
    }

}
