export const AppRoles = {
  Patient: 'Patient',
  Doctor: 'Doctor',
  Admin: 'Admin'
} as const;

export type AppRole = typeof AppRoles[keyof typeof AppRoles];

export const AppRoleValues: readonly AppRole[] = [
  AppRoles.Patient,
  AppRoles.Doctor,
  AppRoles.Admin
] as const;

export function isAppRole(value: unknown): value is AppRole {
  return typeof value === 'string' &&
    AppRoleValues.some(role => role.toLowerCase() === value.toLowerCase());
}

export function normalizeAppRole(value: unknown): AppRole | null {
  if (typeof value !== 'string') {
    return null;
  }

  return AppRoleValues.find(role => role.toLowerCase() === value.toLowerCase()) ?? null;
}
