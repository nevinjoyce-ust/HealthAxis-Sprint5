import { DoctorSpecialisation } from '../models/health-axis.models';

export type DoctorSortOption = 'name' | 'experience' | 'fee';
export type DoctorSortBy = 'Name' | 'Experience' | 'Fee';
export type SortDirection = 'Asc' | 'Desc';

export const doctorSpecialisations: DoctorSpecialisation[] = [
  'Cardiology',
  'Dermatology',
  'Neurology',
  'Orthopaedics',
  'Pediatrics',
  'GeneralMedicine',
  'Psychiatry',
  'Radiology',
  'Gynecology',
  'ENT'
];

export function formatSpecialisation(specialisation: DoctorSpecialisation): string {
  return specialisation === 'GeneralMedicine'
    ? 'General Medicine'
    : specialisation;
}

export function normalizeSpecialisation(value: DoctorSpecialisation | number): DoctorSpecialisation {
  if (typeof value === 'string') {
    return value;
  }

  return doctorSpecialisations[value] ?? 'GeneralMedicine';
}

export function normalizeDoctorSpecialisation<T extends { specialisation: DoctorSpecialisation | number }>(doctor: T): T {
  return {
    ...doctor,
    specialisation: normalizeSpecialisation(doctor.specialisation)
  };
}

export function isValidSpecialisation(value: string | null): value is DoctorSpecialisation {
  return doctorSpecialisations.includes(value as DoctorSpecialisation);
}

export function toApiDoctorSortBy(sortBy: DoctorSortOption): DoctorSortBy {
  switch (sortBy) {
    case 'fee':
      return 'Fee';
    case 'experience':
      return 'Experience';
    default:
      return 'Name';
  }
}

export function toApiSortDirection(sortBy: DoctorSortOption): SortDirection {
  return sortBy === 'experience'
    ? 'Desc'
    : 'Asc';
}

export function isValidDoctorSort(value: string | null): value is DoctorSortOption {
  return value === 'name' || value === 'experience' || value === 'fee';
}