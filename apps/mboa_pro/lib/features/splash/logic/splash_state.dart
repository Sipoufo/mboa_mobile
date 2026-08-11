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
  const SplashAuthenticated({this.role});

  /// Known from the startup `/me`, so the first authenticated route can be the
  /// right shell rather than the prestataire one corrected a moment later.
  final AccountRole? role;

  @override
  List<Object?> get props => [role];
}

final class SplashUnauthenticated extends SplashState {
  const SplashUnauthenticated();
}

/// A non-connectivity error blocked the check; the splash offers a retry. The
/// UI renders a localised message.
final class SplashFailure extends SplashState {
  const SplashFailure();
}
