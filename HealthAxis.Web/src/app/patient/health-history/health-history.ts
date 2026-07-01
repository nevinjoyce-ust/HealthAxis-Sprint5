import { Component, OnInit, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';

import { PatientService } from '../../core/services/patient-service';
import {
  DoctorSpecialisation,
  HealthRecord,
  PublicDoctor
} from '../../shared/models/health-axis.models';

@Component({
  selector: 'app-health-history',
  imports: [FormsModule],
  templateUrl: './health-history.html',
  styleUrl: './health-history.css'
})
export class HealthHistory implements OnInit {
  private readonly patientService = inject(PatientService);
  private readonly route = inject(ActivatedRoute);
  private readonly router = inject(Router);

  private returnUrl = '';
  private requestedRecordId: number | null = null;

  readonly healthRecords = signal<HealthRecord[]>([]);
  readonly doctors = signal<PublicDoctor[]>([]);

  readonly isHealthRecordsLoading = signal(false);
  readonly isDoctorsLoading = signal(false);
  readonly healthRecordsErrorMessage = signal('');
  readonly doctorsErrorMessage = signal('');

  searchText = '';
  fromDate = '';
  toDate = '';
  showFilters = false;

  selectedHealthRecord: HealthRecord | null = null;

  constructor() {
    this.route.queryParamMap.subscribe(params => {
      const recordId = Number(params.get('recordId'));
      this.returnUrl = params.get('returnUrl') ?? '';

      this.requestedRecordId = Number.isInteger(recordId) && recordId > 0
        ? recordId
        : null;

      this.openRequestedRecordIfAvailable();
    });
  }

  ngOnInit(): void {
    this.loadHealthRecords();
    this.loadDoctors();
  }

  get isAnyLoading(): boolean {
    return this.isHealthRecordsLoading() || this.isDoctorsLoading();
  }

  get filteredHealthRecords(): HealthRecord[] {
    return this.healthRecords()
      .filter(record => this.matchesSearchText(record))
      .filter(record => this.matchesDateRange(record))
      .sort((first, second) => second.visitDate.localeCompare(first.visitDate));
  }

  loadHealthRecords(): void {
    this.isHealthRecordsLoading.set(true);
    this.healthRecordsErrorMessage.set('');

    this.patientService.getCurrentPatientHealthRecords()
      .subscribe({
        next: healthRecords => {
          this.healthRecords.set(healthRecords);
          this.openRequestedRecordIfAvailable();
          this.isHealthRecordsLoading.set(false);
        },
        error: error => {
          console.error('Failed to load patient health records.', error);
          this.healthRecordsErrorMessage.set(error?.error?.message ?? 'Unable to load health records.');
          this.isHealthRecordsLoading.set(false);
        }
      });
  }

  loadDoctors(): void {
    this.isDoctorsLoading.set(true);
    this.doctorsErrorMessage.set('');

    this.patientService.getPublicDoctors()
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

  openHealthRecordDetails(record: HealthRecord): void {
    this.selectedHealthRecord = record;
  }

  closeHealthRecordDetails(): void {
    this.selectedHealthRecord = null;

    if (this.returnUrl) {
      this.router.navigateByUrl(this.returnUrl);
      return;
    }

    if (this.requestedRecordId) {
      this.router.navigate([], {
        relativeTo: this.route,
        queryParams: { recordId: null, returnUrl: null },
        queryParamsHandling: 'merge'
      });
    }
  }

  clearFilters(): void {
    this.searchText = '';
    this.fromDate = '';
    this.toDate = '';
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

  private openRequestedRecordIfAvailable(): void {
    if (!this.requestedRecordId) {
      return;
    }

    const matchedRecord = this.healthRecords().find(record => record.id === this.requestedRecordId);

    if (matchedRecord) {
      this.selectedHealthRecord = matchedRecord;
    }
  }

  private matchesSearchText(record: HealthRecord): boolean {
    const normalizedSearchText = this.searchText.trim().toLowerCase();

    if (!normalizedSearchText) {
      return true;
    }

    const specialisation = this.getDoctorSpecialisation(record.doctorId).toLowerCase();

    return record.doctorName.toLowerCase().includes(normalizedSearchText) ||
      specialisation.includes(normalizedSearchText);
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
}
