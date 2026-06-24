using System.ComponentModel.DataAnnotations;

namespace HealthAxis.Shared.Validation;

[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field, AllowMultiple = false)]
public sealed class DateOfBirthAttribute : ValidationAttribute
{
    public DateOfBirthAttribute()
    {
        ErrorMessage = "Date of birth cannot be in the future.";
    }

    protected override ValidationResult? IsValid(object? value, ValidationContext validationContext)
    {
        if (value is null)
        {
            return ValidationResult.Success;
        }

        if (value is not DateOnly dateOfBirth)
        {
            return new ValidationResult("Date of birth must be a valid date.");
        }

        var today = DateOnly.FromDateTime(DateTime.Today);

        return dateOfBirth > today
            ? new ValidationResult(ErrorMessage)
            : ValidationResult.Success;
    }
}
