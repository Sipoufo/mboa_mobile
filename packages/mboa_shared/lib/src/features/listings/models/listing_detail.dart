import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';

import '../../profile/models/base_profile.dart';
import 'amenity.dart';
import 'property_type.dart';
import 'rental_period.dart';

/// A trust badge on a prestataire (CDC M05).
///
/// The wire values are the backend's `BadgeCode` enum, typed since
/// 2026-09-30. They were a bare `string[]` before, and the values this app
/// guessed for them were wrong — `TRUSTED_PROVIDER` for `TRUSTED`,
/// `VERIFIED_IDENTITY` for `IDENTITY_VERIFIED` — so every badge was silently
/// dropped on the fiche. Guessing a wire value is a bug that looks like an
/// empty list.
///
/// Declaration order is the prestige order RM-M05-03 asks for: 🏆 → 🔄 → ✅ →
/// 📸. The server sorts them too; this enum keeps the rule where the rule is
/// applied.
enum TrustBadge {
  trustedProvider,
  recertified,
  verifiedIdentity,
  verifiedPhotos;

  /// One mapping, from the one enum: the generated client gives a different
  /// Dart type per schema that carries badges, and they all mean `BadgeCode`.
  static TrustBadge? fromWire(String? value) => switch (value) {
        'TRUSTED' => TrustBadge.trustedProvider,
        'RECERTIFIED' => TrustBadge.recertified,
        'IDENTITY_VERIFIED' => TrustBadge.verifiedIdentity,
        'PHOTOS_VERIFIED' => TrustBadge.verifiedPhotos,
        // `unknown_default_open_api`, or a code added after this build.
        _ => null,
      };

  /// The words the fiche's chip uses, so a filter and a badge never disagree.
  String label(I18n l10n) => switch (this) {
        TrustBadge.trustedProvider => l10n.badgeTrustedProvider,
        TrustBadge.recertified => l10n.badgeRecertified,
        TrustBadge.verifiedIdentity => l10n.badgeVerifiedIdentity,
        TrustBadge.verifiedPhotos => l10n.badgeVerifiedPhotos,
      };

  /// The wire value, for the `badges` query parameter (Doc 10 M04).
  String get asSearchParam => switch (this) {
        TrustBadge.trustedProvider => 'TRUSTED',
        TrustBadge.recertified => 'RECERTIFIED',
        TrustBadge.verifiedIdentity => 'IDENTITY_VERIFIED',
        TrustBadge.verifiedPhotos => 'PHOTOS_VERIFIED',
      };

  /// RM-M05-03 — prestige order, highest first, whatever order they arrived in.
  static List<TrustBadge> sorted(Iterable<TrustBadge> badges) =>
      badges.toSet().toList()..sort((a, b) => a.index.compareTo(b.index));
}

/// What kind of outfit the prestataire is (Doc 10 M02).
enum PrestataireKind {
  particulier,
  agence,
  promoteur;

  static PrestataireKind? fromProvider(ProviderCardTypeEnum? value) =>
      switch (value) {
        ProviderCardTypeEnum.PARTICULIER => PrestataireKind.particulier,
        ProviderCardTypeEnum.AGENCE => PrestataireKind.agence,
        ProviderCardTypeEnum.PROMOTEUR => PrestataireKind.promoteur,
        _ => null,
      };
}

/// What a tenant may know about the prestataire behind a listing (CDC M05).
class ProviderSummary extends Equatable {
  const ProviderSummary({
    this.accountId,
    this.displayName,
    this.logoObjectKey,
    this.type,
    this.tierRank,
    this.badges = const [],
  });

  final String? accountId;
  final String? displayName;
  final String? logoObjectKey;
  final PrestataireKind? type;

  /// Shown discreetly, per Doc 10 — a tier is not an endorsement.
  final int? tierRank;

  /// RM-M05-03 — in prestige order, highest first.
  final List<TrustBadge> badges;

  String? get logoUrl => BaseProfile.mediaUrl(logoObjectKey);

  static ProviderSummary fromResponse(ProviderCard card) {
    final badges = TrustBadge.sorted(
      card.badges?.map((badge) => TrustBadge.fromWire(badge.name)).nonNulls ??
          const <TrustBadge>[],
    );

    return ProviderSummary(
      accountId: card.accountId,
      displayName: card.displayName,
      logoObjectKey: card.logoObjectKey,
      type: PrestataireKind.fromProvider(card.type),
      tierRank: card.tierRank,
      badges: badges,
    );
  }

  @override
  List<Object?> get props =>
      [accountId, displayName, logoObjectKey, type, tierRank, badges];
}

/// How a property is rated (RG-06, computed server-side).
class PropertyRatingSummary extends Equatable {
  const PropertyRatingSummary({
    this.average,
    this.reviewCount = 0,
    this.visitCount = 0,
    this.residentCount = 0,
  });

  final double? average;
  final int reviewCount;
  final int visitCount;
  final int residentCount;

  /// RM-M05-08 — a property with no review shows **no** rating block; a "0/5"
  /// would read as a bad property rather than an unrated one.
  bool get hasRating => average != null && reviewCount > 0;

  static PropertyRatingSummary fromResponse(PropertyRating rating) =>
      PropertyRatingSummary(
        average: rating.average,
        reviewCount: rating.reviewCount ?? 0,
        visitCount: rating.visitCount ?? 0,
        residentCount: rating.residentCount ?? 0,
      );

  @override
  List<Object?> get props => [average, reviewCount, visitCount, residentCount];
}

/// The public fiche of a listing (CDC M05).
///
/// **The exact address is never here** (RM-M05-02 / CA-M05-03): the API does
/// not return it and the coordinates are fuzzed by ~200 m (RM-M04-06). There is
/// nothing for the UI to hide, because there is nothing to hide.
class ListingDetail extends Equatable {
  const ListingDetail({
    required this.id,
    this.residenceId,
    this.title,
    this.propertyType = PropertyType.apartment,
    this.price,
    this.rentalPeriod = RentalPeriod.fallback,
    this.monthlyRent,
    this.chargesIncluded,
    this.chargesAmount,
    this.city,
    this.district,
    this.latitude,
    this.longitude,
    this.surfaceArea,
    this.roomCount,
    this.bathroomCount,
    this.furnished,
    this.availableFrom,
    this.description,
    this.amenities = const [],
    this.photoKeys = const [],
    this.provider,
    this.canContact = false,
    this.canPlanVisit = false,
    this.rating = const PropertyRatingSummary(),
    this.viewCount,
  });

  /// RM-M05-01 — three in the carousel, the rest behind the gallery.
  static const int carouselPhotos = 3;

  final String id;

  /// Set when the listing is a unit of a residence.
  final String? residenceId;

  final String? title;
  final PropertyType propertyType;
  final int? price;
  final RentalPeriod rentalPeriod;
  final int? monthlyRent;
  final bool? chargesIncluded;
  final int? chargesAmount;
  final String? city;
  final String? district;
  final double? latitude;
  final double? longitude;
  final int? surfaceArea;
  final int? roomCount;
  final int? bathroomCount;
  final bool? furnished;
  final DateTime? availableFrom;
  final String? description;
  final List<Amenity> amenities;
  final List<String> photoKeys;
  final ProviderSummary? provider;

  /// **Server-computed.** RM-M04-05 — a visitor reads the fiche and cannot
  /// contact; the app renders the verdict rather than deciding it.
  final bool canContact;

  /// **Server-computed.** RM-M05-07 — true only when the property has a
  /// bookable visitor: an assigned agent with declared hours, or an owner who
  /// runs his own visits. Working this out in the app would mean promising a
  /// booking screen that opens empty.
  final bool canPlanVisit;

  final PropertyRatingSummary rating;

  /// RM-M05-06 — counted by the server; **shown to the prestataire only**, so
  /// the tenant's fiche carries it and never draws it.
  final int? viewCount;

  int? get displayPrice => price ?? monthlyRent;

  List<String> get photoUrls =>
      photoKeys.map(BaseProfile.mediaUrl).nonNulls.toList();

  bool get hasPosition => latitude != null && longitude != null;

  static ListingDetail fromResponse(AnnonceDetailResponse response) =>
      ListingDetail(
        id: response.id ?? '',
        residenceId: response.residenceId,
        title: response.title,
        propertyType: PropertyType.fromDetail(response.propertyType),
        price: response.price,
        rentalPeriod: RentalPeriod.fromDetail(response.rentalPeriod),
        monthlyRent: response.monthlyRent,
        chargesIncluded: response.chargesIncluded,
        chargesAmount: response.chargesAmount,
        city: response.city,
        district: response.district,
        latitude: response.latitude,
        longitude: response.longitude,
        surfaceArea: response.surfaceArea,
        roomCount: response.roomCount,
        bathroomCount: response.bathroomCount,
        furnished: response.furnished,
        availableFrom: response.availableFrom?.toDateTime(),
        description: response.description,
        amenities:
            response.amenities?.map(Amenity.fromDetail).nonNulls.toList() ??
                const [],
        photoKeys: response.photoKeys?.toList() ?? const [],
        provider: response.provider == null
            ? null
            : ProviderSummary.fromResponse(response.provider!),
        canContact: response.canContact ?? false,
        canPlanVisit: response.canPlanVisit ?? false,
        rating: response.rating == null
            ? const PropertyRatingSummary()
            : PropertyRatingSummary.fromResponse(response.rating!),
        viewCount: response.viewCount,
      );

  @override
  List<Object?> get props => [
        id,
        residenceId,
        title,
        propertyType,
        price,
        rentalPeriod,
        monthlyRent,
        chargesIncluded,
        chargesAmount,
        city,
        district,
        latitude,
        longitude,
        surfaceArea,
        roomCount,
        bathroomCount,
        furnished,
        availableFrom,
        description,
        amenities,
        photoKeys,
        provider,
        canContact,
        canPlanVisit,
        rating,
        viewCount,
      ];
}

/// One unit of a residence, as its row shows it.
class ListingUnit extends Equatable {
  const ListingUnit({
    required this.id,
    this.title,
    this.propertyType = PropertyType.apartment,
    this.price,
    this.rentalPeriod = RentalPeriod.fallback,
    this.monthlyRent,
    this.roomCount,
    this.surfaceArea,
    this.primaryPhotoKey,
  });

  final String id;
  final String? title;
  final PropertyType propertyType;
  final int? price;
  final RentalPeriod rentalPeriod;
  final int? monthlyRent;
  final int? roomCount;
  final int? surfaceArea;
  final String? primaryPhotoKey;

  int? get displayPrice => price ?? monthlyRent;

  String? get photoUrl => BaseProfile.mediaUrl(primaryPhotoKey);

  static ListingUnit fromResponse(SearchResultItem item) => ListingUnit(
        id: item.id ?? '',
        title: item.title,
        propertyType: PropertyType.fromSearch(item.propertyType),
        price: item.price,
        rentalPeriod: RentalPeriod.fromSearch(item.rentalPeriod),
        monthlyRent: item.monthlyRent,
        roomCount: item.roomCount,
        surfaceArea: item.surfaceArea,
        primaryPhotoKey: item.primaryPhotoKey,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        propertyType,
        price,
        rentalPeriod,
        monthlyRent,
        roomCount,
        surfaceArea,
        primaryPhotoKey,
      ];
}

/// The public fiche of a residence, with its live units.
class ResidenceDetail extends Equatable {
  const ResidenceDetail({
    required this.id,
    this.name,
    this.city,
    this.district,
    this.description,
    this.photoKeys = const [],
    this.latitude,
    this.longitude,
    this.units = const [],
  });

  final String id;
  final String? name;
  final String? city;
  final String? district;
  final String? description;
  final List<String> photoKeys;
  final double? latitude;
  final double? longitude;

  /// A unit **is** a listing, so each row opens the ordinary fiche — the same
  /// identity the pro app relies on.
  final List<ListingUnit> units;

  List<String> get photoUrls =>
      photoKeys.map(BaseProfile.mediaUrl).nonNulls.toList();

  static ResidenceDetail fromResponse(ResidenceDetailResponse response) =>
      ResidenceDetail(
        id: response.id ?? '',
        name: response.name,
        city: response.city,
        district: response.district,
        description: response.description,
        photoKeys: response.photoKeys?.toList() ?? const [],
        latitude: response.latitude,
        longitude: response.longitude,
        units:
            response.units?.map(ListingUnit.fromResponse).toList() ?? const [],
      );

  @override
  List<Object?> get props => [
        id,
        name,
        city,
        district,
        description,
        photoKeys,
        latitude,
        longitude,
        units,
      ];
}
