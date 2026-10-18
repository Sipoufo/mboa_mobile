import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for FinanceAddOnApi
void main() {
  final instance = ApiClient().getFinanceAddOnApi();

  group(FinanceAddOnApi, () {
    // My finance add-on: active, until when, and its price
    //
    //Future<FinanceAddonResponse> getFinanceAddon() async
    test('test getFinanceAddon', () async {
      // TODO
    });

    // Buy 30 days of the add-on — added after the running period; same payment flow as a tier
    //
    //Future<PaymentInitiatedResponse> subscribeFinanceAddon(SubscribeAddonRequest subscribeAddonRequest, { String idempotencyKey }) async
    test('test subscribeFinanceAddon', () async {
      // TODO
    });

  });
}
