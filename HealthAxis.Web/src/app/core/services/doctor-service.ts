import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable, inject } from '@angular/core';
import { Observable, map } from 'rxjs';

import { API_BASE_URL } from '../constants/api-constants';
import {
  Appointment,
  AppointmentStatus,
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
import { normalizeDoctorSpecialisation } from '../../shared/utils/doctor-utils';

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
        map(doctor => normalizeDoctorSpecialisation(doctor))
      );
  }

  updateCurrentDoctorAvailability(isAvailable: boolean): Observable<DoctorAvailabilityDto> {
    const request: UpdateDoctorAvailabilityRequest = { isAvailable };

    return this.http.put<DoctorAvailabilityDto>(`${this.apiBaseUrl}/doctors/me/availability`, request);
  }

  changePassword(request: ChangePasswordRequest): Observable<{ message: string }> {
    return this.http.put<{ message: string }>(`${this.apiBaseUrl}/account/change-password`, request);
  }

  getCurrentDoctorAppointments(pageSize = 100): Observable<Appointment[]> {
    const params = this.createPaginationParams(pageSize);

    return this.http.get<PagedResult<Appointment> | Appointment[] | null>(
      `${this.apiBaseUrl}/appointments/me`,
      { params }
    ).pipe(
      map(response => getItemsFromPagedResult(response)
        .map(appointment => this.normalizeAppointment(appointment)))
    );
  }

  getCurrentDoctorHealthRecords(pageSize = 100): Observable<HealthRecord[]> {
    const params = this.createPaginationParams(pageSize);

    return this.http.get<PagedResult<HealthRecord> | HealthRecord[] | null>(
      `${this.apiBaseUrl}/health-records/me`,
      { params }
    ).pipe(
      map(response => getItemsFromPagedResult(response))
    );
  }

  getPatientHealthRecords(patientId: number, pageSize = 100): Observable<HealthRecord[]> {
    const params = this.createPaginationParams(pageSize);

    return this.http.get<PagedResult<HealthRecord> | HealthRecord[] | null>(
      `${this.apiBaseUrl}/health-records/patient/${patientId}`,
      { params }
    ).pipe(
      map(response => getItemsFromPagedResult(response))
    );
  }

  getPublicDoctors(pageSize = 100): Observable<PublicDoctor[]> {
    const params = this.createPaginationParams(pageSize);

    return this.http.get<PagedResult<PublicDoctor> | PublicDoctor[] | null>(
      `${this.apiBaseUrl}/doctors`,
      { params }
    ).pipe(
      map(response => getItemsFromPagedResult(response)
        .map(doctor => normalizeDoctorSpecialisation(doctor)))
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

    return this.http.post<HealthRecord>(`${this.apiBaseUrl}/health-records`, request);
  }

  private updateAppointmentStatus(
    appointmentId: number,
    status: AppointmentStatus,
    cancellationReason?: string | null
  ): Observable<Appointment> {
    const request: UpdateAppointmentStatusRequest = {
      status: toAppointmentStatusNumber(status),
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

  private normalizeAppointment(appointment: Appointment): Appointment {
    return {
      ...appointment,
      status: normalizeAppointmentStatus(appointment.status)
    };
  }
}
