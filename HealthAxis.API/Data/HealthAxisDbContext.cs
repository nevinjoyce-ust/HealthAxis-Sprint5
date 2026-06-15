using HealthAxis.API.Models;
using Microsoft.EntityFrameworkCore;

namespace HealthAxis.API.Data;

public class HealthAxisDbContext : DbContext
{
    public HealthAxisDbContext(DbContextOptions<HealthAxisDbContext> options)
        : base(options)
    {
    }

    public DbSet<User> Users { get; set; }

    public DbSet<Doctor> Doctors { get; set; }

    public DbSet<Patient> Patients { get; set; }

    public DbSet<Appointment> Appointments { get; set; }

    public DbSet<HealthRecord> HealthRecords { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<User>()
            .HasIndex(user => user.Email)
            .IsUnique();

        modelBuilder.Entity<User>()
            .HasOne(user => user.Doctor)
            .WithOne(doctor => doctor.User)
            .HasForeignKey<Doctor>(doctor => doctor.UserId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<User>()
            .HasOne(user => user.Patient)
            .WithOne(patient => patient.User)
            .HasForeignKey<Patient>(patient => patient.UserId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<User>()
            .Property(user => user.Role)
            .HasConversion<string>()
            .HasMaxLength(30)
            .IsRequired();

        modelBuilder.Entity<Appointment>()
            .HasOne(appointment => appointment.Patient)
            .WithMany(patient => patient.Appointments)
            .HasForeignKey(appointment => appointment.PatientId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<Appointment>()
            .HasOne(appointment => appointment.Doctor)
            .WithMany(doctor => doctor.Appointments)
            .HasForeignKey(appointment => appointment.DoctorId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<Appointment>()
            .Property(appointment => appointment.Status)
            .HasConversion<string>()
            .HasMaxLength(30)
            .IsRequired();

        modelBuilder.Entity<HealthRecord>()
            .HasOne(record => record.Patient)
            .WithMany(patient => patient.HealthRecords)
            .HasForeignKey(record => record.PatientId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<HealthRecord>()
            .HasOne(record => record.Doctor)
            .WithMany(doctor => doctor.HealthRecords)
            .HasForeignKey(record => record.DoctorId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<Doctor>()
            .Property(doctor => doctor.Specialisation)
            .HasConversion<string>()
            .HasMaxLength(100)
            .IsRequired();


        modelBuilder.Entity<User>().HasData(
            new User
            {
                Id = 1,
                FullName = "System Admin",
                Email = "admin@healthaxis.com",
                PasswordHash = "Admin@123",
                Role = "Admin",
                IsActive = true
            },
            new User
            {
                Id = 2,
                FullName = "Dr. Anjali Menon",
                Email = "anjali.menon@healthaxis.com",
                PasswordHash = "Doctor@123",
                Role = "Doctor",
                IsActive = true
            },
            new User
            {
                Id = 3,
                FullName = "Dr. Rahul Nair",
                Email = "rahul.nair@healthaxis.com",
                PasswordHash = "Doctor@123",
                Role = "Doctor",
                IsActive = true
            }
        );

        modelBuilder.Entity<Doctor>().HasData(
            new Doctor
            {
                Id = 1,
                UserId = 2,
                Specialisation = "Cardiology",
                Years = 8,
                ConsultationFee = 600,
                IsAvailable = true
            },
            new Doctor
            {
                Id = 2,
                UserId = 3,
                Specialisation = "Dermatology",
                ExperienceYears = 5,
                ConsultationFee = 500,
                IsAvailable = true
            }
        );
    }
}