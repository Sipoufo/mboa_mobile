import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for SavedSearchesApi
void main() {
  final instance = ApiClient().getSavedSearchesApi();

  group(SavedSearchesApi, () {
    // Forget a saved search
    //
    //Future deleteSavedSearch(String id) async
    test('test deleteSavedSearch', () async {
      // TODO
    });

    // Run a saved search — the same cards as /search; resets its count of new results
    //
    //Future<PageResponseSearchResult> getSavedSearchResults(String id, { int page, int size }) async
    test('test getSavedSearchResults', () async {
      // TODO
    });

    // My saved searches, each with its count of new results
    //
    //Future<BuiltList<SavedSearchResponse>> listSavedSearches() async
    test('test listSavedSearches', () async {
      // TODO
    });

    // Keep a search — three at most; N-01 when new listings match (RM-M04-07)
    //
    //Future<SavedSearchResponse> saveSearch(SaveSearchRequest saveSearchRequest) async
    test('test saveSearch', () async {
      // TODO
    });

    // Rename a saved search or switch its alerts
    //
    //Future<SavedSearchResponse> updateSavedSearch(String id, UpdateSavedSearchRequest updateSavedSearchRequest) async
    test('test updateSavedSearch', () async {
      // TODO
    });

  });
}
