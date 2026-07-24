import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

part 'splash_state.dart';

/// App-Mboa startup controller. Runs the shared session check on launch and
/// emits the decision the [SplashPage] routes on.
///
/// This owns the *startup* routing decision; `AuthBloc` owns runtime session
/// changes (login-success, forced logout).
class SplashCubit extends Cubit<SplashState> {
  SplashCubit({required SessionRepository sessionRepository})
      : _sessionRepository = sessionRepository,
        super(const SplashInitial());

  final SessionRepository _sessionRepository;

  Future<void> initialize() async {
    emit(const SplashLoading());
    final result = await _sessionRepository.resolve();
    emit(switch (result) {
      SessionAuthenticated() => const SplashAuthenticated(),
      SessionUnauthenticated() => const SplashUnauthenticated(),
      SessionCheckError() => const SplashFailure(),
    });
  }

  Future<void> retry() => initialize();
}
