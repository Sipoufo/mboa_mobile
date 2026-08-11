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

    // The assigned agent's free slots over the next 7 days; an empty list carries a reason
    //
    //Future<BookableSlotsResponse> listBookableSlots(String annonceId) async
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
