import { Component, OnInit, inject } from '@angular/core';
import { Router, RouterLink } from '@angular/router';

@Component({
  selector: 'app-logout',
  imports: [RouterLink],
  templateUrl: './logout.html',
  styleUrl: './logout.css'
})
export class Logout implements OnInit {
  private readonly router = inject(Router);

  ngOnInit(): void {
    this.clearSessionData();
  }

  goToLogin(): void {
    this.router.navigate(['/login']);
  }

  goToHome(): void {
    this.router.navigate(['/']);
  }

  private clearSessionData(): void {
    localStorage.removeItem('accessToken');
    localStorage.removeItem('token');
    localStorage.removeItem('authToken');
    localStorage.removeItem('role');
    localStorage.removeItem('userRole');
    localStorage.removeItem('currentUser');

    sessionStorage.removeItem('accessToken');
    sessionStorage.removeItem('token');
    sessionStorage.removeItem('authToken');
    sessionStorage.removeItem('role');
    sessionStorage.removeItem('userRole');
    sessionStorage.removeItem('currentUser');
  }
}
