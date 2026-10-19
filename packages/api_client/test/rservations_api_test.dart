import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for RservationsApi
void main() {
  final instance = ApiClient().getRservationsApi();

  group(RservationsApi, () {
    // Withdraw a request, or cancel an accepted reservation — free before signature (RM-M29-08)
    //
    //Future<ReservationResponse> cancelMyReservation(String id) async
    test('test cancelMyReservation', () async {
      // TODO
    });

    // One of my reservation requests
    //
    //Future<ReservationResponse> getMyReservation(String id) async
    test('test getMyReservation', () async {
      // TODO
    });

    // My reservation requests, newest first
    //
    //Future<PageResponseReservationResponse> listMyReservations(Pageable pageable, { BuiltList<String> status }) async
    test('test listMyReservations', () async {
      // TODO
    });

    // Ask to reserve a published listing: move-in day, duration, a word (RM-M29-01)
    //
    //Future<ReservationResponse> requestReservation(CreateReservationRequest createReservationRequest) async
    test('test requestReservation', () async {
      // TODO
    });

  });
}
