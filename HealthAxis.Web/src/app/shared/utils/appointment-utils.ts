import { AppointmentStatus } from '../models/health-axis.models';

export const appointmentStatuses: AppointmentStatus[] = [
  'Pending',
  'Confirmed',
  'Cancelled',
  'Completed'
];

export function normalizeAppointmentStatus(value: AppointmentStatus | number): AppointmentStatus {
  if (typeof value === 'string') {
    return value;
  }

  return appointmentStatuses[value] ?? 'Pending';
}

export function toAppointmentStatusNumber(status: AppointmentStatus): number {
  return appointmentStatuses.indexOf(status);
}

export function isValidAppointmentStatus(value: string): value is AppointmentStatus {
  return appointmentStatuses.includes(value as AppointmentStatus);
}

export function parseAppointmentStatuses(value: string | null): AppointmentStatus[] {
  if (!value) {
    return [];
  }

  return value
    .split(',')
    .filter(status => isValidAppointmentStatus(status));
}