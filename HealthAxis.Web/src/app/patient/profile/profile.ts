import { Component, OnInit, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';

import {
  PatientDto,
  PatientService,
  UpdatePatientRequest
} from '../../core/services/patient-service';

interface ChangePasswordForm {
  currentPassword: string;
  newPassword: string;
  confirmNewPassword: string;
}

@Component({
  selector: 'app-profile',
  imports: [FormsModule],
  templateUrl: './profile.html',
  styleUrl: './profile.css'
})
export class Profile implements OnInit {
  private readonly route = inject(ActivatedRoute);
  private readonly router = inject(Router);
  private readonly patientService = inject(PatientService);

  readonly isLoading = signal(false);
  readonly isSaving = signal(false);
  readonly isChangingPassword = signal(false);

  readonly profileErrorMessage = signal('');
  readonly saveErrorMessage = signal('');
  readonly passwordErrorMessage = signal('');

  readonly patient = signal<PatientDto | null>(null);

  isEditMode = false;
  showPasswordChange = false;
  saveSuccess = false;
  passwordSuccess = false;

  updatePatient: UpdatePatientRequest = this.createEmptyUpdatePatientRequest();

  changePasswordRequest: ChangePasswordForm = {
    currentPassword: '',
    newPassword: '',
    confirmNewPassword: ''
  };

  constructor() {
    this.route.queryParamMap.subscribe(params => {
      this.isEditMode = params.get('edit') === 'true';
      this.saveSuccess = false;

      const patient = this.patient();

      if (patient) {
        this.updatePatient = this.createUpdatePatientRequest(patient);
      }
    });
  }

  ngOnInit(): void {
    this.loadProfile();
  }

  loadProfile(): void {
    this.isLoading.set(true);
    this.profileErrorMessage.set('');

    this.patientService.getCurrentPatient()
      .subscribe({
        next: patient => {
          this.patient.set(patient);
          this.updatePatient = this.createUpdatePatientRequest(patient);
          this.isLoading.set(false);
        },
        error: error => {
          console.error('Failed to load patient profile.', error);
          this.profileErrorMessage.set(error?.error?.message ?? 'Unable to load profile details.');
          this.isLoading.set(false);
        }
      });
  }

  startEditing(): void {
    const patient = this.patient();

    if (!patient) {
      return;
    }

    this.isEditMode = true;
    this.saveSuccess = false;
    this.saveErrorMessage.set('');
    this.updatePatient = this.createUpdatePatientRequest(patient);

    this.router.navigate([], {
      relativeTo: this.route,
      queryParams: { edit: true },
      queryParamsHandling: 'merge'
    });
  }

  cancelEditing(): void {
    this.isEditMode = false;
    this.saveSuccess = false;
    this.saveErrorMessage.set('');

    const patient = this.patient();

    if (patient) {
      this.updatePatient = this.createUpdatePatientRequest(patient);
    }

    this.router.navigate([], {
      relativeTo: this.route,
      queryParams: { edit: null },
      queryParamsHandling: 'merge'
    });
  }

  saveProfile(): void {
    if (!this.canSaveProfile || this.isSaving()) {
      return;
    }

    this.isSaving.set(true);
    this.saveSuccess = false;
    this.saveErrorMessage.set('');

    this.patientService.updateCurrentPatient(this.updatePatient)
      .subscribe({
        next: patient => {
          this.patient.set(patient);
          this.updatePatient = this.createUpdatePatientRequest(patient);
          this.isEditMode = false;
          this.saveSuccess = true;
          this.isSaving.set(false);

          this.router.navigate([], {
            relativeTo: this.route,
            queryParams: { edit: null },
            queryParamsHandling: 'merge'
          });
        },
        error: error => {
          console.error('Failed to update patient profile.', error);
          this.saveErrorMessage.set(error?.error?.message ?? 'Unable to update profile details.');
          this.isSaving.set(false);
        }
      });
  }

  togglePasswordChange(): void {
    this.showPasswordChange = !this.showPasswordChange;
    this.passwordSuccess = false;
    this.passwordErrorMessage.set('');
    this.resetPasswordForm();
  }

  changePassword(): void {
    if (!this.canChangePassword || this.isChangingPassword()) {
      return;
    }

    this.isChangingPassword.set(true);
    this.passwordSuccess = false;
    this.passwordErrorMessage.set('');

    this.patientService.changePassword({
      currentPassword: this.changePasswordRequest.currentPassword,
      newPassword: this.changePasswordRequest.newPassword
    }).subscribe({
      next: () => {
        this.passwordSuccess = true;
        this.showPasswordChange = false;
        this.isChangingPassword.set(false);
        this.resetPasswordForm();
      },
      error: error => {
        console.error('Failed to change password.', error);
        this.passwordErrorMessage.set(error?.error?.message ?? 'Unable to change password.');
        this.isChangingPassword.set(false);
      }
    });
  }

  get canSaveProfile(): boolean {
    return this.updatePatient.fullName.trim().length > 0 &&
      this.updatePatient.dateOfBirth.trim().length > 0 &&
      this.updatePatient.gender.trim().length > 0 &&
      this.updatePatient.phoneNumber.trim().length > 0 &&
      this.updatePatient.address.trim().length > 0;
  }

  get canChangePassword(): boolean {
    return this.changePasswordRequest.currentPassword.trim().length > 0 &&
      this.changePasswordRequest.newPassword.trim().length >= 8 &&
      this.changePasswordRequest.newPassword === this.changePasswordRequest.confirmNewPassword;
  }

  get passwordMismatch(): boolean {
    return this.changePasswordRequest.confirmNewPassword.length > 0 &&
      this.changePasswordRequest.newPassword !== this.changePasswordRequest.confirmNewPassword;
  }

  formatDate(date: string): string {
    return new Date(`${date}T00:00:00`).toLocaleDateString('en-IN', {
      day: '2-digit',
      month: 'short',
      year: 'numeric'
    });
  }

  private createUpdatePatientRequest(patient: PatientDto): UpdatePatientRequest {
    return {
      fullName: patient.fullName,
      dateOfBirth: patient.dateOfBirth,
      gender: patient.gender,
      phoneNumber: patient.phoneNumber,
      address: patient.address
    };
  }

  private createEmptyUpdatePatientRequest(): UpdatePatientRequest {
    return {
      fullName: '',
      dateOfBirth: '',
      gender: '',
      phoneNumber: '',
      address: ''
    };
  }

  private resetPasswordForm(): void {
    this.changePasswordRequest = {
      currentPassword: '',
      newPassword: '',
      confirmNewPassword: ''
    };
  }
}
