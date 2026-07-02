import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';
import { Observable, tap } from 'rxjs';

import { ADMIN_CALLBACK_URL, API_BASE_URL } from '../constants/api-constants';
import { AppRoutes, RoleDashboardRoutes } from '../constants/route-paths';
import {
  AppRole,
  AppRoles,
  normalizeAppRole
} from '../../shared/models/role.model';
import {
  AuthResponse,
  JwtPayload,
  LoginRequest,
  RegisterRequest,
  RegisterResponse
} from '../../shared/models/auth-models';

interface AdminHandoffCodeResponse {
  code: string;
  expiresInSeconds: number;
}

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private readonly http = inject(HttpClient);
  private readonly router = inject(Router);

  private readonly apiBaseUrl = API_BASE_URL;
  private readonly adminCallbackUrl = ADMIN_CALLBACK_URL;

  private readonly accessTokenKey = 'accessToken';
  private readonly authResponseKey = 'authResponse';

  login(request: LoginRequest): Observable<AuthResponse> {
    return this.http.post<AuthResponse>(`${this.apiBaseUrl}/auth/login`, request)
      .pipe(
        tap(response => this.storeAuthResponse(response))
      );
  }

  register(request: RegisterRequest): Observable<RegisterResponse> {
    return this.http.post<RegisterResponse>(`${this.apiBaseUrl}/auth/register`, request);
  }

  createAdminHandoffCode(): Observable<AdminHandoffCodeResponse> {
    return this.http.post<AdminHandoffCodeResponse>(
      `${this.apiBaseUrl}/auth/admin-handoff-code`,
      {}
    );
  }

  clearSession(): void {
    localStorage.removeItem(this.accessTokenKey);
    localStorage.removeItem(this.authResponseKey);

    sessionStorage.removeItem(this.accessTokenKey);
    sessionStorage.removeItem(this.authResponseKey);
  }

  logout(): void {
    this.clearSession();

    this.router.navigate([AppRoutes.Login], {
      queryParams: { reason: 'logged-out' },
      replaceUrl: true
    });
  }

  getAccessToken(): string | null {
    return localStorage.getItem(this.accessTokenKey) ??
      sessionStorage.getItem(this.accessTokenKey);
  }

  getStoredAuthResponse(): AuthResponse | null {
    const rawValue = localStorage.getItem(this.authResponseKey) ??
      sessionStorage.getItem(this.authResponseKey);

    if (!rawValue) {
      return null;
    }

    try {
      return JSON.parse(rawValue) as AuthResponse;
    } catch {
      return null;
    }
  }

  getJwtPayload(): JwtPayload | null {
    const token = this.getAccessToken();

    if (!token) {
      return null;
    }

    const parts = token.split('.');

    if (parts.length !== 3) {
      return null;
    }

    try {
      const base64 = parts[1].replace(/-/g, '+').replace(/_/g, '/');
      const paddedBase64 = base64.padEnd(
        base64.length + (4 - base64.length % 4) % 4,
        '='
      );

      const jsonPayload = decodeURIComponent(
        atob(paddedBase64)
          .split('')
          .map(character => `%${(`00${character.charCodeAt(0).toString(16)}`).slice(-2)}`)
          .join('')
      );

      return JSON.parse(jsonPayload) as JwtPayload;
    } catch {
      return null;
    }
  }

  isLoggedIn(): boolean {
    const token = this.getAccessToken();
    const payload = this.getJwtPayload();

    if (!token || !payload?.exp) {
      return false;
    }

    return payload.exp * 1000 > Date.now();
  }

  getUserRole(): AppRole | null {
    const responseRole = normalizeAppRole(this.getStoredAuthResponse()?.role);

    if (responseRole) {
      return responseRole;
    }

    const payload = this.getJwtPayload();

    if (!payload) {
      return null;
    }

    const roleClaim = payload.role ??
      payload.roles ??
      payload['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'] ??
      payload['http://healthaxis/claims/role'];

    if (Array.isArray(roleClaim)) {
      return normalizeAppRole(roleClaim[0]);
    }

    return normalizeAppRole(roleClaim);
  }

  hasRole(role: AppRole): boolean {
    return this.getUserRole() === role;
  }

  isPatient(): boolean {
    return this.hasRole(AppRoles.Patient);
  }

  isDoctor(): boolean {
    return this.hasRole(AppRoles.Doctor);
  }

  isAdmin(): boolean {
    return this.hasRole(AppRoles.Admin);
  }

  getDashboardUrl(): string | null {
    const role = this.getUserRole();

    return role ? RoleDashboardRoutes[role] : null;
  }

  getPatientId(): number | null {
    const responsePatientId = this.getStoredAuthResponse()?.patientId;

    if (responsePatientId != null) {
      return responsePatientId;
    }

    const payload = this.getJwtPayload();
    const payloadPatientId = payload?.patientId ?? payload?.['http://healthaxis/claims/patientId'];

    return typeof payloadPatientId === 'string' ? Number(payloadPatientId) : null;
  }

  getDoctorId(): number | null {
    const responseDoctorId = this.getStoredAuthResponse()?.doctorId;

    if (responseDoctorId != null) {
      return responseDoctorId;
    }

    const payload = this.getJwtPayload();
    const payloadDoctorId = payload?.doctorId ?? payload?.['http://healthaxis/claims/doctorId'];

    return typeof payloadDoctorId === 'string' ? Number(payloadDoctorId) : null;
  }

  redirectToDashboard(): void {
    const role = this.getUserRole();

    if (!role) {
      this.router.navigate([AppRoutes.Login]);
      return;
    }

    if (role === AppRoles.Admin) {
      this.redirectAdminToBlazorDashboard();
      return;
    }

    const dashboardUrl = RoleDashboardRoutes[role];

    if (dashboardUrl) {
      this.router.navigate([dashboardUrl]);
      return;
    }

    this.router.navigate([AppRoutes.Login]);
  }

  private redirectAdminToBlazorDashboard(): void {
    this.createAdminHandoffCode().subscribe({
      next: response => {
        this.clearSession();

        window.location.href =
          `${this.adminCallbackUrl}?code=${encodeURIComponent(response.code)}`;
      },
      error: () => {
        this.router.navigate([AppRoutes.Login]);
      }
    });
  }

  private storeAuthResponse(response: AuthResponse): void {
    localStorage.setItem(this.accessTokenKey, response.accessToken);
    localStorage.setItem(this.authResponseKey, JSON.stringify(response));
  }
}
