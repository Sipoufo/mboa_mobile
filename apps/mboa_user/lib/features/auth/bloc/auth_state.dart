part of 'auth_bloc.dart';

/// Observable states of the session gate.
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Startup — session status not yet known.
final class AuthInitial extends AuthState {
  const AuthInitial();
}

/// A valid session exists — the user is signed in.
final class AuthAuthenticated extends AuthState {
  const AuthAuthenticated();
}

/// No valid session — show the login flow.
final class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}
