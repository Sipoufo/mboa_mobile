part of 'change_phone_bloc.dart';

enum ChangePhoneError { requestFailed, invalidCode }

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

/// Step 2 — entering the two OTP codes for [newPhoneNumber].
final class ChangePhoneEnterCodes extends ChangePhoneState {
  const ChangePhoneEnterCodes({
    required this.newPhoneNumber,
    this.loading = false,
    this.error,
    this.justResent = false,
  });

  final String newPhoneNumber;
  final bool loading;
  final ChangePhoneError? error;
  final bool justResent;

  @override
  List<Object?> get props => [newPhoneNumber, loading, error, justResent];
}

final class ChangePhoneSuccess extends ChangePhoneState {
  const ChangePhoneSuccess();
}
