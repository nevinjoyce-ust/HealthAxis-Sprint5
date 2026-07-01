export interface LoginRequest {
  email: string;
  password: string;
}

export interface RegisterRequest {
  fullName: string;
  email: string;
  phoneNumber: string;
  password: string;
  confirmPassword: string;
  dateOfBirth: string;
  gender: string;
  address: string;
}

export interface AuthResponse {
  accessToken: string;
  message: string;
  expiresIn: number;
  userId: string;
  patientId: number | null;
  doctorId: number | null;
  email: string;
  role: string;
}

export interface RegisterResponse {
  message: string;
  userId: string;
}

export interface JwtPayload {
  exp?: number;
  email?: string;
  sub?: string;
  role?: string | string[];
  roles?: string | string[];
  userId?: string;
  patientId?: string;
  doctorId?: string;
  [claim: string]: unknown;
}
