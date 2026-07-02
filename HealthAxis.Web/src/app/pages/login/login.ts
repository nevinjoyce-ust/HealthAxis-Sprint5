import { Component, inject, signal } from '@angular/core';
import { ReactiveFormsModule, FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { HttpErrorResponse } from '@angular/common/http';
import { TimeoutError, finalize, timeout } from 'rxjs';

import { AuthService } from '../../core/services/auth-service';

@Component({
  selector: 'app-login',
  imports: [ReactiveFormsModule, RouterLink],
  templateUrl: './login.html',
  styleUrl: './login.css'
})
export class Login {
  private readonly formBuilder = inject(FormBuilder);
  private readonly auth = inject(AuthService);
  private readonly route = inject(ActivatedRoute);

  readonly isSubmitted = signal(false);
  readonly isLoading = signal(false);
  readonly infoMessage = signal('');
  readonly errorMessage = signal('');

  readonly loginForm = this.formBuilder.nonNullable.group({
    email: ['', [Validators.required, Validators.email]],
    password: ['', [Validators.required]]
  });

  constructor() {
    this.route.queryParamMap.subscribe(params => {
      const reason = params.get('reason');

      this.infoMessage.set(this.getReasonMessage(reason));
      this.errorMessage.set('');
    });
  }

  get email() {
    return this.loginForm.controls.email;
  }

  get password() {
    return this.loginForm.controls.password;
  }

  onSubmit(): void {
    this.isSubmitted.set(true);
    this.infoMessage.set('');
    this.errorMessage.set('');

    if (this.loginForm.invalid) {
      this.loginForm.markAllAsTouched();
      return;
    }

    const request = {
      email: this.email.value.trim(),
      password: this.password.value
    };

    this.isLoading.set(true);

    this.auth.login(request)
      .pipe(
        timeout({ first: 15000 }),
        finalize(() => this.isLoading.set(false))
      )
      .subscribe({
        next: response => {
          if (!response.accessToken) {
            this.errorMessage.set('Login succeeded, but no access token was returned.');
            return;
          }

          this.auth.redirectToDashboard();
        },
        error: error => {
          this.errorMessage.set(this.getLoginErrorMessage(error));
        }
      });
  }

  private getLoginErrorMessage(error: unknown): string {
    if (error instanceof TimeoutError) {
      return 'Login request timed out. Please check whether the API is running and try again.';
    }

    if (error instanceof HttpErrorResponse) {
      if (error.status === 0) {
        return 'Unable to reach the API. Please check whether the backend is running.';
      }

      if (error.status === 401) {
        return this.getErrorMessageFromBody(error) ?? 'Invalid email or password.';
      }

      if (error.status === 403) {
        return this.getErrorMessageFromBody(error) ?? 'You do not have permission to access this application.';
      }

      return this.getErrorMessageFromBody(error) ??
        error.message ??
        'Login failed. Please try again.';
    }

    return 'Login failed. Please try again.';
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

    if (typeof responseBody.title === 'string') {
      return responseBody.title;
    }

    return null;
  }

  private getReasonMessage(reason: string | null): string {
    switch (reason) {
      case 'unauthorized':
        return 'Please log in to continue.';
      case 'forbidden':
        return 'You do not have permission to access that page.';
      case 'logged-out':
        return 'You have been logged out.';
      default:
        return '';
    }
  }
}
