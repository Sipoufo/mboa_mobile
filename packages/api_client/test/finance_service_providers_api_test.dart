import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for FinanceServiceProvidersApi
void main() {
  final instance = ApiClient().getFinanceServiceProvidersApi();

  group(FinanceServiceProvidersApi, () {
    // Declare a payment; it goes into the ledger as Sortie · Prestataires (RM-M26-04)
    //
    //Future<ServiceProviderPaymentResponse> addServiceProviderPayment(String id, ServiceProviderPaymentRequest serviceProviderPaymentRequest) async
    test('test addServiceProviderPayment', () async {
      // TODO
    });

    // Hide an intervenant from pickers; history kept
    //
    //Future<ServiceProviderResponse> archiveServiceProvider(String id) async
    test('test archiveServiceProvider', () async {
      // TODO
    });

    // Add an intervenant — a free entry, or linked to a messaging contact (RM-M26-01)
    //
    //Future<ServiceProviderResponse> createServiceProvider(ServiceProviderRequest serviceProviderRequest) async
    test('test createServiceProvider', () async {
      // TODO
    });

    // Delete an intervenant with no payments; archive the others
    //
    //Future deleteServiceProvider(String id) async
    test('test deleteServiceProvider', () async {
      // TODO
    });

    // Remove a payment and its ledger line
    //
    //Future deleteServiceProviderPayment(String id, String paymentId) async
    test('test deleteServiceProviderPayment', () async {
      // TODO
    });

    // One intervenant
    //
    //Future<ServiceProviderResponse> getServiceProvider(String id) async
    test('test getServiceProvider', () async {
      // TODO
    });

    // An intervenant's payments, latest first
    //
    //Future<BuiltList<ServiceProviderPaymentResponse>> listServiceProviderPayments(String id) async
    test('test listServiceProviderPayments', () async {
      // TODO
    });

    // My intervenants by name, with what each was paid
    //
    //Future<BuiltList<ServiceProviderResponse>> listServiceProviders({ bool includeArchived }) async
    test('test listServiceProviders', () async {
      // TODO
    });

    // Bring an archived intervenant back
    //
    //Future<ServiceProviderResponse> restoreServiceProvider(String id) async
    test('test restoreServiceProvider', () async {
      // TODO
    });

    // Change an intervenant's name, kind or note
    //
    //Future<ServiceProviderResponse> updateServiceProvider(String id, UpdateServiceProviderRequest updateServiceProviderRequest) async
    test('test updateServiceProvider', () async {
      // TODO
    });

    // Correct a payment; its ledger line follows
    //
    //Future<ServiceProviderPaymentResponse> updateServiceProviderPayment(String id, String paymentId, ServiceProviderPaymentRequest serviceProviderPaymentRequest) async
    test('test updateServiceProviderPayment', () async {
      // TODO
    });

  });
}
