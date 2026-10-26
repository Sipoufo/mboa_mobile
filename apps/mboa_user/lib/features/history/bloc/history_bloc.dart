import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/history_repository.dart';
import '../models/history_entry.dart';

/// The fiches the tenant opened (CDC M06, RM-M06-05) — read in « Favoris »,
/// cleared from « Paramètres ». One instance for both, dropped at sign-out.
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc({required HistoryRepository repository})
      : _repository = repository,
        super(const HistoryInitial()) {
    on<HistoryRequested>(_onRequested);
    on<HistoryCleared>(_onCleared);
  }

  final HistoryRepository _repository;

  Future<void> _onRequested(HistoryRequested event, Emitter<HistoryState> emit) async {
    final current = state;
    // A refresh keeps the list on screen; only the first read shows a loader.
    if (current is! HistoryReady) emit(const HistoryLoading());
    try {
      final read = await _repository.list();
      emit(HistoryReady(entries: read.value, isOffline: read.fromCache));
    } catch (_) {
      if (current is! HistoryReady) emit(const HistoryFailure());
    }
  }

  Future<void> _onCleared(HistoryCleared event, Emitter<HistoryState> emit) async {
    final current = state;
    final entries = current is HistoryReady ? current.entries : const <HistoryEntry>[];
    if (current is HistoryReady && current.isClearing) return;
    emit(HistoryReady(entries: entries, isClearing: true));
    try {
      await _repository.clear();
      emit(const HistoryReady(entries: [], outcome: HistoryClearOutcome.cleared));
    } catch (_) {
      // Offline or refused: nothing was cleared, and the screen says so.
      emit(HistoryReady(entries: entries, outcome: HistoryClearOutcome.failed));
    }
  }
}

sealed class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object?> get props => [];
}

/// Read it again — on opening the tab: every fiche opened since adds a row.
final class HistoryRequested extends HistoryEvent {
  const HistoryRequested();
}

/// RM-M06-05 — reset from « Paramètres ».
final class HistoryCleared extends HistoryEvent {
  const HistoryCleared();
}

enum HistoryClearOutcome { cleared, failed }

sealed class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object?> get props => [];
}

final class HistoryInitial extends HistoryState {
  const HistoryInitial();
}

final class HistoryLoading extends HistoryState {
  const HistoryLoading();
}

final class HistoryFailure extends HistoryState {
  const HistoryFailure();
}

final class HistoryReady extends HistoryState {
  const HistoryReady({required this.entries, this.isOffline = false, this.isClearing = false, this.outcome});

  /// Newest first.
  final List<HistoryEntry> entries;
  final bool isOffline;
  final bool isClearing;

  /// Once: how a clearing ended — the screen says it, then forgets it.
  final HistoryClearOutcome? outcome;

  /// The entries day by day, newest day first — each day's order kept.
  List<(DateTime, List<HistoryEntry>)> get byDay {
    final days = <DateTime, List<HistoryEntry>>{};
    for (final entry in entries) {
      final at = entry.viewedAt;
      final day = at == null ? DateTime(0) : DateTime(at.year, at.month, at.day);
      (days[day] ??= []).add(entry);
    }
    return [for (final MapEntry(:key, :value) in days.entries) (key, value)];
  }

  @override
  List<Object?> get props => [entries, isOffline, isClearing, outcome];
}
