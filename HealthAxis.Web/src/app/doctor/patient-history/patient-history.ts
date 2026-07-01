import { Component, OnInit, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, RouterLink } from '@angular/router';

import { DoctorService } from '../../core/services/doctor-service';
import {
  Appointment,
  DoctorSpecialisation,
  HealthRecord,
  PublicDoctor
} from '../../shared/models/health-axis.models';

@Component({
  selector: 'app-patient-history',
  imports: [FormsModule, RouterLink],
  templateUrl: './patient-history.html',
  styleUrl: './patient-history.css'
})
export class PatientHistory implements OnInit {
  private readonly doctorService = inject(DoctorService);
  private readonly route = inject(ActivatedRoute);

  readonly appointments = signal<Appointment[]>([]);
  readonly healthRecords = signal<HealthRecord[]>([]);
  readonly doctors = signal<PublicDoctor[]>([]);

  readonly isAppointmentsLoading = signal(false);
  readonly isHealthRecordsLoading = signal(false);
  readonly isDoctorsLoading = signal(false);

  readonly appointmentsErrorMessage = signal('');
  readonly healthRecordsErrorMessage = signal('');
  readonly doctorsErrorMessage = signal('');

  patientId: number | null = null;
  appointmentId: number | null = null;

  searchText = '';
  fromDate = '';
  toDate = '';
  showFilters = false;

  selectedHealthRecord: HealthRecord | null = null;

  constructor() {
    this.route.queryParamMap.subscribe(params => {
      const patientId = Number(params.get('patientId'));
      const appointmentId = Number(params.get('appointmentId'));

      this.patientId = Number.isInteger(patientId) && patientId > 0 ? patientId : null;
      this.appointmentId = Number.isInteger(appointmentId) && appointmentId > 0 ? appointmentId : null;

      if (this.hasFullHistoryAccess) {
        this.loadPatientHealthRecords();
      } else {
        this.healthRecords.set([]);
      }
    });
  }

  ngOnInit(): void {
    this.loadAppointments();
    this.loadDoctors();
  }

  get isAnyLoading(): boolean {
    return this.isAppointmentsLoading() || this.isHealthRecordsLoading() || this.isDoctorsLoading();
  }

  get accessAppointment(): Appointment | null {
    if (!this.appointmentId || !this.patientId) {
      return null;
    }

    return this.appointments().find(appointment =>
      appointment.id === this.appointmentId &&
      appointment.patientId === this.patientId
    ) ?? null;
  }

  get hasFullHistoryAccess(): boolean {
    const appointment = this.accessAppointment;

    if (!appointment) {
      return false;
    }

    return appointment.status === 'Confirmed' && this.isTodayOrFuture(appointment.appointmentDate);
  }

  get patientName(): string {
    const appointment = this.accessAppointment;

    if (appointment) {
      return appointment.patientName;
    }

    const healthRecord = this.healthRecords().find(record => record.patientId === this.patientId);

    return healthRecord?.patientName ?? 'Patient';
  }

  get filteredPatientHealthRecords(): HealthRecord[] {
    if (!this.hasFullHistoryAccess || !this.patientId) {
      return [];
    }

    return this.healthRecords()
      .filter(record => record.patientId === this.patientId)
      .filter(record => this.matchesSearchText(record))
      .filter(record => this.matchesDateRange(record))
      .sort((first, second) => second.visitDate.localeCompare(first.visitDate));
  }

  loadAppointments(): void {
    this.isAppointmentsLoading.set(true);
    this.appointmentsErrorMessage.set('');

    this.doctorService.getCurrentDoctorAppointments()
      .subscribe({
        next: appointments => {
          this.appointments.set(appointments);
          this.isAppointmentsLoading.set(false);

          if (this.hasFullHistoryAccess) {
            this.loadPatientHealthRecords();
          }
        },
        error: error => {
          console.error('Failed to load doctor appointments.', error);
          this.appointmentsErrorMessage.set(error?.error?.message ?? 'Unable to load appointments.');
          this.isAppointmentsLoading.set(false);
        }
      });
  }

  loadPatientHealthRecords(): void {
    if (!this.patientId) {
      return;
    }

    this.isHealthRecordsLoading.set(true);
    this.healthRecordsErrorMessage.set('');

    this.doctorService.getPatientHealthRecords(this.patientId)
      .subscribe({
        next: records => {
          this.healthRecords.set(records);
          this.isHealthRecordsLoading.set(false);
        },
        error: error => {
          console.error('Failed to load patient health records.', error);
          this.healthRecordsErrorMessage.set(error?.error?.message ?? 'Unable to load patient health records.');
          this.isHealthRecordsLoading.set(false);
        }
      });
  }

  loadDoctors(): void {
    this.isDoctorsLoading.set(true);
    this.doctorsErrorMessage.set('');

    this.doctorService.getPublicDoctors()
      .subscribe({
        next: doctors => {
          this.doctors.set(doctors);
          this.isDoctorsLoading.set(false);
        },
        error: error => {
          console.error('Failed to load doctors.', error);
          this.doctorsErrorMessage.set(error?.error?.message ?? 'Unable to load doctor details.');
          this.isDoctorsLoading.set(false);
        }
      });
  }

  toggleFilters(): void {
    this.showFilters = !this.showFilters;
  }

  clearFilters(): void {
    this.searchText = '';
    this.fromDate = '';
    this.toDate = '';
  }

  openHealthRecordDetails(record: HealthRecord): void {
    this.selectedHealthRecord = record;
  }

  closeHealthRecordDetails(): void {
    this.selectedHealthRecord = null;
  }

  getDoctorSpecialisation(doctorId: number): string {
    const doctor = this.doctors().find(existingDoctor => existingDoctor.id === doctorId);

    return doctor
      ? this.formatSpecialisation(doctor.specialisation)
      : 'Not available';
  }

  formatSpecialisation(specialisation: DoctorSpecialisation): string {
    return specialisation === 'GeneralMedicine'
      ? 'General Medicine'
      : specialisation;
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

  private matchesSearchText(record: HealthRecord): boolean {
    const normalizedSearchText = this.searchText.trim().toLowerCase();

    if (!normalizedSearchText) {
      return true;
    }

    const doctorSpecialisation = this.getDoctorSpecialisation(record.doctorId).toLowerCase();

    return record.doctorName.toLowerCase().includes(normalizedSearchText) ||
      doctorSpecialisation.includes(normalizedSearchText) ||
      record.diagnosis.toLowerCase().includes(normalizedSearchText);
  }

  private matchesDateRange(record: HealthRecord): boolean {
    if (this.fromDate && record.visitDate < this.fromDate) {
      return false;
    }

    if (this.toDate && record.visitDate > this.toDate) {
      return false;
    }

    return true;
  }

  private isTodayOrFuture(date: string): boolean {
    const selectedDate = this.parseDateOnly(date);
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    return selectedDate.getTime() >= today.getTime();
  }

  private parseDateOnly(date: string): Date {
    const [year, month, day] = date.split('-').map(Number);
    return new Date(year, month - 1, day);
  }
}
