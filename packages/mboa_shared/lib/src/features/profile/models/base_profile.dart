import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';

import 'account_role.dart';

/// The base profile shared by both apps (CDC M02): the account (`/me`) plus the
/// base user profile (`/users/me`). App Mboa Pro extends this with business
/// fields; App Mboa users use it directly.
class BaseProfile extends Equatable {
  const BaseProfile({
    this.email,
    this.phoneNumber,
    this.role = AccountRole.user,
    this.firstName,
    this.lastName,
    this.searchCity,
    this.searchCityId,
    this.photoObjectKey,
  });

  final String? email;
  final String? phoneNumber;
  final AccountRole role;
  final String? firstName;
  final String? lastName;

  /// Display name of the search city (from the response).
  final String? searchCity;

  /// ID of the search city (used when updating).
  final String? searchCityId;
  final String? photoObjectKey;

  bool get isPrestataire => role.isPrestataire;
  bool get isAgent => role.isAgent;

  /// "Prénom Nom" when available, else empty. Subclasses may override to add a
  /// fallback (e.g. a business display name).
  String get fullName {
    final parts = [firstName, lastName].where((p) => p != null && p.isNotEmpty);
    return parts.join(' ');
  }

  /// Uppercase initials for the avatar placeholder.
  String get initials {
    final f = (firstName ?? '').trim();
    final l = (lastName ?? '').trim();
    final first = f.isNotEmpty ? f[0] : '';
    final last = l.isNotEmpty ? l[0] : '';
    return (first + last).toUpperCase();
  }

  /// Absolute URL for the profile photo, or null when unset.
  String? get photoUrl => mediaUrl(photoObjectKey);

  /// What an avatar should render. The personal photo here; App Mboa Pro
  /// overrides it, because a prestataire's identity is their business logo.
  String? get avatarUrl => photoUrl;

  /// Overlays the role-specific identity onto the account fields. App Mboa Pro
  /// uses it for an agent, whose name and photo live on `/agents/me` rather
  /// than on the base profile.
  BaseProfile copyWith({
    String? firstName,
    String? lastName,
    String? photoObjectKey,
  }) =>
      BaseProfile(
        email: email,
        phoneNumber: phoneNumber,
        role: role,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        searchCity: searchCity,
        searchCityId: searchCityId,
        photoObjectKey: photoObjectKey ?? this.photoObjectKey,
      );

  /// Builds an absolute R2 URL from a stored object key.
  static String? mediaUrl(String? key) {
    if (key == null || key.isEmpty) return null;
    return '${Environment.r2PublicBaseUrl}/$key';
  }

  @override
  List<Object?> get props =>
      [email, phoneNumber, role, firstName, lastName, searchCity, searchCityId, photoObjectKey];
}

/// The editable base fields submitted from any Edit Profile screen.
///
/// [searchCityId] is the city chosen in the picker; when null the current city
/// is left unchanged (partial update).
class BaseProfileEdit extends Equatable {
  const BaseProfileEdit({
    required this.firstName,
    required this.lastName,
    this.searchCityId,
  });

  final String firstName;
  final String lastName;
  final String? searchCityId;

  @override
  List<Object?> get props => [firstName, lastName, searchCityId];
}
