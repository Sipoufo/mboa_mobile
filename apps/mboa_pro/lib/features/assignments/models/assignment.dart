import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

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
  });

  final String accountId;
  final String? firstName;
  final String? lastName;
  final String? photoObjectKey;

  /// The only quality signal a prestataire currently gets. `averageRating` and
  /// `ratingCount` exist on the agent record but are not exposed here — see
  /// `docs/backend-requests.md` §11.
  final int completedVisitCount;

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
      );

  @override
  List<Object?> get props =>
      [accountId, firstName, lastName, photoObjectKey, completedVisitCount];
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
