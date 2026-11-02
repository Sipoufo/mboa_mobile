import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../api/api_error.dart';
import '../../../api/otp_guard.dart';
import '../data/account_repository.dart';

part 'change_phone_event.dart';
part 'change_phone_state.dart';

/// Two-step phone-number change (RM-M02-02): the current number, then the
/// new one (OTP goes to both), then confirm with both codes.
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

  String? _currentPhone;
  String? _newPhone;

  Future<void> _onRequested(ChangePhoneRequested event, Emitter<ChangePhoneState> emit) async {
    _currentPhone = event.currentPhoneNumber;
    _newPhone = event.newPhoneNumber;
    emit(const ChangePhoneEnterPhone(loading: true));
    try {
      await _repository.requestPhoneChange(
        currentPhoneNumber: event.currentPhoneNumber,
        newPhoneNumber: event.newPhoneNumber,
      );
      emit(ChangePhoneEnterCodes(currentPhoneNumber: event.currentPhoneNumber, newPhoneNumber: event.newPhoneNumber));
    } catch (error) {
      emit(ChangePhoneEnterPhone(error: _requestError(error)));
    }
  }

  Future<void> _onResent(ChangePhoneResent event, Emitter<ChangePhoneState> emit) async {
    final (current, phone) = (_currentPhone, _newPhone);
    if (current == null || phone == null) return;
    emit(ChangePhoneEnterCodes(currentPhoneNumber: current, newPhoneNumber: phone, loading: true));
    try {
      await _repository.requestPhoneChange(currentPhoneNumber: current, newPhoneNumber: phone);
      emit(ChangePhoneEnterCodes(currentPhoneNumber: current, newPhoneNumber: phone, justResent: true));
    } catch (_) {
      emit(ChangePhoneEnterCodes(
        currentPhoneNumber: current,
        newPhoneNumber: phone,
        error: ChangePhoneError.requestFailed,
      ));
    }
  }

  Future<void> _onConfirmed(ChangePhoneConfirmed event, Emitter<ChangePhoneState> emit) async {
    final (current, phone) = (_currentPhone, _newPhone);
    if (current == null || phone == null) return;
    emit(ChangePhoneEnterCodes(currentPhoneNumber: current, newPhoneNumber: phone, loading: true));
    try {
      await _repository.confirmPhoneChange(
        newPhoneNumber: phone,
        oldCode: event.oldCode,
        newCode: event.newCode,
      );
      emit(const ChangePhoneSuccess());
    } on OtpCodeBurnt {
      emit(ChangePhoneEnterCodes(currentPhoneNumber: current, newPhoneNumber: phone, error: ChangePhoneError.codeBurnt));
    } catch (_) {
      emit(ChangePhoneEnterCodes(
        currentPhoneNumber: current,
        newPhoneNumber: phone,
        error: ChangePhoneError.invalidCode,
      ));
    }
  }

  /// The refusals that point at one of the two numbers, so the screen can say
  /// which; anything else is a failure to retry.
  static ChangePhoneError _requestError(Object error) {
    final api = ApiError.from(error);
    if (api.hasCode('CURRENT_PHONE_MISMATCH')) return ChangePhoneError.currentMismatch;
    if (api.hasCode('PHONE_UNCHANGED')) return ChangePhoneError.unchanged;
    if (api.hasCode('PHONE_ALREADY_USED')) return ChangePhoneError.alreadyUsed;
    return ChangePhoneError.requestFailed;
  }

  void _onBack(ChangePhoneBack event, Emitter<ChangePhoneState> emit) {
    emit(const ChangePhoneEnterPhone());
  }
}
