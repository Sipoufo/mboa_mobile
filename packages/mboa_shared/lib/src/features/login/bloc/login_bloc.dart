import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/login_repository.dart';
import '../models/otp_session.dart';

part 'login_event.dart';
part 'login_state.dart';

/// The shared SMS-OTP login flow. Ends in [LoginSuccess] once tokens are
/// persisted — the host app then promotes the session on its own `AuthBloc`.
///
/// Stateless with respect to the challenge: the [OtpSession] is carried in the
/// submit event, so each screen can own its own instance without sharing one
/// bloc across the navigation boundary.
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required LoginRepository repository})
      : _repository = repository,
        super(const LoginInitial()) {
    on<LoginOtpRequested>(_onOtpRequested);
    on<LoginCodeSubmitted>(_onCodeSubmitted);
  }

  final LoginRepository _repository;

  Future<void> _onOtpRequested(LoginOtpRequested event, Emitter<LoginState> emit) async {
    emit(const LoginInProgress());
    try {
      final session = await _repository.requestOtp(event.phoneNumber);
      emit(LoginOtpSent(session));
    } catch (_) {
      emit(const LoginFailure(LoginError.otpRequestFailed));
    }
  }

  Future<void> _onCodeSubmitted(LoginCodeSubmitted event, Emitter<LoginState> emit) async {
    emit(const LoginInProgress());
    try {
      await _repository.verifyOtp(session: event.session, code: event.code);
      emit(const LoginSuccess());
    } catch (_) {
      emit(LoginFailure(LoginError.invalidCode, session: event.session));
    }
  }
}
