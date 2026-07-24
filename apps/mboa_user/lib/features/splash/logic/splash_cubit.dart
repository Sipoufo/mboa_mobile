import 'dart:async';

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
  SplashCubit({
    required SessionRepository sessionRepository,
    Duration minimumDisplay = const Duration(seconds: 2),
  })  : _sessionRepository = sessionRepository,
        _minimumDisplay = minimumDisplay,
        super(const SplashInitial());

  final SessionRepository _sessionRepository;

  /// Minimum time the branded splash stays visible, so a fast (often <100ms)
  /// session check doesn't make it flash-and-vanish.
  final Duration _minimumDisplay;

  Future<void> initialize() async {
    emit(const SplashLoading());
    // Session check and the minimum display run in parallel: the splash shows
    // for at least [_minimumDisplay] but never adds delay beyond it.
    final (result, _) = await (
      _sessionRepository.resolve(),
      Future<void>.delayed(_minimumDisplay),
    ).wait;
    emit(switch (result) {
      SessionAuthenticated() => const SplashAuthenticated(),
      SessionUnauthenticated() => const SplashUnauthenticated(),
      SessionCheckError() => const SplashFailure(),
    });
  }

  Future<void> retry() => initialize();
}
