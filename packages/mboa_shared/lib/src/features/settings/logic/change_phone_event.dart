part of 'change_phone_bloc.dart';

sealed class ChangePhoneEvent extends Equatable {
  const ChangePhoneEvent();

  @override
  List<Object?> get props => [];
}

/// Step 1 — request a change to [newPhoneNumber] (OTP sent to old + new).
final class ChangePhoneRequested extends ChangePhoneEvent {
  const ChangePhoneRequested(this.newPhoneNumber);

  final String newPhoneNumber;

  @override
  List<Object?> get props => [newPhoneNumber];
}

/// Re-send both codes.
final class ChangePhoneResent extends ChangePhoneEvent {
  const ChangePhoneResent();
}

/// Step 2 — confirm with the code from the old number and the new number.
final class ChangePhoneConfirmed extends ChangePhoneEvent {
  const ChangePhoneConfirmed({required this.oldCode, required this.newCode});

  final String oldCode;
  final String newCode;

  @override
  List<Object?> get props => [oldCode, newCode];
}

/// Return from the code step to the phone step.
final class ChangePhoneBack extends ChangePhoneEvent {
  const ChangePhoneBack();
}
