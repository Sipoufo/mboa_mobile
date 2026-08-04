import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

import 'prestataire_type.dart';

/// App Mboa Pro's profile: the shared [BaseProfile] plus the prestataire
/// business fields (`/prestataires/me`). Agents carry no business fields.
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
  });

  /// Adds the business fields on top of a loaded [base].
  factory ProfileData.fromBase(
    BaseProfile base, {
    String? displayName,
    String? mainCity,
    String? mainCityId,
    PrestataireType? type,
    String? logoObjectKey,
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
    );
  }

  final String? displayName;
  final String? mainCity;
  final String? mainCityId;
  final PrestataireType? type;
  final String? logoObjectKey;

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

  @override
  List<Object?> get props =>
      [...super.props, displayName, mainCity, mainCityId, type, logoObjectKey];
}

/// The editable subset submitted from the Pro Edit Profile screen. City IDs
/// come from the location picker; when null the current value is unchanged.
class ProfileEdit extends Equatable {
  const ProfileEdit({
    required this.firstName,
    required this.lastName,
    required this.isPrestataire,
    this.searchCityId,
    this.displayName,
    this.mainCityId,
    this.type,
  });

  final String firstName;
  final String lastName;
  final bool isPrestataire;
  final String? searchCityId;
  final String? displayName;
  final String? mainCityId;
  final PrestataireType? type;

  @override
  List<Object?> get props =>
      [firstName, lastName, isPrestataire, searchCityId, displayName, mainCityId, type];
}
