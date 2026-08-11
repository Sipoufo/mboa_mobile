import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// Where the admin has got to with this agent's account.
///
/// An agent is only offered work while `active` (RM-M11-05 removes a suspended
/// agent from their assignments), so the profile screen has to say which of
/// these applies rather than leaving the agent guessing why nothing arrives.
enum AgentStatus {
  pending,
  active,
  suspended,
  deleted,
  unknown;

  static AgentStatus fromResponse(AgentProfileResponseStatusEnum? value) =>
      switch (value) {
        AgentProfileResponseStatusEnum.PENDING => AgentStatus.pending,
        AgentProfileResponseStatusEnum.ACTIVE => AgentStatus.active,
        AgentProfileResponseStatusEnum.SUSPENDED => AgentStatus.suspended,
        AgentProfileResponseStatusEnum.DELETED => AgentStatus.deleted,
        _ => AgentStatus.unknown,
      };
}

/// One place an agent will work (RM-M15-04).
///
/// A zone is **either** a whole city **or** a single district, never both — the
/// backend builds them with `AgentZone.ofCity` / `ofDistrict`, leaving the other
/// id null. Modelled as a sealed pair rather than two nullable fields so a
/// "both set" state cannot be represented.
sealed class AgentZone extends Equatable {
  const AgentZone(this.id);

  /// City id or district id, depending on the variant.
  final String id;

  static AgentZone? fromResponse(ZoneResponse response) {
    if (response.districtId case final districtId?) {
      return AgentDistrictZone(districtId);
    }
    if (response.cityId case final cityId?) return AgentCityZone(cityId);
    // Neither set: not something the backend produces, but it costs nothing to
    // drop the row instead of inventing a zone.
    return null;
  }

  @override
  List<Object?> get props => [id, runtimeType];
}

/// The whole city.
class AgentCityZone extends AgentZone {
  const AgentCityZone(super.id);
}

/// One district within a city.
class AgentDistrictZone extends AgentZone {
  const AgentDistrictZone(super.id);
}

/// The agent's own profile (CDC M15).
///
/// **Distinct from the base `/users/me` profile**, which an agent also has: the
/// name and photo here live on the agent record, are written by
/// `PATCH /agents/me`, and are what [profileComplete] and the prestataire-facing
/// candidate card read. Writing the base profile instead leaves an agent
/// looking complete in the app and unassignable on the server.
class AgentProfile extends Equatable {
  const AgentProfile({
    required this.accountId,
    this.firstName,
    this.lastName,
    this.photoObjectKey,
    this.zones = const [],
    this.acceptingAssignments = true,
    this.completedVisitCount = 0,
    this.averageRating,
    this.ratingCount = 0,
    this.status = AgentStatus.unknown,
    this.profileComplete = false,
    this.createdAt,
  });

  final String accountId;
  final String? firstName;
  final String? lastName;
  final String? photoObjectKey;
  final List<AgentZone> zones;

  /// RM-M15-05 — "Inactif" when false: no new assignments, but visits already
  /// scheduled are still carried out.
  final bool acceptingAssignments;

  final int completedVisitCount;
  final double? averageRating;
  final int ratingCount;
  final AgentStatus status;

  /// Server-computed: name + photo + at least one zone. The authority for
  /// whether this agent can be offered work at all.
  final bool profileComplete;

  final DateTime? createdAt;

  String get fullName =>
      [firstName, lastName].where((p) => p != null && p.isNotEmpty).join(' ');

  String get initials {
    final f = (firstName ?? '').trim();
    final l = (lastName ?? '').trim();
    return ((f.isNotEmpty ? f[0] : '') + (l.isNotEmpty ? l[0] : ''))
        .toUpperCase();
  }

  String? get photoUrl => BaseProfile.mediaUrl(photoObjectKey);

  bool get hasRating => averageRating != null && ratingCount > 0;

  List<String> get cityZoneIds =>
      zones.whereType<AgentCityZone>().map((z) => z.id).toList();

  List<String> get districtZoneIds =>
      zones.whereType<AgentDistrictZone>().map((z) => z.id).toList();

  static AgentProfile fromResponse(AgentProfileResponse response) =>
      AgentProfile(
        accountId: response.accountId ?? '',
        firstName: response.firstName,
        lastName: response.lastName,
        photoObjectKey: response.photoObjectKey,
        zones:
            response.zones?.map(AgentZone.fromResponse).nonNulls.toList() ??
                const [],
        acceptingAssignments: response.acceptingAssignments ?? true,
        completedVisitCount: response.completedVisitCount ?? 0,
        averageRating: response.averageRating,
        ratingCount: response.ratingCount ?? 0,
        status: AgentStatus.fromResponse(response.status),
        profileComplete: response.profileComplete ?? false,
        createdAt: response.createdAt,
      );

  /// Only what the optimistic toggle needs — the rest is server-owned.
  AgentProfile copyWith({bool? acceptingAssignments}) => AgentProfile(
        accountId: accountId,
        firstName: firstName,
        lastName: lastName,
        photoObjectKey: photoObjectKey,
        zones: zones,
        acceptingAssignments: acceptingAssignments ?? this.acceptingAssignments,
        completedVisitCount: completedVisitCount,
        averageRating: averageRating,
        ratingCount: ratingCount,
        status: status,
        profileComplete: profileComplete,
        createdAt: createdAt,
      );

  // Every field, deliberately — a partial list makes bloc drop an emission that
  // compares equal and the screen silently does not update.
  @override
  List<Object?> get props => [
        accountId,
        firstName,
        lastName,
        photoObjectKey,
        zones,
        acceptingAssignments,
        completedVisitCount,
        averageRating,
        ratingCount,
        status,
        profileComplete,
        createdAt,
      ];
}
