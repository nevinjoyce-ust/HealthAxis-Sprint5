using HealthAxis.API.Models;
using HealthAxis.Shared.Constants;
using HealthAxis.Shared.Enums;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace HealthAxis.API.Data;

public static class IdentityDataSeeder
{
    private const string AdminPassword = "Admin@123";
    private const string DoctorPassword = "Doctor@123";
    private const string PatientPassword = "Patient@123";

    public static async Task SeedAsync(
        RoleManager<IdentityRole> roleManager,
        UserManager<IdentityUser> userManager,
        HealthAxisDbContext context)
    {
        await SeedRolesAsync(roleManager);

        await SeedAdminsAsync(userManager);

        var doctors = await SeedDoctorsAsync(userManager, context);
        var patients = await SeedPatientsAsync(userManager, context);
        Console.WriteLine(
    $"Seeder checkpoint: doctors={doctors.Count}, patients={patients.Count}, appointments={await context.Appointments.CountAsync()}, healthRecords={await context.HealthRecords.CountAsync()}"
);
        await SeedAppointmentsAndHealthRecordsAsync(context, doctors, patients);
    }

    private static async Task SeedRolesAsync(RoleManager<IdentityRole> roleManager)
    {
        string[] roles = [AppRoles.Admin, AppRoles.Doctor, AppRoles.Patient];

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
    }

    private static async Task SeedAdminsAsync(UserManager<IdentityUser> userManager)
    {
        var admins = new[]
        {
            new SeedUser("admin@healthaxis.com", "9999900001"),
            new SeedUser("operations.admin@healthaxis.com", "9999900002"),
            new SeedUser("reports.admin@healthaxis.com", "9999900003")
        };

        foreach (var admin in admins)
        {
            await EnsureUserWithRoleAsync(userManager, admin.Email, admin.PhoneNumber, AdminPassword, AppRoles.Admin);
        }
    }

    private static async Task<List<Doctor>> SeedDoctorsAsync(
        UserManager<IdentityUser> userManager,
        HealthAxisDbContext context)
    {
        var doctorSeeds = new[]
        {
            new SeedDoctor("Anjali Menon", "anjali.menon@healthaxis.com", "9000001001", DoctorSpecialisation.Cardiology, new DateOnly(2015, 1, 1), 600, true),
            new SeedDoctor("Rahul Nair", "rahul.nair@healthaxis.com", "9000001002", DoctorSpecialisation.Dermatology, new DateOnly(2019, 1, 1), 500, true),
            new SeedDoctor("Meera Pillai", "meera.pillai@healthaxis.com", "9000001003", DoctorSpecialisation.Orthopaedics, new DateOnly(2012, 6, 15), 750, true),
            new SeedDoctor("Arjun Varma", "arjun.varma@healthaxis.com", "9000001004", DoctorSpecialisation.Cardiology, new DateOnly(2021, 3, 10), 450, false),
            new SeedDoctor("Nisha Thomas", "nisha.thomas@healthaxis.com", "9000001005", DoctorSpecialisation.Dermatology, new DateOnly(2017, 8, 20), 650, true),
            new SeedDoctor("Kiran Joseph", "kiran.joseph@healthaxis.com", "9000001006", DoctorSpecialisation.Orthopaedics, new DateOnly(2010, 11, 5), 850, true),
            new SeedDoctor("Divya Raman", "divya.raman@healthaxis.com", "9000001007", DoctorSpecialisation.Cardiology, new DateOnly(2023, 2, 1), 400, true),
            new SeedDoctor("Sanjay Kumar", "sanjay.kumar@healthaxis.com", "9000001008", DoctorSpecialisation.Dermatology, new DateOnly(2014, 9, 12), 700, false)
        };

        foreach (var seed in doctorSeeds)
        {
            var user = await EnsureUserWithRoleAsync(userManager, seed.Email, seed.PhoneNumber, DoctorPassword, AppRoles.Doctor);

            var doctor = await context.Doctors.FirstOrDefaultAsync(existingDoctor => existingDoctor.UserId == user.Id);

            if (doctor == null)
            {
                doctor = new Doctor
                {
                    UserId = user.Id,
                    FullName = seed.FullName,
                    Specialisation = seed.Specialisation,
                    PracticeStartDate = seed.PracticeStartDate,
                    ConsultationFee = seed.ConsultationFee,
                    IsAvailable = seed.IsAvailable
                };

                await context.Doctors.AddAsync(doctor);
            }
            else
            {
                doctor.FullName = RemoveDoctorTitle(seed.FullName);
                doctor.Specialisation = seed.Specialisation;
                doctor.PracticeStartDate = seed.PracticeStartDate;
                doctor.ConsultationFee = seed.ConsultationFee;
                doctor.IsAvailable = seed.IsAvailable;
            }
        }

        await context.SaveChangesAsync();

        return await context.Doctors
            .Include(doctor => doctor.User)
            .OrderBy(doctor => doctor.Id)
            .ToListAsync();
    }

    private static async Task<List<Patient>> SeedPatientsAsync(
        UserManager<IdentityUser> userManager,
        HealthAxisDbContext context)
    {
        var patientSeeds = new[]
        {
            new SeedPatient("Nevin Joyce", "nevin.joyce@example.com", "9100002001", new DateOnly(1998, 5, 12), "Male", "Trivandrum, Kerala"),
            new SeedPatient("Asha Thomas", "asha.thomas@example.com", "9100002002", new DateOnly(1995, 11, 3), "Female", "Kochi, Kerala"),
            new SeedPatient("Ravi Menon", "ravi.menon@example.com", "9100002003", new DateOnly(1988, 2, 18), "Male", "Kollam, Kerala"),
            new SeedPatient("Priya Nair", "priya.nair@example.com", "9100002004", new DateOnly(1992, 7, 25), "Female", "Thrissur, Kerala"),
            new SeedPatient("Jacob Mathew", "jacob.mathew@example.com", "9100002005", new DateOnly(1979, 12, 2), "Male", "Kottayam, Kerala"),
            new SeedPatient("Sneha Paul", "sneha.paul@example.com", "9100002006", new DateOnly(2001, 4, 14), "Female", "Alappuzha, Kerala"),
            new SeedPatient("Maya Krishnan", "maya.krishnan@example.com", "9100002007", new DateOnly(1985, 9, 9), "Female", "Palakkad, Kerala"),
            new SeedPatient("Arun George", "arun.george@example.com", "9100002008", new DateOnly(1990, 1, 30), "Male", "Kannur, Kerala"),
            new SeedPatient("Leena Das", "leena.das@example.com", "9100002009", new DateOnly(1975, 6, 21), "Female", "Calicut, Kerala"),
            new SeedPatient("Vivek Raj", "vivek.raj@example.com", "9100002010", new DateOnly(1999, 10, 5), "Male", "Malappuram, Kerala"),
            new SeedPatient("Sara Wilson", "sara.wilson@example.com", "9100002011", new DateOnly(1993, 3, 17), "Female", "Pathanamthitta, Kerala"),
            new SeedPatient("Dinesh Babu", "dinesh.babu@example.com", "9100002012", new DateOnly(1982, 8, 28), "Male", "Idukki, Kerala")
        };

        foreach (var seed in patientSeeds)
        {
            var user = await EnsureUserWithRoleAsync(userManager, seed.Email, seed.PhoneNumber, PatientPassword, AppRoles.Patient);

            var patient = await context.Patients.FirstOrDefaultAsync(existingPatient => existingPatient.UserId == user.Id);

            if (patient == null)
            {
                patient = new Patient
                {
                    UserId = user.Id,
                    FullName = seed.FullName,
                    DateOfBirth = seed.DateOfBirth,
                    Gender = seed.Gender,
                    Address = seed.Address
                };

                await context.Patients.AddAsync(patient);
            }
            else
            {
                patient.FullName = seed.FullName;
                patient.DateOfBirth = seed.DateOfBirth;
                patient.Gender = seed.Gender;
                patient.Address = seed.Address;
            }
        }

        await context.SaveChangesAsync();

        return await context.Patients
            .Include(patient => patient.User)
            .OrderBy(patient => patient.Id)
            .ToListAsync();
    }

    private static async Task SeedAppointmentsAndHealthRecordsAsync(
        HealthAxisDbContext context,
        IReadOnlyList<Doctor> doctors,
        IReadOnlyList<Patient> patients)
    {
        Console.WriteLine("Entered SeedAppointmentsAndHealthRecordsAsync.");
        if (doctors.Count == 0 || patients.Count == 0)
        {
            return;
        }

        var today = DateOnly.FromDateTime(DateTime.Today);

        var appointmentSeeds = new List<SeedAppointment>
        {
            new(0, 0, today.AddDays(2), new TimeOnly(9, 0), AppointmentStatus.Pending, null, null),
            new(1, 1, today.AddDays(2), new TimeOnly(10, 0), AppointmentStatus.Confirmed, null, null),
            new(2, 2, today.AddDays(2), new TimeOnly(11, 0), AppointmentStatus.Cancelled, "Patient requested reschedule. Cancelled by admin.", null),
            new(3, 4, today.AddDays(3), new TimeOnly(9, 30), AppointmentStatus.Pending, null, null),
            new(4, 5, today.AddDays(3), new TimeOnly(10, 30), AppointmentStatus.Confirmed, null, null),
            new(5, 6, today.AddDays(3), new TimeOnly(11, 30), AppointmentStatus.Pending, null, null),
            new(6, 0, today.AddDays(4), new TimeOnly(12, 0), AppointmentStatus.Confirmed, null, null),
            new(7, 1, today.AddDays(4), new TimeOnly(14, 0), AppointmentStatus.Pending, null, null),
            new(8, 2, today.AddDays(5), new TimeOnly(9, 0), AppointmentStatus.Cancelled, "Doctor unavailable. Cancelled by admin.", null),
            new(9, 4, today.AddDays(5), new TimeOnly(10, 0), AppointmentStatus.Pending, null, null),
            new(10, 5, today.AddDays(6), new TimeOnly(15, 0), AppointmentStatus.Confirmed, null, null),
            new(11, 6, today.AddDays(6), new TimeOnly(16, 0), AppointmentStatus.Pending, null, null),

            new(0, 1, today.AddDays(-1), new TimeOnly(9, 0), AppointmentStatus.Completed, null, new SeedHealthRecord(today.AddDays(-1), "Seasonal allergy", "Antihistamine for five days", "Follow up if symptoms persist.")),
            new(1, 2, today.AddDays(-1), new TimeOnly(10, 0), AppointmentStatus.Completed, null, new SeedHealthRecord(today.AddDays(-1), "Mild dermatitis", "Topical ointment twice daily", "Avoid scented soaps.")),
            new(2, 4, today.AddDays(-2), new TimeOnly(11, 0), AppointmentStatus.Completed, null, new SeedHealthRecord(today.AddDays(-2), "Knee strain", "Rest and anti-inflammatory medication", "Physiotherapy recommended.")),
            new(3, 5, today.AddDays(-2), new TimeOnly(12, 0), AppointmentStatus.Completed, null, new SeedHealthRecord(today.AddDays(-2), "Hypertension review", "Continue current medication", "Monitor blood pressure weekly.")),
            new(4, 6, today.AddDays(-3), new TimeOnly(9, 30), AppointmentStatus.Completed, null, new SeedHealthRecord(today.AddDays(-3), "Acne follow up", "Continue prescribed gel", "Review after one month.")),
            new(5, 0, today.AddDays(-3), new TimeOnly(10, 30), AppointmentStatus.Completed, null, new SeedHealthRecord(today.AddDays(-3), "Chest discomfort evaluation", "ECG normal, lifestyle advice", "Return immediately if symptoms worsen.")),
            new(6, 1, today.AddDays(-4), new TimeOnly(11, 30), AppointmentStatus.Cancelled, "Patient cancelled due to travel. Cancelled by patient.", null),
            new(7, 2, today.AddDays(-4), new TimeOnly(14, 0), AppointmentStatus.Cancelled, "Appointment auto-cancelled after pending expiry.", null),
            new(8, 4, today.AddDays(-5), new TimeOnly(15, 0), AppointmentStatus.Completed, null, new SeedHealthRecord(today.AddDays(-5), "Shoulder pain", "Analgesic and rest", "Avoid heavy lifting.")),
            new(9, 5, today.AddDays(-5), new TimeOnly(16, 0), AppointmentStatus.Completed, null, new SeedHealthRecord(today.AddDays(-5), "Skin rash", "Antifungal cream", "Keep area dry.")),
            new(10, 6, today.AddDays(-6), new TimeOnly(9, 0), AppointmentStatus.Completed, null, new SeedHealthRecord(today.AddDays(-6), "Routine cardiac review", "No medication changes", "Next review in six months.")),
            new(11, 0, today.AddDays(-6), new TimeOnly(10, 0), AppointmentStatus.Cancelled, "Clinic emergency. Cancelled by admin.", null),

            new(0, 2, today, new TimeOnly(9, 30), AppointmentStatus.Confirmed, null, null),
            new(1, 4, today, new TimeOnly(10, 30), AppointmentStatus.Pending, null, null),
            new(2, 5, today, new TimeOnly(11, 30), AppointmentStatus.Cancelled, "Patient requested cancellation. Cancelled by admin.", null),
            new(3, 6, today, new TimeOnly(12, 30), AppointmentStatus.Completed, null, new SeedHealthRecord(today, "Back pain", "Muscle relaxant for three days", "Posture correction advised.")),
            new(4, 0, today.AddDays(7), new TimeOnly(9, 0), AppointmentStatus.Pending, null, null),
            new(5, 1, today.AddDays(7), new TimeOnly(10, 0), AppointmentStatus.Confirmed, null, null),
            new(6, 2, today.AddDays(8), new TimeOnly(11, 0), AppointmentStatus.Pending, null, null),
            new(7, 4, today.AddDays(8), new TimeOnly(12, 0), AppointmentStatus.Confirmed, null, null),
            new(8, 5, today.AddDays(9), new TimeOnly(13, 0), AppointmentStatus.Pending, null, null),
            new(9, 6, today.AddDays(9), new TimeOnly(14, 0), AppointmentStatus.Confirmed, null, null),
            new(10, 0, today.AddDays(10), new TimeOnly(15, 0), AppointmentStatus.Pending, null, null),
            new(11, 1, today.AddDays(10), new TimeOnly(16, 0), AppointmentStatus.Confirmed, null, null)
        };

        if (await context.Appointments.AnyAsync())
        {
            return;
        }

        foreach (var seed in appointmentSeeds)
        {
            var patient = patients[seed.PatientIndex % patients.Count];
            var doctor = doctors[seed.DoctorIndex % doctors.Count];

            var appointment = new Appointment
            {
                PatientId = patient.Id,
                DoctorId = doctor.Id,
                AppointmentDate = seed.Date,
                AppointmentTime = seed.Time,
                Status = seed.Status,
                CancellationReason = seed.CancellationReason
            };

            await context.Appointments.AddAsync(appointment);
            await context.SaveChangesAsync();

            if (seed.HealthRecord != null && seed.Status == AppointmentStatus.Completed)
            {
                await context.HealthRecords.AddAsync(new HealthRecord
                {
                    AppointmentId = appointment.Id,
                    VisitDate = seed.HealthRecord.VisitDate,
                    Diagnosis = seed.HealthRecord.Diagnosis,
                    Prescription = seed.HealthRecord.Prescription,
                    Notes = seed.HealthRecord.Notes
                });

                await context.SaveChangesAsync();
            }
        }
    }

    private static async Task<IdentityUser> EnsureUserWithRoleAsync(
        UserManager<IdentityUser> userManager,
        string email,
        string phoneNumber,
        string password,
        string role)
    {
        var existingUser = await userManager.FindByEmailAsync(email);

        if (existingUser == null)
        {
            existingUser = new IdentityUser
            {
                UserName = email,
                Email = email,
                PhoneNumber = phoneNumber,
                EmailConfirmed = true
            };

            var result = await userManager.CreateAsync(existingUser, password);

            if (!result.Succeeded)
            {
                var errors = string.Join(" ", result.Errors.Select(error => error.Description));
                throw new InvalidOperationException($"Unable to seed user {email}. {errors}");
            }
        }
        else
        {
            existingUser.PhoneNumber = phoneNumber;
            existingUser.EmailConfirmed = true;
            await userManager.UpdateAsync(existingUser);
        }

        if (!await userManager.IsInRoleAsync(existingUser, role))
        {
            await userManager.AddToRoleAsync(existingUser, role);
        }

        return existingUser;
    }

    private static string RemoveDoctorTitle(string fullName)
    {
        return fullName.StartsWith("Dr. ", StringComparison.OrdinalIgnoreCase)
            ? fullName[4..]
            : fullName;
    }

    private sealed record SeedUser(string Email, string PhoneNumber);

    private sealed record SeedDoctor(
        string FullName,
        string Email,
        string PhoneNumber,
        DoctorSpecialisation Specialisation,
        DateOnly PracticeStartDate,
        decimal ConsultationFee,
        bool IsAvailable);

    private sealed record SeedPatient(
        string FullName,
        string Email,
        string PhoneNumber,
        DateOnly DateOfBirth,
        string Gender,
        string Address);

    private sealed record SeedAppointment(
        int PatientIndex,
        int DoctorIndex,
        DateOnly Date,
        TimeOnly Time,
        AppointmentStatus Status,
        string? CancellationReason,
        SeedHealthRecord? HealthRecord);

    private sealed record SeedHealthRecord(
        DateOnly VisitDate,
        string Diagnosis,
        string Prescription,
        string? Notes);
}
