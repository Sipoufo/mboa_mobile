part of 'credential_login_bloc.dart';

/// Events for the Pro credential login flow.
sealed class CredentialLoginEvent extends Equatable {
  const CredentialLoginEvent();

  @override
  List<Object?> get props => [];
}

/// Step 1 submitted — verify [email] + [password].
final class CredentialLoginSubmitted extends CredentialLoginEvent {
  const CredentialLoginSubmitted({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

/// Step 2 submitted — verify the emailed OTP [code].
final class CredentialLoginOtpSubmitted extends CredentialLoginEvent {
  const CredentialLoginOtpSubmitted(this.code);

  final String code;

  @override
  List<Object?> get props => [code];
}

/// Resend the OTP by replaying the login call with the retained credentials.
final class CredentialLoginOtpResent extends CredentialLoginEvent {
  const CredentialLoginOtpResent();
}

/// Return from the OTP step to the credentials step.
final class CredentialLoginBackToCredentials extends CredentialLoginEvent {
  const CredentialLoginBackToCredentials();
}
