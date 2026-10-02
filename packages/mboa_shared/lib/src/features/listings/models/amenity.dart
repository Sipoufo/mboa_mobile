import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';

/// Doc 10's "Équipements (checklist)" on a listing.
///
/// A closed enum rather than free text so M04 can filter on it — that was the
/// whole argument for adding it (see `docs/backend-requests.md` §8). Search does
/// **not** filter on amenities yet, which is worth chasing.
///
/// Residences cannot carry equipment: neither `CreateResidenceRequest` nor
/// `UnitGroup` has the field, so the form hides it for a Bien Multiple.
enum Amenity {
  airConditioning,
  hotWater,
  generator,
  securityGuard,
  parking,
  wifi;

  static Amenity? fromResponse(AnnonceResponseAmenitiesEnum? value) =>
      switch (value) {
        AnnonceResponseAmenitiesEnum.AIR_CONDITIONING =>
          Amenity.airConditioning,
        AnnonceResponseAmenitiesEnum.HOT_WATER => Amenity.hotWater,
        AnnonceResponseAmenitiesEnum.GENERATOR => Amenity.generator,
        AnnonceResponseAmenitiesEnum.SECURITY_GUARD => Amenity.securityGuard,
        AnnonceResponseAmenitiesEnum.PARKING => Amenity.parking,
        AnnonceResponseAmenitiesEnum.WIFI => Amenity.wifi,
        // A value added server-side that this build predates: drop it rather
        // than crash, and it survives the round trip only if left untouched.
        _ => null,
      };

  /// M05 — the same checklist, arriving on a public fiche.
  static Amenity? fromDetail(AnnonceDetailResponseAmenitiesEnum? value) =>
      switch (value) {
        AnnonceDetailResponseAmenitiesEnum.AIR_CONDITIONING =>
          Amenity.airConditioning,
        AnnonceDetailResponseAmenitiesEnum.HOT_WATER => Amenity.hotWater,
        AnnonceDetailResponseAmenitiesEnum.GENERATOR => Amenity.generator,
        AnnonceDetailResponseAmenitiesEnum.SECURITY_GUARD =>
          Amenity.securityGuard,
        AnnonceDetailResponseAmenitiesEnum.PARKING => Amenity.parking,
        AnnonceDetailResponseAmenitiesEnum.WIFI => Amenity.wifi,
        _ => null,
      };

  CreateAnnonceRequestAmenitiesEnum get asCreate => switch (this) {
        Amenity.airConditioning =>
          CreateAnnonceRequestAmenitiesEnum.AIR_CONDITIONING,
        Amenity.hotWater => CreateAnnonceRequestAmenitiesEnum.HOT_WATER,
        Amenity.generator => CreateAnnonceRequestAmenitiesEnum.GENERATOR,
        Amenity.securityGuard =>
          CreateAnnonceRequestAmenitiesEnum.SECURITY_GUARD,
        Amenity.parking => CreateAnnonceRequestAmenitiesEnum.PARKING,
        Amenity.wifi => CreateAnnonceRequestAmenitiesEnum.WIFI,
      };

  UpdateAnnonceRequestAmenitiesEnum get asUpdate => switch (this) {
        Amenity.airConditioning =>
          UpdateAnnonceRequestAmenitiesEnum.AIR_CONDITIONING,
        Amenity.hotWater => UpdateAnnonceRequestAmenitiesEnum.HOT_WATER,
        Amenity.generator => UpdateAnnonceRequestAmenitiesEnum.GENERATOR,
        Amenity.securityGuard =>
          UpdateAnnonceRequestAmenitiesEnum.SECURITY_GUARD,
        Amenity.parking => UpdateAnnonceRequestAmenitiesEnum.PARKING,
        Amenity.wifi => UpdateAnnonceRequestAmenitiesEnum.WIFI,
      };

  /// The `BadgeCode`-style wire value, for the `amenities` query parameter.
  ///
  /// Written out rather than derived from [name]: the enum's Dart names are
  /// ours and renaming one must not silently change what is sent.
  String get asSearchParam => switch (this) {
        Amenity.airConditioning => 'AIR_CONDITIONING',
        Amenity.hotWater => 'HOT_WATER',
        Amenity.generator => 'GENERATOR',
        Amenity.securityGuard => 'SECURITY_GUARD',
        Amenity.parking => 'PARKING',
        Amenity.wifi => 'WIFI',
      };

  String label(I18n l10n) => switch (this) {
        Amenity.airConditioning => l10n.amenityAirConditioning,
        Amenity.hotWater => l10n.amenityHotWater,
        Amenity.generator => l10n.amenityGenerator,
        Amenity.securityGuard => l10n.amenitySecurityGuard,
        Amenity.parking => l10n.amenityParking,
        Amenity.wifi => l10n.amenityWifi,
      };
}
