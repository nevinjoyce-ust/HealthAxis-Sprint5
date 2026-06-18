using HealthAxis.API.Enums;
using HealthAxis.API.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace HealthAxis.API.Data;

public static class IdentityDataSeeder
{
    public static async Task SeedAsync(
        RoleManager<IdentityRole> roleManager,
        UserManager<IdentityUser> userManager,
        HealthAxisDbContext context)
    {
        string[] roles = ["Admin", "Doctor", "Patient"];

        foreach (var role in roles)
        {
            if (!await roleManager.RoleExistsAsync(role))
            {
                await roleManager.CreateAsync(new IdentityRole
                {
                    Name = role
                });
            }
        }

        await SeedAdminAsync(userManager);

        await SeedDoctorAsync(
            userManager,
            context,
            "Dr. Anjali Menon",
            "anjali.menon@healthaxis.com",
            DoctorSpecialisation.Cardiology,
            new DateOnly(2015, 1, 1),
            600);

        await SeedDoctorAsync(
            userManager,
            context,
            "Dr. Rahul Nair",
            "rahul.nair@healthaxis.com",
            DoctorSpecialisation.Dermatology,
            new DateOnly(2019, 1, 1),
            500);
    }

    private static async Task SeedAdminAsync(UserManager<IdentityUser> userManager)
    {
        const string adminEmail = "admin@healthaxis.com";

        var existingAdmin = await userManager.FindByEmailAsync(adminEmail);

        if (existingAdmin != null)
        {
            return;
        }

        var adminUser = new IdentityUser
        {
            UserName = adminEmail,
            Email = adminEmail,
            EmailConfirmed = true
        };

        var result = await userManager.CreateAsync(adminUser, "Admin@123");

        if (result.Succeeded)
        {
            await userManager.AddToRoleAsync(adminUser, "Admin");
        }
    }

    private static async Task SeedDoctorAsync(
        UserManager<IdentityUser> userManager,
        HealthAxisDbContext context,
        string fullName,
        string email,
        DoctorSpecialisation specialisation,
        DateOnly practiceStartDate,
        decimal consultationFee)
    {
        var existingUser = await userManager.FindByEmailAsync(email);

        if (existingUser == null)
        {
            existingUser = new IdentityUser
            {
                UserName = email,
                Email = email,
                EmailConfirmed = true
            };

            var result = await userManager.CreateAsync(existingUser, "Doctor@123");

            if (!result.Succeeded)
            {
                return;
            }

            await userManager.AddToRoleAsync(existingUser, "Doctor");
        }

        var doctorExists = await context.Doctors
            .AnyAsync(doctor => doctor.UserId == existingUser.Id);

        if (doctorExists)
        {
            return;
        }

        var doctor = new Doctor
        {
            UserId = existingUser.Id,
            FullName = fullName,
            Specialisation = specialisation,
            PracticeStartDate = practiceStartDate,
            ConsultationFee = consultationFee,
            IsAvailable = true
        };

        await context.Doctors.AddAsync(doctor);
        await context.SaveChangesAsync();
    }
}
