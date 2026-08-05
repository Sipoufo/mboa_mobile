import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AdminSubscriptionsApi
void main() {
  final instance = ApiClient().getAdminSubscriptionsApi();

  group(AdminSubscriptionsApi, () {
    // Grant a tier to an account for a number of days, without payment
    //
    //Future grant(GrantSubscriptionRequest grantSubscriptionRequest) async
    test('test grant', () async {
      // TODO
    });

    // Update a tier's parameters (price, listing limit, residence unit allowance)
    //
    //Future<TierInfo> updatePlan(String tier, UpdatePlanRequest updatePlanRequest) async
    test('test updatePlan', () async {
      // TODO
    });

  });
}
