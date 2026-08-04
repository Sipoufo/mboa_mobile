import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/account_repository.dart';

part 'change_phone_event.dart';
part 'change_phone_state.dart';

/// Two-step phone-number change (RM-M02-02): request a change for the new
/// number (OTP goes to both old and new), then confirm with both codes.
class ChangePhoneBloc extends Bloc<ChangePhoneEvent, ChangePhoneState> {
  ChangePhoneBloc({required AccountRepository repository})
      : _repository = repository,
        super(const ChangePhoneEnterPhone()) {
    on<ChangePhoneRequested>(_onRequested);
    on<ChangePhoneResent>(_onResent);
    on<ChangePhoneConfirmed>(_onConfirmed);
    on<ChangePhoneBack>(_onBack);
  }

  final AccountRepository _repository;

  String? _newPhone;

  Future<void> _onRequested(ChangePhoneRequested event, Emitter<ChangePhoneState> emit) async {
    _newPhone = event.newPhoneNumber;
    emit(const ChangePhoneEnterPhone(loading: true));
    try {
      await _repository.requestPhoneChange(event.newPhoneNumber);
      emit(ChangePhoneEnterCodes(newPhoneNumber: event.newPhoneNumber));
    } catch (_) {
      emit(const ChangePhoneEnterPhone(error: ChangePhoneError.requestFailed));
    }
  }

  Future<void> _onResent(ChangePhoneResent event, Emitter<ChangePhoneState> emit) async {
    final phone = _newPhone;
    if (phone == null) return;
    emit(ChangePhoneEnterCodes(newPhoneNumber: phone, loading: true));
    try {
      await _repository.requestPhoneChange(phone);
      emit(ChangePhoneEnterCodes(newPhoneNumber: phone, justResent: true));
    } catch (_) {
      emit(ChangePhoneEnterCodes(newPhoneNumber: phone, error: ChangePhoneError.requestFailed));
    }
  }

  Future<void> _onConfirmed(ChangePhoneConfirmed event, Emitter<ChangePhoneState> emit) async {
    final phone = _newPhone;
    if (phone == null) return;
    emit(ChangePhoneEnterCodes(newPhoneNumber: phone, loading: true));
    try {
      await _repository.confirmPhoneChange(
        newPhoneNumber: phone,
        oldCode: event.oldCode,
        newCode: event.newCode,
      );
      emit(const ChangePhoneSuccess());
    } catch (_) {
      emit(ChangePhoneEnterCodes(newPhoneNumber: phone, error: ChangePhoneError.invalidCode));
    }
  }

  void _onBack(ChangePhoneBack event, Emitter<ChangePhoneState> emit) {
    emit(const ChangePhoneEnterPhone());
  }
}
