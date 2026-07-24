import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// App Mboa Pro's global session gate. Owns *runtime* session state
/// (authenticated vs not); the splash owns the startup decision. The shared
/// login flow signals [AuthSessionEstablished] once tokens are persisted.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository repository})
      : _repository = repository,
        super(const AuthInitial()) {
    on<AuthSessionEstablished>(_onSessionEstablished);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  final AuthRepository _repository;

  void _onSessionEstablished(AuthSessionEstablished event, Emitter<AuthState> emit) {
    emit(const AuthAuthenticated());
  }

  Future<void> _onLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    await _repository.logout();
    emit(const AuthUnauthenticated());
  }
}
