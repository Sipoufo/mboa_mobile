import '../models/agent_visit.dart';

/// One visit's sheet, and what the visitor does with it on the day — the
/// same for an agent (CDC M16) and for an owner showing their own property
/// (§14): the server answers both with `AgentVisiteDetail`, and presence is
/// confirmed through the same endpoint.
abstract interface class VisitDetailSource {
  Future<AgentVisitDetail> detail(String id);

  /// RM-M07-05 / RM-M16-02 — the coordinates go with it; the server decides.
  Future<void> confirmPresence(
    String id, {
    required double latitude,
    required double longitude,
    String? overrideReason,
  });

  /// Up to one hour before the slot; the server owns the cutoff and answers
  /// `409 CANCELLATION_TOO_LATE` after it.
  Future<void> cancel(String id);
}

/// RM-M15-06 — an owner answers a proposed time; an agent never sees one.
///
/// Kept apart from [VisitDetailSource] so the agent's repository does not
/// grow two methods it could only throw from.
abstract interface class VisitRequestResponder {
  Future<void> confirm(String id);

  Future<void> decline(String id);
}

/// Who is reading the sheet — it decides the source and what is shown.
enum VisitPersona { agent, owner }
