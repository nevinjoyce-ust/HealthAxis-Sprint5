import { Component, inject } from '@angular/core';
import { RouterLink } from '@angular/router';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';

@Component({
  selector: 'app-login',
  imports: [ReactiveFormsModule, RouterLink],
  templateUrl: './login.html',
  styleUrl: './login.css'
})
export class Login {
  private readonly formBuilder = inject(FormBuilder);

  private readonly adminConsoleUrl = 'https://localhost:7041/login';

  isSubmitted = false;
  demoMessage = '';

  loginForm = this.formBuilder.group({
    email: ['', [Validators.required, Validators.email]],
    password: ['', [Validators.required]]
  });

  get email() {
    return this.loginForm.controls.email;
  }

  get password() {
    return this.loginForm.controls.password;
  }

  onSubmit(): void {
    this.isSubmitted = true;
    this.demoMessage = '';

    if (this.loginForm.invalid) {
      this.loginForm.markAllAsTouched();
      return;
    }

    const emailAddress = this.email.value?.trim().toLowerCase();

    // Temporary demo logic only.
    // Later this will come from POST /api/auth/login response/JWT role claim.
    if (emailAddress?.includes('admin')) {
      window.location.href = this.adminConsoleUrl;
      return;
    }

    if (emailAddress?.includes('doctor')) {
      this.demoMessage = 'Doctor login validated. Later this will redirect to the Doctor Dashboard.';
      return;
    }

    this.demoMessage = 'Patient login validated. Later this will redirect to the Patient Dashboard.';
  }
}
