import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';

/// Who carries the visit out (Doc 10 M07, revised 2026-08-13).
///
/// A visit is no longer always an agent's: a prestataire can enable personal
/// visits on a listing (RM-M11-10) and joins the bookable pool himself.
enum VisitorKind {
  agent,
  owner,
  unknown;

  static VisitorKind fromResponse(VisiteResponseVisitorKindEnum? value) =>
      switch (value) {
        VisiteResponseVisitorKindEnum.AGENT => VisitorKind.agent,
        VisiteResponseVisitorKindEnum.OWNER => VisitorKind.owner,
        _ => VisitorKind.unknown,
      };
}

/// Where a visit has got to.
///
/// [requested] is a slot proposed to an owner who confirms by hand
/// (RM-M15-06); [notFulfilled] is a visit nobody confirmed being at
/// (RM-M16-05). Both arrived with the mutual-confirmation flow.
enum VisitStatus {
  requested,
  scheduled,
  cancelled,
  completed,
  notFulfilled,
  unknown;

  static VisitStatus fromResponse(VisiteResponseStatusEnum? value) =>
      switch (value) {
        VisiteResponseStatusEnum.REQUESTED => VisitStatus.requested,
        VisiteResponseStatusEnum.SCHEDULED => VisitStatus.scheduled,
        VisiteResponseStatusEnum.CANCELLED => VisitStatus.cancelled,
        VisiteResponseStatusEnum.COMPLETED => VisitStatus.completed,
        VisiteResponseStatusEnum.NOT_FULFILLED => VisitStatus.notFulfilled,
        _ => VisitStatus.unknown,
      };

  /// Still to happen — the visit is on somebody's calendar.
  bool get isOpen => this == VisitStatus.requested ||
      this == VisitStatus.scheduled;
}

/// One visit in a list, whoever is looking.
///
/// The same `VisiteResponse` is served to the client (`GET /visites`), the
/// agent (`GET /agents/me/visites`) and the prestataire visiting his own
/// property (`GET /prestataires/me/visites`), so this model is shared by both
/// apps. What each app *does* with it — and the detail behind it — is theirs.
class Visit extends Equatable {
  const Visit({
    required this.id,
    required this.status,
    this.annonceId,
    this.annonceTitle,
    this.scheduledAt,
    this.visitorAccountId,
    this.visitorKind = VisitorKind.unknown,
    this.visitorConfirmedAt,
    this.clientConfirmedAt,
  });

  final String id;
  final VisitStatus status;
  final String? annonceId;
  final String? annonceTitle;
  final DateTime? scheduledAt;
  final String? visitorAccountId;
  final VisitorKind visitorKind;

  /// RM-M07-05 — presence is confirmed by **both** parties. Either timestamp
  /// alone means the visit is still waiting on the other one.
  final DateTime? visitorConfirmedAt;
  final DateTime? clientConfirmedAt;

  /// Still to happen, and not cancelled.
  bool get isUpcoming =>
      status.isOpen && (scheduledAt?.isAfter(DateTime.now()) ?? false);

  /// Today's work, in the visitor's own day — a visit at 08:00 is still today's
  /// at 09:00, so this compares dates rather than "is in the future".
  bool isToday({DateTime? now}) {
    final at = scheduledAt;
    if (at == null || !status.isOpen) return false;
    final today = now ?? DateTime.now();
    final local = at.toLocal();
    return local.year == today.year &&
        local.month == today.month &&
        local.day == today.day;
  }

  static Visit fromResponse(VisiteResponse response) => Visit(
        id: response.id ?? '',
        status: VisitStatus.fromResponse(response.status),
        annonceId: response.annonceId,
        annonceTitle: response.annonceTitle,
        scheduledAt: response.scheduledAt?.toLocal(),
        visitorAccountId: response.visitorAccountId,
        visitorKind: VisitorKind.fromResponse(response.visitorKind),
        visitorConfirmedAt: response.visitorConfirmedAt?.toLocal(),
        clientConfirmedAt: response.clientConfirmedAt?.toLocal(),
      );

  @override
  List<Object?> get props => [
        id,
        status,
        annonceId,
        annonceTitle,
        scheduledAt,
        visitorAccountId,
        visitorKind,
        visitorConfirmedAt,
        clientConfirmedAt,
      ];
}
