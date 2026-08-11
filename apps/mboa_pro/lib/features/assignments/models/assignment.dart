import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// Two-letter avatar fallback for a name the API gives as one string.
///
/// Assignment payloads carry `agentName` whole, not first/last, so the split is
/// here rather than reusing `BaseProfile.initials` — and every place that shows
/// an assigned agent uses this one, so they cannot disagree.
String initialsFromFullName(String? name) {
  final parts = (name ?? '')
      .trim()
      .split(RegExp(r'\s+'))
      .where((p) => p.isNotEmpty)
      .toList();
  if (parts.isEmpty) return '';
  if (parts.length == 1) return parts.first[0].toUpperCase();
  return (parts.first[0] + parts.last[0]).toUpperCase();
}

/// What an assignment is attached to (CDC M11 / RM-M10bis-05).
///
/// Every action has a listing form and a residence form, on different endpoints
/// with different payloads. A sealed target keeps that fork in the repository
/// instead of duplicating each screen, each bloc and each event.
sealed class AssignmentTarget extends Equatable {
  const AssignmentTarget(this.id);

  final String id;

  @override
  List<Object?> get props => [id, runtimeType];
}

class AnnonceTarget extends AssignmentTarget {
  const AnnonceTarget(super.id);
}

class ResidenceTarget extends AssignmentTarget {
  const ResidenceTarget(super.id);
}

/// Where an assignment has got to.
///
/// Seven wire values, but a screen only ever asks two questions of them: is
/// someone being waited on, and is an agent actually working this property.
enum AssignmentStatus {
  /// The agent applied and the prestataire has not answered.
  applied,

  /// The prestataire offered and the agent has not answered.
  pending,

  accepted,
  declined,

  /// The applicant took their application back.
  withdrawn,

  /// The prestataire removed the agent.
  revoked,

  /// The agent stepped down (RM-M11-06).
  resigned,

  unknown;

  static AssignmentStatus fromResponse(AssignmentResponseStatusEnum? value) =>
      switch (value) {
        AssignmentResponseStatusEnum.APPLIED => AssignmentStatus.applied,
        AssignmentResponseStatusEnum.PENDING => AssignmentStatus.pending,
        AssignmentResponseStatusEnum.ACCEPTED => AssignmentStatus.accepted,
        AssignmentResponseStatusEnum.DECLINED => AssignmentStatus.declined,
        AssignmentResponseStatusEnum.WITHDRAWN => AssignmentStatus.withdrawn,
        AssignmentResponseStatusEnum.REVOKED => AssignmentStatus.revoked,
        AssignmentResponseStatusEnum.RESIGNED => AssignmentStatus.resigned,
        _ => AssignmentStatus.unknown,
      };

  /// Somebody owes an answer.
  bool get isPending =>
      this == AssignmentStatus.applied || this == AssignmentStatus.pending;

  /// An agent is actually on this property — the only status that makes the
  /// "Planifier une visite avec Agent" button appear (RM-M07-01).
  bool get isLive => this == AssignmentStatus.accepted;

  /// Over, one way or another. Kept out of the live list without enumerating
  /// four terminal values at every call site.
  bool get isClosed => !isPending && !isLive;
}

/// Who started it (RM-M11-09).
///
/// Recorded and shown, but it **must not decide which list the assignment
/// appears in** — "mes biens" is a filter on status, not on origin. A
/// prestataire's offer that the agent accepted and an agent's application the
/// prestataire accepted are the same thing afterwards.
enum AssignmentInitiator {
  prestataire,
  agent,
  unknown;

  static AssignmentInitiator fromResponse(
    AssignmentResponseInitiatedByEnum? value,
  ) =>
      switch (value) {
        AssignmentResponseInitiatedByEnum.PRESTATAIRE =>
          AssignmentInitiator.prestataire,
        AssignmentResponseInitiatedByEnum.AGENT => AssignmentInitiator.agent,
        _ => AssignmentInitiator.unknown,
      };
}

/// One agent on one property.
class Assignment extends Equatable {
  const Assignment({
    required this.id,
    required this.target,
    required this.status,
    required this.initiatedBy,
    this.propertyTitle,
    this.agentAccountId,
    this.agentName,
    this.agentPhotoObjectKey,
    this.unitCount,
    this.createdAt,
    this.respondedAt,
  });

  final String id;
  final AssignmentTarget target;
  final AssignmentStatus status;
  final AssignmentInitiator initiatedBy;
  final String? propertyTitle;
  final String? agentAccountId;
  final String? agentName;

  /// Added 2026-08-11 — the assigned-agent list had no face to show before it.
  final String? agentPhotoObjectKey;

  String? get agentPhotoUrl => BaseProfile.mediaUrl(agentPhotoObjectKey);

  /// Residences only — how many units the assignment covers (RM-M10bis-11
  /// shows one entry per lot with its count, never one per unit).
  final int? unitCount;

  final DateTime? createdAt;
  final DateTime? respondedAt;

  static Assignment fromResponse(AssignmentResponse response) {
    // `residenceId` present means the assignment is the residence-level lot,
    // not the unit it happens to name.
    final target = response.residenceId != null
        ? ResidenceTarget(response.residenceId!)
        : AnnonceTarget(response.annonceId ?? '');

    return Assignment(
      id: response.id ?? '',
      target: target,
      status: AssignmentStatus.fromResponse(response.status),
      initiatedBy: AssignmentInitiator.fromResponse(response.initiatedBy),
      propertyTitle: response.annonceTitle,
      agentAccountId: response.agentAccountId,
      agentName: response.agentName,
      agentPhotoObjectKey: response.agentPhotoObjectKey,
      createdAt: response.createdAt,
      respondedAt: response.respondedAt,
    );
  }

  static Assignment fromResidenceSummary(ResidenceAssignmentSummary summary) =>
      Assignment(
        id: '${summary.residenceId}:${summary.agentAccountId}',
        target: ResidenceTarget(summary.residenceId ?? ''),
        status: switch (summary.status) {
          ResidenceAssignmentSummaryStatusEnum.APPLIED =>
            AssignmentStatus.applied,
          ResidenceAssignmentSummaryStatusEnum.PENDING =>
            AssignmentStatus.pending,
          ResidenceAssignmentSummaryStatusEnum.ACCEPTED =>
            AssignmentStatus.accepted,
          ResidenceAssignmentSummaryStatusEnum.DECLINED =>
            AssignmentStatus.declined,
          ResidenceAssignmentSummaryStatusEnum.WITHDRAWN =>
            AssignmentStatus.withdrawn,
          ResidenceAssignmentSummaryStatusEnum.REVOKED =>
            AssignmentStatus.revoked,
          ResidenceAssignmentSummaryStatusEnum.RESIGNED =>
            AssignmentStatus.resigned,
          _ => AssignmentStatus.unknown,
        },
        initiatedBy: switch (summary.initiatedBy) {
          ResidenceAssignmentSummaryInitiatedByEnum.PRESTATAIRE =>
            AssignmentInitiator.prestataire,
          ResidenceAssignmentSummaryInitiatedByEnum.AGENT =>
            AssignmentInitiator.agent,
          _ => AssignmentInitiator.unknown,
        },
        propertyTitle: summary.residenceName,
        agentAccountId: summary.agentAccountId,
        agentName: summary.agentName,
        agentPhotoObjectKey: summary.agentPhotoObjectKey,
        unitCount: summary.unitCount,
        createdAt: summary.createdAt,
        respondedAt: summary.respondedAt,
      );

  @override
  List<Object?> get props => [
        id,
        target,
        status,
        initiatedBy,
        propertyTitle,
        agentAccountId,
        agentName,
        agentPhotoObjectKey,
        unitCount,
        createdAt,
        respondedAt,
      ];
}

/// An agent the prestataire may offer this property to.
///
/// The server has already filtered to active agents whose zones cover the
/// property (RM-M11-08), so the picker shows the list as given rather than
/// re-deciding who is eligible.
class AgentCandidateView extends Equatable {
  const AgentCandidateView({
    required this.accountId,
    this.firstName,
    this.lastName,
    this.photoObjectKey,
    this.completedVisitCount = 0,
    this.averageRating,
    this.ratingCount = 0,
  });

  final String accountId;
  final String? firstName;
  final String? lastName;
  final String? photoObjectKey;
  final int completedVisitCount;

  /// **Null until somebody rates them**, and rating a visit is optional
  /// (RM-M07-07), so twelve visits with no rating is an ordinary state. Never
  /// render that as "0 ★" — it libels a perfectly good agent.
  final double? averageRating;
  final int ratingCount;

  bool get hasRating => averageRating != null && ratingCount > 0;

  String get fullName =>
      [firstName, lastName].where((p) => p != null && p.isNotEmpty).join(' ');

  String get initials {
    final f = (firstName ?? '').trim();
    final l = (lastName ?? '').trim();
    return ((f.isNotEmpty ? f[0] : '') + (l.isNotEmpty ? l[0] : ''))
        .toUpperCase();
  }

  String? get photoUrl => BaseProfile.mediaUrl(photoObjectKey);

  /// Sorted by surname, which is what the alphabetical picker groups on.
  String get sortKey =>
      ((lastName?.isNotEmpty ?? false) ? lastName! : (firstName ?? ''))
          .toUpperCase();

  static AgentCandidateView fromResponse(AgentCandidate candidate) =>
      AgentCandidateView(
        accountId: candidate.accountId ?? '',
        firstName: candidate.firstName,
        lastName: candidate.lastName,
        photoObjectKey: candidate.photoObjectKey,
        completedVisitCount: candidate.completedVisitCount ?? 0,
        averageRating: candidate.averageRating,
        ratingCount: candidate.ratingCount ?? 0,
      );

  @override
  List<Object?> get props => [
        accountId,
        firstName,
        lastName,
        photoObjectKey,
        completedVisitCount,
        averageRating,
        ratingCount,
      ];
}

/// An agent who applied and is waiting on the prestataire (RM-M11-07).
class AgentApplication extends Equatable {
  const AgentApplication({
    required this.id,
    required this.agentAccountId,
    required this.target,
    this.agentName,
    this.photoObjectKey,
    this.completedVisitCount = 0,
    this.unitCount,
    this.appliedAt,
  });

  /// For a listing this is the application id; for a residence the endpoints
  /// key on the agent's account id instead.
  final String id;
  final String agentAccountId;
  final AssignmentTarget target;
  final String? agentName;
  final String? photoObjectKey;
  final int completedVisitCount;
  final int? unitCount;
  final DateTime? appliedAt;

  String? get photoUrl => BaseProfile.mediaUrl(photoObjectKey);

  static AgentApplication fromAnnonce(AssignmentResponse response) =>
      AgentApplication(
        id: response.id ?? '',
        agentAccountId: response.agentAccountId ?? '',
        target: AnnonceTarget(response.annonceId ?? ''),
        agentName: response.agentName,
        appliedAt: response.createdAt,
      );

  static AgentApplication fromResidence(ResidenceApplicationSummary summary) =>
      AgentApplication(
        // The residence accept/decline endpoints take the agent's account id.
        id: summary.agentAccountId ?? '',
        agentAccountId: summary.agentAccountId ?? '',
        target: ResidenceTarget(summary.residenceId ?? ''),
        agentName: summary.agentName,
        photoObjectKey: summary.photoObjectKey,
        completedVisitCount: summary.completedVisitCount ?? 0,
        unitCount: summary.unitCount,
        appliedAt: summary.appliedAt,
      );

  @override
  List<Object?> get props => [
        id,
        agentAccountId,
        target,
        agentName,
        photoObjectKey,
        completedVisitCount,
        unitCount,
        appliedAt,
      ];
}

/// What a residence-level offer actually did (RM-M10bis-06).
///
/// Units that already have an agent are **skipped and reported**, not treated as
/// a failure. Swallowing this would tell a prestataire the whole residence was
/// offered when part of it was not.
class ResidenceOfferOutcome extends Equatable {
  const ResidenceOfferOutcome({this.offered = 0, this.skipped = const []});

  final int offered;
  final List<SkippedUnitView> skipped;

  bool get hasSkipped => skipped.isNotEmpty;

  static ResidenceOfferOutcome fromResponse(ResidenceAssignmentResult result) =>
      ResidenceOfferOutcome(
        offered: result.offered ?? 0,
        skipped: result.skipped
                ?.map(
                  (s) => SkippedUnitView(
                    title: s.title ?? '',
                    reason: s.reason ?? '',
                  ),
                )
                .toList() ??
            const [],
      );

  @override
  List<Object?> get props => [offered, skipped];
}

class SkippedUnitView extends Equatable {
  const SkippedUnitView({required this.title, required this.reason});

  final String title;
  final String reason;

  @override
  List<Object?> get props => [title, reason];
}


/// A published property in one of the agent's zones that has no agent yet
/// (RM-M11-07 / RM-M11-08).
///
/// `OpportunityItem` is a discriminated union on `kind`; flattening it here
/// means the screen renders one list instead of switching on a nullable pair.
class Opportunity extends Equatable {
  const Opportunity({
    required this.target,
    required this.title,
    this.photoKey,
    this.city,
    this.district,
    this.price,
    this.unitCount,
  });

  final AssignmentTarget target;
  final String title;
  final String? photoKey;
  final String? city;
  final String? district;
  final int? price;

  /// Residences only — how many units applying would cover (RM-M10bis-05).
  final int? unitCount;

  String? get photoUrl => BaseProfile.mediaUrl(photoKey);

  bool get isResidence => target is ResidenceTarget;

  static Opportunity? fromItem(OpportunityItem item) {
    if (item.listing case final listing?) {
      return Opportunity(
        target: AnnonceTarget(listing.annonceId ?? ''),
        title: listing.title ?? '',
        photoKey: listing.primaryPhotoKey,
        city: listing.city,
        district: listing.district,
        price: listing.price ?? listing.monthlyRent,
      );
    }
    if (item.residence case final residence?) {
      return Opportunity(
        target: ResidenceTarget(residence.residenceId ?? ''),
        title: residence.residenceName ?? '',
        photoKey: residence.primaryPhotoKey,
        city: residence.city,
        district: residence.district,
        price: residence.fromPrice ?? residence.fromMonthlyRent,
        unitCount: residence.unitCount,
      );
    }
    // A kind this build does not know: drop the row rather than render a blank.
    return null;
  }

  @override
  List<Object?> get props =>
      [target, title, photoKey, city, district, price, unitCount];
}

/// One place an agent works, as the public profile names it.
///
/// `district` is absent when the agent covers the whole city — the same
/// either/or the agent's own zones use, expressed here as names rather than
/// ids, because nothing on this screen needs to look them up.
class AgentZoneLabel extends Equatable {
  const AgentZoneLabel({required this.city, this.district});

  final String city;
  final String? district;

  bool get isWholeCity => district == null || district!.isEmpty;

  String get label => isWholeCity ? city : '$district, $city';

  @override
  List<Object?> get props => [city, district];
}

/// What a prestataire may see about an agent (`GET /search/agents/{id}`).
///
/// Public, and deliberately thin: **no phone, no email, nothing from KYC** —
/// the agent's number reaches only the people who need it, and the visit sheet
/// gives the agent the user's number rather than the other way round.
///
/// A suspended or pending agent still resolves. They are named on every visit
/// they carried out, and 404-ing would dead-link that history; the payload
/// makes no claim that they are currently working.
class AgentPublicProfileView extends Equatable {
  const AgentPublicProfileView({
    required this.accountId,
    this.firstName,
    this.lastName,
    this.photoObjectKey,
    this.completedVisitCount = 0,
    this.averageRating,
    this.ratingCount = 0,
    this.zones = const [],
    this.memberSince,
  });

  final String accountId;
  final String? firstName;
  final String? lastName;
  final String? photoObjectKey;
  final int completedVisitCount;

  /// Null until somebody rates them; rating is optional (RM-M07-07).
  final double? averageRating;
  final int ratingCount;

  final List<AgentZoneLabel> zones;
  final DateTime? memberSince;

  String get fullName =>
      [firstName, lastName].where((p) => p != null && p.isNotEmpty).join(' ');

  String get initials => initialsFromFullName(fullName);

  String? get photoUrl => BaseProfile.mediaUrl(photoObjectKey);

  bool get hasRating => averageRating != null && ratingCount > 0;

  static AgentPublicProfileView fromResponse(AgentPublicProfile response) =>
      AgentPublicProfileView(
        accountId: response.accountId ?? '',
        firstName: response.firstName,
        lastName: response.lastName,
        photoObjectKey: response.photoObjectKey,
        completedVisitCount: response.completedVisitCount ?? 0,
        averageRating: response.averageRating,
        ratingCount: response.ratingCount ?? 0,
        zones: response.zones
                ?.map(
                  (z) => AgentZoneLabel(
                    city: z.city ?? '',
                    district: z.district,
                  ),
                )
                .where((z) => z.city.isNotEmpty)
                .toList() ??
            const [],
        memberSince: response.memberSince,
      );

  @override
  List<Object?> get props => [
        accountId,
        firstName,
        lastName,
        photoObjectKey,
        completedVisitCount,
        averageRating,
        ratingCount,
        zones,
        memberSince,
      ];
}
