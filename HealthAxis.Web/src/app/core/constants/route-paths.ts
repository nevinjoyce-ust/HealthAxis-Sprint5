import { AppRole, AppRoles } from '../../shared/models/role.model';

export const AppRoutes = {
  Home: '/',
  Login: '/login',
  Register: '/register',
  Logout: '/logout',
  PatientDashboard: '/patient/dashboard',
  DoctorDashboard: '/doctor/dashboard'
} as const;

export const RoleDashboardRoutes: Record<AppRole, string | null> = {
  [AppRoles.Patient]: AppRoutes.PatientDashboard,
  [AppRoles.Doctor]: AppRoutes.DoctorDashboard,
  [AppRoles.Admin]: null
};
