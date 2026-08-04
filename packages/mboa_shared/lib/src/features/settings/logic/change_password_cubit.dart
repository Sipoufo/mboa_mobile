import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/account_repository.dart';

part 'change_password_state.dart';

/// Changes the account password (Pro/admin — email accounts only).
class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({required AccountRepository repository})
      : _repository = repository,
        super(const ChangePasswordIdle());

  final AccountRepository _repository;

  Future<void> submit({required String currentPassword, required String newPassword}) async {
    if (state is ChangePasswordInProgress) return;
    emit(const ChangePasswordInProgress());
    try {
      await _repository.changePassword(currentPassword: currentPassword, newPassword: newPassword);
      emit(const ChangePasswordSuccess());
    } catch (_) {
      emit(const ChangePasswordFailure());
    }
  }
}
