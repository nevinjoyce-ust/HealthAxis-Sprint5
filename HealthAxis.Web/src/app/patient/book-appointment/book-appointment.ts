import { Component, OnInit, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';

import { PatientService } from '../../core/services/patient-service';
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
export class BookAppointment implements OnInit {
  private readonly patientService = inject(PatientService);
  private readonly route = inject(ActivatedRoute);
  private readonly router = inject(Router);

  readonly doctorSlots = signal<DoctorAvailableSlots[]>([]);
  readonly isLoadingSlots = signal(false);
  readonly slotsErrorMessage = signal('');
  readonly bookingErrorMessage = signal('');
  readonly isBooking = signal(false);

  bookingDate = this.getDefaultBookingDate();
  selectedSpecialisation: DoctorSpecialisation | '' = '';
  searchText = '';

  selectedSlot: SelectedSlot | null = null;
  bookingSuccess = false;

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

      this.loadAvailableSlots();
    });
  }

  ngOnInit(): void {
    this.loadAvailableSlots();
  }

  get filteredDoctorSlots(): DoctorAvailableSlots[] {
    return this.doctorSlots()
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

  loadAvailableSlots(): void {
    if (!this.bookingDate) {
      return;
    }

    this.isLoadingSlots.set(true);
    this.slotsErrorMessage.set('');

    this.patientService.getAvailableDoctorSlots(this.bookingDate, this.selectedSpecialisation)
      .subscribe({
        next: doctorSlots => {
          this.doctorSlots.set(doctorSlots);
          this.isLoadingSlots.set(false);
        },
        error: error => {
          console.error('Failed to load available slots.', error);
          this.slotsErrorMessage.set(error?.error?.message ?? 'Unable to load available slots.');
          this.isLoadingSlots.set(false);
        }
      });
  }

  openBookingConfirmation(doctor: DoctorAvailableSlots, time: string): void {
    this.selectedSlot = {
      doctor,
      date: this.bookingDate,
      time
    };
    this.bookingSuccess = false;
    this.bookingErrorMessage.set('');
  }

  closeBookingConfirmation(): void {
    this.selectedSlot = null;
    this.bookingErrorMessage.set('');
    this.isBooking.set(false);
  }

  confirmBooking(): void {
    if (!this.selectedSlot || this.isBooking()) {
      return;
    }

    this.isBooking.set(true);
    this.bookingErrorMessage.set('');

    this.patientService.createCurrentPatientAppointment(
      this.selectedSlot.doctor.doctorId,
      this.selectedSlot.date,
      this.selectedSlot.time
    ).subscribe({
      next: () => {
        this.bookingSuccess = true;
        this.isBooking.set(false);
        this.loadAvailableSlots();
      },
      error: error => {
        console.error('Failed to book appointment.', error);
        this.bookingErrorMessage.set(error?.error?.message ?? 'Unable to book appointment.');
        this.isBooking.set(false);
      }
    });
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
