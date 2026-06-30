export type AppointmentStatus =
  | 'Pending'
  | 'Confirmed'
  | 'Cancelled'
  | 'Completed';

export type DoctorSpecialisation =
  | 'Cardiology'
  | 'Dermatology'
  | 'Neurology'
  | 'Orthopaedics'
  | 'Pediatrics'
  | 'GeneralMedicine'
  | 'Psychiatry'
  | 'Radiology'
  | 'Gynecology'
  | 'ENT';

export interface PublicDoctor {
  id: number;
  fullName: string;
  specialisation: DoctorSpecialisation;
  yearsOfExperience: number;
  consultationFee: number;
  isAvailable: boolean;
}

export interface DoctorAvailableSlots {
  doctorId: number;
  doctorName: string;
  specialisation: DoctorSpecialisation;
  yearsOfExperience: number;
  consultationFee: number;
  isAvailable: boolean;
  availableSlots: string[];
}

export interface Appointment {
  id: number;
  patientId: number;
  doctorId: number;
  patientName: string;
  doctorName: string;
  appointmentDate: string;
  appointmentTime: string;
  status: AppointmentStatus;
  cancellationReason?: string | null;
  healthRecordId?: number | null;
}

export interface HealthRecord {
  id: number;
  appointmentId: number;
  patientId: number;
  doctorId: number;
  patientName: string;
  doctorName: string;
  visitDate: string;
  diagnosis: string;
  prescription: string;
  notes?: string | null;
}