part of 'password_reset_bloc.dart';

enum PasswordResetError { wrongCode, expired, tooManyAttempts, failed }

sealed class PasswordResetState extends Equatable {
  const PasswordResetState();

  @override
  List<Object?> get props => [];
}

/// Step 1 — the account's email.
final class PasswordResetEnterEmail extends PasswordResetState {
  const PasswordResetEnterEmail({this.loading = false, this.error});

  final bool loading;
  final PasswordResetError? error;

  @override
  List<Object?> get props => [loading, error];
}

/// Step 2 — the SMS code and the new password.
final class PasswordResetEnterCode extends PasswordResetState {
  const PasswordResetEnterCode({
    required this.email,
    this.loading = false,
    this.error,
    this.justResent = false,
  });

  final String email;
  final bool loading;
  final PasswordResetError? error;
  final bool justResent;

  @override
  List<Object?> get props => [email, loading, error, justResent];
}

/// Changed; every session was closed server-side.
final class PasswordResetDone extends PasswordResetState {
  const PasswordResetDone({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}
