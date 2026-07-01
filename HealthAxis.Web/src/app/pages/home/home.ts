import { Component, inject } from '@angular/core';
import { RouterLink } from '@angular/router';

import { AuthService } from '../../core/services/auth-service';
import { DoctorSlotSearch } from '../../shared/components/doctor-slot-search/doctor-slot-search';

@Component({
  selector: 'app-home',
  imports: [RouterLink, DoctorSlotSearch],
  templateUrl: './home.html',
  styleUrl: './home.css'
})
export class Home {
  private readonly auth = inject(AuthService);

  get isLoggedIn(): boolean {
    return this.auth.isLoggedIn();
  }
}
