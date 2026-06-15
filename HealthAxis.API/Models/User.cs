using System.ComponentModel.DataAnnotations;

namespace HealthAxis.API.Models;

public class User
{
    [Key]
    public int Id { get; set; }

    [Required]
    [StringLength(100)]
    public string FullName { get; set; } = string.Empty;

    [Required]
    [EmailAddress]
    [StringLength(150)]
    public string Email { get; set; } = string.Empty;

    [Required]
    [StringLength(500)]
    public string PasswordHash { get; set; } = string.Empty;

    [Required]
    [StringLength(30)]
    public string Role { get; set; } = string.Empty;

    public bool IsActive { get; set; } = true;

    public Doctor? Doctor { get; set; }

    public Patient? Patient { get; set; }
}