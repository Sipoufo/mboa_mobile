part of 'login_bloc.dart';

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

/// The last action failed; [message] is user-presentable.
final class LoginFailure extends LoginState {
  const LoginFailure(this.message, {this.session});

  final String message;

  /// Preserved so the OTP screen stays usable after a bad code.
  final OtpSession? session;

  @override
  List<Object?> get props => [message, session];
}
