namespace HealthAxis.API.Constants;

public static class ErrorMessages
{
    public const string InvalidCredentials = "Invalid credentials.";

    public const string InvalidRefreshToken = "Invalid refresh token.";

    public const string RefreshTokenExpired = "Refresh token has expired.";

    public const string PasswordsDoNotMatch = "Passwords do not match.";

    public const string EmailAlreadyRegistered = "Email is already registered.";

    public const string EmailAlreadyExists = "A user with this email already exists.";

    public const string PatientNotFound = "Patient not found.";

    public const string PatientAccountNotFound = "Patient account not found.";

    public const string PatientProfileNotFound = "Patient profile was not found for this user.";

    public const string DoctorNotFound = "Doctor not found.";

    public const string DoctorNotFoundAfterCreation = "Doctor not found after creation.";

    public const string DoctorProfileNotFound = "Doctor profile was not found for this user.";

    public const string DoctorUnavailable = "Doctor is not available for appointments.";

    public const string DoctorAvailableMessage = "Doctor is available.";

    public const string DoctorUnavailableMessage = "Doctor is not available.";

    public const string DoctorCannotDeactivateWithConfirmedAppointmentsToday = "Doctor cannot be deactivated because confirmed appointments exist today. Complete or cancel today's confirmed appointments first.";

    public const string DoctorsCanUpdateOnlyOwnAvailability = "Doctors can update only their own availability.";

    public const string DoctorEmergencyCancellationReason = "Appointment cancelled due to doctor emergency, sincere apologies.";

    public const string AppointmentNotFound = "Appointment not found.";

    public const string AppointmentNotFoundAfterCreation = "Appointment not found after creation.";

    public const string AppointmentDateCannotBeInPast = "Appointment date cannot be in the past.";

    public const string AppointmentMustBeBookedAtLeast24HoursAhead = "Appointments must be booked at least 24 hours before the scheduled time.";

    public const string DoctorSlotAlreadyBooked = "Doctor already has an appointment at the selected date and time.";

    public const string PatientSlotAlreadyBooked = "Patient already has an appointment at the selected date and time.";

    public const string PatientAlreadyHasAppointmentWithDoctorOnDate = "Patient already has an appointment with this doctor on the selected date.";

    public const string OnlyPendingAppointmentsCanBeConfirmed = "Only pending appointments can be confirmed.";

    public const string DoctorsCanManageOnlyOwnAppointments = "Doctors can manage only their own appointments.";

    public const string PatientsCanManageOnlyOwnAppointments = "Patients can manage only their own appointments.";

    public const string CancellationReasonRequired = "Cancellation reason is required.";

    public const string CompletedAppointmentsCannotBeCancelled = "Completed appointments cannot be cancelled.";

    public const string CancelledAppointmentsCannotBeCancelledAgain = "Cancelled appointments cannot be cancelled again.";

    public const string AppointmentCannotBeCancelledWithin24Hours = "Appointment cannot be cancelled within 24 hours of the scheduled time.";

    public const string AppointmentCompletedOnlyThroughHealthRecord = "Appointments can be completed only by creating a health record.";

    public const string UnsupportedAppointmentStatusTransition = "Unsupported appointment status transition.";

    public const string PendingAppointmentAutoCancelledReason = "Automatically cancelled because the appointment was not confirmed at least 24 hours before the scheduled time.";

    public const string CancelledByPatientSuffix = " - Cancelled by patient";

    public const string CancelledByDoctorSuffix = " - Cancelled by doctor";

    public const string CancelledByAdminSuffix = " - Cancelled by admin";

    public const string AppointmentCannotBeDeletedBecauseHealthRecordExists = "Appointment cannot be deleted because a health record exists for this appointment.";

    public const string HealthRecordNotFound = "Health record not found.";

    public const string HealthRecordNotFoundAfterCreation = "Health record not found after creation.";

    public const string DoctorCanCreateHealthRecordOnlyForOwnAppointment = "Doctor can create a health record only for their own appointment.";

    public const string OnlyConfirmedAppointmentsCanBeCompleted = "Only confirmed appointments can be completed.";

    public const string HealthRecordCanBeCreatedOnlyOnAppointmentDate = "Health records can be created only on the appointment date.";

    public const string VisitDateMustMatchAppointmentDate = "Visit date must match the appointment date.";

    public const string HealthRecordAlreadyExistsForAppointment = "A health record already exists for this appointment.";

    public const string UnableToCreateDoctor = "Unable to create doctor.";

    public const string UnableToCreateAppointment = "Unable to create appointment.";

    public const string UnableToCreateHealthRecord = "Unable to create health record.";
}
