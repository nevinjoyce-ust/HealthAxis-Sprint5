import { Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';

import { PatientDto, PatientService } from '../../core/services/patient-service';
import {
  Appointment,
  DoctorSpecialisation,
  HealthRecord,
  PublicDoctor
} from '../../shared/models/health-axis.models';

@Component({
  selector: 'app-patient-dashboard',
  imports: [FormsModule, RouterLink],
  templateUrl: './dashboard.html',
  styleUrl: './dashboard.css'
})
export class PatientDashboard implements OnInit {
  private readonly patientService = inject(PatientService);

  readonly isPatientLoading = signal(false);
  readonly isAppointmentsLoading = signal(false);
  readonly isHealthRecordsLoading = signal(false);
  readonly isDoctorsLoading = signal(false);

  readonly patientErrorMessage = signal('');
  readonly appointmentsErrorMessage = signal('');
  readonly healthRecordsErrorMessage = signal('');
  readonly doctorsErrorMessage = signal('');
  readonly cancellationErrorMessage = signal('');

  readonly patient = signal<PatientDto | null>(null);
  readonly doctors = signal<PublicDoctor[]>([]);
  readonly appointments = signal<Appointment[]>([]);
  readonly healthRecords = signal<HealthRecord[]>([]);

  bookingDate = this.getDefaultBookingDate();
  bookingSpecialisation = '';

  doctorSearchText = '';
  doctorSearchSpecialisation = '';

  selectedHealthRecord: HealthRecord | null = null;
  selectedCancelledAppointment: Appointment | null = null;
  selectedCancelAppointment: Appointment | null = null;
  cancellationReason = '';

  readonly today = computed(() => this.formatDateOnly(new Date()));

  readonly firstName = computed(() => {
    return this.patient()?.fullName?.split(' ')[0] || 'Patient';
  });

  readonly isAnySectionLoading = computed(() => {
    return this.isPatientLoading() ||
      this.isAppointmentsLoading() ||
      this.isHealthRecordsLoading() ||
      this.isDoctorsLoading();
  });

  readonly futureAppointments = computed(() => {
    return this.appointments()
      .filter(appointment => appointment.appointmentDate >= this.today())
      .sort((first, second) => this.compareAppointmentDateTime(first, second));
  });

  readonly pastAppointments = computed(() => {
    return this.appointments()
      .filter(appointment => appointment.appointmentDate < this.today())
      .sort((first, second) => this.compareAppointmentDateTime(second, first));
  });

  readonly todayAppointments = computed(() => {
    return this.futureAppointments().filter(
      appointment => appointment.appointmentDate === this.today() && appointment.status !== 'Cancelled'
    );
  });

  readonly confirmedUpcomingAppointments = computed(() => {
    return this.futureAppointments().filter(
      appointment => appointment.status === 'Confirmed' && appointment.appointmentDate > this.today()
    );
  });

  readonly pendingUpcomingAppointments = computed(() => {
    return this.futureAppointments().filter(
      appointment => appointment.status === 'Pending' && appointment.appointmentDate > this.today()
    );
  });

  readonly pendingUpcomingPreview = computed(() => {
    return this.pendingUpcomingAppointments().slice(0, 5);
  });

  readonly futureCancelledAppointments = computed(() => {
    return this.futureAppointments().filter(appointment => appointment.status === 'Cancelled');
  });

  readonly healthRecordPreview = computed(() => {
    return [...this.healthRecords()]
      .sort((first, second) => second.visitDate.localeCompare(first.visitDate))
      .slice(0, 4);
  });

  readonly pastCancelledPreview = computed(() => {
    return this.pastAppointments()
      .filter(appointment => appointment.status === 'Cancelled')
      .slice(0, 4);
  });

  readonly hasNonCancelledUpcomingAppointments = computed(() => {
    return this.todayAppointments().length > 0 ||
      this.confirmedUpcomingAppointments().length > 0 ||
      this.pendingUpcomingAppointments().length > 0;
  });

  ngOnInit(): void {
    this.loadDashboardData();
  }

  loadDashboardData(): void {
    this.loadPatient();
    this.loadAppointments();
    this.loadHealthRecords();
    this.loadDoctors();
  }

  loadPatient(): void {
    this.isPatientLoading.set(true);
    this.patientErrorMessage.set('');

    try {
      this.patientService.getCurrentPatient()
        .subscribe({
          next: patient => {
            this.patient.set(patient);
            this.isPatientLoading.set(false);
          },
          error: error => {
            console.error('Failed to load current patient.', error);
            this.patientErrorMessage.set(error?.error?.message ?? 'Unable to load profile details.');
            this.isPatientLoading.set(false);
          }
        });
    } catch (error) {
      console.error('Failed to start patient profile request.', error);
      this.patientErrorMessage.set('Unable to load profile details.');
      this.isPatientLoading.set(false);
    }
  }

  loadAppointments(): void {
    this.isAppointmentsLoading.set(true);
    this.appointmentsErrorMessage.set('');

    try {
      this.patientService.getCurrentPatientAppointments()
        .subscribe({
          next: appointments => {
            this.appointments.set(appointments);
            this.isAppointmentsLoading.set(false);
          },
          error: error => {
            console.error('Failed to load patient appointments.', error);
            this.appointmentsErrorMessage.set(error?.error?.message ?? 'Unable to load appointments.');
            this.isAppointmentsLoading.set(false);
          }
        });
    } catch (error) {
      console.error('Failed to start patient appointments request.', error);
      this.appointmentsErrorMessage.set('Unable to load appointments.');
      this.isAppointmentsLoading.set(false);
    }
  }

  loadHealthRecords(): void {
    this.isHealthRecordsLoading.set(true);
    this.healthRecordsErrorMessage.set('');

    try {
      this.patientService.getCurrentPatientHealthRecords()
        .subscribe({
          next: healthRecords => {
            this.healthRecords.set(healthRecords);
            this.isHealthRecordsLoading.set(false);
          },
          error: error => {
            console.error('Failed to load patient health records.', error);
            this.healthRecordsErrorMessage.set(error?.error?.message ?? 'Unable to load health records.');
            this.isHealthRecordsLoading.set(false);
          }
        });
    } catch (error) {
      console.error('Failed to start patient health records request.', error);
      this.healthRecordsErrorMessage.set('Unable to load health records.');
      this.isHealthRecordsLoading.set(false);
    }
  }

  loadDoctors(): void {
    this.isDoctorsLoading.set(true);
    this.doctorsErrorMessage.set('');

    try {
      this.patientService.getPublicDoctors()
        .subscribe({
          next: doctors => {
            this.doctors.set(doctors);
            this.isDoctorsLoading.set(false);
          },
          error: error => {
            console.error('Failed to load doctors.', error);
            this.doctorsErrorMessage.set(error?.error?.message ?? 'Unable to load doctors.');
            this.isDoctorsLoading.set(false);
          }
        });
    } catch (error) {
      console.error('Failed to start doctors request.', error);
      this.doctorsErrorMessage.set('Unable to load doctors.');
      this.isDoctorsLoading.set(false);
    }
  }

  openHealthRecordDetails(record: HealthRecord): void {
    this.selectedHealthRecord = record;
  }

  closeHealthRecordDetails(): void {
    this.selectedHealthRecord = null;
  }

  openCancellationReason(appointment: Appointment): void {
    this.selectedCancelledAppointment = appointment;
  }

  closeCancellationReason(): void {
    this.selectedCancelledAppointment = null;
  }

  openCancelAppointment(appointment: Appointment): void {
    this.selectedCancelAppointment = appointment;
    this.cancellationReason = '';
    this.cancellationErrorMessage.set('');
  }

  closeCancelAppointment(): void {
    this.selectedCancelAppointment = null;
    this.cancellationReason = '';
    this.cancellationErrorMessage.set('');
  }

  submitCancellation(): void {
    if (!this.selectedCancelAppointment || !this.cancellationReason.trim()) {
      return;
    }

    this.cancellationErrorMessage.set('');

    this.patientService.cancelAppointment(this.selectedCancelAppointment.id, this.cancellationReason.trim())
      .subscribe({
        next: updatedAppointment => {
          this.appointments.update(appointments => appointments.map(appointment =>
            appointment.id === updatedAppointment.id ? updatedAppointment : appointment));

          this.closeCancelAppointment();
        },
        error: error => {
          console.error('Failed to cancel appointment.', error);
          this.cancellationErrorMessage.set(error?.error?.message ?? 'Unable to cancel appointment.');
        }
      });
  }

  getDoctorSpecialisation(doctorId: number): string {
    const doctor = this.doctors().find(existingDoctor => existingDoctor.id === doctorId);

    return doctor
      ? this.formatSpecialisation(doctor.specialisation)
      : 'Not available';
  }

  getAppointmentStatusClasses(status: Appointment['status']): string {
    switch (status) {
      case 'Pending':
        return 'rounded-full bg-amber-100 px-3 py-1 text-xs font-bold text-amber-700';
      case 'Confirmed':
        return 'rounded-full bg-green-100 px-3 py-1 text-xs font-bold text-green-700';
      case 'Cancelled':
        return 'rounded-full bg-red-100 px-3 py-1 text-xs font-bold text-red-700';
      case 'Completed':
        return 'rounded-full bg-blue-100 px-3 py-1 text-xs font-bold text-blue-700';
    }
  }

  formatSpecialisation(specialisation: DoctorSpecialisation): string {
    return specialisation === 'GeneralMedicine'
      ? 'General Medicine'
      : specialisation;
  }

  formatTime(time: string): string {
    return time.slice(0, 5);
  }

  formatDate(date: string): string {
    return new Date(`${date}T00:00:00`).toLocaleDateString('en-IN', {
      day: '2-digit',
      month: 'short',
      year: 'numeric'
    });
  }

  private compareAppointmentDateTime(first: Appointment, second: Appointment): number {
    return `${first.appointmentDate}T${first.appointmentTime}`
      .localeCompare(`${second.appointmentDate}T${second.appointmentTime}`);
  }

  private getDefaultBookingDate(): string {
    const date = new Date();
    date.setDate(date.getDate() + 3);

    return this.formatDateOnly(date);
  }

  private formatDateOnly(date: Date): string {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');

    return `${year}-${month}-${day}`;
  }
}
