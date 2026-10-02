import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AdminBadgesApi
void main() {
  final instance = ApiClient().getAdminBadgesApi();

  group(AdminBadgesApi, () {
    // Grant the Photos vérifiées badge
    //
    //Future<PhotoVerificationResponse> approvePhotoVerification(String id) async
    test('test approvePhotoVerification', () async {
      // TODO
    });

    // A prestataire's badges and their full trail
    //
    //Future<AdminPrestataireBadgesResponse> getAdminPrestataireBadges(String id) async
    test('test getAdminPrestataireBadges', () async {
      // TODO
    });

    // The photo verification queue, oldest first, with its 48h timer (RM-M20-01)
    //
    //Future<PageResponseAdminPhotoVerificationItem> listAdminPhotoVerifications(Pageable pageable, { String status }) async
    test('test listAdminPhotoVerifications', () async {
      // TODO
    });

    // Refuse it, with a reason (RM-M20-02)
    //
    //Future<PhotoVerificationResponse> rejectPhotoVerification(String id, BadgeDecisionRequest badgeDecisionRequest) async
    test('test rejectPhotoVerification', () async {
      // TODO
    });

    // Give Identité vérifiée back once cleared up
    //
    //Future restoreIdentityBadge(String id) async
    test('test restoreIdentityBadge', () async {
      // TODO
    });

    // Withdraw Identité vérifiée — the CNI was reported false (RG-03)
    //
    //Future revokeIdentityBadge(String id, BadgeDecisionRequest badgeDecisionRequest) async
    test('test revokeIdentityBadge', () async {
      // TODO
    });

    // Withdraw a granted badge (RM-M20-04)
    //
    //Future<PhotoVerificationResponse> revokePhotoVerification(String id, BadgeDecisionRequest badgeDecisionRequest) async
    test('test revokePhotoVerification', () async {
      // TODO
    });

  });
}
