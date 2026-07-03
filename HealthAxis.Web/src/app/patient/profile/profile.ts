import { Component, OnInit, inject, signal } from '@angular/core';
import {
  FormBuilder,
  ReactiveFormsModule,
  FormsModule,
  Validators
} from '@angular/forms';
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

const strongPasswordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z\d]).{8,100}$/;

@Component({
  selector: 'app-profile',
  imports: [ReactiveFormsModule, FormsModule],
  templateUrl: './profile.html',
  styleUrl: './profile.css'
})
export class Profile implements OnInit {
  private readonly route = inject(ActivatedRoute);
  private readonly router = inject(Router);
  private readonly patientService = inject(PatientService);
  private readonly fb = inject(FormBuilder);

  readonly isLoading = signal(false);
  readonly isSaving = signal(false);
  readonly isChangingPassword = signal(false);

  readonly profileErrorMessage = signal('');
  readonly saveErrorMessage = signal('');
  readonly passwordErrorMessage = signal('');

  readonly patient = signal<PatientDto | null>(null);

  readonly genderOptions = ['Male', 'Female', 'Other'];

  readonly profileForm = this.fb.nonNullable.group({
    fullName: ['', [
      Validators.required,
      Validators.maxLength(100),
      Validators.pattern(/^[A-Za-z][A-Za-z\s.'-]*$/)
    ]],
    email: ['', [
      Validators.required,
      Validators.email,
      Validators.maxLength(256)
    ]],
    dateOfBirth: ['', [
      Validators.required
    ]],
    gender: ['', [
      Validators.required
    ]],
    phoneNumber: ['', [
      Validators.required,
      Validators.pattern(/^[6-9]\d{9}$/)
    ]],
    address: ['', [
      Validators.required,
      Validators.minLength(5),
      Validators.maxLength(250)
    ]]
  });

  isEditMode = false;
  showPasswordChange = false;
  saveSuccess = false;
  passwordSuccess = false;
  passwordSubmitted = false;

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
        this.populateProfileForm(patient);
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
          this.populateProfileForm(patient);
          this.isLoading.set(false);
        },
        error: error => {
          console.error('Failed to load patient profile.', error);
          this.profileErrorMessage.set(
            error?.error?.message ?? 'Unable to load profile details.'
          );
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
    this.populateProfileForm(patient);

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
      this.populateProfileForm(patient);
    }

    this.router.navigate([], {
      relativeTo: this.route,
      queryParams: { edit: null },
      queryParamsHandling: 'merge'
    });
  }

  saveProfile(): void {
    if (this.profileForm.invalid || this.isSaving()) {
      this.profileForm.markAllAsTouched();
      this.saveErrorMessage.set('Please correct the highlighted fields before saving.');
      return;
    }

    this.isSaving.set(true);
    this.saveSuccess = false;
    this.saveErrorMessage.set('');

    const formValue = this.profileForm.getRawValue();

    const request: UpdatePatientRequest = {
      fullName: formValue.fullName.trim(),
      email: formValue.email.trim(),
      dateOfBirth: formValue.dateOfBirth,
      gender: formValue.gender,
      phoneNumber: formValue.phoneNumber.trim(),
      address: formValue.address.trim()
    };

    this.patientService.updateCurrentPatient(request)
      .subscribe({
        next: patient => {
          this.patient.set(patient);
          this.populateProfileForm(patient);
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
          this.saveErrorMessage.set(this.getApiErrorMessage(error, 'Unable to update profile details.'));
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
    this.passwordSubmitted = true;
    this.passwordSuccess = false;
    this.passwordErrorMessage.set('');

    if (!this.canChangePassword || this.isChangingPassword()) {
      this.passwordErrorMessage.set('Please correct the highlighted password fields before saving.');
      return;
    }

    this.isChangingPassword.set(true);

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
        this.passwordErrorMessage.set(
          this.getApiErrorMessage(error, 'Unable to change password. Please check your current password and try again.')
        );
        this.isChangingPassword.set(false);
      }
    });
  }

  get canSaveProfile(): boolean {
    return this.profileForm.valid;
  }

  get isCurrentPasswordValid(): boolean {
    return this.changePasswordRequest.currentPassword.trim().length > 0;
  }

  get isNewPasswordValid(): boolean {
    return strongPasswordPattern.test(this.changePasswordRequest.newPassword);
  }

  get isConfirmPasswordValid(): boolean {
    return this.changePasswordRequest.confirmNewPassword.trim().length > 0 &&
      this.changePasswordRequest.newPassword === this.changePasswordRequest.confirmNewPassword;
  }

  get isNewPasswordSameAsCurrent(): boolean {
    return this.changePasswordRequest.currentPassword.trim().length > 0 &&
      this.changePasswordRequest.newPassword.trim().length > 0 &&
      this.changePasswordRequest.currentPassword === this.changePasswordRequest.newPassword;
  }

  get canChangePassword(): boolean {
    return this.isCurrentPasswordValid &&
      this.isNewPasswordValid &&
      this.isConfirmPasswordValid &&
      !this.isNewPasswordSameAsCurrent &&
      !this.isChangingPassword();
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

  private populateProfileForm(patient: PatientDto): void {
    this.profileForm.setValue({
      fullName: patient.fullName,
      email: patient.email,
      dateOfBirth: patient.dateOfBirth,
      gender: patient.gender,
      phoneNumber: patient.phoneNumber,
      address: patient.address
    });
  }

  private resetPasswordForm(): void {
    this.passwordSubmitted = false;

    this.changePasswordRequest = {
      currentPassword: '',
      newPassword: '',
      confirmNewPassword: ''
    };
  }

  private getApiErrorMessage(error: any, fallbackMessage: string): string {
    if (error?.error?.message) {
      return error.error.message;
    }

    const errors = error?.error?.errors;

    if (errors && typeof errors === 'object') {
      const messages = Object.values(errors)
        .flat()
        .filter(Boolean);

      if (messages.length > 0) {
        return messages.join(' ');
      }
    }

    if (error?.error?.title) {
      return error.error.title;
    }

    return fallbackMessage;
  }
}
