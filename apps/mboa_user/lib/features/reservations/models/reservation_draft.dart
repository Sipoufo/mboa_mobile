import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// What the request screen shows of the listing — carried from the fiche so
/// the screen opens drawn, with no second read.
class ReservationListing extends Equatable {
  const ReservationListing({
    required this.id,
    this.title,
    this.district,
    this.city,
    this.photoUrl,
    this.price,
    this.rentalPeriod = RentalPeriod.fallback,
  });

  final String id;
  final String? title;
  final String? district;
  final String? city;
  final String? photoUrl;
  final int? price;
  final RentalPeriod rentalPeriod;

  static ReservationListing fromDetail(ListingDetail detail) => ReservationListing(
        id: detail.id,
        title: detail.title,
        district: detail.district,
        city: detail.city,
        photoUrl: detail.photoUrls.firstOrNull,
        price: detail.displayPrice,
        rentalPeriod: detail.rentalPeriod,
      );

  @override
  List<Object?> get props => [id, title, district, city, photoUrl, price, rentalPeriod];
}

/// The stay being asked for, and what follows from it — kept out of the
/// widget so the arithmetic is tested, not eyeballed.
class ReservationDraft extends Equatable {
  const ReservationDraft({required this.listing, this.start, this.units = 1});

  final ReservationListing listing;
  final DateTime? start;

  /// In the listing's own periodicity — the client does not choose it.
  final int units;

  /// The API's bounds (`CreateReservationRequest.durationUnits`).
  static const int minUnits = 1;
  static const int maxUnits = 600;

  /// The move-in day may be from today to twelve months ahead.
  static DateTime firstDay(DateTime now) => DateTime(now.year, now.month, now.day);
  static DateTime lastStartDay(DateTime now) => DateTime(now.year + 1, now.month, now.day);

  DateTime? get lastDay => start == null ? null : listing.rentalPeriod.lastDay(start!, units);

  /// Rent over the stay, **indicative** (CA-M29-04: nothing here is to pay —
  /// it is settled between the parties after the contract is signed).
  int? get indicativeTotal => listing.price == null ? null : listing.price! * units;

  bool get isComplete => start != null && units >= minUnits && units <= maxUnits;

  ReservationDraft copyWith({DateTime? start, int? units}) =>
      ReservationDraft(listing: listing, start: start ?? this.start, units: units ?? this.units);

  @override
  List<Object?> get props => [listing, start, units];
}
