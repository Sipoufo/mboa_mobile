part of 'register_bloc.dart';

/// Why a registration step failed. The UI maps this to a localised message.
enum RegisterError { registrationFailed, invalidCode, otpResendFailed }

/// Observable states of the Pro registration flow. The two `Enter*` states
/// double as the flow's step indicator (which screen to render).
sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

/// Step 1 — the role + email + password + phone form.
final class RegisterEnterDetails extends RegisterState {
  const RegisterEnterDetails({this.loading = false, this.error});

  final bool loading;
  final RegisterError? error;

  @override
  List<Object?> get props => [loading, error];
}

/// Step 2 — the phone OTP entry for [phone].
final class RegisterEnterOtp extends RegisterState {
  const RegisterEnterOtp({
    required this.phone,
    this.loading = false,
    this.error,
    this.justResent = false,
  });

  final String phone;
  final bool loading;
  final RegisterError? error;
  final bool justResent;

  @override
  List<Object?> get props => [phone, loading, error, justResent];
}

/// Registration succeeded and tokens were persisted; the app promotes the
/// session on its [AuthBloc].
final class RegisterSuccess extends RegisterState {
  const RegisterSuccess();
}
