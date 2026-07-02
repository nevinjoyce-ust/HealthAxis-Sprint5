import { Component, inject } from '@angular/core';
import { Router } from '@angular/router';

import { AppRoutes } from '../../core/constants/route-paths';
import { AuthService } from '../../core/services/auth-service';

@Component({
  selector: 'app-logout',
  templateUrl: './logout.html',
  styleUrl: './logout.css'
})
export class Logout {
  private readonly auth = inject(AuthService);
  private readonly router = inject(Router);

  constructor() {
    this.auth.clearSession();

    this.router.navigate([AppRoutes.Login], {
      queryParams: { reason: 'logged-out' },
      replaceUrl: true
    });
  }
}
