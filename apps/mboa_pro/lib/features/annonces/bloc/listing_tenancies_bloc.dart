import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// A listing's « Occupant » and « Historique » cards (RM-M31-09): who lives
/// there now — or moves in next — and who lived there before, from the homes
/// its signed contracts opened. Offline, the last read.
class ListingTenanciesBloc extends Bloc<ListingTenanciesEvent, ListingTenanciesState> {
  ListingTenanciesBloc({required HomesRepository repository})
    : _repository = repository,
      super(const ListingTenanciesLoading()) {
    on<ListingTenanciesRequested>(_onRequested);
    on<ListingTenanciesHistoryExpanded>(_onHistoryExpanded);
  }

  final HomesRepository _repository;

  Future<void> _onRequested(ListingTenanciesRequested event, Emitter<ListingTenanciesState> emit) async {
    // A retry after a failure shows it is trying; a refresh keeps the cards.
    if (state is ListingTenanciesFailure) emit(const ListingTenanciesLoading());
    try {
      final read = await _repository.tenantHomes(annonceId: event.annonceId);
      final previous = state;
      emit(
        ListingTenanciesReady.of(
          read.value,
          isOffline: read.fromCache,
          showAllPast: previous is ListingTenanciesReady && previous.showAllPast,
        ),
      );
    } catch (_) {
      if (state is! ListingTenanciesReady) emit(const ListingTenanciesFailure());
    }
  }

  void _onHistoryExpanded(ListingTenanciesHistoryExpanded event, Emitter<ListingTenanciesState> emit) {
    if (state case final ListingTenanciesReady ready) emit(ready.copyWith(showAllPast: true));
  }
}

sealed class ListingTenanciesEvent extends Equatable {
  const ListingTenanciesEvent();

  @override
  List<Object?> get props => [];
}

final class ListingTenanciesRequested extends ListingTenanciesEvent {
  const ListingTenanciesRequested(this.annonceId);

  final String annonceId;

  @override
  List<Object?> get props => [annonceId];
}

/// « Voir tout » under the history.
final class ListingTenanciesHistoryExpanded extends ListingTenanciesEvent {
  const ListingTenanciesHistoryExpanded();
}

sealed class ListingTenanciesState extends Equatable {
  const ListingTenanciesState();

  @override
  List<Object?> get props => [];
}

final class ListingTenanciesLoading extends ListingTenanciesState {
  const ListingTenanciesLoading();
}

/// Nothing read, nothing cached.
final class ListingTenanciesFailure extends ListingTenanciesState {
  const ListingTenanciesFailure();
}

final class ListingTenanciesReady extends ListingTenanciesState {
  const ListingTenanciesReady({
    this.occupant,
    this.next,
    this.past = const [],
    this.showAllPast = false,
    this.isOffline = false,
  });

  /// Sorts the listing's homes: the running tenancy is the occupant — the
  /// latest begun, should two overlap; with none, the next one to begin. A
  /// tenancy signed to follow the running one is [next]. The ended ones are
  /// the history, the latest ended first.
  factory ListingTenanciesReady.of(List<Home> homes, {bool isOffline = false, bool showAllPast = false}) {
    List<Home> inState(HomeStage stage) => homes.where((h) => h.state == stage).toList();

    final active = inState(HomeStage.active)..sort((a, b) => _latestFirst(a.startDate, b.startDate));
    final upcoming = inState(HomeStage.upcoming)..sort((a, b) => _earliestFirst(a.startDate, b.startDate));
    final past = inState(HomeStage.readOnly)..sort((a, b) => _latestFirst(a.endDate, b.endDate));

    return ListingTenanciesReady(
      occupant: active.firstOrNull ?? upcoming.firstOrNull,
      next: active.isEmpty ? null : upcoming.firstOrNull,
      past: past,
      showAllPast: showAllPast,
      isOffline: isOffline,
    );
  }

  /// How many ended tenancies show before « Voir tout ».
  static const pastShown = 3;

  /// Null: the place is free.
  final Home? occupant;
  final Home? next;
  final List<Home> past;
  final bool showAllPast;
  final bool isOffline;

  List<Home> get visiblePast => showAllPast ? past : past.take(pastShown).toList();

  bool get hasMorePast => !showAllPast && past.length > pastShown;

  ListingTenanciesReady copyWith({bool? showAllPast}) => ListingTenanciesReady(
    occupant: occupant,
    next: next,
    past: past,
    showAllPast: showAllPast ?? this.showAllPast,
    isOffline: isOffline,
  );

  @override
  List<Object?> get props => [occupant, next, past, showAllPast, isOffline];
}

/// Latest first; an unknown date last.
int _latestFirst(DateTime? a, DateTime? b) => _byDate(a, b, (a, b) => b.compareTo(a));

/// Earliest first; an unknown date last.
int _earliestFirst(DateTime? a, DateTime? b) => _byDate(a, b, (a, b) => a.compareTo(b));

int _byDate(DateTime? a, DateTime? b, int Function(DateTime, DateTime) compare) => switch ((a, b)) {
  (null, null) => 0,
  (null, _) => 1,
  (_, null) => -1,
  (final a?, final b?) => compare(a, b),
};
