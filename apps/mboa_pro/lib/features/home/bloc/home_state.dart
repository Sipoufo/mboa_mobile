part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoadInProgress extends HomeState {
  const HomeLoadInProgress();
}

/// Figures on screen.
///
/// [fromCache] drives the "données hors ligne" banner — the figures are real but
/// may be stale, which is different from having none.
final class HomeReady extends HomeState {
  const HomeReady(this.stats, {this.fromCache = false});

  final DashboardStats stats;
  final bool fromCache;

  @override
  List<Object?> get props => [stats, fromCache];
}

/// Nothing to show — the fetch failed and there was no usable cache.
final class HomeFailure extends HomeState {
  const HomeFailure();
}
