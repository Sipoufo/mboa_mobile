import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// One saved listing (CDC M06).
class Favorite extends Equatable {
  const Favorite({
    required this.annonceId,
    this.title,
    this.primaryPhotoKey,
    this.price,
    this.rentalPeriod = RentalPeriod.fallback,
    this.monthlyRent,
    this.city,
    this.district,
    this.isAvailable = true,
    this.savedAt,
  });

  final String annonceId;
  final String? title;
  final String? primaryPhotoKey;
  final int? price;
  final RentalPeriod rentalPeriod;
  final int? monthlyRent;
  final String? city;
  final String? district;

  /// A listing that has been rented or archived **stays in the list for 30
  /// days, flagged**. Removing it silently would look like the app lost it;
  /// the row says it is gone instead.
  final bool isAvailable;

  final DateTime? savedAt;

  int? get displayPrice => price ?? monthlyRent;

  String? get photoUrl => BaseProfile.mediaUrl(primaryPhotoKey);

  static Favorite fromResponse(FavoriResponse response) => Favorite(
        annonceId: response.annonceId ?? '',
        title: response.title,
        primaryPhotoKey: response.primaryPhotoKey,
        price: response.price,
        rentalPeriod: RentalPeriod.fromFavorite(response.rentalPeriod),
        monthlyRent: response.monthlyRent,
        city: response.city,
        district: response.district,
        isAvailable: response.available ?? true,
        savedAt: response.savedAt?.toLocal(),
      );

  @override
  List<Object?> get props => [
        annonceId,
        title,
        primaryPhotoKey,
        price,
        rentalPeriod,
        monthlyRent,
        city,
        district,
        isAvailable,
        savedAt,
      ];
}

/// Saved listings (CDC M06).
///
/// Every call needs a session: a visitor may search and read, but not save
/// (RM-M04-05). The screen asks for a sign-in rather than calling and failing.
class FavoritesRepository {
  FavoritesRepository({required DioClient dioClient}) : _dioClient = dioClient;

  final DioClient _dioClient;

  /// RM-M06-02 — the server caps it at 50; the app shows that limit rather
  /// than letting the 51st fail silently.
  static const int maxFavorites = 50;

  static const int _pageSize = 50;

  FavorisApi get _api => _dioClient.api.getFavorisApi();

  Future<List<Favorite>> list() async {
    final response = await _api.listMyFavoris(
      pageable: Pageable((b) => b
        ..page = 0
        ..size = _pageSize),
    );
    return (response.data?.content ?? const <FavoriResponse>[])
        .map(Favorite.fromResponse)
        .toList();
  }

  /// Saving one twice is a no-op server-side, so the app never has to check
  /// first.
  Future<void> add(String annonceId) => _api.addFavori(
        addFavoriRequest:
            AddFavoriRequest((b) => b..annonceId = annonceId),
      );

  /// Unsaving one that is not saved is not an error either.
  Future<void> remove(String annonceId) =>
      _api.removeFavori(annonceId: annonceId);
}
