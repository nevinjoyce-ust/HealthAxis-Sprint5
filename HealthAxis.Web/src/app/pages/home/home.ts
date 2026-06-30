import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';

import { DoctorSlotSearch } from '../../shared/components/doctor-slot-search/doctor-slot-search';

@Component({
  selector: 'app-home',
  imports: [RouterLink, DoctorSlotSearch],
  templateUrl: './home.html',
  styleUrl: './home.css'
})
export class Home {}