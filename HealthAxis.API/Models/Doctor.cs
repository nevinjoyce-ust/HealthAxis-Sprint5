using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using HealthAxis.API.Enums;
using HealthAxis.API.Validation;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace HealthAxis.API.Models;

public class Doctor
{
    [Key]
    public int Id { get; set; }

    [Required]
    public string UserId { get; set; } = string.Empty;

    [Required]
    [StringLength(100)]
    public string FullName { get; set; } = string.Empty;

    [Required]
    public DoctorSpecialisation Specialisation { get; set; }

    [Required]
    [PracticeStartDate(70)]
    public DateOnly PracticeStartDate { get; set; }

    [Precision(18, 2)]
    [Range(0, 999999)]
    public decimal ConsultationFee { get; set; }

    public bool IsAvailable { get; set; } = true;

    [ForeignKey(nameof(UserId))]
    public IdentityUser? User { get; set; }

    public ICollection<Appointment> Appointments { get; set; } = new List<Appointment>();

    [NotMapped]
    public int YearsOfExperience => CalculateYearsOfExperience();

    public int CalculateYearsOfExperience()
    {
        var today = DateOnly.FromDateTime(DateTime.Today);
        var years = today.Year - PracticeStartDate.Year;

        if (today < PracticeStartDate.AddYears(years))
        {
            years--;
        }

        return years < 0 ? 0 : years;
    }
}
