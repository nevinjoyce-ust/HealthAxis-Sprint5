using System.Security.Claims;
using HealthAxis.Shared.Constants;

namespace HealthAxis.API.Extensions;

public static class ClaimsPrincipalExtensions
{
    public static int? GetPatientId(this ClaimsPrincipal user)
    {
        var claimValue = user.FindFirstValue(AppClaimTypes.PatientId);

        return int.TryParse(claimValue, out var patientId)
            ? patientId
            : null;
    }

    public static int? GetDoctorId(this ClaimsPrincipal user)
    {
        var claimValue = user.FindFirstValue(AppClaimTypes.DoctorId);

        return int.TryParse(claimValue, out var doctorId)
            ? doctorId
            : null;
    }

    public static string? GetCurrentRole(this ClaimsPrincipal user)
    {
        if (user.IsInRole(AppRoles.Admin))
        {
            return AppRoles.Admin;
        }

        if (user.IsInRole(AppRoles.Doctor))
        {
            return AppRoles.Doctor;
        }

        if (user.IsInRole(AppRoles.Patient))
        {
            return AppRoles.Patient;
        }

        return null;
    }
}