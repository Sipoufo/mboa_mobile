import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for RservationsPrestataireApi
void main() {
  final instance = ApiClient().getRservationsPrestataireApi();

  group(RservationsPrestataireApi, () {
    // Accept, optionally on another unit of the residence (unitId): it is reserved for this client 7 days; the others on it are not retained (RM-M29-04/07/16)
    //
    //Future<ReservationResponse> acceptReservation(String id, { AcceptReservationRequest acceptReservationRequest }) async
    test('test acceptReservation', () async {
      // TODO
    });

    // Cancel an accepted reservation, with a reason — counted for the admin (RM-M29-08)
    //
    //Future<ReservationResponse> cancelIncomingReservation(String id, OwnerDecisionRequest ownerDecisionRequest) async
    test('test cancelIncomingReservation', () async {
      // TODO
    });

    // Extend an accepted reservation by 7 days, once (RM-M29-07)
    //
    //Future<ReservationResponse> extendReservation(String id) async
    test('test extendReservation', () async {
      // TODO
    });

    // One request on my listings
    //
    //Future<ReservationResponse> getIncomingReservation(String id) async
    test('test getIncomingReservation', () async {
      // TODO
    });

    // The residence's units this request could be accepted on instead — free, same period, the one asked for first (RM-M29-16)
    //
    //Future<BuiltList<AssignableUnit>> listAssignableUnits(String id) async
    test('test listAssignableUnits', () async {
      // TODO
    });

    // Requests on my listings, newest first, on one listing or one residence's units — status=PENDING's totalElements is the home counter
    //
    //Future<PageResponseReservationResponse> listIncomingReservations(Pageable pageable, { String annonceId, String residenceId, BuiltList<String> status }) async
    test('test listIncomingReservations', () async {
      // TODO
    });

    // Refuse, with a reason — never public (RM-M29-06)
    //
    //Future<ReservationResponse> refuseReservation(String id, OwnerDecisionRequest ownerDecisionRequest) async
    test('test refuseReservation', () async {
      // TODO
    });

  });
}
