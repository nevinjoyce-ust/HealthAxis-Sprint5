import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';

interface PublicDoctor {
  id: number;
  fullName: string;
  specialisation: string;
  experienceYears: number;
  consultationFee: number;
  isAvailable: boolean;
}

@Component({
  selector: 'app-home',
  imports: [RouterLink],
  templateUrl: './home.html',
  styleUrl: './home.css'
})
export class Home {
  doctors: PublicDoctor[] = [
    {
      id: 1,
      fullName: 'Dr. Arjun Menon',
      specialisation: 'Cardiology',
      experienceYears: 12,
      consultationFee: 700,
      isAvailable: true
    },
    {
      id: 2,
      fullName: 'Dr. Meera Nair',
      specialisation: 'Dermatology',
      experienceYears: 8,
      consultationFee: 500,
      isAvailable: true
    },
    {
      id: 3,
      fullName: 'Dr. Rahul Thomas',
      specialisation: 'Orthopaedics',
      experienceYears: 10,
      consultationFee: 650,
      isAvailable: false
    }
  ];
}
