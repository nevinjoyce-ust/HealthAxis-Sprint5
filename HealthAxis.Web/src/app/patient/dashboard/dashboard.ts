import { Component, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';

import { MockData } from '../../core/services/mock-data';
import {
  Appointment,
  DoctorSpecialisation,
  HealthRecord,
  PublicDoctor
} from '../../shared/models/health-axis.models';

@Component({
  selector: 'app-patient-dashboard',
  imports: [FormsModule, RouterLink],
  templateUrl: './dashboard.html',
  styleUrl: './dashboard.css'
})
export class PatientDashboard {
  private readonly mockData = inject(MockData);

  bookingDate = this.getDefaultBookingDate();
  bookingSpecialisation = '';

  doctorSearchText = '';
  doctorSearchSpecialisation = '';

  doctors: PublicDoctor[] = this.mockData.getPublicDoctors();
  futureAppointments: Appointment[] = this.mockData.getFuturePatientAppointments();
  pastAppointments: Appointment[] = this.mockData.getPastPatientAppointments();
  healthRecords: HealthRecord[] = this.mockData.getPatientHealthRecords();

  selectedHealthRecord: HealthRecord | null = null;
  selectedCancelledAppointment: Appointment | null = null;
  selectedCancelAppointment: Appointment | null = null;
  cancellationReason = '';

  todayAppointments = this.futureAppointments.filter(
    appointment =>
      appointment.appointmentDate === this.today &&
      appointment.status !== 'Cancelled'
  );

  confirmedUpcomingAppointments = this.futureAppointments.filter(
    appointment =>
      appointment.status === 'Confirmed' &&
      appointment.appointmentDate > this.today
  );

  pendingUpcomingAppointments = this.futureAppointments.filter(
    appointment =>
      appointment.status === 'Pending' &&
      appointment.appointmentDate > this.today
  );

  pendingUpcomingPreview = this.pendingUpcomingAppointments.slice(0, 5);

  futureCancelledAppointments = this.futureAppointments.filter(
    appointment => appointment.status === 'Cancelled'
  );

  healthRecordPreview = this.healthRecords.slice(0, 4);

  pastCancelledPreview = this.pastAppointments
    .filter(appointment => appointment.status === 'Cancelled')
    .slice(0, 4);

  get today(): string {
    return new Date().toISOString().split('T')[0];
  }

  get hasNonCancelledUpcomingAppointments(): boolean {
    return this.todayAppointments.length > 0 ||
      this.confirmedUpcomingAppointments.length > 0 ||
      this.pendingUpcomingAppointments.length > 0;
  }

  openHealthRecordDetails(record: HealthRecord): void {
    this.selectedHealthRecord = record;
  }

  closeHealthRecordDetails(): void {
    this.selectedHealthRecord = null;
  }

  openCancellationReason(appointment: Appointment): void {
    this.selectedCancelledAppointment = appointment;
  }

  closeCancellationReason(): void {
    this.selectedCancelledAppointment = null;
  }

  openCancelAppointment(appointment: Appointment): void {
    this.selectedCancelAppointment = appointment;
    this.cancellationReason = '';
  }

  closeCancelAppointment(): void {
    this.selectedCancelAppointment = null;
    this.cancellationReason = '';
  }

  submitCancellation(): void {
    if (!this.selectedCancelAppointment || !this.cancellationReason.trim()) {
      return;
    }

    this.futureAppointments = this.futureAppointments.map(appointment => {
      if (appointment.id !== this.selectedCancelAppointment?.id) {
        return appointment;
      }

      return {
        ...appointment,
        status: 'Cancelled',
        cancellationReason: `${this.cancellationReason.trim()} - Cancelled by patient`
      };
    });

    this.recalculateAppointmentPreviews();
    this.closeCancelAppointment();
  }

  getDoctorSpecialisation(doctorId: number): string {
    const doctor = this.doctors.find(existingDoctor => existingDoctor.id === doctorId);

    return doctor
      ? this.formatSpecialisation(doctor.specialisation)
      : 'Not available';
  }

  getAppointmentStatusClasses(status: Appointment['status']): string {
    switch (status) {
      case 'Pending':
        return 'rounded-full bg-amber-100 px-3 py-1 text-xs font-bold text-amber-700';
      case 'Confirmed':
        return 'rounded-full bg-green-100 px-3 py-1 text-xs font-bold text-green-700';
      case 'Cancelled':
        return 'rounded-full bg-red-100 px-3 py-1 text-xs font-bold text-red-700';
      case 'Completed':
        return 'rounded-full bg-blue-100 px-3 py-1 text-xs font-bold text-blue-700';
    }
  }

  formatSpecialisation(specialisation: DoctorSpecialisation): string {
    return specialisation === 'GeneralMedicine'
      ? 'General Medicine'
      : specialisation;
  }

  formatTime(time: string): string {
    return time.slice(0, 5);
  }

  formatDate(date: string): string {
    return new Date(`${date}T00:00:00`).toLocaleDateString('en-IN', {
      day: '2-digit',
      month: 'short',
      year: 'numeric'
    });
  }

  private recalculateAppointmentPreviews(): void {
    this.todayAppointments = this.futureAppointments.filter(
      appointment =>
        appointment.appointmentDate === this.today &&
        appointment.status !== 'Cancelled'
    );

    this.confirmedUpcomingAppointments = this.futureAppointments.filter(
      appointment =>
        appointment.status === 'Confirmed' &&
        appointment.appointmentDate > this.today
    );

    this.pendingUpcomingAppointments = this.futureAppointments.filter(
      appointment =>
        appointment.status === 'Pending' &&
        appointment.appointmentDate > this.today
    );

    this.pendingUpcomingPreview = this.pendingUpcomingAppointments.slice(0, 5);

    this.futureCancelledAppointments = this.futureAppointments.filter(
      appointment => appointment.status === 'Cancelled'
    );
  }

  private getDefaultBookingDate(): string {
    const date = new Date();
    date.setDate(date.getDate() + 3);

    return date.toISOString().split('T')[0];
  }
}
