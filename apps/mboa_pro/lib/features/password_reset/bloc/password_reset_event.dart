part of 'password_reset_bloc.dart';

sealed class PasswordResetEvent extends Equatable {
  const PasswordResetEvent();

  @override
  List<Object?> get props => [];
}

/// Send a code for this email.
final class PasswordResetRequested extends PasswordResetEvent {
  const PasswordResetRequested(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

final class PasswordResetCodeResent extends PasswordResetEvent {
  const PasswordResetCodeResent();
}

final class PasswordResetSubmitted extends PasswordResetEvent {
  const PasswordResetSubmitted({required this.code, required this.newPassword});

  final String code;
  final String newPassword;

  @override
  List<Object?> get props => [code, newPassword];
}

/// A wrong email typed: back to the first step.
final class PasswordResetBackToEmail extends PasswordResetEvent {
  const PasswordResetBackToEmail();
}
