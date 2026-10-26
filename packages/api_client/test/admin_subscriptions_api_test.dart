import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AdminSubscriptionsApi
void main() {
  final instance = ApiClient().getAdminSubscriptionsApi();

  group(AdminSubscriptionsApi, () {
    // Add days to a subscription, same tier, with a mandatory reason (RM-M21-04)
    //
    //Future<AdminSubscriptionItem> extendSubscription(String accountId, ExtendSubscriptionRequest extendSubscriptionRequest) async
    test('test extendSubscription', () async {
      // TODO
    });

    // One prestataire's subscription, payments and admin adjustments
    //
    //Future<AdminSubscriptionDetail> getAdminSubscription(String accountId) async
    test('test getAdminSubscription', () async {
      // TODO
    });

    // Monthly recap: revenue, refunds, active prestataires and MRR per tier, exact FCFA (RM-M21-02)
    //
    //Future<SubscriptionRecapResponse> getSubscriptionRecap({ String month }) async
    test('test getSubscriptionRecap', () async {
      // TODO
    });

    // Grant a tier without payment, with a mandatory reason; refused over a paid period (RM-M21-01)
    //
    //Future<AdminSubscriptionItem> grantSubscription(GrantSubscriptionRequest grantSubscriptionRequest) async
    test('test grantSubscription', () async {
      // TODO
    });

    // Payment history, filtered by status, account and month
    //
    //Future<PageResponseAdminPaymentItem> listAdminPayments(Pageable pageable, { String status, String accountId, String month }) async
    test('test listAdminPayments', () async {
      // TODO
    });

    // Subscriptions, filtered by tier and status
    //
    //Future<PageResponseAdminSubscriptionItem> listAdminSubscriptions(Pageable pageable, { String tier, String status }) async
    test('test listAdminSubscriptions', () async {
      // TODO
    });

    // Record a refund made outside the platform; access is not cut (RM-M21-03)
    //
    //Future<AdminPaymentItem> refundPayment(String id, RefundPaymentRequest refundPaymentRequest) async
    test('test refundPayment', () async {
      // TODO
    });

    // Update a tier's parameters (price, listing limit, residence unit allowance, finance tools)
    //
    // What the founder adjusts to the market without a release: the entry prices set by V076 (3 000 / 7 500 / 10 000 FCFA), the allowances, and which plans include the finance tools (M24–M26). A price applies to the payments that follow; a period already paid is untouched.
    //
    //Future<TierInfo> updatePlan(String tier, UpdatePlanRequest updatePlanRequest) async
    test('test updatePlan', () async {
      // TODO
    });

  });
}
