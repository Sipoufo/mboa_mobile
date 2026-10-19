import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/password_reset_repository.dart';

part 'password_reset_event.dart';
part 'password_reset_state.dart';

/// Forgotten password (M02, App Mboa Pro): the email, then the SMS code and
/// the new password.
class PasswordResetBloc extends Bloc<PasswordResetEvent, PasswordResetState> {
  PasswordResetBloc({required PasswordResetRepository repository})
      : _repository = repository,
        super(const PasswordResetEnterEmail()) {
    on<PasswordResetRequested>(_onRequested);
    on<PasswordResetCodeResent>(_onResent);
    on<PasswordResetSubmitted>(_onSubmitted);
    on<PasswordResetBackToEmail>(_onBack);
  }

  final PasswordResetRepository _repository;

  Future<void> _onRequested(PasswordResetRequested event, Emitter<PasswordResetState> emit) async {
    emit(const PasswordResetEnterEmail(loading: true));
    try {
      await _repository.requestCode(event.email);
      // The server says "sent" whether or not the email has an account; the
      // screen says the same, so it gives nothing away either.
      emit(PasswordResetEnterCode(email: event.email.trim()));
    } catch (_) {
      emit(const PasswordResetEnterEmail(error: PasswordResetError.failed));
    }
  }

  Future<void> _onResent(PasswordResetCodeResent event, Emitter<PasswordResetState> emit) async {
    final current = state;
    if (current is! PasswordResetEnterCode) return;
    emit(PasswordResetEnterCode(email: current.email, loading: true));
    try {
      await _repository.requestCode(current.email);
      emit(PasswordResetEnterCode(email: current.email, justResent: true));
    } catch (_) {
      emit(PasswordResetEnterCode(email: current.email, error: PasswordResetError.failed));
    }
  }

  Future<void> _onSubmitted(PasswordResetSubmitted event, Emitter<PasswordResetState> emit) async {
    final current = state;
    if (current is! PasswordResetEnterCode) return;
    emit(PasswordResetEnterCode(email: current.email, loading: true));
    try {
      await _repository.reset(email: current.email, code: event.code, newPassword: event.newPassword);
      emit(PasswordResetDone(email: current.email));
    } on PasswordResetRefused catch (refused) {
      emit(
        PasswordResetEnterCode(
          email: current.email,
          error: switch (refused.reason) {
            PasswordResetRefusal.wrongCode => PasswordResetError.wrongCode,
            PasswordResetRefusal.expired => PasswordResetError.expired,
            PasswordResetRefusal.tooManyAttempts => PasswordResetError.tooManyAttempts,
          },
        ),
      );
    } catch (_) {
      emit(PasswordResetEnterCode(email: current.email, error: PasswordResetError.failed));
    }
  }

  void _onBack(PasswordResetBackToEmail event, Emitter<PasswordResetState> emit) =>
      emit(const PasswordResetEnterEmail());
}
