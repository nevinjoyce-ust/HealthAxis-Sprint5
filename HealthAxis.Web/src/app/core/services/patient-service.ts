import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable, inject } from '@angular/core';
import { Observable, map } from 'rxjs';

import { API_BASE_URL } from '../constants/api-constants';
import { AuthService } from './auth-service';
import {
  Appointment,
  DoctorAvailableSlots,
  DoctorSpecialisation,
  HealthRecord,
  PublicDoctor
} from '../../shared/models/health-axis.models';
import {
  getItemsFromPagedResult,
  PagedResult
} from '../../shared/utils/paged-result-utils';
import {
  normalizeAppointmentStatus,
  toAppointmentStatusNumber
} from '../../shared/utils/appointment-utils';
import {
  DoctorSortBy,
  normalizeDoctorSpecialisation,
  SortDirection
} from '../../shared/utils/doctor-utils';

export type { DoctorSortBy, SortDirection } from '../../shared/utils/doctor-utils';
export type { PagedResult } from '../../shared/utils/paged-result-utils';

export interface DoctorSearchRequest {
  pageNumber: number;
  pageSize: number;
  search?: string;
  specialisation?: DoctorSpecialisation | '';
  isAvailable?: boolean | null;
  sortBy?: DoctorSortBy;
  sortDirection?: SortDirection;
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
  email: string;
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
    return this.http.put<{ message: string }>(`${this.apiBaseUrl}/account/change-password`, request);
  }

  getCurrentPatientAppointments(pageSize = 100): Observable<Appointment[]> {
    const params = this.createPaginationParams(pageSize);

    return this.http.get<PagedResult<Appointment> | Appointment[] | null>(
      `${this.apiBaseUrl}/appointments/me`,
      { params }
    ).pipe(
      map(response => getItemsFromPagedResult(response)
        .map(appointment => this.normalizeAppointment(appointment)))
    );
  }

  getCurrentPatientHealthRecords(pageSize = 100): Observable<HealthRecord[]> {
    const params = this.createPaginationParams(pageSize);

    return this.http.get<PagedResult<HealthRecord> | HealthRecord[] | null>(
      `${this.apiBaseUrl}/health-records/me`,
      { params }
    ).pipe(
      map(response => getItemsFromPagedResult(response))
    );
  }

  getPublicDoctors(pageSize = 100): Observable<PublicDoctor[]> {
    return this.getPublicDoctorsPage({
      pageNumber: 1,
      pageSize,
      sortBy: 'Name',
      sortDirection: 'Asc'
    }).pipe(
      map(response => response.items)
    );
  }

  getPublicDoctorsPage(request: DoctorSearchRequest): Observable<PagedResult<PublicDoctor>> {
    let params = new HttpParams()
      .set('pageNumber', String(request.pageNumber))
      .set('pageSize', String(request.pageSize));

    if (request.search?.trim()) {
      params = params.set('search', request.search.trim());
    }

    if (request.specialisation) {
      params = params.set('specialisation', request.specialisation);
    }

    if (request.isAvailable !== null && request.isAvailable !== undefined) {
      params = params.set('isAvailable', String(request.isAvailable));
    }

    if (request.sortBy) {
      params = params.set('sortBy', request.sortBy);
    }

    if (request.sortDirection) {
      params = params.set('sortDirection', request.sortDirection);
    }

    return this.http.get<PagedResult<PublicDoctor>>(
      `${this.apiBaseUrl}/doctors`,
      { params }
    ).pipe(
      map(response => ({
        ...response,
        items: response.items.map(doctor => normalizeDoctorSpecialisation(doctor))
      }))
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
      map(response => getItemsFromPagedResult(response)
        .map(doctor => normalizeDoctorSpecialisation(doctor)))
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
      status: toAppointmentStatusNumber('Cancelled'),
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

  private normalizeAppointment(appointment: Appointment): Appointment {
    return {
      ...appointment,
      status: normalizeAppointmentStatus(appointment.status)
    };
  }
}
