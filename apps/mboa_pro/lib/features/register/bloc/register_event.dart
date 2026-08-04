part of 'register_bloc.dart';

/// Events for the Pro professional registration flow.
sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

/// Step 1 submitted — create the account for [role] with these details.
final class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted({
    required this.role,
    required this.email,
    required this.password,
    required this.phone,
  });

  final ProfessionalRole role;
  final String email;
  final String password;
  final String phone;

  @override
  List<Object?> get props => [role, email, password, phone];
}

/// Step 2 submitted — verify the phone OTP [code].
final class RegisterOtpSubmitted extends RegisterEvent {
  const RegisterOtpSubmitted(this.code);

  final String code;

  @override
  List<Object?> get props => [code];
}

/// Request a fresh OTP for the retained phone number.
final class RegisterOtpResent extends RegisterEvent {
  const RegisterOtpResent();
}

/// Return from the OTP step to the details step.
final class RegisterBackToDetails extends RegisterEvent {
  const RegisterBackToDetails();
}
