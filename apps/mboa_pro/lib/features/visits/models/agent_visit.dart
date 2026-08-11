import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mboa_core/mboa_core.dart';

/// Where a visit has got to.
enum VisitStatus {
  scheduled,
  cancelled,
  completed,
  unknown;

  static VisitStatus fromResponse(VisiteResponseStatusEnum? value) =>
      switch (value) {
        VisiteResponseStatusEnum.SCHEDULED => VisitStatus.scheduled,
        VisiteResponseStatusEnum.CANCELLED => VisitStatus.cancelled,
        VisiteResponseStatusEnum.COMPLETED => VisitStatus.completed,
        _ => VisitStatus.unknown,
      };

  static VisitStatus fromDetail(AgentVisiteDetailStatusEnum? value) =>
      switch (value) {
        AgentVisiteDetailStatusEnum.SCHEDULED => VisitStatus.scheduled,
        AgentVisiteDetailStatusEnum.CANCELLED => VisitStatus.cancelled,
        AgentVisiteDetailStatusEnum.COMPLETED => VisitStatus.completed,
        _ => VisitStatus.unknown,
      };
}

/// One visit in the agent's list (CDC M16).
class AgentVisit extends Equatable {
  const AgentVisit({
    required this.id,
    required this.status,
    this.annonceId,
    this.annonceTitle,
    this.scheduledAt,
  });

  final String id;
  final VisitStatus status;
  final String? annonceId;
  final String? annonceTitle;
  final DateTime? scheduledAt;

  /// Still to happen, and not cancelled.
  bool get isUpcoming =>
      status == VisitStatus.scheduled &&
      (scheduledAt?.isAfter(DateTime.now()) ?? false);

  /// Today's work, in the agent's own day — a visit at 08:00 is still today's
  /// at 09:00, so this compares dates rather than "is in the future".
  bool isToday({DateTime? now}) {
    final at = scheduledAt;
    if (at == null || status != VisitStatus.scheduled) return false;
    final today = now ?? DateTime.now();
    final local = at.toLocal();
    return local.year == today.year &&
        local.month == today.month &&
        local.day == today.day;
  }

  static AgentVisit fromResponse(VisiteResponse response) => AgentVisit(
        id: response.id ?? '',
        status: VisitStatus.fromResponse(response.status),
        annonceId: response.annonceId,
        annonceTitle: response.annonceTitle,
        scheduledAt: response.scheduledAt?.toLocal(),
      );

  @override
  List<Object?> get props => [id, status, annonceId, annonceTitle, scheduledAt];
}

/// Everything the agent needs on the day (CDC M16 flux agent).
///
/// **This is the only place the exact address appears** (RM-M16-01), and the
/// only place the app shows anyone's phone number — the agent is going to a
/// stranger's property to meet another stranger, and needs to reach both.
class AgentVisitDetail extends Equatable {
  const AgentVisitDetail({
    required this.id,
    required this.status,
    this.annonceId,
    this.annonceTitle,
    this.exactAddress,
    this.latitude,
    this.longitude,
    this.scheduledAt,
    this.userName,
    this.userPhone,
    this.prestataireName,
    this.prestatairePhone,
    this.startedAt,
    this.canStart = false,
    this.reportSubmitted = false,
  });

  final String id;
  final VisitStatus status;
  final String? annonceId;
  final String? annonceTitle;
  final String? exactAddress;
  final double? latitude;
  final double? longitude;
  final DateTime? scheduledAt;
  final String? userName;
  final String? userPhone;
  final String? prestataireName;
  final String? prestatairePhone;
  final DateTime? startedAt;

  /// **Server-computed.** Whether the visit may be started at all — the
  /// day-of rule lives there, not here, so the app never re-derives it.
  final bool canStart;

  /// RM-M16-03 — a filed report is locked; there is no editing it after.
  final bool reportSubmitted;

  bool get hasStarted => startedAt != null;

  bool get hasPosition => latitude != null && longitude != null;

  static AgentVisitDetail fromResponse(AgentVisiteDetail response) =>
      AgentVisitDetail(
        id: response.id ?? '',
        status: VisitStatus.fromDetail(response.status),
        annonceId: response.annonceId,
        annonceTitle: response.annonceTitle,
        exactAddress: response.exactAddress,
        latitude: response.latitude,
        longitude: response.longitude,
        scheduledAt: response.scheduledAt?.toLocal(),
        userName: response.userName,
        userPhone: response.userPhone,
        prestataireName: response.prestataireName,
        prestatairePhone: response.prestatairePhone,
        startedAt: response.startedAt?.toLocal(),
        canStart: response.canStart ?? false,
        reportSubmitted: response.reportSubmitted ?? false,
      );

  @override
  List<Object?> get props => [
        id,
        status,
        annonceId,
        annonceTitle,
        exactAddress,
        latitude,
        longitude,
        scheduledAt,
        userName,
        userPhone,
        prestataireName,
        prestatairePhone,
        startedAt,
        canStart,
        reportSubmitted,
      ];
}

/// RM-M16-02 — the agent must be within 500 m of the property to start.
///
/// A pure function of two positions, so the rule is testable without a device.
/// Beyond the radius the visit is **not blocked**: Doc 10 asks for a manual
/// confirmation with a written justification, because a GPS fix can be wrong
/// and an agent standing at the gate should not be stranded by it.
abstract final class VisitGeofence {
  static const double radiusMetres = 500;

  static double? distanceTo(
    AgentVisitDetail visit, {
    required double latitude,
    required double longitude,
  }) {
    if (!visit.hasPosition) return null;
    return Geolocator.distanceBetween(
      latitude,
      longitude,
      visit.latitude!,
      visit.longitude!,
    );
  }

  /// True when the agent is far enough away that Doc 10 wants a justification.
  ///
  /// A property with no coordinates cannot be checked, so it never demands one
  /// — refusing to start a visit because the *listing* is incomplete would
  /// punish the agent for someone else's omission.
  static bool needsOverride(double? distanceMetres) =>
      distanceMetres != null && distanceMetres > radiusMetres;
}
