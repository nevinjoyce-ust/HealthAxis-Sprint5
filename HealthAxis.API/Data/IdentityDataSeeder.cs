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

    private const string PrimaryAdminEmail = "admin@healthaxis.com";
    private const string PrimaryDoctorEmail = "anjalimenon@healthaxis.com";

    public static async Task SeedAsync(
        RoleManager<IdentityRole> roleManager,
        UserManager<IdentityUser> userManager,
        HealthAxisDbContext context,
        bool seedDemoData = false)
    {
        await SeedRolesAsync(roleManager);

        if (seedDemoData)
        {
            await ResetAllApplicationDataAsync(context, userManager);
        }

        await SeedAdminsAsync(userManager);

        if (!seedDemoData)
        {
            return;
        }

        var doctors = await SeedDoctorsAsync(userManager, context);
        var patients = await SeedPatientsAsync(userManager, context);

        await SeedAppointmentsAndHealthRecordsAsync(context, doctors, patients);
    }

    private static async Task SeedRolesAsync(RoleManager<IdentityRole> roleManager)
    {
        string[] roles = [AppRoles.Admin, AppRoles.Doctor, AppRoles.Patient];

        foreach (var role in roles)
        {
            if (!await roleManager.RoleExistsAsync(role))
            {
                var result = await roleManager.CreateAsync(new IdentityRole
                {
                    Name = role
                });

                if (!result.Succeeded)
                {
                    var errors = string.Join(" ", result.Errors.Select(error => error.Description));
                    throw new InvalidOperationException($"Unable to seed role {role}. {errors}");
                }
            }
        }
    }

    private static async Task ResetAllApplicationDataAsync(
        HealthAxisDbContext context,
        UserManager<IdentityUser> userManager)
    {
        var healthRecords = await context.HealthRecords.ToListAsync();
        context.HealthRecords.RemoveRange(healthRecords);

        var appointments = await context.Appointments.ToListAsync();
        context.Appointments.RemoveRange(appointments);

        var doctors = await context.Doctors.ToListAsync();
        context.Doctors.RemoveRange(doctors);

        var patients = await context.Patients.ToListAsync();
        context.Patients.RemoveRange(patients);

        await context.SaveChangesAsync();

        var users = await userManager.Users.ToListAsync();

        foreach (var user in users)
        {
            var result = await userManager.DeleteAsync(user);

            if (!result.Succeeded)
            {
                var errors = string.Join(" ", result.Errors.Select(error => error.Description));
                throw new InvalidOperationException($"Unable to delete seeded user {user.Email}. {errors}");
            }
        }
    }

    private static async Task SeedAdminsAsync(UserManager<IdentityUser> userManager)
    {
        var admins = new[]
        {
            new SeedUser(PrimaryAdminEmail, "9999900001"),
            new SeedUser("operations.admin@healthaxis.com", "9999900002"),
            new SeedUser("reports.admin@healthaxis.com", "9999900003")
        };

        foreach (var admin in admins)
        {
            await EnsureUserWithRoleAsync(userManager, admin.Email, admin.PhoneNumber, AdminPassword, AppRoles.Admin, resetPassword: true);
        }
    }

    private static async Task<List<Doctor>> SeedDoctorsAsync(
        UserManager<IdentityUser> userManager,
        HealthAxisDbContext context)
    {
        var today = DateOnly.FromDateTime(DateTime.Today);

        var doctorSeeds = new[]
        {
            new SeedDoctor("Anjali Menon", PrimaryDoctorEmail, "9000001001", DoctorSpecialisation.Cardiology, today.AddYears(-12), 700m, true),
            new SeedDoctor("Arjun Varma", "arjun.varma@healthaxis.com", "9000001002", DoctorSpecialisation.Cardiology, today.AddYears(-5), 450m, false),
            new SeedDoctor("Rahul Nair", "rahul.nair@healthaxis.com", "9000001003", DoctorSpecialisation.Dermatology, today.AddYears(-7), 500m, true),
            new SeedDoctor("Nisha Thomas", "nisha.thomas@healthaxis.com", "9000001004", DoctorSpecialisation.Dermatology, today.AddYears(-9), 650m, true),
            new SeedDoctor("Farah Ahmed", "farah.ahmed@healthaxis.com", "9000001005", DoctorSpecialisation.Neurology, today.AddYears(-10), 720m, true),
            new SeedDoctor("Vikram Das", "vikram.das@healthaxis.com", "9000001006", DoctorSpecialisation.Neurology, today.AddYears(-13), 780m, false),
            new SeedDoctor("Meera Pillai", "meera.pillai@healthaxis.com", "9000001007", DoctorSpecialisation.Orthopaedics, today.AddYears(-14), 750m, true),
            new SeedDoctor("Kiran Joseph", "kiran.joseph@healthaxis.com", "9000001008", DoctorSpecialisation.Orthopaedics, today.AddYears(-16), 850m, true),
            new SeedDoctor("Aparna Suresh", "aparna.suresh@healthaxis.com", "9000001009", DoctorSpecialisation.Pediatrics, today.AddYears(-4), 430m, true),
            new SeedDoctor("Grace George", "grace.george@healthaxis.com", "9000001010", DoctorSpecialisation.Pediatrics, today.AddYears(-15), 820m, true),
            new SeedDoctor("Thomas Kurian", "thomas.kurian@healthaxis.com", "9000001011", DoctorSpecialisation.GeneralMedicine, today.AddYears(-17), 900m, true),
            new SeedDoctor("Ibrahim Khan", "ibrahim.khan@healthaxis.com", "9000001012", DoctorSpecialisation.GeneralMedicine, today.AddYears(-18), 950m, true),
            new SeedDoctor("Lakshmi Iyer", "lakshmi.iyer@healthaxis.com", "9000001013", DoctorSpecialisation.Psychiatry, today.AddYears(-8), 550m, true),
            new SeedDoctor("Rohan Mathew", "rohan.mathew@healthaxis.com", "9000001014", DoctorSpecialisation.Psychiatry, today.AddYears(-6), 520m, true),
            new SeedDoctor("Divya Raman", "divya.raman@healthaxis.com", "9000001015", DoctorSpecialisation.Radiology, today.AddYears(-3), 400m, true),
            new SeedDoctor("Sanjay Kumar", "sanjay.kumar@healthaxis.com", "9000001016", DoctorSpecialisation.Radiology, today.AddYears(-11), 700m, false),
            new SeedDoctor("Maya Krishnan", "maya.krishnan.doctor@healthaxis.com", "9000001017", DoctorSpecialisation.Gynecology, today.AddYears(-12), 760m, true),
            new SeedDoctor("Sara Wilson", "sara.wilson.doctor@healthaxis.com", "9000001018", DoctorSpecialisation.Gynecology, today.AddYears(-8), 640m, true),
            new SeedDoctor("Leena Das", "leena.das.doctor@healthaxis.com", "9000001019", DoctorSpecialisation.ENT, today.AddYears(-10), 580m, true),
            new SeedDoctor("Harish Kumar", "harish.kumar.doctor@healthaxis.com", "9000001020", DoctorSpecialisation.ENT, today.AddYears(-14), 720m, true)
        };

        foreach (var seed in doctorSeeds)
        {
            var user = await EnsureUserWithRoleAsync(userManager, seed.Email, seed.PhoneNumber, DoctorPassword, AppRoles.Doctor, resetPassword: true);

            var doctor = new Doctor
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
        var today = DateOnly.FromDateTime(DateTime.Today);

        var patientSeeds = new[]
        {
            new SeedPatient("Nevin Joyce", "nevin.joyce@example.com", "9100002001", today.AddYears(-28).AddMonths(-1), "Male", "Trivandrum, Kerala"),
            new SeedPatient("Asha Thomas", "asha.thomas@example.com", "9100002002", today.AddYears(-31).AddMonths(-2), "Female", "Kochi, Kerala"),
            new SeedPatient("Ravi Menon", "ravi.menon@example.com", "9100002003", today.AddYears(-38).AddMonths(-3), "Male", "Kollam, Kerala"),
            new SeedPatient("Priya Nair", "priya.nair@example.com", "9100002004", today.AddYears(-34).AddMonths(-4), "Female", "Thrissur, Kerala"),
            new SeedPatient("Jacob Mathew", "jacob.mathew@example.com", "9100002005", today.AddYears(-47).AddMonths(-5), "Male", "Kottayam, Kerala"),
            new SeedPatient("Sneha Paul", "sneha.paul@example.com", "9100002006", today.AddYears(-25).AddMonths(-6), "Female", "Alappuzha, Kerala"),
            new SeedPatient("Maya Krishnan", "maya.krishnan@example.com", "9100002007", today.AddYears(-41).AddMonths(-7), "Female", "Palakkad, Kerala"),
            new SeedPatient("Arun George", "arun.george@example.com", "9100002008", today.AddYears(-36).AddMonths(-8), "Male", "Kannur, Kerala"),
            new SeedPatient("Leena Das", "leena.das@example.com", "9100002009", today.AddYears(-51).AddMonths(-1), "Female", "Calicut, Kerala"),
            new SeedPatient("Vivek Raj", "vivek.raj@example.com", "9100002010", today.AddYears(-27).AddMonths(-2), "Male", "Malappuram, Kerala"),
            new SeedPatient("Sara Wilson", "sara.wilson@example.com", "9100002011", today.AddYears(-33).AddMonths(-3), "Female", "Pathanamthitta, Kerala"),
            new SeedPatient("Dinesh Babu", "dinesh.babu@example.com", "9100002012", today.AddYears(-44).AddMonths(-4), "Male", "Idukki, Kerala"),
            new SeedPatient("Joanna Kuruvilla", "joanna.kuruvilla@example.com", "9100002013", today.AddYears(-30).AddMonths(-5), "Female", "Wayanad, Kerala"),
            new SeedPatient("Manu Sebastian", "manu.sebastian@example.com", "9100002014", today.AddYears(-39).AddMonths(-6), "Male", "Kasargod, Kerala"),
            new SeedPatient("Riya Joseph", "riya.joseph@example.com", "9100002015", today.AddYears(-26).AddMonths(-7), "Female", "Ernakulam, Kerala"),
            new SeedPatient("Harish Kumar", "harish.kumar@example.com", "9100002016", today.AddYears(-54).AddMonths(-8), "Male", "Thiruvalla, Kerala"),
            new SeedPatient("Anu Mary", "anu.mary@example.com", "9100002017", today.AddYears(-35).AddMonths(-1), "Female", "Muvattupuzha, Kerala"),
            new SeedPatient("Sreejith Nambiar", "sreejith.nambiar@example.com", "9100002018", today.AddYears(-42).AddMonths(-2), "Male", "Vadakara, Kerala")
        };

        foreach (var seed in patientSeeds)
        {
            var user = await EnsureUserWithRoleAsync(userManager, seed.Email, seed.PhoneNumber, PatientPassword, AppRoles.Patient, resetPassword: true);

            var patient = new Patient
            {
                UserId = user.Id,
                FullName = seed.FullName,
                DateOfBirth = seed.DateOfBirth,
                Gender = seed.Gender,
                Address = seed.Address
            };

            await context.Patients.AddAsync(patient);
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
        if (doctors.Count == 0 || patients.Count == 0)
        {
            return;
        }

        var today = DateOnly.FromDateTime(DateTime.Today);
        var doctorByEmail = doctors
            .Where(doctor => doctor.User?.Email is not null)
            .ToDictionary(doctor => doctor.User!.Email!, StringComparer.OrdinalIgnoreCase);

        var doctorBySpecialisation = doctors
            .GroupBy(doctor => doctor.Specialisation)
            .ToDictionary(group => group.Key, group => group.First());

        var appointmentSeeds = BuildAppointmentSeeds(today, doctorByEmail, doctorBySpecialisation, patients);
        var completedAppointmentsWithRecords = new List<(Appointment Appointment, SeedAppointment Seed)>();

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
                completedAppointmentsWithRecords.Add((appointment, seed));
            }
        }

        await context.SaveChangesAsync();

        foreach (var (appointment, seed) in completedAppointmentsWithRecords)
        {
            var seedRecord = seed.HealthRecord!;

            await context.HealthRecords.AddAsync(new HealthRecord
            {
                AppointmentId = appointment.Id,
                PatientAge = CalculateAge(seed.Patient.DateOfBirth, appointment.AppointmentDate),
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
        IReadOnlyDictionary<string, Doctor> doctorByEmail,
        IReadOnlyDictionary<DoctorSpecialisation, Doctor> doctorBySpecialisation,
        IReadOnlyList<Patient> patients)
    {
        Doctor Anjali() => doctorByEmail[PrimaryDoctorEmail];
        Doctor Doctor(DoctorSpecialisation specialisation) => doctorBySpecialisation[specialisation];
        Patient Patient(int index) => patients[index % patients.Count];

        return
        [
            // Dr. Anjali Menon has intentionally rich completed history for evaluator demos.
            new(Patient(0), Anjali(), today.AddDays(-180), new TimeOnly(9, 0), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-180), "Baseline cardiac risk assessment", "Lifestyle counselling and baseline cardiac monitoring plan", "Family history and baseline vitals reviewed.")),
            new(Patient(0), Anjali(), today.AddDays(-120), new TimeOnly(9, 30), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-120), "Blood pressure review", "Home BP monitoring continued with diet counselling", "Patient reported improved adherence to walking routine.")),
            new(Patient(0), Anjali(), today.AddDays(-90), new TimeOnly(10, 0), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-90), "Initial hypertension assessment", "Started blood pressure monitoring plan and lifestyle counselling", "Baseline ECG reviewed. Patient advised low-salt diet and home BP log.")),
            new(Patient(0), Anjali(), today.AddDays(-45), new TimeOnly(9, 30), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-45), "Hypertension follow-up", "Antihypertensive therapy continued after review", "BP trend improved. Continue medication adherence and walking routine.")),
            new(Patient(0), Anjali(), today.AddDays(-10), new TimeOnly(10, 0), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-10), "Chest discomfort review", "Cardiac risk review and follow-up testing advised", "No acute red flags documented. Return immediately if symptoms worsen.")),

            new(Patient(1), Anjali(), today.AddDays(-150), new TimeOnly(10, 0), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-150), "Palpitations initial consultation", "Symptom diary and rhythm monitoring advised", "No syncope reported. Hydration and sleep pattern discussed.")),
            new(Patient(1), Anjali(), today.AddDays(-75), new TimeOnly(10, 30), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-75), "Palpitations evaluation", "Lifestyle advice and rhythm monitoring plan", "Caffeine reduction discussed. Review with symptom diary.")),
            new(Patient(1), Anjali(), today.AddDays(-30), new TimeOnly(11, 0), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-30), "Palpitations follow-up", "Monitoring reviewed; reassurance and follow-up advised", "Symptoms less frequent. Continue hydration and sleep routine.")),

            new(Patient(2), Anjali(), today.AddDays(-135), new TimeOnly(11, 0), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-135), "Lipid profile assessment", "Dietary modification and lipid profile follow-up advised", "Moderate cardiovascular risk documented.")),
            new(Patient(2), Anjali(), today.AddDays(-60), new TimeOnly(11, 30), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-60), "Dyslipidaemia review", "Lipid control plan and diet counselling", "Repeat lipid profile advised before next visit.")),
            new(Patient(2), Anjali(), today.AddDays(-20), new TimeOnly(14, 0), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-20), "Cardiology medication review", "Cardiac medication plan reviewed and continued", "No medication intolerance reported.")),

            new(Patient(3), Anjali(), today.AddDays(-110), new TimeOnly(14, 0), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-110), "Post-viral palpitation assessment", "Cardiac review and gradual activity plan", "Vitals stable; warning symptoms explained.")),
            new(Patient(3), Anjali(), today.AddDays(-40), new TimeOnly(14, 30), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-40), "Post-viral fatigue with palpitations", "Cardiac review completed; graded activity advised", "Vitals stable during visit.")),
            new(Patient(4), Anjali(), today.AddDays(-15), new TimeOnly(15, 0), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-15), "Diabetes cardiovascular risk review", "Risk reduction plan reviewed", "Foot care and annual cardiac risk monitoring discussed.")),
            new(Patient(5), Anjali(), today.AddDays(-5), new TimeOnly(15, 30), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-5), "Blood pressure medicine review", "Dose timing reviewed and home monitoring advised", "Patient asked to bring BP log next visit.")),

            new(Patient(0), Anjali(), today, new TimeOnly(9, 0), AppointmentStatus.Confirmed, null, null),
            new(Patient(1), Anjali(), today, new TimeOnly(10, 0), AppointmentStatus.Pending, null, null),
            new(Patient(2), Anjali(), today, new TimeOnly(11, 0), AppointmentStatus.Confirmed, null, null),
            new(Patient(3), Anjali(), today, new TimeOnly(14, 0), AppointmentStatus.Pending, null, null),
            new(Patient(4), Anjali(), today, new TimeOnly(15, 0), AppointmentStatus.Cancelled, "Patient requested cancellation. - Cancelled by admin", null),

            new(Patient(5), Anjali(), today.AddDays(3), new TimeOnly(9, 0), AppointmentStatus.Pending, null, null),
            new(Patient(6), Anjali(), today.AddDays(3), new TimeOnly(10, 0), AppointmentStatus.Confirmed, null, null),
            new(Patient(7), Anjali(), today.AddDays(4), new TimeOnly(11, 0), AppointmentStatus.Pending, null, null),
            new(Patient(8), Anjali(), today.AddDays(5), new TimeOnly(14, 0), AppointmentStatus.Confirmed, null, null),
            new(Patient(9), Anjali(), today.AddDays(7), new TimeOnly(15, 0), AppointmentStatus.Pending, null, null),
            new(Patient(10), Anjali(), today.AddDays(14), new TimeOnly(9, 30), AppointmentStatus.Confirmed, null, null),
            new(Patient(11), Anjali(), today.AddDays(21), new TimeOnly(10, 30), AppointmentStatus.Pending, null, null),
            new(Patient(12), Anjali(), today.AddDays(30), new TimeOnly(11, 30), AppointmentStatus.Confirmed, null, null),

            // Other doctors keep the dashboard and reports realistic.
            new(Patient(6), Doctor(DoctorSpecialisation.Dermatology), today.AddDays(-6), new TimeOnly(9, 0), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-6), "Atopic dermatitis flare", "Topical treatment and moisturiser routine prescribed", "Trigger avoidance discussed.")),
            new(Patient(7), Doctor(DoctorSpecialisation.Neurology), today.AddDays(-7), new TimeOnly(10, 0), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-7), "Migraine review", "Migraine management plan reviewed", "Headache diary advised.")),
            new(Patient(8), Doctor(DoctorSpecialisation.Orthopaedics), today.AddDays(-8), new TimeOnly(11, 0), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-8), "Right knee strain", "Pain management and physiotherapy referral", "Avoid high-impact exercise temporarily.")),
            new(Patient(9), Doctor(DoctorSpecialisation.Pediatrics), today.AddDays(-9), new TimeOnly(14, 0), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-9), "Viral upper respiratory infection", "Symptomatic treatment advised", "Hydration and fever monitoring discussed.")),
            new(Patient(10), Doctor(DoctorSpecialisation.GeneralMedicine), today.AddDays(-11), new TimeOnly(15, 0), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-11), "Routine diabetes review", "Medication adherence and diet plan reviewed", "Follow-up labs advised.")),
            new(Patient(11), Doctor(DoctorSpecialisation.Psychiatry), today.AddDays(-12), new TimeOnly(16, 0), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-12), "Anxiety symptoms", "Counselling plan and sleep hygiene advice", "Stress-management strategies documented.")),
            new(Patient(12), Doctor(DoctorSpecialisation.Radiology), today.AddDays(-13), new TimeOnly(9, 30), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-13), "Lumbar spine imaging review", "Radiology report reviewed", "Mild degenerative changes noted.")),
            new(Patient(13), Doctor(DoctorSpecialisation.Gynecology), today.AddDays(-14), new TimeOnly(10, 30), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-14), "Irregular cycle assessment", "Evaluation plan and follow-up advised", "Ultrasound review planned if symptoms persist.")),
            new(Patient(14), Doctor(DoctorSpecialisation.ENT), today.AddDays(-15), new TimeOnly(11, 30), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-15), "Otitis externa", "Ear care treatment prescribed", "Keep ear dry and review if discharge persists.")),
            new(Patient(15), Doctor(DoctorSpecialisation.GeneralMedicine), today.AddDays(-22), new TimeOnly(9, 30), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-22), "Annual wellness review", "Preventive screening and lifestyle review completed", "Follow-up advised after routine lab results.")),
            new(Patient(16), Doctor(DoctorSpecialisation.Psychiatry), today.AddDays(-25), new TimeOnly(10, 30), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-25), "Sleep disturbance review", "Sleep hygiene plan and counselling follow-up advised", "No acute safety concerns documented.")),
            new(Patient(17), Doctor(DoctorSpecialisation.ENT), today.AddDays(-28), new TimeOnly(11, 30), AppointmentStatus.Completed, null,
                new SeedHealthRecord(today.AddDays(-28), "Recurrent sinusitis review", "Nasal care plan and ENT follow-up advised", "Steam inhalation and allergen avoidance discussed.")),

            new(Patient(15), Doctor(DoctorSpecialisation.Dermatology), today, new TimeOnly(9, 30), AppointmentStatus.Confirmed, null, null),
            new(Patient(16), Doctor(DoctorSpecialisation.GeneralMedicine), today, new TimeOnly(10, 30), AppointmentStatus.Pending, null, null),
            new(Patient(17), Doctor(DoctorSpecialisation.ENT), today, new TimeOnly(11, 30), AppointmentStatus.Cancelled, "Doctor unavailable. - Cancelled by admin", null),

            new(Patient(13), Doctor(DoctorSpecialisation.Neurology), today.AddDays(3), new TimeOnly(9, 30), AppointmentStatus.Pending, null, null),
            new(Patient(14), Doctor(DoctorSpecialisation.Orthopaedics), today.AddDays(4), new TimeOnly(10, 30), AppointmentStatus.Confirmed, null, null),
            new(Patient(15), Doctor(DoctorSpecialisation.Pediatrics), today.AddDays(5), new TimeOnly(11, 30), AppointmentStatus.Pending, null, null),
            new(Patient(16), Doctor(DoctorSpecialisation.Psychiatry), today.AddDays(6), new TimeOnly(14, 30), AppointmentStatus.Confirmed, null, null),
            new(Patient(17), Doctor(DoctorSpecialisation.Gynecology), today.AddDays(7), new TimeOnly(15, 30), AppointmentStatus.Pending, null, null),
            new(Patient(6), Doctor(DoctorSpecialisation.Radiology), today.AddDays(10), new TimeOnly(16, 0), AppointmentStatus.Confirmed, null, null),

            new(Patient(12), Doctor(DoctorSpecialisation.Cardiology), today.AddDays(-16), new TimeOnly(9, 0), AppointmentStatus.Cancelled, "Patient cancelled due to travel. - Cancelled by patient", null),
            new(Patient(13), Doctor(DoctorSpecialisation.Dermatology), today.AddDays(-18), new TimeOnly(10, 0), AppointmentStatus.Cancelled, "Clinic emergency. - Cancelled by admin", null)
        ];
    }

    private static async Task<IdentityUser> EnsureUserWithRoleAsync(
        UserManager<IdentityUser> userManager,
        string email,
        string phoneNumber,
        string password,
        string role,
        bool resetPassword = false)
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
            existingUser.UserName = email;
            existingUser.Email = email;
            existingUser.PhoneNumber = phoneNumber;
            existingUser.EmailConfirmed = true;

            var updateResult = await userManager.UpdateAsync(existingUser);

            if (!updateResult.Succeeded)
            {
                var errors = string.Join(" ", updateResult.Errors.Select(error => error.Description));
                throw new InvalidOperationException($"Unable to update seeded user {email}. {errors}");
            }

            if (resetPassword)
            {
                var token = await userManager.GeneratePasswordResetTokenAsync(existingUser);
                var passwordResult = await userManager.ResetPasswordAsync(existingUser, token, password);

                if (!passwordResult.Succeeded)
                {
                    var errors = string.Join(" ", passwordResult.Errors.Select(error => error.Description));
                    throw new InvalidOperationException($"Unable to reset seeded user password for {email}. {errors}");
                }
            }
        }

        if (!await userManager.IsInRoleAsync(existingUser, role))
        {
            var roleResult = await userManager.AddToRoleAsync(existingUser, role);

            if (!roleResult.Succeeded)
            {
                var errors = string.Join(" ", roleResult.Errors.Select(error => error.Description));
                throw new InvalidOperationException($"Unable to assign role {role} to {email}. {errors}");
            }
        }

        return existingUser;
    }

    private static int CalculateAge(DateOnly dateOfBirth, DateOnly referenceDate)
    {
        var age = referenceDate.Year - dateOfBirth.Year;

        if (referenceDate < dateOfBirth.AddYears(age))
        {
            age--;
        }

        return age;
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
