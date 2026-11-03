part of 'change_phone_bloc.dart';

sealed class ChangePhoneEvent extends Equatable {
  const ChangePhoneEvent();

  @override
  List<Object?> get props => [];
}

/// Step 1 — the number the account has now, then the one it moves to (OTP
/// sent to both). RM-M02-02: the current one is typed first.
final class ChangePhoneRequested extends ChangePhoneEvent {
  const ChangePhoneRequested({this.currentPhoneNumber, required this.newPhoneNumber});

  /// Null: §40 A — an account made by email adds its first number.
  final String? currentPhoneNumber;
  final String newPhoneNumber;

  @override
  List<Object?> get props => [currentPhoneNumber, newPhoneNumber];
}

/// Re-send both codes.
final class ChangePhoneResent extends ChangePhoneEvent {
  const ChangePhoneResent();
}

/// Step 2 — confirm with the code from the old number and the new number.
final class ChangePhoneConfirmed extends ChangePhoneEvent {
  const ChangePhoneConfirmed({this.oldCode, required this.newCode});

  /// Null when there was no number before.
  final String? oldCode;
  final String newCode;

  @override
  List<Object?> get props => [oldCode, newCode];
}

/// Return from the code step to the phone step.
final class ChangePhoneBack extends ChangePhoneEvent {
  const ChangePhoneBack();
}
