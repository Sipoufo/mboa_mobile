import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

import 'prestataire_type.dart';

/// App Mboa Pro's profile: the shared [BaseProfile] plus the prestataire
/// business fields (`/prestataires/me`).
///
/// An agent has no business fields; their name and photo are overlaid from
/// `/agents/me` by the repository, because the agent record — not the base
/// profile — is what the server and other prestataires read.
class ProfileData extends BaseProfile {
  const ProfileData({
    super.email,
    super.phoneNumber,
    super.role,
    super.firstName,
    super.lastName,
    super.searchCity,
    super.searchCityId,
    super.photoObjectKey,
    this.displayName,
    this.mainCity,
    this.mainCityId,
    this.type,
    this.logoObjectKey,
    this.registrationNumber,
    this.profileComplete,
  });

  /// Adds the business fields on top of a loaded [base].
  factory ProfileData.fromBase(
    BaseProfile base, {
    String? displayName,
    String? mainCity,
    String? mainCityId,
    PrestataireType? type,
    String? logoObjectKey,
    String? registrationNumber,
    bool? profileComplete,
  }) {
    return ProfileData(
      email: base.email,
      phoneNumber: base.phoneNumber,
      role: base.role,
      firstName: base.firstName,
      lastName: base.lastName,
      searchCity: base.searchCity,
      searchCityId: base.searchCityId,
      photoObjectKey: base.photoObjectKey,
      displayName: displayName,
      mainCity: mainCity,
      mainCityId: mainCityId,
      type: type,
      logoObjectKey: logoObjectKey,
      registrationNumber: registrationNumber,
      profileComplete: profileComplete,
    );
  }

  final String? displayName;
  final String? mainCity;
  final String? mainCityId;
  final PrestataireType? type;
  final String? logoObjectKey;

  /// CNI or RCCM (2026-08-20 spec). The Contrat Mboa prints the prestataire's
  /// registration alongside the tenant's CNI (M08 "Identité prestataire"), so a
  /// profile without it cannot produce a compliant contract.
  final String? registrationNumber;

  /// Server-computed (`PrestataireProfileResponse.profileComplete`) — the
  /// authority for RM-M10-01, since it is what `publish` enforces.
  ///
  /// For an agent this is the **agent record's** flag (name + photo + a zone).
  /// Null on any backend that does not send it; [isProfileComplete] decides
  /// what to do about that.
  final bool? profileComplete;

  /// The prestataire's logo, falling back to the personal photo — so an account
  /// that only ever uploaded a photo does not lose its avatar. An agent has no
  /// logo, and their `photoObjectKey` is already the agent record's.
  @override
  String? get avatarUrl => BaseProfile.mediaUrl(logoObjectKey) ?? super.avatarUrl;

  /// RM-M10-01. Prefers the server's verdict; falls back to checking the same
  /// three things ourselves when it is absent, because treating a missing flag
  /// as "incomplete" would block every publish in the app.
  bool get isProfileComplete =>
      profileComplete ??
      (logoObjectKey != null || photoObjectKey != null) &&
          type != null &&
          (mainCityId ?? searchCityId) != null;

  /// "Prénom Nom", falling back to the business display name.
  @override
  String get fullName {
    final base = super.fullName;
    return base.isNotEmpty ? base : (displayName ?? '');
  }

  @override
  String get initials {
    final f = (firstName ?? displayName ?? '').trim();
    final l = (lastName ?? '').trim();
    final first = f.isNotEmpty ? f[0] : '';
    final last = l.isNotEmpty ? l[0] : '';
    return (first + last).toUpperCase();
  }

  // Every field — a partial list makes bloc drop an emission as a no-op and the
  // screen silently not update. See the invariant in PROJECT_STATUS.md.
  @override
  List<Object?> get props => [
        ...super.props,
        displayName,
        mainCity,
        mainCityId,
        type,
        logoObjectKey,
        registrationNumber,
        profileComplete,
      ];
}

/// The editable subset submitted from the Pro Edit Profile screen. City IDs
/// come from the location picker; when null the current value is unchanged.
class ProfileEdit extends Equatable {
  const ProfileEdit({
    required this.firstName,
    required this.lastName,
    required this.isPrestataire,
    this.isAgent = false,
    this.searchCityId,
    this.displayName,
    this.mainCityId,
    this.type,
    this.registrationNumber,
  });

  final String firstName;
  final String lastName;
  final bool isPrestataire;

  /// An agent's name lives on `/agents/me`, not `/users/me` — it is what a
  /// prestataire sees when choosing a candidate, so the save has to write it.
  final bool isAgent;
  final String? searchCityId;
  final String? displayName;
  final String? mainCityId;
  final PrestataireType? type;

  /// CNI / RCCM — required by the Contrat Mboa (M08).
  final String? registrationNumber;

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        isPrestataire,
        isAgent,
        searchCityId,
        displayName,
        mainCityId,
        type,
        registrationNumber,
      ];
}
