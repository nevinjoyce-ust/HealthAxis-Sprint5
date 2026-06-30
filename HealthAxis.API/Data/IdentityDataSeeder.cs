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
        HealthAxisDbContext context,
        bool seedDemoData = false)
    {
        await SeedRolesAsync(roleManager);
        await SeedAdminsAsync(userManager);

        if (!seedDemoData)
        {
            return;
        }

        var doctors = await SeedDoctorsAsync(userManager, context);
        var patients = await SeedPatientsAsync(userManager, context);

        await ResetDemoAppointmentsAndHealthRecordsAsync(context, doctors, patients);
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
            new SeedDoctor("Anjali Menon", "anjali.menon@healthaxis.com", "9000001001", DoctorSpecialisation.Cardiology, new DateOnly(2015, 1, 1), 600m, true),
            new SeedDoctor("Arjun Varma", "arjun.varma@healthaxis.com", "9000001002", DoctorSpecialisation.Cardiology, new DateOnly(2021, 3, 10), 450m, false),
            new SeedDoctor("Rahul Nair", "rahul.nair@healthaxis.com", "9000001003", DoctorSpecialisation.Dermatology, new DateOnly(2019, 1, 1), 500m, true),
            new SeedDoctor("Nisha Thomas", "nisha.thomas@healthaxis.com", "9000001004", DoctorSpecialisation.Dermatology, new DateOnly(2017, 8, 20), 650m, true),
            new SeedDoctor("Farah Ahmed", "farah.ahmed@healthaxis.com", "9000001005", DoctorSpecialisation.Neurology, new DateOnly(2016, 4, 18), 720m, true),
            new SeedDoctor("Vikram Das", "vikram.das@healthaxis.com", "9000001006", DoctorSpecialisation.Neurology, new DateOnly(2013, 2, 11), 780m, false),
            new SeedDoctor("Meera Pillai", "meera.pillai@healthaxis.com", "9000001007", DoctorSpecialisation.Orthopaedics, new DateOnly(2012, 6, 15), 750m, true),
            new SeedDoctor("Kiran Joseph", "kiran.joseph@healthaxis.com", "9000001008", DoctorSpecialisation.Orthopaedics, new DateOnly(2010, 11, 5), 850m, true),
            new SeedDoctor("Aparna Suresh", "aparna.suresh@healthaxis.com", "9000001009", DoctorSpecialisation.Pediatrics, new DateOnly(2022, 9, 5), 430m, true),
            new SeedDoctor("Grace George", "grace.george@healthaxis.com", "9000001010", DoctorSpecialisation.Pediatrics, new DateOnly(2011, 10, 22), 820m, true),
            new SeedDoctor("Thomas Kurian", "thomas.kurian@healthaxis.com", "9000001011", DoctorSpecialisation.GeneralMedicine, new DateOnly(2009, 12, 1), 900m, true),
            new SeedDoctor("Ibrahim Khan", "ibrahim.khan@healthaxis.com", "9000001012", DoctorSpecialisation.GeneralMedicine, new DateOnly(2008, 6, 30), 950m, true),
            new SeedDoctor("Lakshmi Iyer", "lakshmi.iyer@healthaxis.com", "9000001013", DoctorSpecialisation.Psychiatry, new DateOnly(2018, 7, 7), 550m, true),
            new SeedDoctor("Rohan Mathew", "rohan.mathew@healthaxis.com", "9000001014", DoctorSpecialisation.Psychiatry, new DateOnly(2020, 5, 14), 520m, true),
            new SeedDoctor("Divya Raman", "divya.raman@healthaxis.com", "9000001015", DoctorSpecialisation.Radiology, new DateOnly(2023, 2, 1), 400m, true),
            new SeedDoctor("Sanjay Kumar", "sanjay.kumar@healthaxis.com", "9000001016", DoctorSpecialisation.Radiology, new DateOnly(2014, 9, 12), 700m, false),
            new SeedDoctor("Maya Krishnan", "maya.krishnan.doctor@healthaxis.com", "9000001017", DoctorSpecialisation.Gynecology, new DateOnly(2014, 6, 25), 760m, true),
            new SeedDoctor("Sara Wilson", "sara.wilson.doctor@healthaxis.com", "9000001018", DoctorSpecialisation.Gynecology, new DateOnly(2018, 12, 3), 640m, true),
            new SeedDoctor("Leena Das", "leena.das.doctor@healthaxis.com", "9000001019", DoctorSpecialisation.ENT, new DateOnly(2016, 9, 14), 580m, true),
            new SeedDoctor("Harish Kumar", "harish.kumar.doctor@healthaxis.com", "9000001020", DoctorSpecialisation.ENT, new DateOnly(2012, 1, 9), 720m, true)
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
                    FullName = RemoveDoctorTitle(seed.FullName),
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
            .Where(doctor => doctor.User != null && doctor.User.Email != null && doctor.User.Email.EndsWith("@healthaxis.com"))
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
            new SeedPatient("Dinesh Babu", "dinesh.babu@example.com", "9100002012", new DateOnly(1982, 8, 28), "Male", "Idukki, Kerala"),
            new SeedPatient("Joanna Kuruvilla", "joanna.kuruvilla@example.com", "9100002013", new DateOnly(1996, 12, 8), "Female", "Wayanad, Kerala"),
            new SeedPatient("Manu Sebastian", "manu.sebastian@example.com", "9100002014", new DateOnly(1987, 4, 19), "Male", "Kasargod, Kerala"),
            new SeedPatient("Riya Joseph", "riya.joseph@example.com", "9100002015", new DateOnly(2000, 9, 11), "Female", "Ernakulam, Kerala"),
            new SeedPatient("Harish Kumar", "harish.kumar@example.com", "9100002016", new DateOnly(1972, 1, 6), "Male", "Thiruvalla, Kerala"),
            new SeedPatient("Anu Mary", "anu.mary@example.com", "9100002017", new DateOnly(1991, 7, 2), "Female", "Muvattupuzha, Kerala"),
            new SeedPatient("Sreejith Nambiar", "sreejith.nambiar@example.com", "9100002018", new DateOnly(1984, 10, 16), "Male", "Vadakara, Kerala")
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
            .Where(patient => patient.User != null && patient.User.Email != null && patient.User.Email.EndsWith("@example.com"))
            .OrderBy(patient => patient.Id)
            .ToListAsync();
    }

    private static async Task ResetDemoAppointmentsAndHealthRecordsAsync(
        HealthAxisDbContext context,
        IReadOnlyCollection<Doctor> doctors,
        IReadOnlyCollection<Patient> patients)
    {
        var doctorIds = doctors.Select(doctor => doctor.Id).ToList();
        var patientIds = patients.Select(patient => patient.Id).ToList();

        var appointmentIds = await context.Appointments
            .Where(appointment => doctorIds.Contains(appointment.DoctorId) && patientIds.Contains(appointment.PatientId))
            .Select(appointment => appointment.Id)
            .ToListAsync();

        var healthRecords = await context.HealthRecords
            .Where(record => appointmentIds.Contains(record.AppointmentId))
            .ToListAsync();

        context.HealthRecords.RemoveRange(healthRecords);

        var appointments = await context.Appointments
            .Where(appointment => appointmentIds.Contains(appointment.Id))
            .ToListAsync();

        context.Appointments.RemoveRange(appointments);

        await context.SaveChangesAsync();
    }

    private static async Task SeedAppointmentsAndHealthRecordsAsync(
        HealthAxisDbContext context,
        IReadOnlyList<Doctor> doctors,
        IReadOnlyList<Patient> patients)
    {
        if (doctors.Count == 0 || patients.Count == 0)
        {
            return;
        }

        var today = DateOnly.FromDateTime(DateTime.Today);
        var doctorLookup = doctors
            .GroupBy(doctor => doctor.Specialisation)
            .ToDictionary(group => group.Key, group => group.First());

        var appointmentSeeds = BuildAppointmentSeeds(today, doctorLookup, patients);
        var completedAppointmentsWithRecords = new List<(Appointment Appointment, SeedHealthRecord HealthRecord)>();

        foreach (var seed in appointmentSeeds)
        {
            var appointment = new Appointment
            {
                PatientId = seed.Patient.Id,
                DoctorId = seed.Doctor.Id,
                AppointmentDate = seed.Date,
                AppointmentTime = seed.Time,
                Status = seed.Status,
                CancellationReason = seed.CancellationReason
            };

            await context.Appointments.AddAsync(appointment);

            if (seed.HealthRecord != null && seed.Status == AppointmentStatus.Completed)
            {
                completedAppointmentsWithRecords.Add((appointment, seed.HealthRecord));
            }
        }

        await context.SaveChangesAsync();

        foreach (var (appointment, seedRecord) in completedAppointmentsWithRecords)
        {
            await context.HealthRecords.AddAsync(new HealthRecord
            {
                AppointmentId = appointment.Id,
                VisitDate = seedRecord.VisitDate,
                Diagnosis = seedRecord.Diagnosis,
                Prescription = seedRecord.Prescription,
                Notes = seedRecord.Notes
            });
        }

        await context.SaveChangesAsync();
    }

    private static IReadOnlyList<SeedAppointment> BuildAppointmentSeeds(
        DateOnly today,
        IReadOnlyDictionary<DoctorSpecialisation, Doctor> doctorLookup,
        IReadOnlyList<Patient> patients)
    {
        Doctor Doctor(DoctorSpecialisation specialisation) => doctorLookup[specialisation];
        Patient Patient(int index) => patients[index % patients.Count];

        return
        [
            // Today's doctor-dashboard data. These are intentionally today-relative for demos.
            new(Patient(0), Doctor(DoctorSpecialisation.Radiology), today, new TimeOnly(9, 30), AppointmentStatus.Confirmed, null, null),
            new(Patient(1), Doctor(DoctorSpecialisation.Gynecology), today, new TimeOnly(10, 30), AppointmentStatus.Pending, null, null),
            new(Patient(2), Doctor(DoctorSpecialisation.ENT), today, new TimeOnly(11, 30), AppointmentStatus.Cancelled, "Patient requested cancellation. - Cancelled by admin", null),
            new(Patient(3), Doctor(DoctorSpecialisation.GeneralMedicine), today, new TimeOnly(14, 30), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today, "Acute lower back pain", "Short-term pain management and posture advice provided", "No neurological red flags documented.")),

            // Future appointments start after the 48-hour booking window.
            new(Patient(0), Doctor(DoctorSpecialisation.Cardiology), today.AddDays(3), new TimeOnly(9, 0), AppointmentStatus.Pending, null, null),
            new(Patient(1), Doctor(DoctorSpecialisation.Dermatology), today.AddDays(3), new TimeOnly(10, 0), AppointmentStatus.Confirmed, null, null),
            new(Patient(2), Doctor(DoctorSpecialisation.Neurology), today.AddDays(3), new TimeOnly(11, 0), AppointmentStatus.Cancelled, "Patient requested reschedule. - Cancelled by admin", null),
            new(Patient(3), Doctor(DoctorSpecialisation.Orthopaedics), today.AddDays(4), new TimeOnly(9, 30), AppointmentStatus.Pending, null, null),
            new(Patient(4), Doctor(DoctorSpecialisation.Pediatrics), today.AddDays(4), new TimeOnly(10, 30), AppointmentStatus.Confirmed, null, null),
            new(Patient(5), Doctor(DoctorSpecialisation.GeneralMedicine), today.AddDays(4), new TimeOnly(11, 30), AppointmentStatus.Pending, null, null),
            new(Patient(6), Doctor(DoctorSpecialisation.Psychiatry), today.AddDays(5), new TimeOnly(13, 0), AppointmentStatus.Confirmed, null, null),
            new(Patient(7), Doctor(DoctorSpecialisation.Radiology), today.AddDays(5), new TimeOnly(14, 0), AppointmentStatus.Pending, null, null),
            new(Patient(8), Doctor(DoctorSpecialisation.Gynecology), today.AddDays(6), new TimeOnly(9, 0), AppointmentStatus.Cancelled, "Doctor unavailable. - Cancelled by admin", null),
            new(Patient(9), Doctor(DoctorSpecialisation.ENT), today.AddDays(6), new TimeOnly(10, 0), AppointmentStatus.Pending, null, null),

            // Past completed/cancelled appointments for patient history.
            new(Patient(0), Doctor(DoctorSpecialisation.Cardiology), today.AddDays(-1), new TimeOnly(9, 0), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-1), "Hypertension follow-up", "Antihypertensive therapy continued as reviewed by cardiology", "Blood pressure trend reviewed; lifestyle measures reinforced.")),
            new(Patient(1), Doctor(DoctorSpecialisation.Dermatology), today.AddDays(-1), new TimeOnly(10, 0), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-1), "Atopic dermatitis flare", "Topical anti-inflammatory skin treatment prescribed", "Moisturiser use and trigger avoidance discussed.")),
            new(Patient(2), Doctor(DoctorSpecialisation.Neurology), today.AddDays(-2), new TimeOnly(11, 0), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-2), "Migraine without acute neurological deficit", "Migraine management plan reviewed", "Headache diary advised; warning symptoms explained.")),
            new(Patient(3), Doctor(DoctorSpecialisation.Orthopaedics), today.AddDays(-2), new TimeOnly(14, 0), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-2), "Right knee ligament strain", "Analgesic support and physiotherapy referral provided", "Avoid high-impact activity until reassessed.")),
            new(Patient(4), Doctor(DoctorSpecialisation.Pediatrics), today.AddDays(-3), new TimeOnly(9, 30), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-3), "Viral upper respiratory infection", "Symptomatic paediatric care advised", "Hydration and fever monitoring discussed with guardian.")),
            new(Patient(5), Doctor(DoctorSpecialisation.GeneralMedicine), today.AddDays(-3), new TimeOnly(10, 30), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-3), "Type 2 diabetes routine review", "Current metabolic management plan reviewed", "Diet, exercise, and follow-up lab review advised.")),
            new(Patient(6), Doctor(DoctorSpecialisation.Psychiatry), today.AddDays(-4), new TimeOnly(11, 30), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-4), "Generalised anxiety symptoms", "Counselling plan and medication review discussed", "Sleep routine and stress-management plan documented.")),
            new(Patient(7), Doctor(DoctorSpecialisation.Radiology), today.AddDays(-4), new TimeOnly(14, 0), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-4), "Lumbar spine imaging review", "Radiology report discussed with referring care team", "Mild degenerative changes noted; correlate clinically.")),
            new(Patient(8), Doctor(DoctorSpecialisation.Gynecology), today.AddDays(-5), new TimeOnly(15, 0), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-5), "Irregular menstrual cycle assessment", "Hormonal evaluation and follow-up plan advised", "Pelvic ultrasound review planned if symptoms persist.")),
            new(Patient(9), Doctor(DoctorSpecialisation.ENT), today.AddDays(-5), new TimeOnly(16, 0), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-5), "Acute otitis externa", "ENT ear care treatment prescribed", "Keep ear dry; follow up if pain or discharge persists.")),
            new(Patient(10), Doctor(DoctorSpecialisation.Cardiology), today.AddDays(-6), new TimeOnly(9, 0), AppointmentStatus.Cancelled, "Clinic emergency. - Cancelled by admin", null),
            new(Patient(11), Doctor(DoctorSpecialisation.Dermatology), today.AddDays(-6), new TimeOnly(10, 0), AppointmentStatus.Cancelled, "Patient cancelled due to travel. - Cancelled by patient", null)
        ];
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
        Patient Patient,
        Doctor Doctor,
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
