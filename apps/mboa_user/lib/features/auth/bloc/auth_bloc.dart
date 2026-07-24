import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// The global session gate (the one BLoC shared app-wide, per CLAUDE.md).
///
/// It owns *session* state only — authenticated vs not — and does not run the
/// login flow itself: the shared `LoginBloc` does that, then signals
/// [AuthSessionEstablished] here once tokens are persisted.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository repository})
      : _repository = repository,
        super(const AuthInitial()) {
    on<AuthStarted>(_onStarted);
    on<AuthSessionEstablished>(_onSessionEstablished);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  final AuthRepository _repository;

  Future<void> _onStarted(AuthStarted event, Emitter<AuthState> emit) async {
    final hasSession = await _repository.hasSession();
    emit(hasSession ? const AuthAuthenticated() : const AuthUnauthenticated());
  }

  void _onSessionEstablished(AuthSessionEstablished event, Emitter<AuthState> emit) {
    // Tokens were just persisted by the shared login flow.
    emit(const AuthAuthenticated());
  }

  Future<void> _onLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    await _repository.logout();
    emit(const AuthUnauthenticated());
  }
}
