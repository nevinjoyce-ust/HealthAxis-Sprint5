import { Component, OnInit, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';

import {
  DoctorSearchRequest,
  PatientService,
  PagedResult
} from '../../core/services/patient-service';
import {
  DoctorSpecialisation,
  PublicDoctor
} from '../../shared/models/health-axis.models';
import {
  DoctorSortOption,
  doctorSpecialisations,
  formatSpecialisation,
  isValidDoctorSort,
  isValidSpecialisation,
  toApiDoctorSortBy,
  toApiSortDirection
} from '../../shared/utils/doctor-utils';
import {
  addDaysDateOnly,
  addMonthsDateOnly,
  todayDateOnly
} from '../../shared/utils/date-utils';

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

  pageNumber = 1;
  pageSize = 5;
  totalCount = 0;
  totalPages = 0;
  hasPreviousPage = false;
  hasNextPage = false;

  searchText = '';
  selectedSpecialisation: DoctorSpecialisation | '' = '';
  onlyShowAvailableDoctors = true;
  sortBy: DoctorSortOption = 'experience';

  selectedDoctorForBooking: PublicDoctor | null = null;
  bookingDate = addDaysDateOnly(3);

  specialisationOptions: DoctorSpecialisation[] = doctorSpecialisations;

  ngOnInit(): void {
    this.route.queryParamMap.subscribe(params => {
      const search = params.get('search');
      const specialisation = params.get('specialisation');
      const availability = params.get('availability');
      const sort = params.get('sort');
      const page = Number(params.get('page') ?? 1);

      this.searchText = search ?? '';
      this.selectedSpecialisation = isValidSpecialisation(specialisation)
        ? specialisation
        : '';
      this.onlyShowAvailableDoctors = availability !== 'all';
      this.sortBy = isValidDoctorSort(sort) ? sort : 'experience';
      this.pageNumber = Number.isNaN(page) || page < 1 ? 1 : page;

      this.loadDoctors();
    });
  }

  get minimumDate(): string {
    return todayDateOnly();
  }

  get maximumDate(): string {
    return addMonthsDateOnly(6);
  }

  get isBookingDateValid(): boolean {
    return !!this.bookingDate &&
      this.bookingDate >= this.minimumDate &&
      this.bookingDate <= this.maximumDate;
  }

  loadDoctors(): void {
    this.isDoctorsLoading.set(true);
    this.doctorsErrorMessage.set('');

    this.patientService.getPublicDoctorsPage(this.createSearchRequest())
      .subscribe({
        next: response => {
          this.setPagedResult(response);
          this.isDoctorsLoading.set(false);
        },
        error: error => {
          console.error('Failed to load doctors.', error);
          this.doctorsErrorMessage.set(error?.error?.message ?? 'Unable to load doctors.');
          this.isDoctorsLoading.set(false);
        }
      });
  }

  updateQueryParams(resetPage = true): void {
    this.router.navigate([], {
      relativeTo: this.route,
      queryParams: {
        search: this.searchText.trim() || null,
        specialisation: this.selectedSpecialisation || null,
        availability: this.onlyShowAvailableDoctors ? null : 'all',
        sort: this.sortBy === 'experience' ? null : this.sortBy,
        page: resetPage ? null : this.pageNumber
      }
    });
  }

  applyFilters(): void {
    this.pageNumber = 1;
    this.updateQueryParams();
  }

  setSortBy(sortBy: DoctorSortOption): void {
    this.sortBy = sortBy;
    this.pageNumber = 1;
    this.updateQueryParams();
  }

  clearFilters(): void {
    this.searchText = '';
    this.selectedSpecialisation = '';
    this.onlyShowAvailableDoctors = true;
    this.sortBy = 'experience';
    this.pageNumber = 1;

    this.router.navigate([], {
      relativeTo: this.route,
      queryParams: {}
    });
  }

  goToPreviousPage(): void {
    if (!this.hasPreviousPage || this.isDoctorsLoading()) {
      return;
    }

    this.pageNumber--;
    this.updateQueryParams(false);
  }

  goToNextPage(): void {
    if (!this.hasNextPage || this.isDoctorsLoading()) {
      return;
    }

    this.pageNumber++;
    this.updateQueryParams(false);
  }

  openBookingDatePrompt(doctor: PublicDoctor): void {
    this.selectedDoctorForBooking = doctor;
    this.bookingDate = addDaysDateOnly(3);
  }

  closeBookingDatePrompt(): void {
    this.selectedDoctorForBooking = null;
  }

  continueToBooking(): void {
    if (!this.selectedDoctorForBooking || !this.bookingDate) {
      return;
    }

    if (!this.isBookingDateValid) {
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
