import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for PrestataireProfileApi
void main() {
  final instance = ApiClient().getPrestataireProfileApi();

  group(PrestataireProfileApi, () {
    // Get the authenticated prestataire's profile
    //
    //Future<PrestataireProfileResponse> getMyPrestataireProfile() async
    test('test getMyPrestataireProfile', () async {
      // TODO
    });

    // Change the provider type — applied directly if eligible, else opens an admin request
    //
    //Future<TypeChangeResult> requestPrestataireTypeChange(RequestTypeChangeRequest requestTypeChangeRequest) async
    test('test requestPrestataireTypeChange', () async {
      // TODO
    });

    // Partially update the authenticated prestataire's profile
    //
    //Future<PrestataireProfileResponse> updateMyPrestataireProfile(UpdatePrestataireProfileRequest updatePrestataireProfileRequest) async
    test('test updateMyPrestataireProfile', () async {
      // TODO
    });

  });
}
