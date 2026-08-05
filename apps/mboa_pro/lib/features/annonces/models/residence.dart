import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import 'annonce.dart';
import 'annonce_status.dart';

/// A multi-unit property ("Bien Multiple").
///
/// Distinct from [Annonce] because the API models it as its own resource: you
/// create it from *groups* of units and the backend expands them, then reports
/// per-status counts.
class Residence extends Equatable {
  const Residence({
    required this.id,
    required this.name,
    required this.status,
    this.city,
    this.district,
    this.exactAddress,
    this.description,
    this.photoKeys = const [],
    this.unitCount,
    this.publishedUnitCount,
    this.draftUnitCount,
    this.reserveUnitCount,
    this.units = const [],
    this.createdAt,
  });

  final String id;
  final String name;
  final AnnonceStatus status;
  final String? city;
  final String? district;
  final String? exactAddress;
  final String? description;
  final List<String> photoKeys;
  final int? unitCount;
  final int? publishedUnitCount;
  final int? draftUnitCount;
  final int? reserveUnitCount;
  final List<ResidenceUnit> units;
  final DateTime? createdAt;

  String? get coverUrl =>
      photoKeys.isEmpty ? null : BaseProfile.mediaUrl(photoKeys.first);

  /// Units neither published nor reserved — i.e. available to let.
  int get availableUnitCount {
    final total = unitCount ?? 0;
    return (total - (reserveUnitCount ?? 0)).clamp(0, total);
  }

  static Residence fromResponse(ResidenceResponse response) => Residence(
        id: response.id ?? '',
        name: response.name ?? '',
        status: _statusOf(response.status),
        city: response.city,
        district: response.district,
        exactAddress: response.exactAddress,
        description: response.description,
        photoKeys: response.photoKeys?.toList() ?? const [],
        unitCount: response.unitCount,
        publishedUnitCount: response.publishedUnitCount,
        draftUnitCount: response.draftUnitCount,
        reserveUnitCount: response.reserveUnitCount,
        units:
            response.units?.map(ResidenceUnit.fromSummary).toList() ?? const [],
        createdAt: response.createdAt,
      );

  static AnnonceStatus _statusOf(ResidenceResponseStatusEnum? value) =>
      switch (value) {
        ResidenceResponseStatusEnum.DRAFT => AnnonceStatus.draft,
        ResidenceResponseStatusEnum.PUBLISHED => AnnonceStatus.published,
        ResidenceResponseStatusEnum.RESERVED => AnnonceStatus.reserved,
        ResidenceResponseStatusEnum.RENTED => AnnonceStatus.rented,
        ResidenceResponseStatusEnum.ARCHIVED => AnnonceStatus.archived,
        _ => AnnonceStatus.unknown,
      };

  @override
  List<Object?> get props => [id, name, status, unitCount, publishedUnitCount];
}

/// One unit inside a [Residence].
class ResidenceUnit extends Equatable {
  const ResidenceUnit({
    required this.id,
    required this.title,
    required this.status,
    this.propertyType,
    this.monthlyRent,
  });

  final String id;
  final String title;
  final AnnonceStatus status;
  final PropertyType? propertyType;
  final int? monthlyRent;

  static ResidenceUnit fromSummary(UnitSummary summary) => ResidenceUnit(
        id: summary.id ?? '',
        title: summary.title ?? '',
        status: AnnonceStatus.fromUnitSummary(summary.status),
        propertyType: switch (summary.propertyType) {
          UnitSummaryPropertyTypeEnum.STUDIO => PropertyType.studio,
          UnitSummaryPropertyTypeEnum.VILLA => PropertyType.villa,
          UnitSummaryPropertyTypeEnum.ROOM => PropertyType.room,
          UnitSummaryPropertyTypeEnum.OFFICE => PropertyType.office,
          UnitSummaryPropertyTypeEnum.COMMERCIAL_SPACE =>
            PropertyType.commercialSpace,
          UnitSummaryPropertyTypeEnum.APARTMENT => PropertyType.apartment,
          _ => null,
        },
        monthlyRent: summary.monthlyRent,
      );

  @override
  List<Object?> get props => [id, title, status, propertyType, monthlyRent];
}
