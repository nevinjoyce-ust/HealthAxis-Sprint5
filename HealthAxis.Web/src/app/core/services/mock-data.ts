import { Injectable } from '@angular/core';
import {
  Appointment,
  DoctorAvailableSlots,
  HealthRecord,
  PublicDoctor
} from '../../shared/models/health-axis.models';

@Injectable({
  providedIn: 'root'
})
export class MockData {
  getPublicDoctors(): PublicDoctor[] {
    return [
      {
        id: 1,
        fullName: 'Anjali Menon',
        specialisation: 'Cardiology',
        yearsOfExperience: 11,
        consultationFee: 600,
        isAvailable: true
      },
      {
        id: 2,
        fullName: 'Rahul Nair',
        specialisation: 'Dermatology',
        yearsOfExperience: 7,
        consultationFee: 500,
        isAvailable: true
      },
      {
        id: 3,
        fullName: 'Meera Pillai',
        specialisation: 'Orthopaedics',
        yearsOfExperience: 14,
        consultationFee: 750,
        isAvailable: true
      },
      {
        id: 4,
        fullName: 'Arjun Varma',
        specialisation: 'Cardiology',
        yearsOfExperience: 5,
        consultationFee: 450,
        isAvailable: false
      }
    ];
  }

  getDoctorAvailableSlots(): DoctorAvailableSlots[] {
    return [
      {
        doctorId: 1,
        doctorName: 'Anjali Menon',
        specialisation: 'Cardiology',
        yearsOfExperience: 11,
        consultationFee: 600,
        isAvailable: true,
        availableSlots: ['09:00:00', '09:30:00', '10:00:00', '14:00:00']
      },
      {
        doctorId: 2,
        doctorName: 'Rahul Nair',
        specialisation: 'Dermatology',
        yearsOfExperience: 7,
        consultationFee: 500,
        isAvailable: true,
        availableSlots: ['10:30:00', '11:00:00', '15:30:00']
      },
      {
        doctorId: 3,
        doctorName: 'Meera Pillai',
        specialisation: 'Orthopaedics',
        yearsOfExperience: 14,
        consultationFee: 750,
        isAvailable: true,
        availableSlots: ['09:30:00', '13:00:00', '16:00:00']
      }
    ];
  }

  getPatientAppointments(): Appointment[] {
    return [
      {
        id: 1,
        patientId: 1,
        doctorId: 1,
        patientName: 'Nevin Joyce',
        doctorName: 'Anjali Menon',
        appointmentDate: this.addDays(0),
        appointmentTime: '09:30:00',
        status: 'Confirmed',
        cancellationReason: null,
        healthRecordId: null
      },
      {
        id: 2,
        patientId: 1,
        doctorId: 2,
        patientName: 'Nevin Joyce',
        doctorName: 'Rahul Nair',
        appointmentDate: this.addDays(3),
        appointmentTime: '10:30:00',
        status: 'Confirmed',
        cancellationReason: null,
        healthRecordId: null
      },
      {
        id: 3,
        patientId: 1,
        doctorId: 3,
        patientName: 'Nevin Joyce',
        doctorName: 'Meera Pillai',
        appointmentDate: this.addDays(4),
        appointmentTime: '13:00:00',
        status: 'Pending',
        cancellationReason: null,
        healthRecordId: null
      },
      {
        id: 4,
        patientId: 1,
        doctorId: 1,
        patientName: 'Nevin Joyce',
        doctorName: 'Anjali Menon',
        appointmentDate: this.addDays(5),
        appointmentTime: '09:00:00',
        status: 'Cancelled',
        cancellationReason: 'Automatically cancelled because the appointment was not confirmed in time.',
        healthRecordId: null
      },
      {
        id: 5,
        patientId: 1,
        doctorId: 1,
        patientName: 'Nevin Joyce',
        doctorName: 'Anjali Menon',
        appointmentDate: this.addDays(-2),
        appointmentTime: '09:00:00',
        status: 'Completed',
        cancellationReason: null,
        healthRecordId: 101
      },
      {
        id: 6,
        patientId: 1,
        doctorId: 2,
        patientName: 'Nevin Joyce',
        doctorName: 'Rahul Nair',
        appointmentDate: this.addDays(-4),
        appointmentTime: '10:00:00',
        status: 'Completed',
        cancellationReason: null,
        healthRecordId: 102
      },
      {
        id: 7,
        patientId: 1,
        doctorId: 3,
        patientName: 'Nevin Joyce',
        doctorName: 'Meera Pillai',
        appointmentDate: this.addDays(-6),
        appointmentTime: '14:00:00',
        status: 'Cancelled',
        cancellationReason: 'Patient requested reschedule. - Cancelled by patient',
        healthRecordId: null
      }
    ];
  }

  getFuturePatientAppointments(): Appointment[] {
    const today = this.todayDateOnly();

    return this.getPatientAppointments()
      .filter(appointment => appointment.appointmentDate >= today)
      .sort((first, second) => this.compareAppointmentDateTime(first, second));
  }

  getPastPatientAppointments(): Appointment[] {
    const today = this.todayDateOnly();

    return this.getPatientAppointments()
      .filter(appointment => appointment.appointmentDate < today)
      .sort((first, second) => this.compareAppointmentDateTime(second, first));
  }

  getPatientHealthRecords(): HealthRecord[] {
    return [
      {
        id: 101,
        appointmentId: 5,
        patientId: 1,
        doctorId: 1,
        patientName: 'Nevin Joyce',
        doctorName: 'Anjali Menon',
        visitDate: this.addDays(-2),
        diagnosis: 'Hypertension follow-up',
        prescription: 'Antihypertensive therapy continued',
        notes: 'Blood pressure trend reviewed; lifestyle measures reinforced.'
      },
      {
        id: 102,
        appointmentId: 6,
        patientId: 1,
        doctorId: 2,
        patientName: 'Nevin Joyce',
        doctorName: 'Rahul Nair',
        visitDate: this.addDays(-4),
        diagnosis: 'Skin allergy review',
        prescription: 'Topical treatment advised',
        notes: 'Patient advised to avoid known triggers.'
      }
    ].sort((first, second) => second.visitDate.localeCompare(first.visitDate));
  }

  private addDays(days: number): string {
    const date = new Date();
    date.setHours(0, 0, 0, 0);
    date.setDate(date.getDate() + days);

    return date.toISOString().split('T')[0];
  }

  private todayDateOnly(): string {
    return this.addDays(0);
  }

  private compareAppointmentDateTime(first: Appointment, second: Appointment): number {
    return `${first.appointmentDate}T${first.appointmentTime}`
      .localeCompare(`${second.appointmentDate}T${second.appointmentTime}`);
  }
}
