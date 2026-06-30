import { Component, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';

import { MockData } from '../../core/services/mock-data';
import {
  DoctorAvailableSlots,
  DoctorSpecialisation
} from '../../shared/models/health-axis.models';

interface SelectedSlot {
  doctor: DoctorAvailableSlots;
  date: string;
  time: string;
}

@Component({
  selector: 'app-book-appointment',
  imports: [FormsModule],
  templateUrl: './book-appointment.html',
  styleUrl: './book-appointment.css'
})
export class BookAppointment {
  private readonly mockData = inject(MockData);
  private readonly route = inject(ActivatedRoute);
  private readonly router = inject(Router);

  bookingDate = this.getDefaultBookingDate();
  selectedSpecialisation: DoctorSpecialisation | '' = '';
  searchText = '';

  selectedSlot: SelectedSlot | null = null;
  bookingSuccess = false;

  doctorSlots: DoctorAvailableSlots[] = this.mockData.getDoctorAvailableSlots();

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
      const date = params.get('date');
      const specialisation = params.get('specialisation');
      const search = params.get('search');

      this.bookingDate = date || this.getDefaultBookingDate();
      this.selectedSpecialisation = this.isValidSpecialisation(specialisation)
        ? specialisation
        : '';
      this.searchText = search ?? '';
    });
  }

  get filteredDoctorSlots(): DoctorAvailableSlots[] {
    return this.doctorSlots
      .filter(doctor => doctor.isAvailable)
      .filter(doctor => this.matchesSpecialisation(doctor))
      .filter(doctor => this.matchesSearchText(doctor));
  }

  get minimumDate(): string {
    return new Date().toISOString().split('T')[0];
  }

  updateQueryParams(): void {
    this.router.navigate([], {
      relativeTo: this.route,
      queryParams: {
        date: this.bookingDate || null,
        specialisation: this.selectedSpecialisation || null,
        search: this.searchText.trim() || null
      }
    });
  }

  clearFilters(): void {
    this.bookingDate = this.getDefaultBookingDate();
    this.selectedSpecialisation = '';
    this.searchText = '';

    this.router.navigate([], {
      relativeTo: this.route,
      queryParams: {}
    });
  }

  openBookingConfirmation(doctor: DoctorAvailableSlots, time: string): void {
    this.selectedSlot = {
      doctor,
      date: this.bookingDate,
      time
    };
    this.bookingSuccess = false;
  }

  closeBookingConfirmation(): void {
    this.selectedSlot = null;
  }

  confirmBooking(): void {
    if (!this.selectedSlot) {
      return;
    }

    this.bookingSuccess = true;
  }

  goToPendingAppointments(): void {
    this.router.navigate(['/patient/appointments'], {
      queryParams: {
        time: 'future',
        status: 'Pending'
      }
    });
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

  private matchesSpecialisation(doctor: DoctorAvailableSlots): boolean {
    return !this.selectedSpecialisation ||
      doctor.specialisation === this.selectedSpecialisation;
  }

 private matchesSearchText(doctor: DoctorAvailableSlots): boolean {
  const normalizedSearchText = this.searchText.trim().toLowerCase();

  if (!normalizedSearchText) {
    return true;
  }

  return doctor.doctorName.toLowerCase().includes(normalizedSearchText);
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
