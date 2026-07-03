import { Component, Input, OnInit, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';

import {
  DoctorSearchRequest,
  PatientService,
  PagedResult
} from '../../../core/services/patient-service';
import {
  DoctorSpecialisation,
  PublicDoctor
} from '../../models/health-axis.models';
import {
  DoctorSortOption,
  doctorSpecialisations,
  formatSpecialisation,
  toApiDoctorSortBy,
  toApiSortDirection
} from '../../utils/doctor-utils';

type SlotSearchMode = 'public' | 'patient';

@Component({
  selector: 'app-doctor-slot-search',
  imports: [FormsModule],
  templateUrl: './doctor-slot-search.html',
  styleUrl: './doctor-slot-search.css'
})
export class DoctorSlotSearch implements OnInit {
  private readonly patientService = inject(PatientService);

  @Input() mode: SlotSearchMode = 'public';

  readonly doctors = signal<PublicDoctor[]>([]);
  readonly isLoading = signal(false);
  readonly errorMessage = signal('');

  searchText = '';
  selectedSpecialisation: DoctorSpecialisation | '' = '';
  onlyShowAvailableDoctors = true;
  sortBy: DoctorSortOption = 'experience';

  pageNumber = 1;
  pageSize = 5;
  totalCount = 0;
  totalPages = 0;
  hasPreviousPage = false;
  hasNextPage = false;

  specialisations: DoctorSpecialisation[] = doctorSpecialisations;

  ngOnInit(): void {
    this.loadDoctors();
  }

  loadDoctors(): void {
    this.isLoading.set(true);
    this.errorMessage.set('');

    this.patientService.getPublicDoctorsPage(this.createSearchRequest())
      .subscribe({
        next: response => {
          this.setPagedResult(response);
          this.isLoading.set(false);
        },
        error: error => {
          console.error('Failed to load public doctors.', error);
          this.errorMessage.set(error?.error?.message ?? 'Unable to load doctors.');
          this.isLoading.set(false);
        }
      });
  }

  applyFilters(): void {
    this.pageNumber = 1;
    this.loadDoctors();
  }

  setSortBy(sortBy: DoctorSortOption): void {
    this.sortBy = sortBy;
    this.pageNumber = 1;
    this.loadDoctors();
  }

  clearFilters(): void {
    this.searchText = '';
    this.selectedSpecialisation = '';
    this.onlyShowAvailableDoctors = true;
    this.sortBy = 'experience';
    this.pageNumber = 1;
    this.loadDoctors();
  }

  goToPreviousPage(): void {
    if (!this.hasPreviousPage || this.isLoading()) {
      return;
    }

    this.pageNumber--;
    this.loadDoctors();
  }

  goToNextPage(): void {
    if (!this.hasNextPage || this.isLoading()) {
      return;
    }

    this.pageNumber++;
    this.loadDoctors();
  }

  formatSpecialisation(specialisation: DoctorSpecialisation): string {
    return formatSpecialisation(specialisation);
  }

  private createSearchRequest(): DoctorSearchRequest {
    return {
      pageNumber: this.pageNumber,
      pageSize: this.pageSize,
      search: this.searchText,
      specialisation: this.selectedSpecialisation,
      isAvailable: this.onlyShowAvailableDoctors ? true : null,
      sortBy: toApiDoctorSortBy(this.sortBy),
      sortDirection: toApiSortDirection(this.sortBy)
    };
  }

  private setPagedResult(response: PagedResult<PublicDoctor>): void {
    this.doctors.set(response.items);
    this.pageNumber = response.pageNumber;
    this.pageSize = response.pageSize;
    this.totalCount = response.totalCount;
    this.totalPages = response.totalPages;
    this.hasPreviousPage = response.hasPreviousPage;
    this.hasNextPage = response.hasNextPage;
  }
}
