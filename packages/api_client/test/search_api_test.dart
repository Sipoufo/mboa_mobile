import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for SearchApi
void main() {
  final instance = ApiClient().getSearchApi();

  group(SearchApi, () {
    // Public profile of an Agent Mboa (M15)
    //
    // Readable without an account, like a listing's fiche. Carries no phone number, no email and nothing from KYC. A suspended agent still resolves — they are named on every visit they carried out; only a deleted account is withheld.
    //
    //Future<AgentPublicProfile> getAgentPublicProfile(String id) async
    test('test getAgentPublicProfile', () async {
      // TODO
    });

    // Public fiche of a listing (M05)
    //
    // Readable without an account. The exact address is never returned and the coordinates are fuzzed by ~200m. Send X-Device-Id so anonymous views are counted once per device per 24h; signed-in views are counted by account.
    //
    //Future<AnnonceDetailResponse> getAnnonceDetail(String id, { String xDeviceId }) async
    test('test getAnnonceDetail', () async {
      // TODO
    });

    // Public detail of a residence with its live units
    //
    //Future<ResidenceDetailResponse> getResidenceDetail(String id) async
    test('test getResidenceDetail', () async {
      // TODO
    });

    // A property's reviews — visits and tenancies in one feed (RM-M27-05)
    //
    // Public, like the fiche itself. Each item carries a `type` of VISIT or RESIDENT; a resident's review counts three times a visitor's in the note (RG-06). Filter with `?type=` to show one kind. An author who has deleted their account appears without a name; the review stays, because it describes the property.
    //
    //Future<PageResponsePropertyReview> listAnnonceReviews(String id, Pageable pageable, { String type }) async
    test('test listAnnonceReviews', () async {
      // TODO
    });

    // Search listings and residences (city/district required; other filters cumulative)
    //
    //Future<PageResponseSearchResult> searchListings({ String cityId, BuiltList<String> districtIds, BuiltList<String> propertyTypes, BuiltList<String> rentalPeriods, int rentMin, int rentMax, int roomsMin, int surfaceMin, int surfaceMax, bool furnished, bool availableNow, int page, int size }) async
    test('test searchListings', () async {
      // TODO
    });

  });
}
