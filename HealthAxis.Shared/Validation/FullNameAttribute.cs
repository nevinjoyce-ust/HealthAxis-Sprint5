using System.ComponentModel.DataAnnotations;
using System.Text.RegularExpressions;

namespace HealthAxis.Shared.Validation;

[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field, AllowMultiple = false)]
public sealed class FullNameAttribute : ValidationAttribute
{
    private static readonly Regex FullNameRegex = new(
        "^[A-Z][A-Za-z]*(?: [A-Za-z]+)*$",
        RegexOptions.Compiled);

    public FullNameAttribute()
    {
        ErrorMessage = "Full name must start with a capital letter and contain only letters and single spaces.";
    }

    public override bool IsValid(object? value)
    {
        if (value is null)
        {
            return true;
        }

        var fullName = value.ToString();

        if (string.IsNullOrWhiteSpace(fullName))
        {
            return true;
        }

        return FullNameRegex.IsMatch(fullName);
    }
}
