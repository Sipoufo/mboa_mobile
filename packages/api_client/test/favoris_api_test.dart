import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for FavorisApi
void main() {
  final instance = ApiClient().getFavorisApi();

  group(FavorisApi, () {
    // Save a listing (max 50 — RM-M06-02); saving one twice is a no-op
    //
    //Future<FavoriResponse> addFavori(AddFavoriRequest addFavoriRequest) async
    test('test addFavori', () async {
      // TODO
    });

    // List saved listings; unavailable ones stay for 30 days flagged available=false
    //
    //Future<PageResponseFavoriResponse> listMyFavoris(Pageable pageable) async
    test('test listMyFavoris', () async {
      // TODO
    });

    // Unsave a listing; unsaving one that is not saved is not an error
    //
    //Future removeFavori(String annonceId) async
    test('test removeFavori', () async {
      // TODO
    });

  });
}
