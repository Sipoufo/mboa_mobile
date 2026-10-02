import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for BadgesApi
void main() {
  final instance = ApiClient().getBadgesApi();

  group(BadgesApi, () {
    // The latest photo verification on a listing
    //
    //Future<PhotoVerificationResponse> getAnnoncePhotoVerification(String id) async
    test('test getAnnoncePhotoVerification', () async {
      // TODO
    });

    // The prestataire's badges and photo verification requests
    //
    //Future<MyBadgesResponse> getMyBadges() async
    test('test getMyBadges', () async {
      // TODO
    });

    // The latest photo verification on a residence
    //
    //Future<PhotoVerificationResponse> getResidencePhotoVerification(String id) async
    test('test getResidencePhotoVerification', () async {
      // TODO
    });

    // Ask for a listing's photos to be verified
    //
    //Future<PhotoVerificationResponse> requestAnnoncePhotoVerification(String id) async
    test('test requestAnnoncePhotoVerification', () async {
      // TODO
    });

    // Ask for a residence's shared photos to be verified
    //
    //Future<PhotoVerificationResponse> requestResidencePhotoVerification(String id) async
    test('test requestResidencePhotoVerification', () async {
      // TODO
    });

  });
}
