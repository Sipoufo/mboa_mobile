part of 'login_bloc.dart';

/// Events for the shared SMS-OTP login flow.
sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

/// User asked for an OTP to be sent to [phoneNumber].
final class LoginOtpRequested extends LoginEvent {
  const LoginOtpRequested(this.phoneNumber);

  final String phoneNumber;

  @override
  List<Object?> get props => [phoneNumber];
}

/// User asked to re-send the OTP for an already-pending [phoneNumber].
final class LoginOtpResendRequested extends LoginEvent {
  const LoginOtpResendRequested(this.phoneNumber);

  final String phoneNumber;

  @override
  List<Object?> get props => [phoneNumber];
}

/// User submitted [code] for the pending [session].
final class LoginCodeSubmitted extends LoginEvent {
  const LoginCodeSubmitted({required this.session, required this.code});

  final OtpSession session;
  final String code;

  @override
  List<Object?> get props => [session, code];
}
