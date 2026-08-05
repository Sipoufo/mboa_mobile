import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for SubscriptionsApi
void main() {
  final instance = ApiClient().getSubscriptionsApi();

  group(SubscriptionsApi, () {
    // Get one payment's current status (poll this after initiating a payment)
    //
    //Future<PaymentSummary> getPayment(String id) async
    test('test getPayment', () async {
      // TODO
    });

    // List the authenticated prestataire's payments, most recent first
    //
    //Future<PageResponsePaymentSummary> listMyPayments(Pageable pageable) async
    test('test listMyPayments', () async {
      // TODO
    });

    // Get the authenticated account's current subscription
    //
    //Future<SubscriptionResponse> mySubscription() async
    test('test mySubscription', () async {
      // TODO
    });

    // Get a short-lived URL to download a payment's PDF receipt
    //
    //Future<ReceiptResponse> receipt(String id) async
    test('test receipt', () async {
      // TODO
    });

    // Subscribe to (or upgrade to) a paid tier; initiates a mobile-money payment
    //
    //Future<PaymentInitiatedResponse> subscribe(SubscribeRequest subscribeRequest, { String idempotencyKey }) async
    test('test subscribe', () async {
      // TODO
    });

    // List the subscription tiers and their current parameters
    //
    //Future<BuiltList<TierInfo>> tiers() async
    test('test tiers', () async {
      // TODO
    });

    // Payment confirmation webhook (HMAC-verified)
    //
    //Future webhook(PaymentWebhookRequest paymentWebhookRequest) async
    test('test webhook', () async {
      // TODO
    });

  });
}
