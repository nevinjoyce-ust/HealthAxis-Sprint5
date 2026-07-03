import { Component, OnInit, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';

import { DoctorService } from '../../core/services/doctor-service';
import { Appointment, AppointmentStatus, HealthRecord } from '../../shared/models/health-axis.models';

type DoctorAppointmentTimeFilter = 'all' | 'future' | 'past' | 'dateRange';

@Component({
  selector: 'app-appointments',
  imports: [FormsModule, RouterLink],
  templateUrl: './appointments.html',
  styleUrl: './appointments.css'
})
export class Appointments implements OnInit {
  private readonly doctorService = inject(DoctorService);
  private readonly route = inject(ActivatedRoute);
  private readonly router = inject(Router);

  readonly pageSize = 10;

  private hasSetInitialFilterVisibility = false;
  private isApplyingQueryParams = false;

  readonly appointments = signal<Appointment[]>([]);
  readonly healthRecords = signal<HealthRecord[]>([]);

  readonly isAppointmentsLoading = signal(false);
  readonly isHealthRecordsLoading = signal(false);
  readonly isCreatingHealthRecord = signal(false);

  readonly appointmentsErrorMessage = signal('');
  readonly healthRecordsErrorMessage = signal('');
  readonly cancellationErrorMessage = signal('');
  readonly completionErrorMessage = signal('');

  showFilters = false;
  searchText = '';
  timeFilter: DoctorAppointmentTimeFilter = 'all';
  selectedStatuses: AppointmentStatus[] = [];
  fromDate = '';
  toDate = '';
  currentPage = 1;

  selectedCancelAppointment: Appointment | null = null;
  selectedCompleteAppointment: Appointment | null = null;
  selectedHealthRecord: HealthRecord | null = null;
  selectedCancellationReason: Appointment | null = null;

  cancellationReason = '';
  diagnosis = '';
  prescription = '';
  notes = '';

  statusOptions: AppointmentStatus[] = ['Pending', 'Confirmed', 'Completed', 'Cancelled'];

  timeOptions: { label: string; value: DoctorAppointmentTimeFilter }[] = [
    { label: 'All', value: 'all' },
    { label: 'Upcoming', value: 'future' },
    { label: 'Past', value: 'past' },
    { label: 'Custom', value: 'dateRange' }
  ];

  constructor() {
    this.route.queryParamMap.subscribe(params => {
      this.isApplyingQueryParams = true;

      if (!this.hasSetInitialFilterVisibility) {
        this.showFilters = params.keys.length > 0;
        this.hasSetInitialFilterVisibility = true;
      }

      const time = params.get('time');
      const status = params.get('status');
      const fromDate = params.get('fromDate');
      const toDate = params.get('toDate');

      this.searchText = params.get('search') ?? '';
      this.timeFilter = this.resolveTimeFilter(time, fromDate, toDate);
      this.selectedStatuses = this.parseStatuses(status);
      this.fromDate = fromDate ?? '';
      this.toDate = toDate ?? '';
      this.removeStatusesUnavailableForCurrentTimeFilter();
      this.currentPage = 1;

      this.isApplyingQueryParams = false;
    });
  }

  ngOnInit(): void {
    this.loadAppointments();
    this.loadHealthRecords();
  }

  get today(): string {
    return this.formatDateOnly(new Date());
  }

  get isAnyLoading(): boolean {
    return this.isAppointmentsLoading() || this.isHealthRecordsLoading();
  }

  get filteredAppointments(): Appointment[] {
    return this.appointments()
      .filter(appointment => this.matchesTimeFilter(appointment))
      .filter(appointment => this.matchesStatusFilter(appointment))
      .filter(appointment => this.matchesSearchText(appointment))
      .sort((first, second) => this.compareAppointmentsForCurrentTimeFilter(first, second));
  }

  get pagedAppointments(): Appointment[] {
    const start = (this.currentPage - 1) * this.pageSize;
    return this.filteredAppointments.slice(start, start + this.pageSize);
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

    this.doctorService.getCurrentDoctorAppointments()
      .subscribe({
        next: appointments => {
          this.appointments.set(appointments);
          this.currentPage = 1;
          this.isAppointmentsLoading.set(false);
        },
        error: error => {
          console.error('Failed to load doctor appointments.', error);
          this.appointmentsErrorMessage.set(error?.error?.message ?? 'Unable to load appointments.');
          this.isAppointmentsLoading.set(false);
        }
      });
  }

  loadHealthRecords(): void {
    this.isHealthRecordsLoading.set(true);
    this.healthRecordsErrorMessage.set('');

    this.doctorService.getCurrentDoctorHealthRecords()
      .subscribe({
        next: records => {
          this.healthRecords.set(records);
          this.isHealthRecordsLoading.set(false);
        },
        error: error => {
          console.error('Failed to load doctor health records.', error);
          this.healthRecordsErrorMessage.set(error?.error?.message ?? 'Unable to load health records.');
          this.isHealthRecordsLoading.set(false);
        }
      });
  }

  toggleFilters(): void {
    this.showFilters = !this.showFilters;
  }

  setTimeFilter(timeFilter: DoctorAppointmentTimeFilter): void {
    this.timeFilter = timeFilter;

    if (timeFilter !== 'dateRange') {
      this.fromDate = '';
      this.toDate = '';
    }

    this.removeStatusesUnavailableForCurrentTimeFilter();
    this.syncQueryParams();
  }

  onSearchChange(): void {
    this.syncQueryParams();
  }

  onDateRangeChange(): void {
    this.timeFilter = 'dateRange';
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

  isStatusSelected(status: AppointmentStatus): boolean {
    return this.selectedStatuses.includes(status);
  }

  isStatusDisabled(status: AppointmentStatus): boolean {
    return !this.availableStatuses().includes(status);
  }

  clearFilters(): void {
    this.searchText = '';
    this.timeFilter = 'all';
    this.selectedStatuses = [];
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

  confirmPendingAppointment(appointment: Appointment): void {
    this.doctorService.confirmAppointment(appointment.id)
      .subscribe({
        next: updatedAppointment => this.updateAppointmentInState(updatedAppointment),
        error: error => {
          console.error('Failed to confirm appointment.', error);
          this.appointmentsErrorMessage.set(error?.error?.message ?? 'Unable to confirm appointment.');
        }
      });
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

    this.doctorService.cancelAppointment(this.selectedCancelAppointment.id, this.cancellationReason.trim())
      .subscribe({
        next: updatedAppointment => {
          this.updateAppointmentInState(updatedAppointment);
          this.closeCancelAppointment();
        },
        error: error => {
          console.error('Failed to cancel appointment.', error);
          this.cancellationErrorMessage.set(error?.error?.message ?? 'Unable to cancel appointment.');
        }
      });
  }

  openCompleteConsultation(appointment: Appointment): void {
    this.selectedCompleteAppointment = appointment;
    this.diagnosis = '';
    this.prescription = '';
    this.notes = '';
    this.completionErrorMessage.set('');
  }

  closeCompleteConsultation(): void {
    this.selectedCompleteAppointment = null;
    this.diagnosis = '';
    this.prescription = '';
    this.notes = '';
    this.completionErrorMessage.set('');
    this.isCreatingHealthRecord.set(false);
  }

  submitHealthRecord(): void {
    if (!this.selectedCompleteAppointment || !this.diagnosis.trim() || !this.prescription.trim() || this.isCreatingHealthRecord()) {
      return;
    }

    const appointment = this.selectedCompleteAppointment;
    this.isCreatingHealthRecord.set(true);
    this.completionErrorMessage.set('');

    this.doctorService.createHealthRecord(
      appointment.id,
      appointment.appointmentDate,
      this.diagnosis.trim(),
      this.prescription.trim(),
      this.notes.trim() || null
    ).subscribe({
      next: record => {
        this.healthRecords.update(records => [record, ...records]);

        this.appointments.update(appointments => appointments.map(existingAppointment =>
          existingAppointment.id === appointment.id
            ? {
                ...existingAppointment,
                status: 'Completed',
                healthRecordId: record.id
              }
            : existingAppointment));

        this.isCreatingHealthRecord.set(false);
        this.closeCompleteConsultation();
      },
      error: error => {
        console.error('Failed to create health record.', error);
        this.completionErrorMessage.set(error?.error?.message ?? 'Unable to create health record.');
        this.isCreatingHealthRecord.set(false);
      }
    });
  }

  openHealthRecordDetails(appointment: Appointment): void {
    const matchedRecord = this.healthRecords().find(record => record.id === appointment.healthRecordId);

    if (matchedRecord) {
      this.selectedHealthRecord = matchedRecord;
      return;
    }

    this.healthRecordsErrorMessage.set('Unable to find the health record for this appointment.');
  }

  closeHealthRecordDetails(): void {
    this.selectedHealthRecord = null;
  }

  openCancellationReason(appointment: Appointment): void {
    this.selectedCancellationReason = appointment;
  }

  closeCancellationReason(): void {
    this.selectedCancellationReason = null;
  }

  canViewPatientHistory(appointment: Appointment): boolean {
    return appointment.status === 'Confirmed' && appointment.appointmentDate >= this.today;
  }

  canCompleteConsultation(appointment: Appointment): boolean {
    return appointment.status === 'Confirmed' && appointment.appointmentDate === this.today;
  }

  canCancelConfirmedAppointment(appointment: Appointment): boolean {
    return appointment.status === 'Confirmed' && appointment.appointmentDate > this.today && this.hoursUntilAppointment(appointment) >= 24;
  }

  isUrgentPendingAppointment(appointment: Appointment): boolean {
    return appointment.status === 'Pending' && this.hoursUntilAppointment(appointment) < 24;
  }

  getStatusClasses(status: AppointmentStatus): string {
    switch (status) {
      case 'Pending': return 'rounded-full bg-amber-100 px-3 py-1 text-xs font-bold text-amber-700';
      case 'Confirmed': return 'rounded-full bg-green-100 px-3 py-1 text-xs font-bold text-green-700';
      case 'Completed': return 'rounded-full bg-blue-100 px-3 py-1 text-xs font-bold text-blue-700';
      case 'Cancelled': return 'rounded-full bg-red-100 px-3 py-1 text-xs font-bold text-red-700';
    }
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

  private updateAppointmentInState(updatedAppointment: Appointment): void {
    this.appointments.update(appointments => appointments.map(appointment =>
      appointment.id === updatedAppointment.id ? updatedAppointment : appointment));
  }

  private syncQueryParams(): void {
    if (this.isApplyingQueryParams) {
      return;
    }

    this.currentPage = 1;

    this.router.navigate([], {
      relativeTo: this.route,
      queryParams: {
        search: this.searchText.trim() || null,
        time: this.timeFilter === 'all' ? null : this.timeFilter,
        status: this.selectedStatuses.length ? this.selectedStatuses.join(',') : null,
        fromDate: this.timeFilter === 'dateRange' && this.fromDate ? this.fromDate : null,
        toDate: this.timeFilter === 'dateRange' && this.toDate ? this.toDate : null
      }
    });
  }

  private availableStatuses(): AppointmentStatus[] {
    if (this.timeFilter === 'future') {
      return ['Pending', 'Confirmed', 'Cancelled'];
    }

    if (this.timeFilter === 'past') {
      return ['Completed', 'Cancelled'];
    }

    if (this.timeFilter === 'dateRange') {
      if (this.fromDate && !this.toDate && this.fromDate >= this.today) {
        return ['Pending', 'Confirmed', 'Cancelled'];
      }

      if (!this.fromDate && this.toDate && this.toDate < this.today) {
        return ['Completed', 'Cancelled'];
      }

      if (this.fromDate && this.toDate && this.fromDate >= this.today) {
        return ['Pending', 'Confirmed', 'Cancelled'];
      }

      if (this.fromDate && this.toDate && this.toDate < this.today) {
        return ['Completed', 'Cancelled'];
      }
    }

    return this.statusOptions;
  }

  private removeStatusesUnavailableForCurrentTimeFilter(): void {
    const statuses = this.availableStatuses();
    this.selectedStatuses = this.selectedStatuses.filter(status => statuses.includes(status));
  }

  private matchesTimeFilter(appointment: Appointment): boolean {
    if (this.timeFilter === 'future') {
      return appointment.appointmentDate >= this.today;
    }

    if (this.timeFilter === 'past') {
      return appointment.appointmentDate < this.today;
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
    const searchText = this.searchText.trim().toLowerCase();

    return searchText === '' || appointment.patientName.toLowerCase().includes(searchText);
  }

  private parseStatuses(value: string | null): AppointmentStatus[] {
    if (!value) {
      return [];
    }

    return value
      .split(',')
      .filter(status => this.isValidStatus(status));
  }

  private isValidStatus(value: string): value is AppointmentStatus {
    return this.statusOptions.includes(value as AppointmentStatus);
  }

  private resolveTimeFilter(
    time: string | null,
    fromDate: string | null,
    toDate: string | null
  ): DoctorAppointmentTimeFilter {
    if (fromDate || toDate) {
      return 'dateRange';
    }

    if (this.isValidTimeFilter(time)) {
      return time;
    }

    return 'all';
  }

  private isValidTimeFilter(value: string | null): value is DoctorAppointmentTimeFilter {
    return value === 'all' || value === 'future' || value === 'past' || value === 'dateRange';
  }

  private compareAppointmentsForCurrentTimeFilter(first: Appointment, second: Appointment): number {
    if (this.timeFilter === 'past') {
      return this.compareDateTimeDescending(first, second);
    }

    return this.compareDateTime(first, second);
  }

  private compareDateTime(first: Appointment, second: Appointment): number {
    const firstDateTime = `${first.appointmentDate}T${first.appointmentTime}`;
    const secondDateTime = `${second.appointmentDate}T${second.appointmentTime}`;

    return firstDateTime.localeCompare(secondDateTime);
  }

  private compareDateTimeDescending(first: Appointment, second: Appointment): number {
    const firstDateTime = `${first.appointmentDate}T${first.appointmentTime}`;
    const secondDateTime = `${second.appointmentDate}T${second.appointmentTime}`;

    return secondDateTime.localeCompare(firstDateTime);
  }

  private hoursUntilAppointment(appointment: Appointment): number {
    const appointmentTime = new Date(`${appointment.appointmentDate}T${appointment.appointmentTime}`).getTime();

    return (appointmentTime - Date.now()) / 36e5;
  }

  private formatDateOnly(date: Date): string {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');

    return `${year}-${month}-${day}`;
  }
}
