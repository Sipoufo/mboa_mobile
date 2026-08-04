import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/credential_auth_repository.dart';

part 'credential_login_event.dart';
part 'credential_login_state.dart';

/// App Mboa Pro credential login: email + password, then an email OTP (2FA).
///
/// A single bloc spans both steps so the entered credentials stay in memory —
/// the OTP verify only needs the email, but a resend must replay the `login`
/// call, which needs the password again. Credentials live only in memory here
/// and are never persisted.
class CredentialLoginBloc extends Bloc<CredentialLoginEvent, CredentialLoginState> {
  CredentialLoginBloc({required CredentialAuthRepository repository})
      : _repository = repository,
        super(const CredentialLoginEnterCredentials()) {
    on<CredentialLoginSubmitted>(_onSubmitted);
    on<CredentialLoginOtpSubmitted>(_onOtpSubmitted);
    on<CredentialLoginOtpResent>(_onResent);
    on<CredentialLoginBackToCredentials>(_onBack);
  }

  final CredentialAuthRepository _repository;

  String? _email;
  String? _password;

  Future<void> _onSubmitted(
    CredentialLoginSubmitted event,
    Emitter<CredentialLoginState> emit,
  ) async {
    _email = event.email;
    _password = event.password;
    emit(const CredentialLoginEnterCredentials(loading: true));
    try {
      await _repository.login(email: event.email, password: event.password);
      emit(CredentialLoginEnterOtp(email: event.email));
    } catch (_) {
      emit(const CredentialLoginEnterCredentials(error: CredentialLoginError.invalidCredentials));
    }
  }

  Future<void> _onOtpSubmitted(
    CredentialLoginOtpSubmitted event,
    Emitter<CredentialLoginState> emit,
  ) async {
    final email = _email;
    if (email == null) return;
    emit(CredentialLoginEnterOtp(email: email, loading: true));
    try {
      await _repository.verifyOtp(email: email, code: event.code);
      emit(const CredentialLoginSuccess());
    } catch (_) {
      emit(CredentialLoginEnterOtp(email: email, error: CredentialLoginError.invalidCode));
    }
  }

  Future<void> _onResent(
    CredentialLoginOtpResent event,
    Emitter<CredentialLoginState> emit,
  ) async {
    final email = _email;
    final password = _password;
    if (email == null || password == null) return;
    emit(CredentialLoginEnterOtp(email: email, loading: true));
    try {
      await _repository.login(email: email, password: password);
      emit(CredentialLoginEnterOtp(email: email, justResent: true));
    } catch (_) {
      emit(CredentialLoginEnterOtp(email: email, error: CredentialLoginError.otpResendFailed));
    }
  }

  void _onBack(
    CredentialLoginBackToCredentials event,
    Emitter<CredentialLoginState> emit,
  ) {
    emit(const CredentialLoginEnterCredentials());
  }
}
