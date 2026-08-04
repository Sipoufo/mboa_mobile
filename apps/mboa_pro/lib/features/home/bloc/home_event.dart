part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

/// First load: paints the cache immediately (when fresh) and fetches behind it.
final class HomeLoadRequested extends HomeEvent {
  const HomeLoadRequested();
}

/// Pull-to-refresh: always goes to the network, keeping the current figures on
/// screen while it does.
final class HomeRefreshRequested extends HomeEvent {
  const HomeRefreshRequested();
}
