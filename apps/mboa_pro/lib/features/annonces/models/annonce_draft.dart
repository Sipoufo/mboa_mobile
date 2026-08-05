import 'package:equatable/equatable.dart';

import 'annonce.dart';

/// Which of the two creation flows the form is running.
enum AnnonceKind { single, residence }

/// A geographic point plus the district it sits in.
///
/// `latitude`/`longitude` are **required** by the create endpoints, but the
/// design shows a single "Localisation" field — so the form captures GPS and
/// pairs it with a district chosen from `LocationsApi`.
class ListingLocation extends Equatable {
  const ListingLocation({
    required this.districtId,
    required this.districtName,
    required this.latitude,
    required this.longitude,
    this.cityId,
    this.cityName,
    this.exactAddress,
  });

  final String districtId;
  final String districtName;
  final double latitude;
  final double longitude;
  final String? cityId;
  final String? cityName;
  final String? exactAddress;

  String get label => [cityName, districtName]
      .where((p) => p != null && p.isNotEmpty)
      .join(' · ');

  ListingLocation copyWith({String? exactAddress}) => ListingLocation(
        districtId: districtId,
        districtName: districtName,
        latitude: latitude,
        longitude: longitude,
        cityId: cityId,
        cityName: cityName,
        exactAddress: exactAddress ?? this.exactAddress,
      );

  @override
  List<Object?> get props =>
      [districtId, latitude, longitude, cityId, exactAddress];
}

/// One row of the multi-unit form: N identical units created in one go.
class UnitGroupDraft extends Equatable {
  const UnitGroupDraft({
    this.propertyType = PropertyType.room,
    this.count = 1,
    this.namePrefix = '',
    this.monthlyRent,
    this.surfaceArea,
    this.roomCount,
    this.bathroomCount,
    this.furnished,
    this.chargesIncluded,
    this.chargesAmount,
    this.description,
  });

  final PropertyType propertyType;
  final int count;
  final String namePrefix;
  final int? monthlyRent;
  final int? surfaceArea;
  final int? roomCount;
  final int? bathroomCount;
  final bool? furnished;
  final bool? chargesIncluded;
  final int? chargesAmount;
  final String? description;

  bool get isValid =>
      count > 0 && namePrefix.trim().isNotEmpty && (monthlyRent ?? 0) > 0;

  UnitGroupDraft copyWith({
    PropertyType? propertyType,
    int? count,
    String? namePrefix,
    int? monthlyRent,
    int? surfaceArea,
    int? roomCount,
    int? bathroomCount,
    bool? furnished,
    bool? chargesIncluded,
    int? chargesAmount,
    String? description,
  }) =>
      UnitGroupDraft(
        propertyType: propertyType ?? this.propertyType,
        count: count ?? this.count,
        namePrefix: namePrefix ?? this.namePrefix,
        monthlyRent: monthlyRent ?? this.monthlyRent,
        surfaceArea: surfaceArea ?? this.surfaceArea,
        roomCount: roomCount ?? this.roomCount,
        bathroomCount: bathroomCount ?? this.bathroomCount,
        furnished: furnished ?? this.furnished,
        chargesIncluded: chargesIncluded ?? this.chargesIncluded,
        chargesAmount: chargesAmount ?? this.chargesAmount,
        description: description ?? this.description,
      );

  @override
  List<Object?> get props =>
      [propertyType, count, namePrefix, monthlyRent, surfaceArea, roomCount];
}

/// The in-progress listing the form edits, for either kind.
class AnnonceDraft extends Equatable {
  const AnnonceDraft({
    required this.kind,
    this.id,
    this.title = '',
    this.propertyType = PropertyType.apartment,
    this.monthlyRent,
    this.chargesIncluded,
    this.chargesAmount,
    this.surfaceArea,
    this.roomCount,
    this.bathroomCount,
    this.furnished,
    this.availableFrom,
    this.description,
    this.photoKeys = const [],
    this.location,
    this.units = const [],
  });

  /// Minimum photos required to publish (Doc 10; CE-M10-03 gives the copy).
  static const int minPhotos = 3;
  static const int maxPhotos = 15;

  final AnnonceKind kind;

  /// Set when editing an existing listing.
  final String? id;

  final String title;
  final PropertyType propertyType;
  final int? monthlyRent;
  final bool? chargesIncluded;
  final int? chargesAmount;
  final int? surfaceArea;
  final int? roomCount;
  final int? bathroomCount;
  final bool? furnished;
  final DateTime? availableFrom;
  final String? description;
  final List<String> photoKeys;
  final ListingLocation? location;

  /// Multi-unit only.
  final List<UnitGroupDraft> units;

  bool get isEditing => id != null;

  bool get hasEnoughPhotos => photoKeys.length >= minPhotos;

  bool get canAddPhoto => photoKeys.length < maxPhotos;

  /// Fields the create endpoints require. Photos are checked separately so the
  /// UI can explain the two failures differently.
  bool get hasRequiredFields {
    if (location == null || title.trim().isEmpty || availableFrom == null) {
      return false;
    }
    return switch (kind) {
      AnnonceKind.single => (monthlyRent ?? 0) > 0,
      AnnonceKind.residence => units.isNotEmpty && units.every((u) => u.isValid),
    };
  }

  /// A draft may be saved incomplete on photos; publishing may not.
  bool get canSave => hasRequiredFields;

  AnnonceDraft copyWith({
    String? id,
    String? title,
    PropertyType? propertyType,
    int? monthlyRent,
    bool? chargesIncluded,
    int? chargesAmount,
    int? surfaceArea,
    int? roomCount,
    int? bathroomCount,
    bool? furnished,
    DateTime? availableFrom,
    String? description,
    List<String>? photoKeys,
    ListingLocation? location,
    List<UnitGroupDraft>? units,
  }) =>
      AnnonceDraft(
        kind: kind,
        id: id ?? this.id,
        title: title ?? this.title,
        propertyType: propertyType ?? this.propertyType,
        monthlyRent: monthlyRent ?? this.monthlyRent,
        chargesIncluded: chargesIncluded ?? this.chargesIncluded,
        chargesAmount: chargesAmount ?? this.chargesAmount,
        surfaceArea: surfaceArea ?? this.surfaceArea,
        roomCount: roomCount ?? this.roomCount,
        bathroomCount: bathroomCount ?? this.bathroomCount,
        furnished: furnished ?? this.furnished,
        availableFrom: availableFrom ?? this.availableFrom,
        description: description ?? this.description,
        photoKeys: photoKeys ?? this.photoKeys,
        location: location ?? this.location,
        units: units ?? this.units,
      );

  static AnnonceDraft fromAnnonce(Annonce annonce, ListingLocation? location) =>
      AnnonceDraft(
        kind: AnnonceKind.single,
        id: annonce.id,
        title: annonce.title,
        propertyType: annonce.propertyType,
        monthlyRent: annonce.monthlyRent,
        chargesIncluded: annonce.chargesIncluded,
        chargesAmount: annonce.chargesAmount,
        surfaceArea: annonce.surfaceArea,
        roomCount: annonce.roomCount,
        bathroomCount: annonce.bathroomCount,
        furnished: annonce.furnished,
        availableFrom: annonce.availableFrom,
        description: annonce.description,
        photoKeys: annonce.photoKeys,
        location: location,
      );

  @override
  List<Object?> get props => [
        kind,
        id,
        title,
        propertyType,
        monthlyRent,
        chargesIncluded,
        chargesAmount,
        surfaceArea,
        roomCount,
        bathroomCount,
        furnished,
        availableFrom,
        description,
        photoKeys,
        location,
        units,
      ];
}
