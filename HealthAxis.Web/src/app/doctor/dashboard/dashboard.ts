import { Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';

import { DoctorService } from '../../core/services/doctor-service';
import {
  Appointment,
  HealthRecord,
  PublicDoctor
} from '../../shared/models/health-axis.models';

interface AccessiblePatientHistory {
  patientId: number;
  patientName: string;
  appointmentId: number;
  appointmentDate: string;
  appointmentTime: string;
}

@Component({
  selector: 'app-doctor-dashboard',
  imports: [FormsModule, RouterLink],
  templateUrl: './dashboard.html',
  styleUrl: './dashboard.css'
})
export class DoctorDashboard implements OnInit {
  private readonly doctorService = inject(DoctorService);

  readonly currentDoctor = signal<PublicDoctor | null>(null);
  readonly appointments = signal<Appointment[]>([]);
  readonly healthRecords = signal<HealthRecord[]>([]);

  readonly isDoctorLoading = signal(false);
  readonly isAppointmentsLoading = signal(false);
  readonly isHealthRecordsLoading = signal(false);

  readonly doctorErrorMessage = signal('');
  readonly appointmentsErrorMessage = signal('');
  readonly healthRecordsErrorMessage = signal('');
  readonly activationErrorMessage = signal('');
  readonly cancellationErrorMessage = signal('');
  readonly completionErrorMessage = signal('');

  selectedActivationState: boolean | null = null;
  selectedCancelAppointment: Appointment | null = null;
  selectedCompleteAppointment: Appointment | null = null;
  selectedHealthRecord: HealthRecord | null = null;
  selectedCancellationReason: Appointment | null = null;

  cancellationReason = '';
  diagnosis = '';
  prescription = '';
  notes = '';

  readonly today = computed(() => this.formatDateOnly(new Date()));

  readonly isAnyLoading = computed(() => {
    return this.isDoctorLoading() ||
      this.isAppointmentsLoading() ||
      this.isHealthRecordsLoading();
  });

  readonly isDoctorActive = computed(() => {
    return this.currentDoctor()?.isAvailable ?? false;
  });

  readonly firstName = computed(() => {
    return this.currentDoctor()?.fullName?.split(' ')[0] ?? '';
  });

  readonly todayAppointments = computed(() => {
    return this.appointments()
      .filter(appointment => appointment.appointmentDate === this.today() && appointment.status === 'Confirmed')
      .sort((first, second) => this.compareAppointmentDateTime(first, second));
  });

  readonly pendingAppointments = computed(() => {
    return this.appointments()
      .filter(appointment => appointment.status === 'Pending')
      .sort((first, second) => this.compareAppointmentDateTime(first, second));
  });

  readonly pendingPreview = computed(() => {
    return this.pendingAppointments().slice(0, 5);
  });

  readonly upcomingConfirmedAppointments = computed(() => {
    return this.appointments()
      .filter(appointment => appointment.status === 'Confirmed' && appointment.appointmentDate > this.today())
      .sort((first, second) => this.compareAppointmentDateTime(first, second));
  });

  readonly upcomingConfirmedPreview = computed(() => {
    return this.upcomingConfirmedAppointments().slice(0, 5);
  });

  readonly doctorCreatedHealthRecords = computed(() => {
    return [...this.healthRecords()]
      .sort((first, second) => second.visitDate.localeCompare(first.visitDate));
  });

  readonly doctorCreatedHealthRecordPreview = computed(() => {
    return this.doctorCreatedHealthRecords().slice(0, 4);
  });

  readonly accessiblePatientHistories = computed(() => {
    const confirmedAppointments = this.appointments()
      .filter(appointment => appointment.status === 'Confirmed' && appointment.appointmentDate >= this.today())
      .sort((first, second) => this.compareAppointmentDateTime(first, second));

    const patientMap = new Map<number, AccessiblePatientHistory>();

    for (const appointment of confirmedAppointments) {
      if (!patientMap.has(appointment.patientId)) {
        patientMap.set(appointment.patientId, {
          patientId: appointment.patientId,
          patientName: appointment.patientName,
          appointmentId: appointment.id,
          appointmentDate: appointment.appointmentDate,
          appointmentTime: appointment.appointmentTime
        });
      }
    }

    return Array.from(patientMap.values());
  });

  readonly cancelledAppointments = computed(() => {
    return this.appointments()
      .filter(appointment => appointment.status === 'Cancelled')
      .sort((first, second) => this.compareAppointmentDateTime(second, first));
  });

  readonly cancelledPreview = computed(() => {
    return this.cancelledAppointments().slice(0, 4);
  });

  ngOnInit(): void {
    this.loadDashboardData();
  }

  loadDashboardData(): void {
    this.loadDoctor();
    this.loadAppointments();
    this.loadHealthRecords();
  }

  loadDoctor(): void {
    this.isDoctorLoading.set(true);
    this.doctorErrorMessage.set('');

    this.doctorService.getCurrentDoctor()
      .subscribe({
        next: doctor => {
          this.currentDoctor.set(doctor);
          this.isDoctorLoading.set(false);
        },
        error: error => {
          console.error('Failed to load doctor profile.', error);
          this.doctorErrorMessage.set(error?.error?.message ?? 'Unable to load doctor profile.');
          this.isDoctorLoading.set(false);
        }
      });
  }

  loadAppointments(): void {
    this.isAppointmentsLoading.set(true);
    this.appointmentsErrorMessage.set('');

    this.doctorService.getCurrentDoctorAppointments()
      .subscribe({
        next: appointments => {
          this.appointments.set(appointments);
          this.isAppointmentsLoading.set(false);
        },
        error: error => {
          console.error('Failed to load doctor appointments.', error);
          this.appointmentsErrorMessage.set(error?.error?.message ?? 'Unable to load appointments.');
          this.isAppointmentsLoading.set(false);
        }
      });
  }

  loadHealthRecords(): void {
    this.isHealthRecordsLoading.set(true);
    this.healthRecordsErrorMessage.set('');

    this.doctorService.getCurrentDoctorHealthRecords()
      .subscribe({
        next: records => {
          this.healthRecords.set(records);
          this.isHealthRecordsLoading.set(false);
        },
        error: error => {
          console.error('Failed to load doctor health records.', error);
          this.healthRecordsErrorMessage.set(error?.error?.message ?? 'Unable to load health records.');
          this.isHealthRecordsLoading.set(false);
        }
      });
  }

  openActivationModal(nextState: boolean): void {
    this.selectedActivationState = nextState;
    this.activationErrorMessage.set('');
  }

  closeActivationModal(): void {
    this.selectedActivationState = null;
    this.activationErrorMessage.set('');
  }

  confirmActivationChange(): void {
    if (this.selectedActivationState === null) {
      return;
    }

    const nextState = this.selectedActivationState;
    this.activationErrorMessage.set('');

    this.doctorService.updateCurrentDoctorAvailability(nextState)
      .subscribe({
        next: availability => {
          this.currentDoctor.update(doctor => doctor
            ? { ...doctor, isAvailable: availability.isAvailable }
            : doctor);

          this.closeActivationModal();
        },
        error: error => {
          console.error('Failed to update doctor activation state.', error);
          this.activationErrorMessage.set(error?.error?.message ?? 'Unable to update activation state.');
        }
      });
  }

  confirmPendingAppointment(appointment: Appointment): void {
    this.doctorService.confirmAppointment(appointment.id)
      .subscribe({
        next: updatedAppointment => {
          this.updateAppointmentInState(updatedAppointment);
        },
        error: error => {
          console.error('Failed to confirm appointment.', error);
          this.appointmentsErrorMessage.set(error?.error?.message ?? 'Unable to confirm appointment.');
        }
      });
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

    this.doctorService.cancelAppointment(this.selectedCancelAppointment.id, this.cancellationReason.trim())
      .subscribe({
        next: updatedAppointment => {
          this.updateAppointmentInState(updatedAppointment);
          this.closeCancelAppointment();
        },
        error: error => {
          console.error('Failed to cancel appointment.', error);
          this.cancellationErrorMessage.set(error?.error?.message ?? 'Unable to cancel appointment.');
        }
      });
  }

  openCompleteConsultation(appointment: Appointment): void {
    this.selectedCompleteAppointment = appointment;
    this.diagnosis = '';
    this.prescription = '';
    this.notes = '';
    this.completionErrorMessage.set('');
  }

  closeCompleteConsultation(): void {
    this.selectedCompleteAppointment = null;
    this.diagnosis = '';
    this.prescription = '';
    this.notes = '';
    this.completionErrorMessage.set('');
  }

  submitHealthRecord(): void {
    if (!this.selectedCompleteAppointment || !this.diagnosis.trim() || !this.prescription.trim()) {
      return;
    }

    const appointment = this.selectedCompleteAppointment;
    this.completionErrorMessage.set('');

    this.doctorService.createHealthRecord(
      appointment.id,
      appointment.appointmentDate,
      this.diagnosis.trim(),
      this.prescription.trim(),
      this.notes.trim() || null
    ).subscribe({
      next: record => {
        this.healthRecords.update(records => [record, ...records]);

        this.appointments.update(appointments => appointments.map(existingAppointment =>
          existingAppointment.id === appointment.id
            ? {
                ...existingAppointment,
                status: 'Completed',
                healthRecordId: record.id
              }
            : existingAppointment));

        this.closeCompleteConsultation();
      },
      error: error => {
        console.error('Failed to create health record.', error);
        this.completionErrorMessage.set(error?.error?.message ?? 'Unable to create health record.');
      }
    });
  }

  openHealthRecordDetails(record: HealthRecord): void {
    this.selectedHealthRecord = record;
  }

  closeHealthRecordDetails(): void {
    this.selectedHealthRecord = null;
  }

  openCancellationReason(appointment: Appointment): void {
    this.selectedCancellationReason = appointment;
  }

  closeCancellationReason(): void {
    this.selectedCancellationReason = null;
  }

  canCancelConfirmedAppointment(appointment: Appointment): boolean {
    return appointment.status === 'Confirmed' && this.hoursUntilAppointment(appointment) >= 24;
  }

  isUrgentPendingAppointment(appointment: Appointment): boolean {
    return appointment.status === 'Pending' && this.hoursUntilAppointment(appointment) < 24;
  }

  formatDate(date: string): string {
    return new Date(`${date}T00:00:00`).toLocaleDateString('en-IN', {
      day: '2-digit',
      month: 'short',
      year: 'numeric'
    });
  }

  formatTime(time: string): string {
    return time.slice(0, 5);
  }

  private updateAppointmentInState(updatedAppointment: Appointment): void {
    this.appointments.update(appointments => appointments.map(appointment =>
      appointment.id === updatedAppointment.id ? updatedAppointment : appointment));
  }

  private hoursUntilAppointment(appointment: Appointment): number {
    const appointmentDateTime = new Date(`${appointment.appointmentDate}T${appointment.appointmentTime}`);
    const now = new Date();

    return (appointmentDateTime.getTime() - now.getTime()) / 36e5;
  }

  private compareAppointmentDateTime(first: Appointment, second: Appointment): number {
    return `${first.appointmentDate}T${first.appointmentTime}`
      .localeCompare(`${second.appointmentDate}T${second.appointmentTime}`);
  }

  private formatDateOnly(date: Date): string {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');

    return `${year}-${month}-${day}`;
  }
}
