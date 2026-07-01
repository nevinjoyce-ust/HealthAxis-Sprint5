import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable, inject } from '@angular/core';
import { Observable, map } from 'rxjs';

import { API_BASE_URL } from '../constants/api-constants';
import { AuthService } from './auth-service';
import {
  Appointment,
  AppointmentStatus,
  DoctorAvailableSlots,
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

export interface PatientDto {
  id: number;
  userId: string;
  fullName: string;
  email: string;
  dateOfBirth: string;
  gender: string;
  phoneNumber: string;
  address: string;
}

export interface UpdatePatientRequest {
  fullName: string;
  dateOfBirth: string;
  gender: string;
  phoneNumber: string;
  address: string;
}

export interface ChangePasswordRequest {
  currentPassword: string;
  newPassword: string;
}

interface UpdateAppointmentStatusRequest {
  status: number;
  cancellationReason?: string | null;
}

interface CreateAppointmentRequest {
  patientId: number;
  doctorId: number;
  appointmentDate: string;
  appointmentTime: string;
}

@Injectable({
  providedIn: 'root'
})
export class PatientService {
  private readonly http = inject(HttpClient);
  private readonly authService = inject(AuthService);

  private readonly apiBaseUrl = API_BASE_URL;

  getCurrentPatient(): Observable<PatientDto> {
    return this.http.get<PatientDto>(`${this.apiBaseUrl}/patients/me`);
  }

  updateCurrentPatient(request: UpdatePatientRequest): Observable<PatientDto> {
    return this.http.put<PatientDto>(`${this.apiBaseUrl}/patients/me`, request);
  }

  changePassword(request: ChangePasswordRequest): Observable<{ message: string }> {
    return this.http.put<{ message: string }>(`${this.apiBaseUrl}/auth/change-password`, request);
  }

  getCurrentPatientAppointments(pageSize = 100): Observable<Appointment[]> {
    const params = this.createPaginationParams(pageSize);

    return this.http.get<PagedResult<Appointment> | Appointment[] | null>(
      `${this.apiBaseUrl}/appointments/me`,
      { params }
    ).pipe(
      map(response => this.getItemsFromPagedResult(response)
        .map(appointment => this.normalizeAppointment(appointment)))
    );
  }

  getCurrentPatientHealthRecords(pageSize = 100): Observable<HealthRecord[]> {
    const params = this.createPaginationParams(pageSize);

    return this.http.get<PagedResult<HealthRecord> | HealthRecord[] | null>(
      `${this.apiBaseUrl}/health-records/me`,
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

  getAvailableDoctorSlots(
    date: string,
    specialisation: DoctorSpecialisation | '' = '',
    pageSize = 100
  ): Observable<DoctorAvailableSlots[]> {
    let params = this.createPaginationParams(pageSize)
      .set('date', date);

    if (specialisation) {
      params = params.set('specialisation', specialisation);
    }

    return this.http.get<PagedResult<DoctorAvailableSlots> | DoctorAvailableSlots[] | null>(
      `${this.apiBaseUrl}/doctors/available-slots`,
      { params }
    ).pipe(
      map(response => this.getItemsFromPagedResult(response)
        .map(doctor => this.normalizeDoctorAvailableSlots(doctor)))
    );
  }

  createCurrentPatientAppointment(
    doctorId: number,
    appointmentDate: string,
    appointmentTime: string
  ): Observable<Appointment> {
    const request: CreateAppointmentRequest = {
      patientId: this.getRequiredPatientId(),
      doctorId,
      appointmentDate,
      appointmentTime
    };

    return this.http.post<Appointment>(`${this.apiBaseUrl}/appointments`, request)
      .pipe(
        map(appointment => this.normalizeAppointment(appointment))
      );
  }

  cancelAppointment(appointmentId: number, cancellationReason: string): Observable<Appointment> {
    const request: UpdateAppointmentStatusRequest = {
      status: this.toAppointmentStatusNumber('Cancelled'),
      cancellationReason
    };

    return this.http.put<Appointment>(`${this.apiBaseUrl}/appointments/${appointmentId}/status`, request)
      .pipe(
        map(appointment => this.normalizeAppointment(appointment))
      );
  }

  private getRequiredPatientId(): number {
    const patientId = this.authService.getPatientId();

    if (patientId == null) {
      console.error('Patient id missing from auth response.', this.authService.getStoredAuthResponse());
      throw new Error('Patient id was not found in the authenticated session.');
    }

    return patientId;
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

  private normalizeAppointment(appointment: Appointment): Appointment {
    return {
      ...appointment,
      status: this.normalizeAppointmentStatus(appointment.status)
    };
  }

  private normalizeHealthRecord(record: HealthRecord): HealthRecord {
    return record;
  }

  private normalizeDoctor(doctor: PublicDoctor): PublicDoctor {
    return {
      ...doctor,
      specialisation: this.normalizeSpecialisation(doctor.specialisation)
    };
  }

  private normalizeDoctorAvailableSlots(doctor: DoctorAvailableSlots): DoctorAvailableSlots {
    return {
      ...doctor,
      specialisation: this.normalizeSpecialisation(doctor.specialisation)
    };
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
