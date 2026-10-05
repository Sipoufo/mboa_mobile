import 'package:mboa_shared/mboa_shared.dart';

/// The clock rules of M07, on the tenant's side.
///
/// Pure functions rather than getters on [Visit] because the same visit obeys
/// different clocks depending on who is looking: the tenant may cancel up to
/// four hours before, the visitor up to one (RM-M07-04 / RM-M16-04), and
/// [Visit] is shared by both apps.
///
/// The server has the last word on all of these. These exist so the screen
/// does not offer a button that is going to be refused.
abstract final class VisitRules {
  /// RM-M07-04 — the tenant's window closes four hours before the slot.
  static const cancelCutoff = Duration(hours: 4);

  /// How long before and after the hour "I am here" makes sense.
  ///
  /// Not in the CDC: the rule is only that both parties confirm on the spot
  /// (RM-M07-05). An hour either side covers arriving early and a visit that
  /// runs over, without leaving the button live for a day.
  static const presenceWindow = Duration(hours: 1);

  static bool canCancel(Visit visit, {DateTime? now}) {
    if (!visit.status.isOpen) return false;
    final at = visit.scheduledAt;
    // A visit with no time on it cannot be too late to cancel.
    if (at == null) return true;
    return at.difference(now ?? DateTime.now()) > cancelCutoff;
  }

  /// Inside four hours, cancelling is blocked and the tenant is told to reach
  /// the visitor directly (CE-M07-03) — they may already be on their way.
  static bool isTooLateToCancel(Visit visit, {DateTime? now}) =>
      visit.status.isOpen &&
      visit.scheduledAt != null &&
      !canCancel(visit, now: now);

  /// RM-M07-05 — "I am here", once, around the hour, and only if this half is
  /// still missing.
  static bool canConfirmPresence(Visit visit, {DateTime? now}) {
    if (!visit.status.isOpen || visit.clientConfirmedAt != null) return false;
    final at = visit.scheduledAt;
    if (at == null) return false;
    final difference = at.difference(now ?? DateTime.now()).abs();
    return difference <= presenceWindow;
  }

  /// This half is in, the other is not — the screen says who is awaited rather
  /// than leaving the tenant wondering whether the tap worked.
  static bool isWaitingForVisitor(Visit visit) =>
      visit.status.isOpen &&
      visit.clientConfirmedAt != null &&
      visit.visitorConfirmedAt == null;

  /// RM-M07bis-01 — only a visit **both parties confirmed** can be reported
  /// on, which is exactly what `COMPLETED` means after RM-M07-05.
  ///
  /// `NOT_FULFILLED` is the trap: "effectuée — non confirmée par le client"
  /// looks like a visit that happened, and the CDC refuses a report for it
  /// precisely because only one side vouched for it.
  ///
  /// Whether one was already written is the server's to say (one per visit);
  /// the screen asks when it opens.
  static bool canWriteReview(Visit visit) =>
      visit.status == VisitStatus.completed;

  /// RM-M07-07 — the agent's service, after a visit that actually happened.
  /// Never a prestataire showing their own property, and never the property
  /// itself, which is M07bis.
  static bool canRateVisitor(Visit visit) =>
      visit.status == VisitStatus.completed &&
      visit.visitorKind == VisitorKind.agent;
}
