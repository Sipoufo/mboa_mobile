part of 'login_bloc.dart';

/// Events for the shared SMS-OTP login flow.
sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

/// User asked for a code, sent to [phoneNumber] or, since §40 A, [email].
final class LoginOtpRequested extends LoginEvent {
  const LoginOtpRequested({this.phoneNumber, this.email});

  final String? phoneNumber;
  final String? email;

  @override
  List<Object?> get props => [phoneNumber, email];
}

/// User asked to re-send the code for the pending [session].
final class LoginOtpResendRequested extends LoginEvent {
  const LoginOtpResendRequested(this.session);

  final OtpSession session;

  @override
  List<Object?> get props => [session];
}

/// User submitted [code] for the pending [session].
final class LoginCodeSubmitted extends LoginEvent {
  const LoginCodeSubmitted({required this.session, required this.code});

  final OtpSession session;
  final String code;

  @override
  List<Object?> get props => [session, code];
}
