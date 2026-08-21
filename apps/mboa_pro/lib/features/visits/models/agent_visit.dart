import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

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
    this.visitorConfirmedAt,
    this.clientConfirmedAt,
    this.canConfirm = false,
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

  /// RM-M07-05 — the agent's own presence, geolocated.
  final DateTime? visitorConfirmedAt;

  /// The client's, taken in the other app. The visit only completes when both
  /// are in, and neither party can supply the other's.
  final DateTime? clientConfirmedAt;

  /// **Server-computed.** Whether presence may be confirmed at all — the
  /// day-of rule lives there, not here, so the app never re-derives it.
  final bool canConfirm;

  bool get hasConfirmed => visitorConfirmedAt != null;

  /// The agent has done their half and the visit is not complete: the screen
  /// says who is being waited on rather than offering the button again.
  bool get isAwaitingClient => hasConfirmed && clientConfirmedAt == null && status != VisitStatus.completed;

  bool get hasPosition => latitude != null && longitude != null;

  static VisitStatus _statusOf(AgentVisiteDetailStatusEnum? value) => switch (value) {
    AgentVisiteDetailStatusEnum.REQUESTED => VisitStatus.requested,
    AgentVisiteDetailStatusEnum.SCHEDULED => VisitStatus.scheduled,
    AgentVisiteDetailStatusEnum.CANCELLED => VisitStatus.cancelled,
    AgentVisiteDetailStatusEnum.COMPLETED => VisitStatus.completed,
    AgentVisiteDetailStatusEnum.NOT_FULFILLED => VisitStatus.notFulfilled,
    _ => VisitStatus.unknown,
  };

  static AgentVisitDetail fromResponse(AgentVisiteDetail response) => AgentVisitDetail(
    id: response.id ?? '',
    status: _statusOf(response.status),
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
    visitorConfirmedAt: response.visitorConfirmedAt?.toLocal(),
    clientConfirmedAt: response.clientConfirmedAt?.toLocal(),
    canConfirm: response.canConfirm ?? false,
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
    visitorConfirmedAt,
    clientConfirmedAt,
    canConfirm,
  ];
}

/// RM-M16-02 — the visitor must be within 500 m of the property to confirm.
///
/// A pure function of two positions, so the rule is testable without a device.
/// Beyond the radius the confirmation is **not blocked**: Doc 10 asks for a
/// manual confirmation with a written justification, because a GPS fix can be
/// wrong and an agent standing at the gate should not be stranded by it.
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
  /// — refusing to confirm a visit because the *listing* is incomplete would
  /// punish the agent for someone else's omission.
  static bool needsOverride(double? distanceMetres) => distanceMetres != null && distanceMetres > radiusMetres;
}
