import { HttpErrorResponse, HttpInterceptorFn } from '@angular/common/http';
import { inject } from '@angular/core';
import { Router } from '@angular/router';
import { catchError, throwError } from 'rxjs';

import { API_BASE_URL } from '../constants/api-constants';
import { AuthService } from '../services/auth-service';

export const authInterceptor: HttpInterceptorFn = (request, next) => {
  const auth = inject(AuthService);
  const router = inject(Router);

  const token = auth.getAccessToken();
  const isApiRequest = request.url.startsWith(API_BASE_URL);

  const shouldAttachToken = token &&
    isApiRequest &&
    !isAuthEndpoint(request.url);

  const authenticatedRequest = shouldAttachToken
    ? request.clone({
        setHeaders: {
          Authorization: `Bearer ${token}`
        }
      })
    : request;

  return next(authenticatedRequest).pipe(
    catchError(error => {
      if (
        error instanceof HttpErrorResponse &&
        error.status === 401 &&
        shouldRedirectOnUnauthorized(request.url)
      ) {
        auth.clearSession();

        router.navigate(['/login'], {
          queryParams: { reason: 'unauthorized' }
        });
      }

      return throwError(() => error);
    })
  );
};

function isAuthEndpoint(url: string): boolean {
  const lowerUrl = url.toLowerCase();

  return lowerUrl.includes('/auth/login') ||
    lowerUrl.includes('/auth/register');
}

function shouldRedirectOnUnauthorized(url: string): boolean {
  return !isAuthEndpoint(url);
}
