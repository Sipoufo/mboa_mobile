import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/register_repository.dart';
import '../models/professional_role.dart';

part 'register_event.dart';
part 'register_state.dart';

/// App Mboa Pro professional registration: role + email + password + phone,
/// then a phone OTP. A single bloc spans both steps; the phone is retained so
/// the OTP verify and resend can reference it.
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required RegisterRepository repository})
      : _repository = repository,
        super(const RegisterEnterDetails()) {
    on<RegisterSubmitted>(_onSubmitted);
    on<RegisterOtpSubmitted>(_onOtpSubmitted);
    on<RegisterOtpResent>(_onResent);
    on<RegisterBackToDetails>(_onBack);
  }

  final RegisterRepository _repository;

  String? _phone;

  Future<void> _onSubmitted(RegisterSubmitted event, Emitter<RegisterState> emit) async {
    _phone = event.phone;
    emit(const RegisterEnterDetails(loading: true));
    try {
      await _repository.register(
        role: event.role,
        email: event.email,
        password: event.password,
        phone: event.phone,
      );
      emit(RegisterEnterOtp(phone: event.phone));
    } catch (_) {
      emit(const RegisterEnterDetails(error: RegisterError.registrationFailed));
    }
  }

  Future<void> _onOtpSubmitted(RegisterOtpSubmitted event, Emitter<RegisterState> emit) async {
    final phone = _phone;
    if (phone == null) return;
    emit(RegisterEnterOtp(phone: phone, loading: true));
    try {
      await _repository.verifyOtp(phone: phone, code: event.code);
      emit(const RegisterSuccess());
    } catch (_) {
      emit(RegisterEnterOtp(phone: phone, error: RegisterError.invalidCode));
    }
  }

  Future<void> _onResent(RegisterOtpResent event, Emitter<RegisterState> emit) async {
    final phone = _phone;
    if (phone == null) return;
    emit(RegisterEnterOtp(phone: phone, loading: true));
    try {
      await _repository.resendOtp(phone);
      emit(RegisterEnterOtp(phone: phone, justResent: true));
    } catch (_) {
      emit(RegisterEnterOtp(phone: phone, error: RegisterError.otpResendFailed));
    }
  }

  void _onBack(RegisterBackToDetails event, Emitter<RegisterState> emit) {
    emit(const RegisterEnterDetails());
  }
}
