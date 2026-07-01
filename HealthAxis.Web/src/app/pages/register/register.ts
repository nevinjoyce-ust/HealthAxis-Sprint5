import { HttpErrorResponse } from '@angular/common/http';
import { Component, inject, signal } from '@angular/core';
import { ReactiveFormsModule, FormBuilder, Validators } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { finalize } from 'rxjs';

import { AuthService } from '../../core/services/auth-service';

@Component({
  selector: 'app-register',
  imports: [ReactiveFormsModule, RouterLink],
  templateUrl: './register.html',
  styleUrl: './register.css'
})
export class Register {
  private readonly formBuilder = inject(FormBuilder);
  private readonly auth = inject(AuthService);
  private readonly router = inject(Router);

  isSubmitted = signal(false);
  isLoading = signal(false);
  successMessage = signal('');
  errorMessage = signal('');

  registerForm = this.formBuilder.group({
    fullName: ['', [Validators.required, Validators.maxLength(100)]],
    email: ['', [Validators.required, Validators.email, Validators.maxLength(150)]],
    phoneNumber: ['', [Validators.required, Validators.maxLength(20)]],
    dateOfBirth: ['', [Validators.required]],
    gender: ['', [Validators.required, Validators.maxLength(20)]],
    address: ['', [Validators.required, Validators.maxLength(250)]],
    password: ['', [Validators.required, Validators.minLength(8)]],
    confirmPassword: ['', [Validators.required]]
  });

  get controls() {
    return this.registerForm.controls;
  }

  onSubmit(): void {
    this.isSubmitted.set(true);
    this.successMessage.set('');
    this.errorMessage.set('');

    this.controls.confirmPassword.setErrors(null);

    if (this.registerForm.invalid) {
      this.registerForm.markAllAsTouched();
      return;
    }

    if (this.controls.password.value !== this.controls.confirmPassword.value) {
      this.controls.confirmPassword.setErrors({ passwordMismatch: true });
      this.controls.confirmPassword.markAsTouched();
      return;
    }

    const request = {
      fullName: this.controls.fullName.value ?? '',
      email: this.controls.email.value ?? '',
      phoneNumber: this.controls.phoneNumber.value ?? '',
      dateOfBirth: this.controls.dateOfBirth.value ?? '',
      gender: this.controls.gender.value ?? '',
      address: this.controls.address.value ?? '',
      password: this.controls.password.value ?? '',
      confirmPassword: this.controls.confirmPassword.value ?? ''
    };

    this.isLoading.set(true);

    this.auth.register(request)
      .pipe(finalize(() => this.isLoading.set(false)))
      .subscribe({
        next: () => {
          this.router.navigate(['/login'], {
            queryParams: { reason: 'registered' }
          });
        },
        error: error => {
          this.errorMessage.set(this.getRegisterErrorMessage(error));
        }
      });
  }

  private getRegisterErrorMessage(error: unknown): string {
    if (error instanceof HttpErrorResponse) {
      if (error.status === 0) {
        return 'Unable to reach the API. Please check whether the backend is running.';
      }

      return this.getErrorMessageFromBody(error) ??
        error.message ??
        'Registration failed. Please try again.';
    }

    return 'Registration failed. Please try again.';
  }

  private getErrorMessageFromBody(error: HttpErrorResponse): string | null {
    const responseBody = error.error;

    if (!responseBody) {
      return null;
    }

    if (typeof responseBody === 'string') {
      return responseBody;
    }

    if (typeof responseBody.message === 'string') {
      return responseBody.message;
    }

    return null;
  }
}