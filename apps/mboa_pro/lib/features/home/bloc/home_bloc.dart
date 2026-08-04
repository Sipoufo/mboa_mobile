import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/pro_dashboard_repository.dart';
import '../models/dashboard_stats.dart';

part 'home_event.dart';
part 'home_state.dart';

/// Drives the Pro home dashboard (CDC M14).
///
/// Offline-first per project rule 3: the cache paints first, the network
/// refreshes behind it, and a failed fetch keeps whatever figures are already
/// on screen rather than blanking the page.
///
/// It deliberately does **not** own the profile — the header binds to the
/// `ProProfileBloc` provided by `AuthenticatedWrapper`, so `/me` is loaded once
/// per session instead of once per surface.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required ProDashboardRepository repository})
      : _repository = repository,
        super(const HomeInitial()) {
    on<HomeLoadRequested>(_onLoadRequested);
    on<HomeRefreshRequested>(_onRefreshRequested);
  }

  final ProDashboardRepository _repository;

  Future<void> _onLoadRequested(
    HomeLoadRequested event,
    Emitter<HomeState> emit,
  ) async {
    final cached = _repository.cached();
    if (cached != null) {
      emit(HomeReady(cached, fromCache: true));
    } else {
      emit(const HomeLoadInProgress());
    }

    try {
      emit(HomeReady(await _repository.fetch()));
    } catch (_) {
      // Stale figures beat a blank screen; only surface a failure when we have
      // nothing at all.
      if (cached == null) emit(const HomeFailure());
    }
  }

  Future<void> _onRefreshRequested(
    HomeRefreshRequested event,
    Emitter<HomeState> emit,
  ) async {
    final current = state;

    try {
      emit(HomeReady(await _repository.fetch()));
    } catch (_) {
      // Keep the current figures; a failed refresh isn't worth losing them.
      if (current is! HomeReady) emit(const HomeFailure());
    }
  }
}
