part of 'auth_bloc.dart';

/// Events for the global session gate.
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Fired at startup to decide between the authenticated and login flows.
final class AuthStarted extends AuthEvent {
  const AuthStarted();
}

/// The shared login flow persisted tokens — promote the session.
final class AuthSessionEstablished extends AuthEvent {
  const AuthSessionEstablished();
}

/// Clean logout (also triggered by the interceptor on refresh failure).
final class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}
