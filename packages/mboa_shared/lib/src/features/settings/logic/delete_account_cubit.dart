import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/account_repository.dart';

part 'delete_account_state.dart';

/// Drives the (deliberately friction-full) account deletion action.
class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit({required AccountRepository repository})
      : _repository = repository,
        super(const DeleteAccountIdle());

  final AccountRepository _repository;

  Future<void> delete() async {
    if (state is DeleteAccountInProgress) return;
    emit(const DeleteAccountInProgress());
    try {
      await _repository.deleteAccount();
      emit(const DeleteAccountSuccess());
    } catch (_) {
      emit(const DeleteAccountFailure());
    }
  }
}
