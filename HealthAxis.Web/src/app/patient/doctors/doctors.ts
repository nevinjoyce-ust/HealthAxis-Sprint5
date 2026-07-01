import { Component, OnInit, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';

import { PatientService } from '../../core/services/patient-service';
import {
  DoctorSpecialisation,
  PublicDoctor
} from '../../shared/models/health-axis.models';

type DoctorSortOption = 'experience' | 'fee';

@Component({
  selector: 'app-doctors',
  imports: [FormsModule],
  templateUrl: './doctors.html',
  styleUrl: './doctors.css'
})
export class Doctors implements OnInit {
  private readonly patientService = inject(PatientService);
  private readonly route = inject(ActivatedRoute);
  private readonly router = inject(Router);

  readonly doctors = signal<PublicDoctor[]>([]);
  readonly isDoctorsLoading = signal(false);
  readonly doctorsErrorMessage = signal('');

  searchText = '';
  selectedSpecialisation: DoctorSpecialisation | '' = '';
  onlyShowAvailableDoctors = true;
  sortBy: DoctorSortOption = 'experience';

  selectedDoctorForBooking: PublicDoctor | null = null;
  bookingDate = this.getDefaultBookingDate();

  specialisationOptions: DoctorSpecialisation[] = [
    'Cardiology',
    'Dermatology',
    'Neurology',
    'Orthopaedics',
    'Pediatrics',
    'GeneralMedicine',
    'Psychiatry',
    'Radiology',
    'Gynecology',
    'ENT'
  ];

  constructor() {
    this.route.queryParamMap.subscribe(params => {
      const search = params.get('search');
      const specialisation = params.get('specialisation');
      const availability = params.get('availability');
      const sort = params.get('sort');

      this.searchText = search ?? '';
      this.selectedSpecialisation = this.isValidSpecialisation(specialisation)
        ? specialisation
        : '';
      this.onlyShowAvailableDoctors = availability !== 'all';
      this.sortBy = sort === 'fee' ? 'fee' : 'experience';
    });
  }

  ngOnInit(): void {
    this.loadDoctors();
  }

  get filteredDoctors(): PublicDoctor[] {
    return this.doctors()
      .filter(doctor => this.matchesAvailability(doctor))
      .filter(doctor => this.matchesSpecialisation(doctor))
      .filter(doctor => this.matchesSearchText(doctor))
      .sort((first, second) => this.compareDoctors(first, second));
  }

  get minimumDate(): string {
    return new Date().toISOString().split('T')[0];
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
          this.doctorsErrorMessage.set(error?.error?.message ?? 'Unable to load doctors.');
          this.isDoctorsLoading.set(false);
        }
      });
  }

  updateQueryParams(): void {
    this.router.navigate([], {
      relativeTo: this.route,
      queryParams: {
        search: this.searchText.trim() || null,
        specialisation: this.selectedSpecialisation || null,
        availability: this.onlyShowAvailableDoctors ? null : 'all',
        sort: this.sortBy !== 'experience' ? this.sortBy : null
      }
    });
  }

  setSortBy(sortBy: DoctorSortOption): void {
    this.sortBy = sortBy;
    this.updateQueryParams();
  }

  clearFilters(): void {
    this.searchText = '';
    this.selectedSpecialisation = '';
    this.onlyShowAvailableDoctors = true;
    this.sortBy = 'experience';

    this.router.navigate([], {
      relativeTo: this.route,
      queryParams: {}
    });
  }

  openBookingDatePrompt(doctor: PublicDoctor): void {
    this.selectedDoctorForBooking = doctor;
    this.bookingDate = this.getDefaultBookingDate();
  }

  closeBookingDatePrompt(): void {
    this.selectedDoctorForBooking = null;
  }

  continueToBooking(): void {
    if (!this.selectedDoctorForBooking || !this.bookingDate) {
      return;
    }

    this.router.navigate(['/patient/book'], {
      queryParams: {
        date: this.bookingDate,
        search: this.selectedDoctorForBooking.fullName,
        specialisation: this.selectedDoctorForBooking.specialisation
      }
    });
  }

  formatSpecialisation(specialisation: DoctorSpecialisation): string {
    return specialisation === 'GeneralMedicine'
      ? 'General Medicine'
      : specialisation;
  }

  private matchesAvailability(doctor: PublicDoctor): boolean {
    return !this.onlyShowAvailableDoctors || doctor.isAvailable;
  }

  private matchesSpecialisation(doctor: PublicDoctor): boolean {
    return !this.selectedSpecialisation || doctor.specialisation === this.selectedSpecialisation;
  }

  private matchesSearchText(doctor: PublicDoctor): boolean {
    const normalizedSearchText = this.searchText.trim().toLowerCase();

    if (!normalizedSearchText) {
      return true;
    }

    return doctor.fullName.toLowerCase().includes(normalizedSearchText);
  }

  private compareDoctors(first: PublicDoctor, second: PublicDoctor): number {
    if (this.sortBy === 'fee') {
      return first.consultationFee - second.consultationFee ||
        first.fullName.localeCompare(second.fullName);
    }

    return second.yearsOfExperience - first.yearsOfExperience ||
      first.fullName.localeCompare(second.fullName);
  }

  private isValidSpecialisation(value: string | null): value is DoctorSpecialisation {
    return this.specialisationOptions.includes(value as DoctorSpecialisation);
  }

  private getDefaultBookingDate(): string {
    const date = new Date();
    date.setDate(date.getDate() + 3);

    return date.toISOString().split('T')[0];
  }
}
