import { Appointment } from '../models/health-axis.models';

export function formatDate(date: string): string {
  return new Date(`${date}T00:00:00`).toLocaleDateString('en-IN', {
    day: '2-digit',
    month: 'short',
    year: 'numeric'
  });
}

export function formatTime(time: string): string {
  return time.slice(0, 5);
}

export function formatDateOnly(date: Date): string {
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, '0');
  const day = String(date.getDate()).padStart(2, '0');

  return `${year}-${month}-${day}`;
}

export function todayDateOnly(): string {
  return formatDateOnly(new Date());
}

export function addDaysDateOnly(days: number): string {
  const date = new Date();
  date.setDate(date.getDate() + days);

  return formatDateOnly(date);
}

export function addMonthsDateOnly(months: number): string {
  const date = new Date();
  date.setMonth(date.getMonth() + months);

  return formatDateOnly(date);
}

export function compareAppointmentDateTime(first: Appointment, second: Appointment): number {
  const firstDateTime = `${first.appointmentDate}T${first.appointmentTime}`;
  const secondDateTime = `${second.appointmentDate}T${second.appointmentTime}`;

  return firstDateTime.localeCompare(secondDateTime);
}

export function compareAppointmentDateTimeDescending(first: Appointment, second: Appointment): number {
  const firstDateTime = `${first.appointmentDate}T${first.appointmentTime}`;
  const secondDateTime = `${second.appointmentDate}T${second.appointmentTime}`;

  return secondDateTime.localeCompare(firstDateTime);
}

export function hoursUntilAppointment(appointment: Appointment): number {
  const appointmentTime = new Date(`${appointment.appointmentDate}T${appointment.appointmentTime}`).getTime();

  return (appointmentTime - Date.now()) / 36e5;
}