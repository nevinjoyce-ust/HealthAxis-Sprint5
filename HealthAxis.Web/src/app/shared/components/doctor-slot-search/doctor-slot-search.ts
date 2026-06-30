import { Component, Input, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';

import { MockData } from '../../../core/services/mock-data';
import {
  DoctorAvailableSlots,
  DoctorSpecialisation
} from '../../models/health-axis.models';

type SlotSearchMode = 'public' | 'patient';

@Component({
  selector: 'app-doctor-slot-search',
  imports: [FormsModule, RouterLink],
  templateUrl: './doctor-slot-search.html',
  styleUrl: './doctor-slot-search.css'
})
export class DoctorSlotSearch {
  private readonly mockData = inject(MockData);

  @Input() mode: SlotSearchMode = 'public';

  selectedDate = this.getDefaultBookingDate();
  selectedSpecialisation: DoctorSpecialisation | '' = '';

  hasSearched = false;
  doctors: DoctorAvailableSlots[] = [];

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

  searchSlots(): void {
    const allDoctors = this.mockData.getDoctorAvailableSlots();

    this.doctors = allDoctors.filter(doctor => {
      const matchesSpecialisation =
        !this.selectedSpecialisation ||
        doctor.specialisation === this.selectedSpecialisation;

      return matchesSpecialisation && doctor.availableSlots.length > 0;
    });

    this.hasSearched = true;
  }

  formatSpecialisation(specialisation: DoctorSpecialisation): string {
    return specialisation === 'GeneralMedicine'
      ? 'General Medicine'
      : specialisation;
  }

  formatTime(time: string): string {
    return time.slice(0, 5);
  }

  getBookingUrl(doctorId: number, time: string): string {
    return `/patient/book?doctorId=${doctorId}&date=${this.selectedDate}&time=${time}`;
  }

  getSlotRouterLink(doctorId: number, time: string): string {
    if (this.mode === 'patient') {
      return '/patient/book';
    }

    return '/login';
  }

  getSlotQueryParams(doctorId: number, time: string): Record<string, string> {
    const bookingParams = {
      doctorId: doctorId.toString(),
      date: this.selectedDate,
      time
    };

    if (this.mode === 'patient') {
      return bookingParams;
    }

    return {
      returnUrl: this.getBookingUrl(doctorId, time)
    };
  }

  private getDefaultBookingDate(): string {
    const date = new Date();
    date.setDate(date.getDate() + 3);

    return date.toISOString().split('T')[0];
  }
}
