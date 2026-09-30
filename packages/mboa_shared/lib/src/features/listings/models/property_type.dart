import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';

/// Kind of property (CDC M10 "Type de bien").
///
/// Shared: the prestataire picks it on a listing (M10), the tenant filters on
/// it (M04) and both read it back on a fiche (M05) — one catalogue, so the two
/// apps cannot disagree about what a "Local commercial" is.
enum PropertyType {
  apartment,
  studio,
  villa,
  room,
  office,
  commercialSpace
  ;

  static PropertyType fromResponse(AnnonceResponsePropertyTypeEnum? value) => switch (value) {
    AnnonceResponsePropertyTypeEnum.STUDIO => PropertyType.studio,
    AnnonceResponsePropertyTypeEnum.VILLA => PropertyType.villa,
    AnnonceResponsePropertyTypeEnum.ROOM => PropertyType.room,
    AnnonceResponsePropertyTypeEnum.OFFICE => PropertyType.office,
    AnnonceResponsePropertyTypeEnum.COMMERCIAL_SPACE => PropertyType.commercialSpace,
    _ => PropertyType.apartment,
  };

  /// M04 — the same catalogue, arriving on a search result or a residence's
  /// type breakdown.
  static PropertyType fromSearch(SearchResultItemPropertyTypeEnum? value) =>
      switch (value) {
        SearchResultItemPropertyTypeEnum.STUDIO => PropertyType.studio,
        SearchResultItemPropertyTypeEnum.VILLA => PropertyType.villa,
        SearchResultItemPropertyTypeEnum.ROOM => PropertyType.room,
        SearchResultItemPropertyTypeEnum.OFFICE => PropertyType.office,
        SearchResultItemPropertyTypeEnum.COMMERCIAL_SPACE =>
          PropertyType.commercialSpace,
        _ => PropertyType.apartment,
      };

  static PropertyType fromTypeCount(TypeCountPropertyTypeEnum? value) =>
      switch (value) {
        TypeCountPropertyTypeEnum.STUDIO => PropertyType.studio,
        TypeCountPropertyTypeEnum.VILLA => PropertyType.villa,
        TypeCountPropertyTypeEnum.ROOM => PropertyType.room,
        TypeCountPropertyTypeEnum.OFFICE => PropertyType.office,
        TypeCountPropertyTypeEnum.COMMERCIAL_SPACE =>
          PropertyType.commercialSpace,
        _ => PropertyType.apartment,
      };

  /// What `GET /search` expects for `propertyTypes`.
  String get asSearchParam => switch (this) {
        PropertyType.apartment => 'APARTMENT',
        PropertyType.studio => 'STUDIO',
        PropertyType.villa => 'VILLA',
        PropertyType.room => 'ROOM',
        PropertyType.office => 'OFFICE',
        PropertyType.commercialSpace => 'COMMERCIAL_SPACE',
      };

  CreateAnnonceRequestPropertyTypeEnum get asCreate => switch (this) {
    PropertyType.apartment => CreateAnnonceRequestPropertyTypeEnum.APARTMENT,
    PropertyType.studio => CreateAnnonceRequestPropertyTypeEnum.STUDIO,
    PropertyType.villa => CreateAnnonceRequestPropertyTypeEnum.VILLA,
    PropertyType.room => CreateAnnonceRequestPropertyTypeEnum.ROOM,
    PropertyType.office => CreateAnnonceRequestPropertyTypeEnum.OFFICE,
    PropertyType.commercialSpace => CreateAnnonceRequestPropertyTypeEnum.COMMERCIAL_SPACE,
  };

  UpdateAnnonceRequestPropertyTypeEnum get asUpdate => switch (this) {
    PropertyType.apartment => UpdateAnnonceRequestPropertyTypeEnum.APARTMENT,
    PropertyType.studio => UpdateAnnonceRequestPropertyTypeEnum.STUDIO,
    PropertyType.villa => UpdateAnnonceRequestPropertyTypeEnum.VILLA,
    PropertyType.room => UpdateAnnonceRequestPropertyTypeEnum.ROOM,
    PropertyType.office => UpdateAnnonceRequestPropertyTypeEnum.OFFICE,
    PropertyType.commercialSpace => UpdateAnnonceRequestPropertyTypeEnum.COMMERCIAL_SPACE,
  };

  UnitGroupPropertyTypeEnum get asUnitGroup => switch (this) {
    PropertyType.apartment => UnitGroupPropertyTypeEnum.APARTMENT,
    PropertyType.studio => UnitGroupPropertyTypeEnum.STUDIO,
    PropertyType.villa => UnitGroupPropertyTypeEnum.VILLA,
    PropertyType.room => UnitGroupPropertyTypeEnum.ROOM,
    PropertyType.office => UnitGroupPropertyTypeEnum.OFFICE,
    PropertyType.commercialSpace => UnitGroupPropertyTypeEnum.COMMERCIAL_SPACE,
  };
}

/// The type's name, from the shared catalogue rather than a French literal.
///
/// It was written out three times — the form, the unit editor and the residence
/// detail — which is three chances to disagree and none to translate.
extension PropertyTypeLabel on PropertyType {
  String label(I18n l10n) => switch (this) {
    PropertyType.apartment => l10n.propertyTypeApartment,
    PropertyType.studio => l10n.propertyTypeStudio,
    PropertyType.villa => l10n.propertyTypeVilla,
    PropertyType.room => l10n.propertyTypeRoom,
    PropertyType.office => l10n.propertyTypeOffice,
    PropertyType.commercialSpace => l10n.propertyTypeCommercialSpace,
  };
}
