import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';

import { AppRoutes, RoleDashboardRoutes } from '../constants/route-paths';
import { AuthService } from '../services/auth-service';
import { AppRole } from '../../shared/models/role.model';

export const roleGuard: CanActivateFn = route => {
  const auth = inject(AuthService);
  const router = inject(Router);

  if (!auth.isLoggedIn()) {
    return router.createUrlTree([AppRoutes.Login], {
      queryParams: { reason: 'unauthorized' }
    });
  }

  const allowedRoles = (route.data?.['roles'] as readonly AppRole[] | undefined) ?? [];

  if (allowedRoles.length === 0) {
    return true;
  }

  const currentRole = auth.getUserRole();

  if (!currentRole) {
    return router.createUrlTree([AppRoutes.Login], {
      queryParams: { reason: 'unauthorized' }
    });
  }

  if (allowedRoles.includes(currentRole)) {
    return true;
  }

  const dashboardUrl = RoleDashboardRoutes[currentRole];

  if (dashboardUrl) {
    return router.createUrlTree([dashboardUrl]);
  }

  return router.createUrlTree([AppRoutes.Login], {
    queryParams: { reason: 'forbidden' }
  });
};
