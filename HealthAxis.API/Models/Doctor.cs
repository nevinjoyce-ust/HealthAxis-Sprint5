using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace HealthAxis.API.Models;

public class Doctor
{
    [Key]
    public int Id { get; set; }

    [Required]
    public int UserId { get; set; }

    [Required]
    [StringLength(100)]
    public string Specialisation { get; set; } = string.Empty;

    [Range(0, 60)]
    public int ExperienceYears { get; set; }

    [Precision(18, 2)]
    [Range(0, 999999)]
    public decimal ConsultationFee { get; set; }

    public bool IsAvailable { get; set; } = true;

    [ForeignKey(nameof(UserId))]
    public User? User { get; set; }

    public ICollection<Appointment> Appointments { get; set; } = new List<Appointment>();

    public ICollection<HealthRecord> HealthRecords { get; set; } = new List<HealthRecord>();
}
