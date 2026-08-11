import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

part 'splash_state.dart';

/// App Mboa Pro startup controller. Runs the shared session check on launch and
/// emits the decision the [SplashPage] routes on. Pro-specific outcomes
/// (onboarding, KYC, agent-role) can be added here later without touching
/// App Mboa.
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
    final (result, _) = await (
      _sessionRepository.resolve(),
      Future<void>.delayed(_minimumDisplay),
    ).wait;
    emit(switch (result) {
      SessionAuthenticated(:final role) => SplashAuthenticated(role: role),
      SessionUnauthenticated() => const SplashUnauthenticated(),
      SessionCheckError() => const SplashFailure(),
    });
  }

  Future<void> retry() => initialize();
}
