import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../data/saved_searches_repository.dart';
import '../models/saved_search.dart';

part 'saved_searches_event.dart';
part 'saved_searches_state.dart';

/// The tenant's saved searches (CDC M04, RM-M04-07).
///
/// A session-scoped singleton: the search screen saves into it and the list
/// reads it, so a search saved on one shows up on the other without a reload.
///
/// Offline the list is read-only — the cached copy is shown, and nothing that
/// would change it is attempted.
class SavedSearchesBloc extends Bloc<SavedSearchesEvent, SavedSearchesState> {
  SavedSearchesBloc({required SavedSearchesRepository repository})
      : _repository = repository,
        super(const SavedSearchesInitial()) {
    on<SavedSearchesRequested>(_onRequested);
    on<SavedSearchSaveRequested>(_onSave);
    on<SavedSearchRenamed>(_onRename);
    on<SavedSearchAlertsToggled>(_onAlerts);
    on<SavedSearchDeleted>(_onDelete);
    on<SavedSearchOpened>(_onOpened);
  }

  final SavedSearchesRepository _repository;

  Future<void> _onRequested(SavedSearchesRequested event, Emitter<SavedSearchesState> emit) async {
    // A reload keeps the list on screen rather than flashing a spinner.
    if (state is! SavedSearchesReady) emit(const SavedSearchesLoading());
    try {
      final list = await _repository.list();
      emit(SavedSearchesReady(searches: list.searches, isOffline: list.fromCache));
    } catch (_) {
      emit(const SavedSearchesFailure());
    }
  }

  Future<void> _onSave(SavedSearchSaveRequested event, Emitter<SavedSearchesState> emit) async {
    final wasLoaded = state is SavedSearchesReady;
    final current = _ready;
    emit(current.copyWith(isSaving: true));
    try {
      final saved = await _repository.save(event.query, name: event.name, alertsEnabled: event.alertsEnabled);
      emit(
        current.copyWith(
          searches: [...current.searches, saved],
          outcome: SavedSearchOutcome.saved,
        ),
      );
      // Saved before the list was ever read: the others are still unknown.
      if (!wasLoaded) add(const SavedSearchesRequested());
    } on SaveSearchRefused catch (refused) {
      emit(
        current.copyWith(
          outcome: switch (refused.reason) {
            SaveRefusal.limit => SavedSearchOutcome.limitReached,
            SaveRefusal.duplicate => SavedSearchOutcome.alreadySaved,
          },
        ),
      );
    } catch (_) {
      emit(current.copyWith(outcome: SavedSearchOutcome.failed));
    }
  }

  Future<void> _onRename(SavedSearchRenamed event, Emitter<SavedSearchesState> emit) async {
    final current = _ready;
    if (current.isOffline || event.name.trim().isEmpty) return;
    emit(current.copyWith(busyId: event.id));
    try {
      final renamed = await _repository.rename(event.id, event.name);
      emit(current.copyWith(searches: _replace(current.searches, renamed)));
    } catch (_) {
      emit(current.copyWith(outcome: SavedSearchOutcome.failed));
    }
  }

  /// The switch moves at once, and goes back if the server says no.
  Future<void> _onAlerts(SavedSearchAlertsToggled event, Emitter<SavedSearchesState> emit) async {
    final current = _ready;
    if (current.isOffline || current.busyId != null) return;
    final target = current.searches.where((s) => s.id == event.id).firstOrNull;
    if (target == null) return;

    emit(
      current.copyWith(
        searches: _replace(current.searches, target.copyWith(alertsEnabled: event.enabled)),
        busyId: event.id,
      ),
    );
    try {
      final updated = await _repository.setAlerts(event.id, enabled: event.enabled);
      emit(current.copyWith(searches: _replace(current.searches, updated)));
    } catch (_) {
      emit(current.copyWith(outcome: SavedSearchOutcome.failed));
    }
  }

  Future<void> _onDelete(SavedSearchDeleted event, Emitter<SavedSearchesState> emit) async {
    final current = _ready;
    if (current.isOffline) return;
    emit(current.copyWith(busyId: event.id));
    try {
      await _repository.delete(event.id);
      emit(current.copyWith(searches: current.searches.where((s) => s.id != event.id).toList()));
    } catch (_) {
      emit(current.copyWith(outcome: SavedSearchOutcome.failed));
    }
  }

  /// Opening its results resets the count on the server; the list follows
  /// without a reload.
  void _onOpened(SavedSearchOpened event, Emitter<SavedSearchesState> emit) {
    final current = state;
    if (current is! SavedSearchesReady) return;
    final opened = current.searches.where((s) => s.id == event.id).firstOrNull;
    if (opened == null || opened.newMatchCount == 0) return;
    emit(current.copyWith(searches: _replace(current.searches, opened.copyWith(newMatchCount: 0))));
  }

  /// A save can come before the list was ever opened: it starts from empty
  /// rather than being refused.
  SavedSearchesReady get _ready => switch (state) {
        final SavedSearchesReady ready => ready,
        _ => const SavedSearchesReady(searches: []),
      };

  static List<SavedSearch> _replace(List<SavedSearch> searches, SavedSearch updated) => [
        for (final s in searches) s.id == updated.id ? updated : s,
      ];
}
