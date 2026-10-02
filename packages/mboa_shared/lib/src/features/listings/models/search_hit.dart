import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';

import '../../profile/models/base_profile.dart';
import 'listing_detail.dart';
import 'property_type.dart';
import 'rental_period.dart';

/// One result of a search (CDC M04).
///
/// The endpoint answers with a **discriminated union** — a hit is either a
/// standalone listing or a whole residence — because the two are not the same
/// offer: a residence card announces "from X, N units available" and opens a
/// different screen. Sealed here so no widget can forget the second case.
sealed class SearchHit extends Equatable {
  const SearchHit({
    required this.id,
    this.title,
    this.city,
    this.district,
    this.primaryPhotoKey,
    this.tierRank,
    this.latitude,
    this.longitude,
    this.badges = const [],
  });

  final String id;
  final String? title;
  final String? city;
  final String? district;
  final String? primaryPhotoKey;

  /// The visibility algorithm's rank (Pro+ → Pro → Basic+ → Gratuit).
  ///
  /// **Read, never sorted on.** The server returns results in tier order
  /// (CA-M04-02); re-sorting here would be a second implementation of the
  /// ranking rule, and the two would drift.
  final int? tierRank;

  /// RM-M04-06 — the API fuzzes these before sending them: an HMAC offset of
  /// 100–200 m under a server secret, stable per listing (confirmed
  /// 2026-10-01). The app never receives an exact position for a listing it
  /// has no contact with, which is what makes the 200 m disc honest.
  final double? latitude;
  final double? longitude;

  /// RM-M20 — the trust badges carried by the listing, in prestige order.
  /// Shown on the card since the backend started sending them (2026-10-02).
  final List<TrustBadge> badges;

  String? get photoUrl => BaseProfile.mediaUrl(primaryPhotoKey);

  bool get hasPosition => latitude != null && longitude != null;

  static SearchHit? fromResponse(SearchResult result) {
    if (result.listing case final listing?) {
      return ListingHit.fromResponse(listing);
    }
    if (result.residence case final residence?) {
      return ResidenceHit.fromResponse(residence);
    }
    // A hit whose payload the build predates: dropped rather than drawn empty.
    return null;
  }
}

/// A standalone listing ("Bien Unique").
final class ListingHit extends SearchHit {
  const ListingHit({
    required super.id,
    super.title,
    super.city,
    super.district,
    super.primaryPhotoKey,
    super.tierRank,
    super.latitude,
    super.longitude,
    super.badges,
    this.propertyType = PropertyType.apartment,
    this.price,
    this.rentalPeriod = RentalPeriod.fallback,
    this.monthlyRent,
    this.furnished,
    this.roomCount,
    this.surfaceArea,
    this.availableFrom,
  });

  final PropertyType propertyType;
  final int? price;
  final RentalPeriod rentalPeriod;

  /// The server's comparison figure — never displayed, never billed. It is what
  /// the rent filters bracket on.
  final int? monthlyRent;

  final bool? furnished;
  final int? roomCount;
  final int? surfaceArea;
  final DateTime? availableFrom;

  /// Listings created before RM-M10-09 carry only the derived monthly figure,
  /// and those really were monthly.
  int? get displayPrice => price ?? monthlyRent;

  static ListingHit fromResponse(SearchResultItem item) => ListingHit(
        id: item.id ?? '',
        title: item.title,
        city: item.city,
        district: item.district,
        primaryPhotoKey: item.primaryPhotoKey,
        tierRank: item.tierRank,
        latitude: item.latitude,
        longitude: item.longitude,
        badges: TrustBadge.sorted(
          item.badges?.map((badge) => TrustBadge.fromWire(badge.name)).nonNulls ??
              const <TrustBadge>[],
        ),
        propertyType: PropertyType.fromSearch(item.propertyType),
        price: item.price,
        rentalPeriod: RentalPeriod.fromSearch(item.rentalPeriod),
        monthlyRent: item.monthlyRent,
        furnished: item.furnished,
        roomCount: item.roomCount,
        surfaceArea: item.surfaceArea,
        availableFrom: item.availableFrom?.toDateTime(),
      );

  @override
  List<Object?> get props => [
        id,
        title,
        city,
        district,
        primaryPhotoKey,
        tierRank,
        latitude,
        longitude,
        badges,
        propertyType,
        price,
        rentalPeriod,
        monthlyRent,
        furnished,
        roomCount,
        surfaceArea,
        availableFrom,
      ];
}

/// How many units of each type a residence has free.
class UnitTypeCount extends Equatable {
  const UnitTypeCount({required this.propertyType, required this.count});

  final PropertyType propertyType;
  final int count;

  @override
  List<Object?> get props => [propertyType, count];
}

/// A whole residence ("Bien Multiple") as one card (RM-M10bis-11).
final class ResidenceHit extends SearchHit {
  const ResidenceHit({
    required super.id,
    super.title,
    super.city,
    super.district,
    super.primaryPhotoKey,
    super.tierRank,
    super.latitude,
    super.longitude,
    super.badges,
    this.availableUnitCount,
    this.reservedUnitCount,
    this.breakdown = const [],
    this.fromMonthlyRent,
  });

  final int? availableUnitCount;
  final int? reservedUnitCount;
  final List<UnitTypeCount> breakdown;

  /// "À partir de" — the cheapest live unit, as a monthly figure. It is the
  /// only price a residence card can show: its units may run on different
  /// periods (a shop by the year, a room by the month).
  final int? fromMonthlyRent;

  /// Formatted without a period suffix, since the figure is already monthly.
  String rentFromLabel(int amount) =>
      '${amount.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]} ')} XAF';

  static ResidenceHit fromResponse(ResidenceSearchCard card) => ResidenceHit(
        id: card.id ?? '',
        title: card.name,
        city: card.city,
        district: card.district,
        primaryPhotoKey: card.primaryPhotoKey,
        tierRank: card.tierRank,
        latitude: card.latitude,
        longitude: card.longitude,
        // A residence card is badged on its shared photos (M20b).
        badges: TrustBadge.sorted(
          card.badges?.map((badge) => TrustBadge.fromWire(badge.name)).nonNulls ??
              const <TrustBadge>[],
        ),
        availableUnitCount: card.availableUnitCount,
        reservedUnitCount: card.reservedUnitCount,
        breakdown: card.breakdown
                ?.map(
                  (t) => UnitTypeCount(
                    propertyType: PropertyType.fromTypeCount(t.propertyType),
                    count: t.count ?? 0,
                  ),
                )
                .toList() ??
            const [],
        fromMonthlyRent: card.fromMonthlyRent,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        city,
        district,
        primaryPhotoKey,
        tierRank,
        latitude,
        longitude,
        availableUnitCount,
        reservedUnitCount,
        breakdown,
        fromMonthlyRent,
      ];
}
