import { Routes } from '@angular/router';

import { authGuard } from './core/guards/auth-guard';
import { roleGuard } from './core/guards/role-guard';

export const routes: Routes = [
  {
    path: '',
    loadComponent: () =>
      import('./core/layouts/public-layout/public-layout').then(m => m.PublicLayout),
    children: [
      {
        path: '',
        title: 'HealthAxis',
        loadComponent: () =>
          import('./pages/home/home').then(m => m.Home)
      },
      {
        path: 'login',
        title: 'Login - HealthAxis',
        loadComponent: () =>
          import('./pages/login/login').then(m => m.Login)
      },
      {
        path: 'register',
        title: 'Register - HealthAxis',
        loadComponent: () =>
          import('./pages/register/register').then(m => m.Register)
      }
    ]
  },
  {
    path: 'patient',
    canActivate: [authGuard, roleGuard],
    data: { roles: ['Patient'] },
    loadComponent: () =>
      import('./core/layouts/patient-layout/patient-layout').then(m => m.PatientLayout),
    children: [
      {
        path: '',
        pathMatch: 'full',
        redirectTo: 'dashboard'
      },
      {
        path: 'dashboard',
        title: 'Patient Dashboard - HealthAxis',
        loadComponent: () =>
          import('./patient/dashboard/dashboard').then(m => m.PatientDashboard)
      },
      {
        path: 'appointments',
        title: 'Appointments - HealthAxis',
        loadComponent: () =>
          import('./patient/appointments/appointments').then(m => m.Appointments)
      },
      {
        path: 'health-history',
        title: 'Health History - HealthAxis',
        loadComponent: () =>
          import('./patient/health-history/health-history').then(m => m.HealthHistory)
      },
      {
        path: 'book',
        title: 'Book Appointment - HealthAxis',
        loadComponent: () =>
          import('./patient/book-appointment/book-appointment').then(m => m.BookAppointment)
      },
      {
        path: 'doctors',
        title: 'Search Doctors - HealthAxis',
        loadComponent: () =>
          import('./patient/doctors/doctors').then(m => m.Doctors)
      },
      {
        path: 'profile',
        title: 'Patient Profile - HealthAxis',
        loadComponent: () =>
          import('./patient/profile/profile').then(m => m.Profile)
      }
    ]
  },
  {
    path: 'doctor',
    canActivate: [authGuard, roleGuard],
    data: { roles: ['Doctor'] },
    loadComponent: () =>
      import('./core/layouts/doctor-layout/doctor-layout').then(m => m.DoctorLayout),
    children: [
      {
        path: '',
        pathMatch: 'full',
        redirectTo: 'dashboard'
      },
      {
        path: 'dashboard',
        title: 'Doctor Dashboard - HealthAxis',
        loadComponent: () =>
          import('./doctor/dashboard/dashboard').then(m => m.DoctorDashboard)
      },
      {
        path: 'appointments',
        title: 'Doctor Appointments - HealthAxis',
        loadComponent: () =>
          import('./doctor/appointments/appointments').then(m => m.Appointments)
      },
      {
        path: 'health-records',
        title: 'Doctor Health Records - HealthAxis',
        loadComponent: () =>
          import('./doctor/health-records/health-records').then(m => m.HealthRecords)
      },
      {
        path: 'patient-history',
        title: 'Patient History - HealthAxis',
        loadComponent: () =>
          import('./doctor/patient-history/patient-history').then(m => m.PatientHistory)
      },
      {
        path: 'profile',
        title: 'Doctor Profile - HealthAxis',
        loadComponent: () =>
          import('./doctor/profile/profile').then(m => m.Profile)
      }
    ]
  },
  {
    path: 'logout',
    title: 'Logout - HealthAxis',
    loadComponent: () =>
      import('./pages/logout/logout').then(m => m.Logout)
  },
  {
    path: '**',
    title: 'Page Not Found - HealthAxis',
    loadComponent: () =>
      import('./pages/not-found/not-found').then(m => m.NotFound)
  }
];
