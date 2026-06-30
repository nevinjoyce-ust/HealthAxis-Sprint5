import { Component, inject } from '@angular/core';
import { ReactiveFormsModule, FormBuilder, Validators } from '@angular/forms';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-register',
  imports: [ReactiveFormsModule, RouterLink],
  templateUrl: './register.html',
  styleUrl: './register.css'
})
export class Register {
  private readonly formBuilder = inject(FormBuilder);

  isSubmitted = false;
  demoMessage = '';

  registerForm = this.formBuilder.group({
    fullName: ['', [Validators.required, Validators.maxLength(100)]],
    email: ['', [Validators.required, Validators.email, Validators.maxLength(150)]],
    phoneNumber: ['', [Validators.required, Validators.maxLength(20)]],
    dateOfBirth: ['', [Validators.required]],
    gender: ['', [Validators.required]],
    address: ['', [Validators.required, Validators.maxLength(250)]],
    password: ['', [Validators.required, Validators.minLength(8)]],
    confirmPassword: ['', [Validators.required]]
  });

  get controls() {
    return this.registerForm.controls;
  }

  onSubmit(): void {
    this.isSubmitted = true;
    this.demoMessage = '';

    if (this.registerForm.invalid) {
      this.registerForm.markAllAsTouched();
      return;
    }

    if (this.controls.password.value !== this.controls.confirmPassword.value) {
      this.controls.confirmPassword.setErrors({ passwordMismatch: true });
      return;
    }

    this.demoMessage = 'Registration form is ready.';
  }
}
