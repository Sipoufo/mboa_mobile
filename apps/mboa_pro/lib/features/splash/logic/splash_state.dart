part of 'splash_cubit.dart';

/// Startup states for App Mboa Pro.
sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

final class SplashInitial extends SplashState {
  const SplashInitial();
}

final class SplashLoading extends SplashState {
  const SplashLoading();
}

final class SplashAuthenticated extends SplashState {
  const SplashAuthenticated();
}

final class SplashUnauthenticated extends SplashState {
  const SplashUnauthenticated();
}

/// A non-connectivity error blocked the check; the splash offers a retry. The
/// UI renders a localised message.
final class SplashFailure extends SplashState {
  const SplashFailure();
}
