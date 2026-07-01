import { Component, OnInit, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { DoctorProfileDto, DoctorService } from '../../core/services/doctor-service';
import { DoctorSpecialisation } from '../../shared/models/health-axis.models';

interface ChangePasswordForm {
  currentPassword: string;
  newPassword: string;
  confirmNewPassword: string;
}

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

  get canChangePassword(): boolean {
    return this.changePasswordForm.currentPassword.trim().length > 0 &&
      this.changePasswordForm.newPassword.trim().length >= 8 &&
      this.changePasswordForm.newPassword === this.changePasswordForm.confirmNewPassword &&
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
    if (!this.canChangePassword) {
      return;
    }

    this.isPasswordChanging.set(true);
    this.passwordErrorMessage.set('');
    this.passwordSuccessMessage.set('');

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
        this.passwordErrorMessage.set(error?.error?.message ?? 'Unable to change password.');
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
    this.changePasswordForm = {
      currentPassword: '',
      newPassword: '',
      confirmNewPassword: ''
    };
  }
}
