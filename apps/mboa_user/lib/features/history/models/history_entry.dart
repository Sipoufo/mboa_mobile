import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// One fiche opened (CDC M06, RM-M06-05). A log of visits, not a set: the
/// same listing may come back, each time with what it cost then.
class HistoryEntry extends Equatable {
  const HistoryEntry({
    this.annonceId,
    this.title,
    this.primaryPhotoKey,
    this.price,
    this.rentalPeriod = RentalPeriod.fallback,
    this.monthlyRent,
    this.city,
    this.district,
    this.viewedAt,
  });

  /// Null once the listing has been deleted: the row stays, and opens nothing.
  final String? annonceId;
  final String? title;
  final String? primaryPhotoKey;
  final int? price;
  final RentalPeriod rentalPeriod;
  final int? monthlyRent;
  final String? city;
  final String? district;
  final DateTime? viewedAt;

  bool get isAvailable => annonceId != null;

  int? get displayPrice => price ?? monthlyRent;

  String? get photoUrl => BaseProfile.mediaUrl(primaryPhotoKey);

  static HistoryEntry fromResponse(HistoriqueResponse response) => HistoryEntry(
        annonceId: response.annonceId,
        title: response.title,
        primaryPhotoKey: response.primaryPhotoKey,
        price: response.price,
        rentalPeriod: RentalPeriod.fromWire(response.rentalPeriod?.name),
        monthlyRent: response.monthlyRent,
        city: response.city,
        district: response.district,
        viewedAt: response.viewedAt?.toLocal(),
      );

  Map<String, dynamic> toCache() => {
        'annonceId': annonceId,
        'title': title,
        'photo': primaryPhotoKey,
        'price': price,
        'period': rentalPeriod.name,
        'monthly': monthlyRent,
        'city': city,
        'district': district,
        'viewedAt': viewedAt?.toIso8601String(),
      };

  static HistoryEntry? fromCache(Object? raw) {
    if (raw is! Map) return null;
    return HistoryEntry(
      annonceId: raw['annonceId'] as String?,
      title: raw['title'] as String?,
      primaryPhotoKey: raw['photo'] as String?,
      price: raw['price'] as int?,
      rentalPeriod: RentalPeriod.values.asNameMap()[raw['period']] ?? RentalPeriod.fallback,
      monthlyRent: raw['monthly'] as int?,
      city: raw['city'] as String?,
      district: raw['district'] as String?,
      viewedAt: raw['viewedAt'] is String ? DateTime.tryParse(raw['viewedAt'] as String) : null,
    );
  }

  @override
  List<Object?> get props =>
      [annonceId, title, primaryPhotoKey, price, rentalPeriod, monthlyRent, city, district, viewedAt];
}
