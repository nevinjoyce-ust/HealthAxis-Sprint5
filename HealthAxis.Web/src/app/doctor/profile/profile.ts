import { Component, OnInit, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { DoctorProfileDto, DoctorService } from '../../core/services/doctor-service';
import { DoctorSpecialisation } from '../../shared/models/health-axis.models';

interface ChangePasswordForm {
  currentPassword: string;
  newPassword: string;
  confirmNewPassword: string;
}

const strongPasswordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z\d]).{8,100}$/;

@Component({
  selector: 'app-doctor-profile',
  imports: [FormsModule],
  templateUrl: './profile.html',
  styleUrl: './profile.css'
})
export class Profile implements OnInit {
  private readonly doctorService = inject(DoctorService);

  readonly currentDoctor = signal<DoctorProfileDto | null>(null);
  readonly isDoctorLoading = signal(false);
  readonly isActivationUpdating = signal(false);
  readonly isPasswordChanging = signal(false);

  readonly doctorErrorMessage = signal('');
  readonly activationErrorMessage = signal('');
  readonly passwordErrorMessage = signal('');
  readonly passwordSuccessMessage = signal('');

  showPasswordChange = false;
  passwordSubmitted = false;
  selectedActivationState: boolean | null = null;

  changePasswordForm: ChangePasswordForm = {
    currentPassword: '',
    newPassword: '',
    confirmNewPassword: ''
  };

  ngOnInit(): void {
    this.loadDoctor();
  }

  get isDoctorActive(): boolean {
    return this.currentDoctor()?.isAvailable ?? false;
  }

  get isCurrentPasswordValid(): boolean {
    return this.changePasswordForm.currentPassword.trim().length > 0;
  }

  get isNewPasswordValid(): boolean {
    return strongPasswordPattern.test(this.changePasswordForm.newPassword);
  }

  get isConfirmPasswordValid(): boolean {
    return this.changePasswordForm.confirmNewPassword.trim().length > 0 &&
      this.changePasswordForm.newPassword === this.changePasswordForm.confirmNewPassword;
  }

  get isNewPasswordSameAsCurrent(): boolean {
    return this.changePasswordForm.currentPassword.trim().length > 0 &&
      this.changePasswordForm.newPassword.trim().length > 0 &&
      this.changePasswordForm.currentPassword === this.changePasswordForm.newPassword;
  }

  get canChangePassword(): boolean {
    return this.isCurrentPasswordValid &&
      this.isNewPasswordValid &&
      this.isConfirmPasswordValid &&
      !this.isNewPasswordSameAsCurrent &&
      !this.isPasswordChanging();
  }

  get passwordMismatch(): boolean {
    return this.changePasswordForm.confirmNewPassword.length > 0 &&
      this.changePasswordForm.newPassword !== this.changePasswordForm.confirmNewPassword;
  }

  loadDoctor(): void {
    this.isDoctorLoading.set(true);
    this.doctorErrorMessage.set('');

    this.doctorService.getCurrentDoctor()
      .subscribe({
        next: doctor => {
          this.currentDoctor.set(doctor);
          this.isDoctorLoading.set(false);
        },
        error: error => {
          console.error('Failed to load doctor profile.', error);
          this.doctorErrorMessage.set(error?.error?.message ?? 'Unable to load doctor profile.');
          this.isDoctorLoading.set(false);
        }
      });
  }

  openActivationModal(nextState: boolean): void {
    this.selectedActivationState = nextState;
    this.activationErrorMessage.set('');
  }

  closeActivationModal(): void {
    this.selectedActivationState = null;
    this.activationErrorMessage.set('');
  }

  confirmActivationChange(): void {
    if (this.selectedActivationState === null || this.isActivationUpdating()) {
      return;
    }

    this.isActivationUpdating.set(true);
    this.activationErrorMessage.set('');

    this.doctorService.updateCurrentDoctorAvailability(this.selectedActivationState)
      .subscribe({
        next: availability => {
          this.currentDoctor.update(doctor => doctor
            ? { ...doctor, isAvailable: availability.isAvailable }
            : doctor);
          this.isActivationUpdating.set(false);
          this.closeActivationModal();
        },
        error: error => {
          console.error('Failed to update doctor activation state.', error);
          this.activationErrorMessage.set(error?.error?.message ?? 'Unable to update activation status.');
          this.isActivationUpdating.set(false);
        }
      });
  }

  togglePasswordChange(): void {
    this.showPasswordChange = !this.showPasswordChange;
    this.passwordSuccessMessage.set('');
    this.passwordErrorMessage.set('');
    this.resetPasswordForm();
  }

  changePassword(): void {
    this.passwordSubmitted = true;
    this.passwordErrorMessage.set('');
    this.passwordSuccessMessage.set('');

    if (!this.canChangePassword) {
      this.passwordErrorMessage.set('Please correct the highlighted password fields before saving.');
      return;
    }

    this.isPasswordChanging.set(true);

    this.doctorService.changePassword({
      currentPassword: this.changePasswordForm.currentPassword,
      newPassword: this.changePasswordForm.newPassword
    }).subscribe({
      next: () => {
        this.passwordSuccessMessage.set('Password changed successfully.');
        this.showPasswordChange = false;
        this.resetPasswordForm();
        this.isPasswordChanging.set(false);
      },
      error: error => {
        console.error('Failed to change password.', error);
        this.passwordErrorMessage.set(this.getApiErrorMessage(error));
        this.isPasswordChanging.set(false);
      }
    });
  }

  formatSpecialisation(specialisation: DoctorSpecialisation): string {
    return specialisation === 'GeneralMedicine'
      ? 'General Medicine'
      : specialisation;
  }

  private resetPasswordForm(): void {
    this.passwordSubmitted = false;

    this.changePasswordForm = {
      currentPassword: '',
      newPassword: '',
      confirmNewPassword: ''
    };
  }

  private getApiErrorMessage(error: any): string {
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

    return 'Unable to change password. Please check your current password and try again.';
  }
}
