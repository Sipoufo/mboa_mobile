import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for SubscriptionsApi
void main() {
  final instance = ApiClient().getSubscriptionsApi();

  group(SubscriptionsApi, () {
    // Get the authenticated account's current subscription
    //
    //Future<SubscriptionResponse> getMySubscription() async
    test('test getMySubscription', () async {
      // TODO
    });

    // Get one payment's current status (poll this after initiating a payment)
    //
    //Future<PaymentSummary> getPayment(String id) async
    test('test getPayment', () async {
      // TODO
    });

    // Get a short-lived URL to download a payment's PDF receipt
    //
    //Future<ReceiptResponse> getPaymentReceipt(String id) async
    test('test getPaymentReceipt', () async {
      // TODO
    });

    // List the authenticated prestataire's payments, most recent first
    //
    //Future<PageResponsePaymentSummary> listMyPayments(Pageable pageable) async
    test('test listMyPayments', () async {
      // TODO
    });

    // List the subscription tiers and their current parameters
    //
    //Future<BuiltList<TierInfo>> listSubscriptionTiers() async
    test('test listSubscriptionTiers', () async {
      // TODO
    });

    // Payment confirmation webhook (HMAC-verified)
    //
    //Future paymentWebhook(PaymentWebhookRequest paymentWebhookRequest) async
    test('test paymentWebhook', () async {
      // TODO
    });

    // Subscribe to (or upgrade to) a paid tier; initiates a mobile-money payment
    //
    //Future<PaymentInitiatedResponse> subscribe(SubscribeRequest subscribeRequest, { String idempotencyKey }) async
    test('test subscribe', () async {
      // TODO
    });

  });
}
