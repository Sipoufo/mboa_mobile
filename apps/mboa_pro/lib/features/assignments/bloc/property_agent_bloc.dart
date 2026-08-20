import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../annonces/data/annonce_repository.dart';
import '../data/assignment_repository.dart';
import '../models/assignment.dart';

part 'property_agent_event.dart';
part 'property_agent_state.dart';

/// One property's agent situation (CDC M11): who is on it, who applied, and who
/// could be offered it.
///
/// Route-scoped — the assign screen and the Agent section on a property's detail
/// each own an instance for their own target.
class PropertyAgentBloc extends Bloc<PropertyAgentEvent, PropertyAgentState> {
  PropertyAgentBloc({
    required AssignmentRepository repository,
    required AnnonceRepository annonces,
  })  : _repository = repository,
        _annonces = annonces,
        super(const PropertyAgentInitial()) {
    on<PropertyAgentLoadRequested>(_onLoad);
    on<AgentOffered>(_onOffer);
    on<AssignmentWithdrawn>(_onWithdraw);
    on<ApplicationAccepted>(_onAccept);
    on<ApplicationDeclined>(_onDecline);
    on<OwnerVisitsToggled>(_onOwnerVisits);
  }

  final AssignmentRepository _repository;

  /// RM-M11-10 lives on the listing, not on the assignment: the owner joins the
  /// pool through a flag on his own annonce.
  final AnnonceRepository _annonces;

  Future<void> _onLoad(
    PropertyAgentLoadRequested event,
    Emitter<PropertyAgentState> emit,
  ) async {
    emit(const PropertyAgentLoadInProgress());
    await _reload(event.target, emit);
  }

  /// The reads are independent, so they go out together — a picker that waits
  /// on three sequential round trips feels broken on a slow connection.
  Future<void> _reload(
    AssignmentTarget target,
    Emitter<PropertyAgentState> emit, {
    ResidenceOfferOutcome? outcome,
  }) async {
    try {
      final results = await Future.wait([
        _repository.forTarget(target),
        _repository.applications(target),
        _repository.candidates(target),
      ]);

      // A residence has no owner-visits flag of its own: RM-M11-10 is a field
      // on an annonce, and a residence is a container. Reading it for one would
      // mean guessing which unit speaks for the rest.
      final ownerVisits = switch (target) {
        AnnonceTarget(:final id) => await _ownerVisitsOf(id),
        ResidenceTarget() => null,
      };

      emit(
        PropertyAgentReady(
          target: target,
          assignments: results[0] as List<Assignment>,
          applications: results[1] as List<AgentApplication>,
          candidates: results[2] as List<AgentCandidateView>,
          ownerVisitsEnabled: ownerVisits,
          lastOutcome: outcome,
        ),
      );
    } catch (_) {
      emit(const PropertyAgentFailure());
    }
  }

  /// Null when the listing could not be read: the toggle then stays hidden
  /// rather than showing "off" for a flag nobody checked.
  Future<bool?> _ownerVisitsOf(String annonceId) async {
    try {
      return (await _annonces.getOne(annonceId)).ownerVisitsEnabled;
    } catch (_) {
      return null;
    }
  }

  /// RM-M11-10 — the owner puts himself in, or takes himself out of, the pool.
  Future<void> _onOwnerVisits(
    OwnerVisitsToggled event,
    Emitter<PropertyAgentState> emit,
  ) async {
    final current = state;
    if (current is! PropertyAgentReady) return;
    if (current.target case AnnonceTarget(:final id)) {
      emit(current.copyWith(isSavingOwnerVisits: true));
      try {
        final annonce = await _annonces.setOwnerVisits(id, enabled: event.enabled);
        emit(
          current.copyWith(
            ownerVisitsEnabled: annonce.ownerVisitsEnabled,
            isSavingOwnerVisits: false,
          ),
        );
      } catch (_) {
        emit(
          current.copyWith(
            isSavingOwnerVisits: false,
            lastActionFailed: true,
          ),
        );
      }
    }
  }

  Future<void> _onOffer(
    AgentOffered event,
    Emitter<PropertyAgentState> emit,
  ) async {
    final current = state;
    if (current is! PropertyAgentReady) return;

    emit(current.copyWith(mutatingId: event.agentAccountId));
    try {
      final outcome =
          await _repository.offer(current.target, event.agentAccountId);
      // Reload rather than patch: an offer moves the agent out of the
      // candidate list and into the pool, and the server is the authority.
      await _reload(current.target, emit, outcome: outcome);
    } catch (_) {
      emit(current.copyWith(clearMutating: true, lastActionFailed: true));
    }
  }

  Future<void> _onWithdraw(
    AssignmentWithdrawn event,
    Emitter<PropertyAgentState> emit,
  ) async {
    final current = state;
    if (current is! PropertyAgentReady) return;

    emit(current.copyWith(mutatingId: event.assignment.agentAccountId));
    try {
      await _repository.withdraw(current.target);
      await _reload(current.target, emit);
    } catch (_) {
      emit(current.copyWith(clearMutating: true, lastActionFailed: true));
    }
  }

  Future<void> _onAccept(
    ApplicationAccepted event,
    Emitter<PropertyAgentState> emit,
  ) async {
    final current = state;
    if (current is! PropertyAgentReady) return;

    emit(current.copyWith(mutatingId: event.application.agentAccountId));
    try {
      final outcome = await _repository.acceptApplication(event.application);
      await _reload(current.target, emit, outcome: outcome);
    } catch (_) {
      emit(current.copyWith(clearMutating: true, lastActionFailed: true));
    }
  }

  Future<void> _onDecline(
    ApplicationDeclined event,
    Emitter<PropertyAgentState> emit,
  ) async {
    final current = state;
    if (current is! PropertyAgentReady) return;

    emit(current.copyWith(mutatingId: event.application.agentAccountId));
    try {
      await _repository.declineApplication(event.application);
      await _reload(current.target, emit);
    } catch (_) {
      emit(current.copyWith(clearMutating: true, lastActionFailed: true));
    }
  }
}
