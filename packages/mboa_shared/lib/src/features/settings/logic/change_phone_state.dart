part of 'change_phone_bloc.dart';

enum ChangePhoneError {
  requestFailed,

  /// `CURRENT_PHONE_MISMATCH` — not the account's number; said under it.
  currentMismatch,

  /// `PHONE_UNCHANGED` — the new number is the current one.
  unchanged,

  /// `PHONE_ALREADY_USED` — another account holds the new number.
  alreadyUsed,

  invalidCode,

  /// Three wrong tries, or expired: only new codes help.
  codeBurnt,
}

sealed class ChangePhoneState extends Equatable {
  const ChangePhoneState();

  @override
  List<Object?> get props => [];
}

/// Step 1 — entering the new phone number.
final class ChangePhoneEnterPhone extends ChangePhoneState {
  const ChangePhoneEnterPhone({this.loading = false, this.error});

  final bool loading;
  final ChangePhoneError? error;

  @override
  List<Object?> get props => [loading, error];
}

/// Step 2 — entering the two OTP codes, one per number.
final class ChangePhoneEnterCodes extends ChangePhoneState {
  const ChangePhoneEnterCodes({
    required this.currentPhoneNumber,
    required this.newPhoneNumber,
    this.loading = false,
    this.error,
    this.justResent = false,
  });

  final String currentPhoneNumber;
  final String newPhoneNumber;
  final bool loading;
  final ChangePhoneError? error;
  final bool justResent;

  @override
  List<Object?> get props => [currentPhoneNumber, newPhoneNumber, loading, error, justResent];
}

final class ChangePhoneSuccess extends ChangePhoneState {
  const ChangePhoneSuccess();
}
