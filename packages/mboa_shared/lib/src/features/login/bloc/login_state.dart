part of 'login_bloc.dart';

/// Why the login flow failed. The UI maps this to a localised message — the
/// logic layer never holds user-facing text.
enum LoginError { otpRequestFailed, invalidCode }

/// Observable states of the shared login flow.
sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

/// Idle — awaiting a phone number.
final class LoginInitial extends LoginState {
  const LoginInitial();
}

/// An OTP request or code verification is in flight.
final class LoginInProgress extends LoginState {
  const LoginInProgress();
}

/// OTP sent; awaiting the code for [session].
final class LoginOtpSent extends LoginState {
  const LoginOtpSent(this.session);

  final OtpSession session;

  @override
  List<Object?> get props => [session];
}

/// Verification succeeded and tokens were persisted. The host app promotes the
/// session on its own AuthBloc in response.
final class LoginSuccess extends LoginState {
  const LoginSuccess();
}

/// The last action failed; [error] is mapped to a localised message by the UI.
final class LoginFailure extends LoginState {
  const LoginFailure(this.error, {this.session});

  final LoginError error;

  /// Preserved so the OTP screen stays usable after a bad code.
  final OtpSession? session;

  @override
  List<Object?> get props => [error, session];
}
