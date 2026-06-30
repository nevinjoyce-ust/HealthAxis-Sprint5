import { Component, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';

import { MockData } from '../../core/services/mock-data';
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
export class HealthHistory {
  private readonly mockData = inject(MockData);
  private readonly route = inject(ActivatedRoute);
  private readonly router = inject(Router);

  private returnUrl = '';

  healthRecords: HealthRecord[] = this.mockData.getPatientHealthRecords();
  doctors: PublicDoctor[] = this.mockData.getPublicDoctors();

  searchText = '';
  fromDate = '';
  toDate = '';
  showFilters = false;

  selectedHealthRecord: HealthRecord | null = null;

  constructor() {
    this.route.queryParamMap.subscribe(params => {
      const recordId = Number(params.get('recordId'));
      this.returnUrl = params.get('returnUrl') ?? '';

      if (Number.isInteger(recordId) && recordId > 0) {
        const matchedRecord = this.healthRecords.find(record => record.id === recordId);

        if (matchedRecord) {
          this.selectedHealthRecord = matchedRecord;
        }
      }
    });
  }

  get filteredHealthRecords(): HealthRecord[] {
    return this.healthRecords
      .filter(record => this.matchesSearchText(record))
      .filter(record => this.matchesDateRange(record))
      .sort((first, second) => second.visitDate.localeCompare(first.visitDate));
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
    }
  }

  clearFilters(): void {
    this.searchText = '';
    this.fromDate = '';
    this.toDate = '';
  }

  getDoctorSpecialisation(doctorId: number): string {
    const doctor = this.doctors.find(existingDoctor => existingDoctor.id === doctorId);

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
