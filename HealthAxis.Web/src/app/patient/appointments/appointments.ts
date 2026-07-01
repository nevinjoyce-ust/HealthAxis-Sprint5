import { Component, OnInit, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';

import { PatientService } from '../../core/services/patient-service';
import {
  Appointment,
  AppointmentStatus,
  DoctorSpecialisation,
  PublicDoctor
} from '../../shared/models/health-axis.models';

type AppointmentTimeFilter = 'all' | 'future' | 'past' | 'dateRange';

@Component({
  selector: 'app-appointments',
  imports: [FormsModule, RouterLink],
  templateUrl: './appointments.html',
  styleUrl: './appointments.css'
})
export class Appointments implements OnInit {
  private readonly patientService = inject(PatientService);
  private readonly route = inject(ActivatedRoute);
  private readonly router = inject(Router);

  readonly pageSize = 10;

  private hasSetInitialFilterVisibility = false;
  private isApplyingQueryParams = false;

  readonly appointments = signal<Appointment[]>([]);
  readonly doctors = signal<PublicDoctor[]>([]);

  readonly isAppointmentsLoading = signal(false);
  readonly isDoctorsLoading = signal(false);
  readonly appointmentsErrorMessage = signal('');
  readonly doctorsErrorMessage = signal('');
  readonly cancellationErrorMessage = signal('');

  showFilters = false;

  timeFilter: AppointmentTimeFilter = 'all';
  selectedStatuses: AppointmentStatus[] = [];
  searchText = '';
  fromDate = '';
  toDate = '';
  currentPage = 1;

  selectedCancellationReason: Appointment | null = null;
  selectedCancelAppointment: Appointment | null = null;
  cancellationReason = '';

  statusOptions: AppointmentStatus[] = [
    'Pending',
    'Confirmed',
    'Cancelled',
    'Completed'
  ];

  timeOptions: { label: string; value: AppointmentTimeFilter }[] = [
    { label: 'All', value: 'all' },
    { label: 'Upcoming', value: 'future' },
    { label: 'Past', value: 'past' },
    { label: 'Custom range', value: 'dateRange' }
  ];

  constructor() {
    this.route.queryParamMap.subscribe(params => {
      this.isApplyingQueryParams = true;

      const time = params.get('time');
      const status = params.get('status');
      const search = params.get('search');
      const doctor = params.get('doctor');
      const date = params.get('date');
      const fromDate = params.get('fromDate');
      const toDate = params.get('toDate');

      if (!this.hasSetInitialFilterVisibility) {
        this.showFilters = params.keys.length > 0;
        this.hasSetInitialFilterVisibility = true;
      }

      if (fromDate || toDate || date) {
        this.timeFilter = 'dateRange';
      } else {
        this.timeFilter = this.isValidTimeFilter(time) ? time : 'all';
      }

      this.selectedStatuses = this.parseStatuses(status);
      this.searchText = search ?? doctor ?? '';
      this.fromDate = fromDate ?? date ?? '';
      this.toDate = toDate ?? date ?? '';
      this.removeStatusesUnavailableForCurrentTimeFilter();
      this.currentPage = 1;

      this.isApplyingQueryParams = false;
    });
  }

  ngOnInit(): void {
    this.loadAppointments();
    this.loadDoctors();
  }

  get isAnyLoading(): boolean {
    return this.isAppointmentsLoading() || this.isDoctorsLoading();
  }

  get filteredAppointments(): Appointment[] {
    return this.appointments()
      .filter(appointment => this.matchesTimeFilter(appointment))
      .filter(appointment => this.matchesStatusFilter(appointment))
      .filter(appointment => this.matchesSearchText(appointment))
      .sort((first, second) => this.compareAppointmentDateTime(first, second));
  }

  get pagedAppointments(): Appointment[] {
    const startIndex = (this.currentPage - 1) * this.pageSize;
    return this.filteredAppointments.slice(startIndex, startIndex + this.pageSize);
  }

  get totalPages(): number {
    return Math.max(1, Math.ceil(this.filteredAppointments.length / this.pageSize));
  }

  get hasPreviousPage(): boolean {
    return this.currentPage > 1;
  }

  get hasNextPage(): boolean {
    return this.currentPage < this.totalPages;
  }

  loadAppointments(): void {
    this.isAppointmentsLoading.set(true);
    this.appointmentsErrorMessage.set('');

    this.patientService.getCurrentPatientAppointments()
      .subscribe({
        next: appointments => {
          this.appointments.set(appointments);
          this.currentPage = 1;
          this.isAppointmentsLoading.set(false);
        },
        error: error => {
          console.error('Failed to load patient appointments.', error);
          this.appointmentsErrorMessage.set(error?.error?.message ?? 'Unable to load appointments.');
          this.isAppointmentsLoading.set(false);
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

  setTimeFilter(timeFilter: AppointmentTimeFilter): void {
    this.timeFilter = timeFilter;

    if (timeFilter !== 'dateRange') {
      this.fromDate = '';
      this.toDate = '';
    }

    this.removeStatusesUnavailableForCurrentTimeFilter();
    this.syncQueryParams();
  }

  onStatusFilterChange(status: AppointmentStatus, event: Event): void {
    const checkbox = event.target as HTMLInputElement;

    if (checkbox.checked && !this.selectedStatuses.includes(status)) {
      this.selectedStatuses = [...this.selectedStatuses, status];
    }

    if (!checkbox.checked) {
      this.selectedStatuses = this.selectedStatuses.filter(existingStatus => existingStatus !== status);
    }

    this.syncQueryParams();
  }

  onTextFilterChange(): void {
    this.syncQueryParams();
  }

  onDateRangeChange(): void {
    if (this.timeFilter !== 'dateRange') {
      this.timeFilter = 'dateRange';
    }

    this.removeStatusesUnavailableForCurrentTimeFilter();
    this.syncQueryParams();
  }

  isStatusSelected(status: AppointmentStatus): boolean {
    return this.selectedStatuses.includes(status);
  }

  isStatusDisabled(status: AppointmentStatus): boolean {
    return !this.getAvailableStatusesForCurrentTimeFilter().includes(status);
  }

  clearFilters(): void {
    this.timeFilter = 'all';
    this.selectedStatuses = [];
    this.searchText = '';
    this.fromDate = '';
    this.toDate = '';
    this.currentPage = 1;

    this.router.navigate([], {
      relativeTo: this.route,
      queryParams: {}
    });
  }

  goToPreviousPage(): void {
    if (this.hasPreviousPage) {
      this.currentPage--;
    }
  }

  goToNextPage(): void {
    if (this.hasNextPage) {
      this.currentPage++;
    }
  }

  openCancellationReason(appointment: Appointment): void {
    this.selectedCancellationReason = appointment;
  }

  closeCancellationReason(): void {
    this.selectedCancellationReason = null;
  }

  openCancelAppointment(appointment: Appointment): void {
    this.selectedCancelAppointment = appointment;
    this.cancellationReason = '';
    this.cancellationErrorMessage.set('');
  }

  closeCancelAppointment(): void {
    this.selectedCancelAppointment = null;
    this.cancellationReason = '';
    this.cancellationErrorMessage.set('');
  }

  submitCancellation(): void {
    if (!this.selectedCancelAppointment || !this.cancellationReason.trim()) {
      return;
    }

    this.cancellationErrorMessage.set('');

    this.patientService.cancelAppointment(this.selectedCancelAppointment.id, this.cancellationReason.trim())
      .subscribe({
        next: updatedAppointment => {
          this.appointments.update(appointments => appointments.map(appointment =>
            appointment.id === updatedAppointment.id ? updatedAppointment : appointment));

          this.closeCancelAppointment();
        },
        error: error => {
          console.error('Failed to cancel appointment.', error);
          this.cancellationErrorMessage.set(error?.error?.message ?? 'Unable to cancel appointment.');
        }
      });
  }

  canPatientCancel(appointment: Appointment): boolean {
    return appointment.status === 'Pending';
  }

  canViewHealthRecord(appointment: Appointment): boolean {
    return appointment.status === 'Completed' && appointment.healthRecordId != null;
  }

  getDoctorSpecialisation(doctorId: number): string {
    const doctor = this.doctors().find(existingDoctor => existingDoctor.id === doctorId);
    return doctor ? this.formatSpecialisation(doctor.specialisation) : 'Not available';
  }

  getStatusClasses(status: AppointmentStatus): string {
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
    return specialisation === 'GeneralMedicine' ? 'General Medicine' : specialisation;
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

  private syncQueryParams(): void {
    if (this.isApplyingQueryParams) {
      return;
    }

    this.currentPage = 1;

    this.router.navigate([], {
      relativeTo: this.route,
      queryParams: {
        time: this.timeFilter !== 'all' ? this.timeFilter : null,
        status: this.selectedStatuses.length > 0 ? this.selectedStatuses.join(',') : null,
        search: this.searchText.trim() || null,
        fromDate: this.timeFilter === 'dateRange' && this.fromDate ? this.fromDate : null,
        toDate: this.timeFilter === 'dateRange' && this.toDate ? this.toDate : null
      }
    });
  }

  private getAvailableStatusesForCurrentTimeFilter(): AppointmentStatus[] {
    if (this.timeFilter === 'future') {
      return ['Pending', 'Confirmed', 'Cancelled'];
    }

    if (this.timeFilter === 'past') {
      return ['Completed', 'Cancelled'];
    }

    if (this.timeFilter === 'dateRange') {
      const today = this.todayDateOnly();

      if (this.fromDate && !this.toDate && this.fromDate >= today) {
        return ['Pending', 'Confirmed', 'Cancelled'];
      }

      if (!this.fromDate && this.toDate && this.toDate < today) {
        return ['Completed', 'Cancelled'];
      }

      if (this.fromDate && this.toDate && this.fromDate >= today) {
        return ['Pending', 'Confirmed', 'Cancelled'];
      }

      if (this.fromDate && this.toDate && this.toDate < today) {
        return ['Completed', 'Cancelled'];
      }
    }

    return this.statusOptions;
  }

  private removeStatusesUnavailableForCurrentTimeFilter(): void {
    const availableStatuses = this.getAvailableStatusesForCurrentTimeFilter();
    this.selectedStatuses = this.selectedStatuses.filter(status => availableStatuses.includes(status));
  }

  private parseStatuses(value: string | null): AppointmentStatus[] {
    if (!value) {
      return [];
    }

    return value
      .split(',')
      .filter(status => this.isValidStatus(status)) as AppointmentStatus[];
  }

  private matchesTimeFilter(appointment: Appointment): boolean {
    const today = this.todayDateOnly();

    if (this.timeFilter === 'future') {
      return appointment.appointmentDate >= today;
    }

    if (this.timeFilter === 'past') {
      return appointment.appointmentDate < today;
    }

    if (this.timeFilter === 'dateRange') {
      if (this.fromDate && appointment.appointmentDate < this.fromDate) {
        return false;
      }

      if (this.toDate && appointment.appointmentDate > this.toDate) {
        return false;
      }
    }

    return true;
  }

  private matchesStatusFilter(appointment: Appointment): boolean {
    return this.selectedStatuses.length === 0 || this.selectedStatuses.includes(appointment.status);
  }

  private matchesSearchText(appointment: Appointment): boolean {
    const normalizedSearchText = this.searchText.trim().toLowerCase();

    if (!normalizedSearchText) {
      return true;
    }

    const doctorSpecialisation = this.getDoctorSpecialisation(appointment.doctorId).toLowerCase();

    return appointment.doctorName.toLowerCase().includes(normalizedSearchText) ||
      doctorSpecialisation.includes(normalizedSearchText);
  }

  private compareAppointmentDateTime(first: Appointment, second: Appointment): number {
    const firstDateTime = `${first.appointmentDate}T${first.appointmentTime}`;
    const secondDateTime = `${second.appointmentDate}T${second.appointmentTime}`;

    if (this.timeFilter === 'past') {
      return secondDateTime.localeCompare(firstDateTime);
    }

    return firstDateTime.localeCompare(secondDateTime);
  }

  private todayDateOnly(): string {
    return new Date().toISOString().split('T')[0];
  }

  private isValidTimeFilter(value: string | null): value is AppointmentTimeFilter {
    return value === 'all' || value === 'future' || value === 'past' || value === 'dateRange';
  }

  private isValidStatus(value: string | null): value is AppointmentStatus {
    return this.statusOptions.includes(value as AppointmentStatus);
  }
}
