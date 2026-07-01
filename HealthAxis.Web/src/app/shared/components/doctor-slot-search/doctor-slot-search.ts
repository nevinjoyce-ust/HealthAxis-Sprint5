import { Component, Input, OnInit, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpClient, HttpParams } from '@angular/common/http';
import { map } from 'rxjs';

import { API_BASE_URL } from '../../../core/constants/api-constants';
import {
  DoctorSpecialisation,
  PublicDoctor
} from '../../models/health-axis.models';

type SlotSearchMode = 'public' | 'patient';
type DoctorSortOption = 'experience' | 'fee';

interface PagedResult<T> {
  items: T[];
  pageNumber: number;
  pageSize: number;
  totalCount: number;
  totalPages: number;
  hasPreviousPage: boolean;
  hasNextPage: boolean;
}

@Component({
  selector: 'app-doctor-slot-search',
  imports: [FormsModule],
  templateUrl: './doctor-slot-search.html',
  styleUrl: './doctor-slot-search.css'
})
export class DoctorSlotSearch implements OnInit {
  private readonly http = inject(HttpClient);

  @Input() mode: SlotSearchMode = 'public';

  readonly doctors = signal<PublicDoctor[]>([]);
  readonly isLoading = signal(false);
  readonly errorMessage = signal('');

  searchText = '';
  selectedSpecialisation: DoctorSpecialisation | '' = '';
  onlyShowAvailableDoctors = true;
  sortBy: DoctorSortOption = 'experience';

  specialisations: DoctorSpecialisation[] = [
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

  loadDoctors(): void {
    this.isLoading.set(true);
    this.errorMessage.set('');

    const params = new HttpParams()
      .set('pageNumber', '1')
      .set('pageSize', '100');

    this.http.get<PagedResult<PublicDoctor> | PublicDoctor[] | null>(`${API_BASE_URL}/doctors`, { params })
      .pipe(
        map(response => this.getItemsFromPagedResult(response)
          .map(doctor => this.normalizeDoctor(doctor)))
      )
      .subscribe({
        next: doctors => {
          this.doctors.set(doctors);
          this.isLoading.set(false);
        },
        error: error => {
          console.error('Failed to load public doctors.', error);
          this.errorMessage.set(error?.error?.message ?? 'Unable to load doctors.');
          this.isLoading.set(false);
        }
      });
  }

  setSortBy(sortBy: DoctorSortOption): void {
    this.sortBy = sortBy;
  }

  clearFilters(): void {
    this.searchText = '';
    this.selectedSpecialisation = '';
    this.onlyShowAvailableDoctors = true;
    this.sortBy = 'experience';
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

  private getItemsFromPagedResult<T>(response: PagedResult<T> | T[] | null): T[] {
    if (!response) {
      return [];
    }

    if (Array.isArray(response)) {
      return response;
    }

    return response.items ?? [];
  }

  private normalizeDoctor(doctor: PublicDoctor): PublicDoctor {
    return {
      ...doctor,
      specialisation: this.normalizeSpecialisation(doctor.specialisation)
    };
  }

  private normalizeSpecialisation(value: DoctorSpecialisation | number): DoctorSpecialisation {
    if (typeof value === 'string') {
      return value;
    }

    const specialisations: DoctorSpecialisation[] = [
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

    return specialisations[value] ?? 'GeneralMedicine';
  }
}
