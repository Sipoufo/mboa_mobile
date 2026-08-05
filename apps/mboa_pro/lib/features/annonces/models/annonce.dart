import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import 'annonce_status.dart';

/// Kind of property (CDC M10 "Type de bien").
enum PropertyType {
  apartment,
  studio,
  villa,
  room,
  office,
  commercialSpace;

  static PropertyType fromResponse(AnnonceResponsePropertyTypeEnum? value) =>
      switch (value) {
        AnnonceResponsePropertyTypeEnum.STUDIO => PropertyType.studio,
        AnnonceResponsePropertyTypeEnum.VILLA => PropertyType.villa,
        AnnonceResponsePropertyTypeEnum.ROOM => PropertyType.room,
        AnnonceResponsePropertyTypeEnum.OFFICE => PropertyType.office,
        AnnonceResponsePropertyTypeEnum.COMMERCIAL_SPACE =>
          PropertyType.commercialSpace,
        _ => PropertyType.apartment,
      };

  CreateAnnonceRequestPropertyTypeEnum get asCreate => switch (this) {
        PropertyType.apartment => CreateAnnonceRequestPropertyTypeEnum.APARTMENT,
        PropertyType.studio => CreateAnnonceRequestPropertyTypeEnum.STUDIO,
        PropertyType.villa => CreateAnnonceRequestPropertyTypeEnum.VILLA,
        PropertyType.room => CreateAnnonceRequestPropertyTypeEnum.ROOM,
        PropertyType.office => CreateAnnonceRequestPropertyTypeEnum.OFFICE,
        PropertyType.commercialSpace =>
          CreateAnnonceRequestPropertyTypeEnum.COMMERCIAL_SPACE,
      };

  UpdateAnnonceRequestPropertyTypeEnum get asUpdate => switch (this) {
        PropertyType.apartment => UpdateAnnonceRequestPropertyTypeEnum.APARTMENT,
        PropertyType.studio => UpdateAnnonceRequestPropertyTypeEnum.STUDIO,
        PropertyType.villa => UpdateAnnonceRequestPropertyTypeEnum.VILLA,
        PropertyType.room => UpdateAnnonceRequestPropertyTypeEnum.ROOM,
        PropertyType.office => UpdateAnnonceRequestPropertyTypeEnum.OFFICE,
        PropertyType.commercialSpace =>
          UpdateAnnonceRequestPropertyTypeEnum.COMMERCIAL_SPACE,
      };

  UnitGroupPropertyTypeEnum get asUnitGroup => switch (this) {
        PropertyType.apartment => UnitGroupPropertyTypeEnum.APARTMENT,
        PropertyType.studio => UnitGroupPropertyTypeEnum.STUDIO,
        PropertyType.villa => UnitGroupPropertyTypeEnum.VILLA,
        PropertyType.room => UnitGroupPropertyTypeEnum.ROOM,
        PropertyType.office => UnitGroupPropertyTypeEnum.OFFICE,
        PropertyType.commercialSpace =>
          UnitGroupPropertyTypeEnum.COMMERCIAL_SPACE,
      };
}

/// A single listing ("Bien Unique").
class Annonce extends Equatable {
  const Annonce({
    required this.id,
    required this.title,
    required this.status,
    required this.propertyType,
    this.city,
    this.cityId,
    this.district,
    this.districtId,
    this.latitude,
    this.longitude,
    this.exactAddress,
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
    this.publishedAt,
    this.createdAt,
    this.residenceId,
    this.expiresAt,
  });

  final String id;
  final String title;
  final AnnonceStatus status;
  final PropertyType propertyType;
  final String? city;
  final String? cityId;
  final String? district;

  /// Kept so editing can rebuild the location without re-capturing GPS.
  final String? districtId;
  final double? latitude;
  final double? longitude;
  final String? exactAddress;
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
  final DateTime? publishedAt;
  final DateTime? createdAt;

  /// Null for a standalone listing; the parent residence for a unit.
  final String? residenceId;

  /// When a Free-tier listing auto-expires (RM-M10-04). Null on paid tiers.
  final DateTime? expiresAt;

  /// Absolute URL of the cover photo, or null when the listing has none.
  String? get coverUrl =>
      photoKeys.isEmpty ? null : BaseProfile.mediaUrl(photoKeys.first);

  static Annonce fromResponse(AnnonceResponse response) => Annonce(
        id: response.id ?? '',
        title: response.title ?? '',
        status: AnnonceStatus.fromResponse(response.status),
        propertyType: PropertyType.fromResponse(response.propertyType),
        city: response.city,
        cityId: response.cityId,
        district: response.district,
        districtId: response.districtId,
        latitude: response.latitude,
        longitude: response.longitude,
        exactAddress: response.exactAddress,
        monthlyRent: response.monthlyRent,
        chargesIncluded: response.chargesIncluded,
        chargesAmount: response.chargesAmount,
        surfaceArea: response.surfaceArea,
        roomCount: response.roomCount,
        bathroomCount: response.bathroomCount,
        furnished: response.furnished,
        availableFrom: response.availableFrom?.toDateTime(),
        description: response.description,
        photoKeys: response.photoKeys?.toList() ?? const [],
        publishedAt: response.publishedAt,
        createdAt: response.createdAt,
        residenceId: response.residenceId,
        expiresAt: response.expiresAt,
      );

  // Every field: a partial props list makes an edit that only touched, say, the
  // description compare equal to the old value, and the screen never redraws.
  @override
  List<Object?> get props => [
        id,
        title,
        status,
        propertyType,
        city,
        cityId,
        district,
        districtId,
        latitude,
        longitude,
        exactAddress,
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
        publishedAt,
        createdAt,
        residenceId,
        expiresAt,
      ];
}
