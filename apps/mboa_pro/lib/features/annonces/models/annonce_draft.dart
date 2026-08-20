import 'package:equatable/equatable.dart';

import 'annonce.dart';
import 'amenity.dart';
import 'rental_period.dart';

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
    this.price,
    this.rentalPeriod = RentalPeriod.fallback,
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
  final int? price;
  final RentalPeriod rentalPeriod;
  final int? surfaceArea;
  final int? roomCount;
  final int? bathroomCount;
  final bool? furnished;
  final bool? chargesIncluded;
  final int? chargesAmount;
  final String? description;

  bool get isValid =>
      count > 0 && namePrefix.trim().isNotEmpty && (price ?? 0) > 0;

  UnitGroupDraft copyWith({
    PropertyType? propertyType,
    int? count,
    String? namePrefix,
    int? price,
    RentalPeriod? rentalPeriod,
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
        price: price ?? this.price,
        rentalPeriod: rentalPeriod ?? this.rentalPeriod,
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
      [propertyType, count, namePrefix, price, rentalPeriod, surfaceArea, roomCount];
}

/// The in-progress listing the form edits, for either kind.
class AnnonceDraft extends Equatable {
  const AnnonceDraft({
    required this.kind,
    this.id,
    this.title = '',
    this.propertyType = PropertyType.apartment,
    this.price,
    this.rentalPeriod = RentalPeriod.fallback,
    this.chargesIncluded,
    this.chargesAmount,
    this.surfaceArea,
    this.roomCount,
    this.bathroomCount,
    this.furnished,
    this.availableFrom,
    this.description,
    this.photoKeys = const [],
    this.amenities = const [],
    this.location,
    this.units = const [],
    this.ownerVisitsEnabled = false,
  });

  /// Minimum photos required to publish (Doc 10; CE-M10-03 gives the copy).
  static const int minPhotos = 3;
  static const int maxPhotos = 15;

  final AnnonceKind kind;

  /// Set when editing an existing listing.
  final String? id;

  final String title;
  final PropertyType propertyType;

  /// The rent as entered, for [rentalPeriod] (RM-M10-09). The monthly
  /// equivalent is derived server-side; the app neither sends nor shows it.
  final int? price;
  final RentalPeriod rentalPeriod;
  final bool? chargesIncluded;
  final int? chargesAmount;
  final int? surfaceArea;
  final int? roomCount;
  final int? bathroomCount;
  final bool? furnished;
  final DateTime? availableFrom;
  final String? description;
  final List<String> photoKeys;

  /// Doc 10's "Équipements" checklist. Single listings only — the residence
  /// endpoints have no such field.
  final List<Amenity> amenities;
  final ListingLocation? location;

  /// Multi-unit only.
  final List<UnitGroupDraft> units;

  /// RM-M11-10 — carried so an edit never clears it. `UpdateAnnonceRequest`
  /// replaces the listing wholesale, so a field left out of the draft is a
  /// field switched off; the toggle itself lives on the agents screen.
  /// **`CreateAnnonceRequest` has no such field** — it can only be turned on
  /// after the listing exists.
  final bool ownerVisitsEnabled;

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
      AnnonceKind.single => (price ?? 0) > 0,
      AnnonceKind.residence => units.isNotEmpty && units.every((u) => u.isValid),
    };
  }

  /// A draft may be saved incomplete on photos; publishing may not.
  bool get canSave => hasRequiredFields;

  AnnonceDraft copyWith({
    String? id,
    String? title,
    PropertyType? propertyType,
    int? price,
    RentalPeriod? rentalPeriod,
    bool? chargesIncluded,
    int? chargesAmount,
    int? surfaceArea,
    int? roomCount,
    int? bathroomCount,
    bool? furnished,
    DateTime? availableFrom,
    String? description,
    List<String>? photoKeys,
    List<Amenity>? amenities,
    ListingLocation? location,
    List<UnitGroupDraft>? units,
    bool? ownerVisitsEnabled,
  }) =>
      AnnonceDraft(
        kind: kind,
        id: id ?? this.id,
        title: title ?? this.title,
        propertyType: propertyType ?? this.propertyType,
        price: price ?? this.price,
        rentalPeriod: rentalPeriod ?? this.rentalPeriod,
        chargesIncluded: chargesIncluded ?? this.chargesIncluded,
        chargesAmount: chargesAmount ?? this.chargesAmount,
        surfaceArea: surfaceArea ?? this.surfaceArea,
        roomCount: roomCount ?? this.roomCount,
        bathroomCount: bathroomCount ?? this.bathroomCount,
        furnished: furnished ?? this.furnished,
        availableFrom: availableFrom ?? this.availableFrom,
        description: description ?? this.description,
        photoKeys: photoKeys ?? this.photoKeys,
        amenities: amenities ?? this.amenities,
        location: location ?? this.location,
        units: units ?? this.units,
        ownerVisitsEnabled: ownerVisitsEnabled ?? this.ownerVisitsEnabled,
      );

  /// Seeds the form from an existing listing.
  ///
  /// The location is rebuilt from the listing's own district/coordinates, so
  /// editing never forces a fresh GPS capture — only changing it does.
  static AnnonceDraft fromAnnonce(Annonce annonce) => AnnonceDraft(
        kind: AnnonceKind.single,
        id: annonce.id,
        title: annonce.title,
        propertyType: annonce.propertyType,
        amenities: annonce.amenities,
        price: annonce.displayPrice,
        rentalPeriod: annonce.rentalPeriod,
        chargesIncluded: annonce.chargesIncluded,
        chargesAmount: annonce.chargesAmount,
        surfaceArea: annonce.surfaceArea,
        roomCount: annonce.roomCount,
        bathroomCount: annonce.bathroomCount,
        furnished: annonce.furnished,
        availableFrom: annonce.availableFrom,
        description: annonce.description,
        photoKeys: annonce.photoKeys,
        ownerVisitsEnabled: annonce.ownerVisitsEnabled,
        location: switch ((
          annonce.districtId,
          annonce.latitude,
          annonce.longitude
        )) {
          (final String id, final double lat, final double lng) =>
            ListingLocation(
              districtId: id,
              districtName: annonce.district ?? '',
              cityId: annonce.cityId,
              cityName: annonce.city,
              latitude: lat,
              longitude: lng,
              exactAddress: annonce.exactAddress,
            ),
          _ => null,
        },
      );

  @override
  List<Object?> get props => [
        kind,
        id,
        title,
        propertyType,
        price,
        rentalPeriod,
        chargesIncluded,
        chargesAmount,
        surfaceArea,
        roomCount,
        bathroomCount,
        furnished,
        availableFrom,
        description,
        photoKeys,
        amenities,
        location,
        units,
        ownerVisitsEnabled,
      ];
}
