import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/agent_repository.dart';
import '../models/availability.dart';

part 'agent_availability_event.dart';
part 'agent_availability_state.dart';

/// The agent's weekly availability, visit duration and days off (RM-M15-01,
/// RM-M15-03).
///
/// Route-scoped: only the availability screen reads it.
///
/// The weekly pattern is edited locally and saved as a whole, because the
/// endpoint is a PUT that replaces the set — so a rule left out is a rule
/// deleted, and `isDirty` drives the save button. Days off are **immediate**:
/// blocking one auto-cancels the visits already booked on it, which is not a
/// side effect to hide behind an unsaved form.
class AgentAvailabilityBloc
    extends Bloc<AgentAvailabilityEvent, AgentAvailabilityState> {
  AgentAvailabilityBloc({required AgentAvailabilityRepository repository})
      : _repository = repository,
        super(const AvailabilityInitial()) {
    on<AvailabilityLoadRequested>(_onLoad);
    on<AvailabilityRuleAdded>(_onRuleAdded);
    on<AvailabilityRuleRemoved>(_onRuleRemoved);
    on<AvailabilityRuleChanged>(_onRuleChanged);
    on<VisitDurationChanged>(_onDuration);
    on<AvailabilitySaveRequested>(_onSave);
    on<DayOffBlocked>(_onBlockDay);
    on<DayOffUnblocked>(_onUnblockDay);
  }

  final AgentAvailabilityRepository _repository;

  Future<void> _onLoad(
    AvailabilityLoadRequested event,
    Emitter<AgentAvailabilityState> emit,
  ) async {
    emit(const AvailabilityLoadInProgress());
    try {
      final loaded = await _repository.load();
      emit(AvailabilityReady(saved: loaded, draft: loaded));
    } catch (_) {
      emit(const AvailabilityFailure());
    }
  }

  void _onRuleAdded(
    AvailabilityRuleAdded event,
    Emitter<AgentAvailabilityState> emit,
  ) {
    final current = state;
    if (current is! AvailabilityReady || !current.draft.canAddRule) return;

    // Overlapping windows on one day are two ways of writing the same thing,
    // and the backend stores them verbatim — so the form is where it is caught.
    final overlaps =
        current.draft.rules.any((r) => r.overlaps(event.rule));
    if (overlaps || !event.rule.isValid) {
      emit(current.copyWith(rejected: true));
      return;
    }

    emit(
      current.copyWith(
        draft: current.draft.copyWith(
          rules: [...current.draft.rules, event.rule],
        ),
      ),
    );
  }

  void _onRuleRemoved(
    AvailabilityRuleRemoved event,
    Emitter<AgentAvailabilityState> emit,
  ) {
    final current = state;
    if (current is! AvailabilityReady) return;

    emit(
      current.copyWith(
        draft: current.draft.copyWith(
          rules: [...current.draft.rules]..remove(event.rule),
        ),
      ),
    );
  }

  void _onRuleChanged(
    AvailabilityRuleChanged event,
    Emitter<AgentAvailabilityState> emit,
  ) {
    final current = state;
    if (current is! AvailabilityReady) return;

    final rules = [...current.draft.rules];
    final index = rules.indexOf(event.before);
    if (index < 0) return;

    final others = [...rules]..removeAt(index);
    if (!event.after.isValid || others.any((r) => r.overlaps(event.after))) {
      emit(current.copyWith(rejected: true));
      return;
    }

    rules[index] = event.after;
    emit(current.copyWith(draft: current.draft.copyWith(rules: rules)));
  }

  void _onDuration(
    VisitDurationChanged event,
    Emitter<AgentAvailabilityState> emit,
  ) {
    final current = state;
    if (current is! AvailabilityReady) return;

    final minutes = event.minutes.clamp(
      Availability.minVisitMinutes,
      Availability.maxVisitMinutes,
    );
    emit(
      current.copyWith(
        draft: current.draft.copyWith(visitDurationMinutes: minutes),
      ),
    );
  }

  Future<void> _onSave(
    AvailabilitySaveRequested event,
    Emitter<AgentAvailabilityState> emit,
  ) async {
    final current = state;
    if (current is! AvailabilityReady || !current.isDirty) return;

    emit(current.copyWith(isSaving: true));
    try {
      final saved = await _repository.save(current.draft);
      emit(AvailabilityReady(saved: saved, draft: saved, justSaved: true));
    } catch (_) {
      emit(current.copyWith(isSaving: false, lastActionFailed: true));
    }
  }

  Future<void> _onBlockDay(
    DayOffBlocked event,
    Emitter<AgentAvailabilityState> emit,
  ) async {
    final current = state;
    if (current is! AvailabilityReady) return;

    emit(current.copyWith(isSaving: true));
    try {
      await _repository.blockDay(event.day);
      final days = [...current.saved.daysOff, event.day];
      emit(
        current.copyWith(
          saved: current.saved.copyWith(daysOff: days),
          draft: current.draft.copyWith(daysOff: days),
          isSaving: false,
        ),
      );
    } catch (_) {
      emit(current.copyWith(isSaving: false, lastActionFailed: true));
    }
  }

  Future<void> _onUnblockDay(
    DayOffUnblocked event,
    Emitter<AgentAvailabilityState> emit,
  ) async {
    final current = state;
    if (current is! AvailabilityReady) return;

    emit(current.copyWith(isSaving: true));
    try {
      await _repository.unblockDay(event.day);
      bool sameDay(DateTime d) =>
          d.year == event.day.year &&
          d.month == event.day.month &&
          d.day == event.day.day;
      final days = current.saved.daysOff.where((d) => !sameDay(d)).toList();
      emit(
        current.copyWith(
          saved: current.saved.copyWith(daysOff: days),
          draft: current.draft.copyWith(daysOff: days),
          isSaving: false,
        ),
      );
    } catch (_) {
      emit(current.copyWith(isSaving: false, lastActionFailed: true));
    }
  }
}
