import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';

import { AuthService } from '../services/auth-service';

export const roleGuard: CanActivateFn = route => {
  const auth = inject(AuthService);
  const router = inject(Router);

  if (!auth.isLoggedIn()) {
    return router.createUrlTree(['/login'], {
      queryParams: { reason: 'unauthorized' }
    });
  }

  const allowedRoles = (route.data?.['roles'] as string[] | undefined) ?? [];

  if (allowedRoles.length === 0) {
    return true;
  }

  const currentRole = auth.getUserRole();

  if (!currentRole) {
    return router.createUrlTree(['/login'], {
      queryParams: { reason: 'unauthorized' }
    });
  }

  const hasAllowedRole = allowedRoles.some(
    role => role.toLowerCase() === currentRole.toLowerCase()
  );

  if (hasAllowedRole) {
    return true;
  }

  return router.createUrlTree(['/login'], {
    queryParams: { reason: 'forbidden' }
  });
};