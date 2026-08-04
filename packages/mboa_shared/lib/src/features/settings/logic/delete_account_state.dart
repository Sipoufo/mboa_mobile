part of 'delete_account_cubit.dart';

sealed class DeleteAccountState extends Equatable {
  const DeleteAccountState();

  @override
  List<Object?> get props => [];
}

final class DeleteAccountIdle extends DeleteAccountState {
  const DeleteAccountIdle();
}

final class DeleteAccountInProgress extends DeleteAccountState {
  const DeleteAccountInProgress();
}

/// The account was deleted; the app should clear the session and route out.
final class DeleteAccountSuccess extends DeleteAccountState {
  const DeleteAccountSuccess();
}

final class DeleteAccountFailure extends DeleteAccountState {
  const DeleteAccountFailure();
}
