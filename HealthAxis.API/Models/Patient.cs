using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.AspNetCore.Identity;

namespace HealthAxis.API.Models;

public class Patient
{
    [Key]
    public int Id { get; set; }

    [Required]
    public string UserId { get; set; } = string.Empty;

    [Required]
    [StringLength(100)]
    public string FullName { get; set; } = string.Empty;

    [Required]
    public DateOnly DateOfBirth { get; set; }

    [Required]
    [StringLength(20)]
    public string Gender { get; set; } = string.Empty;

    [Required]
    [StringLength(250)]
    public string Address { get; set; } = string.Empty;

    [ForeignKey(nameof(UserId))]
    public IdentityUser? User { get; set; }

    public ICollection<Appointment> Appointments { get; set; } = new List<Appointment>();
}
