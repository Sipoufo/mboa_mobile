part of 'credential_login_bloc.dart';

/// Why a credential-login step failed. The UI maps this to a localised message.
enum CredentialLoginError { invalidCredentials, invalidCode, otpResendFailed }

/// Observable states of the Pro credential login flow. The two `Enter*` states
/// double as the flow's step indicator (which screen to render).
sealed class CredentialLoginState extends Equatable {
  const CredentialLoginState();

  @override
  List<Object?> get props => [];
}

/// Step 1 — the email/password form.
final class CredentialLoginEnterCredentials extends CredentialLoginState {
  const CredentialLoginEnterCredentials({this.loading = false, this.error});

  final bool loading;
  final CredentialLoginError? error;

  @override
  List<Object?> get props => [loading, error];
}

/// Step 2 — the email OTP entry for [email].
final class CredentialLoginEnterOtp extends CredentialLoginState {
  const CredentialLoginEnterOtp({
    required this.email,
    this.loading = false,
    this.error,
    this.justResent = false,
  });

  final String email;
  final bool loading;
  final CredentialLoginError? error;
  final bool justResent;

  @override
  List<Object?> get props => [email, loading, error, justResent];
}

/// Verification succeeded and tokens were persisted; the app promotes the
/// session on its [AuthBloc].
final class CredentialLoginSuccess extends CredentialLoginState {
  const CredentialLoginSuccess();
}
