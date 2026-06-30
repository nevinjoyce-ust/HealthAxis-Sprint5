import { Component, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';

interface PatientDto {
  id: number;
  userId: string;
  fullName: string;
  email: string;
  dateOfBirth: string;
  gender: string;
  phoneNumber: string;
  address: string;
}

interface UpdatePatientDto {
  fullName: string;
  email: string;
  dateOfBirth: string;
  gender: string;
  phoneNumber: string;
  address: string;
}

interface ChangePasswordDto {
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
export class Profile {
  private readonly route = inject(ActivatedRoute);
  private readonly router = inject(Router);

  isEditMode = false;
  showPasswordChange = false;
  saveSuccess = false;
  passwordSuccess = false;

  patient: PatientDto = {
    id: 1,
    userId: 'patient-user-1',
    fullName: 'Nevin Joyce',
    email: 'nevin.joyce@example.com',
    dateOfBirth: '1996-08-14',
    gender: 'Male',
    phoneNumber: '+91 98765 43210',
    address: 'Bengaluru, Karnataka'
  };

  updatePatient: UpdatePatientDto = this.createUpdatePatientDto(this.patient);

  changePasswordRequest: ChangePasswordDto = {
    currentPassword: '',
    newPassword: '',
    confirmNewPassword: ''
  };

  constructor() {
    this.route.queryParamMap.subscribe(params => {
      this.isEditMode = params.get('edit') === 'true';
      this.updatePatient = this.createUpdatePatientDto(this.patient);
      this.saveSuccess = false;
    });
  }

  startEditing(): void {
    this.isEditMode = true;
    this.updatePatient = this.createUpdatePatientDto(this.patient);

    this.router.navigate([], {
      relativeTo: this.route,
      queryParams: { edit: true },
      queryParamsHandling: 'merge'
    });
  }

  cancelEditing(): void {
    this.isEditMode = false;
    this.updatePatient = this.createUpdatePatientDto(this.patient);
    this.saveSuccess = false;

    this.router.navigate([], {
      relativeTo: this.route,
      queryParams: { edit: null },
      queryParamsHandling: 'merge'
    });
  }

  saveProfile(): void {
    if (!this.canSaveProfile) {
      return;
    }

    this.patient = {
      ...this.patient,
      ...this.updatePatient
    };

    this.isEditMode = false;
    this.saveSuccess = true;

    this.router.navigate([], {
      relativeTo: this.route,
      queryParams: { edit: null },
      queryParamsHandling: 'merge'
    });
  }

  togglePasswordChange(): void {
    this.showPasswordChange = !this.showPasswordChange;
    this.passwordSuccess = false;
    this.resetPasswordForm();
  }

  changePassword(): void {
    if (!this.canChangePassword) {
      return;
    }

    this.passwordSuccess = true;
    this.showPasswordChange = false;
    this.resetPasswordForm();
  }

  get canSaveProfile(): boolean {
    return this.updatePatient.fullName.trim().length > 0 &&
      this.updatePatient.email.trim().length > 0 &&
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

  private createUpdatePatientDto(patient: PatientDto): UpdatePatientDto {
    return {
      fullName: patient.fullName,
      email: patient.email,
      dateOfBirth: patient.dateOfBirth,
      gender: patient.gender,
      phoneNumber: patient.phoneNumber,
      address: patient.address
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
