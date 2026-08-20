import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for VisitesApi
void main() {
  final instance = ApiClient().getVisitesApi();

  group(VisitesApi, () {
    // Book a visit in one of the agent's free slots
    //
    //Future<VisiteResponse> bookVisite(BookVisiteRequest bookVisiteRequest) async
    test('test bookVisite', () async {
      // TODO
    });

    // Cancel a visit — allowed up to 4 hours before the slot (RM-M07-04)
    //
    //Future cancelMyVisite(String id) async
    test('test cancelMyVisite', () async {
      // TODO
    });

    // Confirm you are at the visit; with the visitor's, it completes it (RM-M07-05)
    //
    //Future<VisiteResponse> confirmClientPresence(String id) async
    test('test confirmClientPresence', () async {
      // TODO
    });

    // The bookable visitors for a listing, each with their own times (RM-M07-01)
    //
    //Future<BuiltList<VisitorSlots>> listBookableSlots(String annonceId) async
    test('test listBookableSlots', () async {
      // TODO
    });

    // The authenticated user's visits
    //
    //Future<PageResponseVisiteResponse> listMyVisites(Pageable pageable, { BuiltList<String> status, DateTime from, DateTime to }) async
    test('test listMyVisites', () async {
      // TODO
    });

    // Rate the agent 1–5 after the visit; optional, and only once (RM-M07-07)
    //
    //Future rateVisiteAgent(String id, RateAgentRequest rateAgentRequest) async
    test('test rateVisiteAgent', () async {
      // TODO
    });

  });
}
