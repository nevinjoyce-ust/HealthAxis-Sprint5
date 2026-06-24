using HealthAxis.API.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace HealthAxis.API.Data;

public class HealthAxisDbContext(DbContextOptions<HealthAxisDbContext> options) : IdentityDbContext<IdentityUser>(options)
{

    public DbSet<Doctor> Doctors { get; set; }

    public DbSet<Patient> Patients { get; set; }

    public DbSet<Appointment> Appointments { get; set; }

    public DbSet<HealthRecord> HealthRecords { get; set; }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);

        builder.Entity<IdentityUser>()
            .HasOne<Doctor>()
            .WithOne(doctor => doctor.User)
            .HasForeignKey<Doctor>(doctor => doctor.UserId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.Entity<IdentityUser>()
            .HasOne<Patient>()
            .WithOne(patient => patient.User)
            .HasForeignKey<Patient>(patient => patient.UserId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.Entity<Appointment>()
            .HasOne(appointment => appointment.Patient)
            .WithMany(patient => patient.Appointments)
            .HasForeignKey(appointment => appointment.PatientId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.Entity<Appointment>()
            .HasOne(appointment => appointment.Doctor)
            .WithMany(doctor => doctor.Appointments)
            .HasForeignKey(appointment => appointment.DoctorId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.Entity<Appointment>()
            .Property(appointment => appointment.Status)
            .HasConversion<string>()
            .HasMaxLength(30)
            .IsRequired();

        builder.Entity<Appointment>()
            .HasOne(appointment => appointment.HealthRecord)
            .WithOne(record => record.Appointment)
            .HasForeignKey<HealthRecord>(record => record.AppointmentId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.Entity<HealthRecord>()
            .HasIndex(record => record.AppointmentId)
            .IsUnique();

        builder.Entity<Doctor>()
            .Property(doctor => doctor.Specialisation)
            .HasConversion<string>()
            .HasMaxLength(100)
            .IsRequired();
    }
}
