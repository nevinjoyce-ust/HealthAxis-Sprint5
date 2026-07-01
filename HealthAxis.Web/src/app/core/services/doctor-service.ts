import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable, inject } from '@angular/core';
import { Observable, map } from 'rxjs';

import { API_BASE_URL } from '../constants/api-constants';
import {
  Appointment,
  AppointmentStatus,
  DoctorSpecialisation,
  HealthRecord,
  PublicDoctor
} from '../../shared/models/health-axis.models';

interface PagedResult<T> {
  items: T[];
  pageNumber: number;
  pageSize: number;
  totalCount: number;
  totalPages: number;
  hasPreviousPage: boolean;
  hasNextPage: boolean;
}

interface UpdateDoctorAvailabilityRequest {
  isAvailable: boolean;
}

interface UpdateAppointmentStatusRequest {
  status: number;
  cancellationReason?: string | null;
}

interface CreateHealthRecordRequest {
  appointmentId: number;
  visitDate: string;
  diagnosis: string;
  prescription: string;
  notes?: string | null;
}

export interface ChangePasswordRequest {
  currentPassword: string;
  newPassword: string;
}

export interface DoctorProfileDto extends PublicDoctor {
  userId: string;
  email: string;
  phoneNumber: string;
  practiceStartDate: string;
}

export interface DoctorAvailabilityDto {
  doctorId: number;
  isAvailable: boolean;
  message: string;
}

@Injectable({
  providedIn: 'root'
})
export class DoctorService {
  private readonly http = inject(HttpClient);

  private readonly apiBaseUrl = API_BASE_URL;

  getCurrentDoctor(): Observable<DoctorProfileDto> {
    return this.http.get<DoctorProfileDto>(`${this.apiBaseUrl}/doctors/me`)
      .pipe(
        map(doctor => this.normalizeDoctorProfile(doctor))
      );
  }

  updateCurrentDoctorAvailability(isAvailable: boolean): Observable<DoctorAvailabilityDto> {
    const request: UpdateDoctorAvailabilityRequest = { isAvailable };

    return this.http.put<DoctorAvailabilityDto>(`${this.apiBaseUrl}/doctors/me/availability`, request);
  }

  changePassword(request: ChangePasswordRequest): Observable<{ message: string }> {
    return this.http.put<{ message: string }>(`${this.apiBaseUrl}/auth/change-password`, request);
  }

  getCurrentDoctorAppointments(pageSize = 100): Observable<Appointment[]> {
    const params = this.createPaginationParams(pageSize);

    return this.http.get<PagedResult<Appointment> | Appointment[] | null>(
      `${this.apiBaseUrl}/appointments/me`,
      { params }
    ).pipe(
      map(response => this.getItemsFromPagedResult(response)
        .map(appointment => this.normalizeAppointment(appointment)))
    );
  }

  getCurrentDoctorHealthRecords(pageSize = 100): Observable<HealthRecord[]> {
    const params = this.createPaginationParams(pageSize);

    return this.http.get<PagedResult<HealthRecord> | HealthRecord[] | null>(
      `${this.apiBaseUrl}/health-records/me`,
      { params }
    ).pipe(
      map(response => this.getItemsFromPagedResult(response)
        .map(record => this.normalizeHealthRecord(record)))
    );
  }

  getPatientHealthRecords(patientId: number, pageSize = 100): Observable<HealthRecord[]> {
    const params = this.createPaginationParams(pageSize);

    return this.http.get<PagedResult<HealthRecord> | HealthRecord[] | null>(
      `${this.apiBaseUrl}/health-records/patient/${patientId}`,
      { params }
    ).pipe(
      map(response => this.getItemsFromPagedResult(response)
        .map(record => this.normalizeHealthRecord(record)))
    );
  }

  getPublicDoctors(pageSize = 100): Observable<PublicDoctor[]> {
    const params = this.createPaginationParams(pageSize);

    return this.http.get<PagedResult<PublicDoctor> | PublicDoctor[] | null>(
      `${this.apiBaseUrl}/doctors`,
      { params }
    ).pipe(
      map(response => this.getItemsFromPagedResult(response)
        .map(doctor => this.normalizeDoctor(doctor)))
    );
  }

  confirmAppointment(appointmentId: number): Observable<Appointment> {
    return this.updateAppointmentStatus(appointmentId, 'Confirmed');
  }

  cancelAppointment(appointmentId: number, cancellationReason: string): Observable<Appointment> {
    return this.updateAppointmentStatus(appointmentId, 'Cancelled', cancellationReason);
  }

  completeAppointment(appointmentId: number): Observable<Appointment> {
    return this.updateAppointmentStatus(appointmentId, 'Completed');
  }

  createHealthRecord(
    appointmentId: number,
    visitDate: string,
    diagnosis: string,
    prescription: string,
    notes?: string | null
  ): Observable<HealthRecord> {
    const request: CreateHealthRecordRequest = {
      appointmentId,
      visitDate,
      diagnosis,
      prescription,
      notes: notes?.trim() || null
    };

    return this.http.post<HealthRecord>(`${this.apiBaseUrl}/health-records`, request)
      .pipe(
        map(record => this.normalizeHealthRecord(record))
      );
  }

  private updateAppointmentStatus(
    appointmentId: number,
    status: AppointmentStatus,
    cancellationReason?: string | null
  ): Observable<Appointment> {
    const request: UpdateAppointmentStatusRequest = {
      status: this.toAppointmentStatusNumber(status),
      cancellationReason
    };

    return this.http.put<Appointment>(`${this.apiBaseUrl}/appointments/${appointmentId}/status`, request)
      .pipe(
        map(appointment => this.normalizeAppointment(appointment))
      );
  }

  private createPaginationParams(pageSize: number): HttpParams {
    return new HttpParams()
      .set('pageNumber', '1')
      .set('pageSize', String(pageSize));
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

  private normalizeDoctorProfile(doctor: DoctorProfileDto): DoctorProfileDto {
    return {
      ...doctor,
      specialisation: this.normalizeSpecialisation(doctor.specialisation)
    };
  }

  private normalizeDoctor(doctor: PublicDoctor): PublicDoctor {
    return {
      ...doctor,
      specialisation: this.normalizeSpecialisation(doctor.specialisation)
    };
  }

  private normalizeAppointment(appointment: Appointment): Appointment {
    return {
      ...appointment,
      status: this.normalizeAppointmentStatus(appointment.status)
    };
  }

  private normalizeHealthRecord(record: HealthRecord): HealthRecord {
    return record;
  }

  private normalizeAppointmentStatus(value: AppointmentStatus | number): AppointmentStatus {
    if (typeof value === 'string') {
      return value;
    }

    const statuses: AppointmentStatus[] = [
      'Pending',
      'Confirmed',
      'Cancelled',
      'Completed'
    ];

    return statuses[value] ?? 'Pending';
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

  private toAppointmentStatusNumber(status: AppointmentStatus): number {
    const statuses: AppointmentStatus[] = [
      'Pending',
      'Confirmed',
      'Cancelled',
      'Completed'
    ];

    return statuses.indexOf(status);
  }
}
