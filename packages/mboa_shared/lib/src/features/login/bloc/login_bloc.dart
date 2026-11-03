import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../api/api_error.dart';
import '../../../api/otp_guard.dart';
import '../data/login_repository.dart';
import '../models/otp_session.dart';

part 'login_event.dart';
part 'login_state.dart';

/// The shared code sign-in: a phone or, since §40 A, an email. Ends in [LoginSuccess] once tokens are
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
    on<LoginOtpResendRequested>(_onOtpResendRequested);
    on<LoginCodeSubmitted>(_onCodeSubmitted);
  }

  final LoginRepository _repository;

  Future<void> _onOtpResendRequested(
    LoginOtpResendRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginInProgress());
    try {
      await _repository.resendOtp(event.session);
      emit(const LoginOtpResent());
    } catch (error) {
      emit(LoginFailure(_requestError(error)));
    }
  }

  Future<void> _onOtpRequested(LoginOtpRequested event, Emitter<LoginState> emit) async {
    emit(const LoginInProgress());
    try {
      final session = await _repository.requestOtp(phoneNumber: event.phoneNumber, email: event.email);
      emit(LoginOtpSent(session));
    } catch (error) {
      emit(LoginFailure(_requestError(error)));
    }
  }

  Future<void> _onCodeSubmitted(LoginCodeSubmitted event, Emitter<LoginState> emit) async {
    emit(const LoginInProgress());
    try {
      await _repository.verifyOtp(session: event.session, code: event.code);
      emit(const LoginSuccess());
    } on OtpCodeBurnt {
      emit(LoginFailure(LoginError.codeBurnt, session: event.session));
    } catch (_) {
      emit(LoginFailure(LoginError.invalidCode, session: event.session));
    }
  }

  /// The refusals the screen says in words; anything else is a failure to
  /// retry.
  static LoginError _requestError(Object error) {
    final api = ApiError.from(error);
    if (api.hasCode('WHATSAPP_UNAVAILABLE')) return LoginError.whatsappUnavailable;
    if (api.hasCode('USE_PASSWORD_LOGIN')) return LoginError.usePasswordLogin;
    return LoginError.otpRequestFailed;
  }
}
