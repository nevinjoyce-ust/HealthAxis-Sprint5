using System.ComponentModel.DataAnnotations;

namespace HealthAxis.API.Validation;

[AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
public class PracticeStartDateAttribute : ValidationAttribute
{
    private readonly int _maxYearsInPast;

    public PracticeStartDateAttribute(int maxYearsInPast = 70)
    {
        _maxYearsInPast = maxYearsInPast;
    }

    protected override ValidationResult? IsValid(object? value, ValidationContext validationContext)
    {
        if (value == null)
        {
            return ValidationResult.Success;
        }

        if (value is not DateOnly practiceStartDate)
        {
            return new ValidationResult("Practice start date must be a valid date.");
        }

        var today = DateOnly.FromDateTime(DateTime.Today);
        var earliestAllowedDate = today.AddYears(-_maxYearsInPast);

        if (practiceStartDate > today)
        {
            return new ValidationResult("Practice start date cannot be in the future.");
        }

        if (practiceStartDate < earliestAllowedDate)
        {
            return new ValidationResult($"Practice start date cannot be more than {_maxYearsInPast} years in the past.");
        }

        return ValidationResult.Success;
    }
}
