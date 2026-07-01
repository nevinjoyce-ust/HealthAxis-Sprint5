import { Component, OnInit, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';

import { DoctorService } from '../../core/services/doctor-service';
import { Appointment, HealthRecord } from '../../shared/models/health-axis.models';

type HealthRecordTab = 'created' | 'accessible';

interface AccessiblePatientHistory {
  patientId: number;
  patientName: string;
  appointmentId: number;
  appointmentDate: string;
  appointmentTime: string;
}

@Component({
  selector: 'app-health-records',
  imports: [FormsModule, RouterLink],
  templateUrl: './health-records.html',
  styleUrl: './health-records.css'
})
export class HealthRecords implements OnInit {
  private readonly doctorService = inject(DoctorService);
  private readonly route = inject(ActivatedRoute);
  private readonly router = inject(Router);

  readonly appointments = signal<Appointment[]>([]);
  readonly healthRecords = signal<HealthRecord[]>([]);

  readonly isAppointmentsLoading = signal(false);
  readonly isHealthRecordsLoading = signal(false);

  readonly appointmentsErrorMessage = signal('');
  readonly healthRecordsErrorMessage = signal('');

  activeTab: HealthRecordTab = 'created';
  showFilters = false;

  searchText = '';
  fromDate = '';
  toDate = '';

  selectedHealthRecord: HealthRecord | null = null;

  constructor() {
    this.route.queryParamMap.subscribe(params => {
      const tab = params.get('tab');
      this.activeTab = tab === 'accessible' ? 'accessible' : 'created';
    });
  }

  ngOnInit(): void {
    this.loadHealthRecords();
    this.loadAppointments();
  }

  get isAnyLoading(): boolean {
    return this.isHealthRecordsLoading() || this.isAppointmentsLoading();
  }

  get doctorCreatedHealthRecords(): HealthRecord[] {
    return this.healthRecords()
      .filter(record => this.matchesCreatedRecordSearch(record))
      .filter(record => this.matchesDateRange(record))
      .sort((first, second) => second.visitDate.localeCompare(first.visitDate));
  }

  get accessiblePatientHistories(): AccessiblePatientHistory[] {
    const confirmedAppointments = this.appointments()
      .filter(appointment => appointment.status === 'Confirmed' && appointment.appointmentDate >= this.today)
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

    return Array.from(patientMap.values())
      .filter(patient => this.matchesAccessiblePatientSearch(patient));
  }

  get today(): string {
    return this.formatDateOnly(new Date());
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

  setActiveTab(tab: HealthRecordTab): void {
    this.activeTab = tab;
    this.clearFilters();

    this.router.navigate([], {
      relativeTo: this.route,
      queryParams: { tab: tab === 'created' ? null : tab },
      queryParamsHandling: 'merge'
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

  private matchesCreatedRecordSearch(record: HealthRecord): boolean {
    const normalizedSearchText = this.searchText.trim().toLowerCase();

    if (!normalizedSearchText) {
      return true;
    }

    return record.patientName.toLowerCase().includes(normalizedSearchText) ||
      record.diagnosis.toLowerCase().includes(normalizedSearchText);
  }

  private matchesAccessiblePatientSearch(patient: AccessiblePatientHistory): boolean {
    const normalizedSearchText = this.searchText.trim().toLowerCase();

    if (!normalizedSearchText) {
      return true;
    }

    return patient.patientName.toLowerCase().includes(normalizedSearchText);
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
