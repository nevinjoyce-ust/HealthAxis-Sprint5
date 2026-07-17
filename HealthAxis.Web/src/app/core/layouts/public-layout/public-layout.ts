import { Component, inject } from '@angular/core';
import { Router, RouterLink, RouterOutlet } from '@angular/router';

import { AuthService } from '../../services/auth-service';

@Component({
  selector: 'app-public-layout',
  imports: [RouterOutlet, RouterLink],
  templateUrl: './public-layout.html',
  styleUrl: './public-layout.css'
})
export class PublicLayout {
  private readonly auth = inject(AuthService);
  private readonly router = inject(Router);

  get showLoggedInPublicActions(): boolean {
  return this.auth.isLoggedIn() &&
    this.auth.getDashboardUrl() !== null;
}

  logout(): void {
    this.auth.logout();
  }

  scrollToDoctors(): void {
    this.router.navigate(['/'], { fragment: 'doctors' }).then(() => {
      setTimeout(() => {
        document
          .getElementById('doctors')
          ?.scrollIntoView({ behavior: 'smooth', block: 'start' });
      });
    });
  }
}
