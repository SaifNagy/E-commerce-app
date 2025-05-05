part of 'auth_cubit.dart';

sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}
final class AuthDone extends AuthState {
  const AuthDone();
}
final class AuthError extends AuthState {
  final String errorMessage;

  const AuthError(this.errorMessage);
}
final class AuthLoggedout extends AuthState {
  const AuthLoggedout();
}
final class AuthLoggingout extends AuthState {
  const AuthLoggingout();
}

final class AuthLoggingoutError extends AuthState {
  final String errorMessage;

  const AuthLoggingoutError(this.errorMessage);
}
final class GoogleAuthenticating extends AuthState {
  const GoogleAuthenticating();
}
final class GoogleAuthError extends AuthState {
  final String errorMessage;
  const GoogleAuthError(this.errorMessage);
}
final class GoogleAuthDone extends AuthState {
  const GoogleAuthDone();
}
