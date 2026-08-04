import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for PrestataireProfileApi
void main() {
  final instance = ApiClient().getPrestataireProfileApi();

  group(PrestataireProfileApi, () {
    // Change the provider type — applied directly if eligible, else opens an admin request
    //
    //Future<TypeChangeResult> changeType(RequestTypeChangeRequest requestTypeChangeRequest) async
    test('test changeType', () async {
      // TODO
    });

    // Get the authenticated prestataire's profile
    //
    //Future<PrestataireProfileResponse> myProfile1() async
    test('test myProfile1', () async {
      // TODO
    });

    // Partially update the authenticated prestataire's profile
    //
    //Future<PrestataireProfileResponse> updateMyProfile1(UpdatePrestataireProfileRequest updatePrestataireProfileRequest) async
    test('test updateMyProfile1', () async {
      // TODO
    });

  });
}
