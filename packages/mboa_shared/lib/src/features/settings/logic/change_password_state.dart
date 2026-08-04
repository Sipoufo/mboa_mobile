part of 'change_password_cubit.dart';

sealed class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object?> get props => [];
}

final class ChangePasswordIdle extends ChangePasswordState {
  const ChangePasswordIdle();
}

final class ChangePasswordInProgress extends ChangePasswordState {
  const ChangePasswordInProgress();
}

final class ChangePasswordSuccess extends ChangePasswordState {
  const ChangePasswordSuccess();
}

final class ChangePasswordFailure extends ChangePasswordState {
  const ChangePasswordFailure();
}
