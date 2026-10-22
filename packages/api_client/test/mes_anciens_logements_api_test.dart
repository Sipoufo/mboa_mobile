import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for MesAnciensLogementsApi
void main() {
  final instance = ApiClient().getMesAnciensLogementsApi();

  group(MesAnciensLogementsApi, () {
    // One past home: property as signed, contract code, confirmed expenses, requests, current note, my review (RM-M31-02 to 05)
    //
    //Future<PastHomeResponse> getMyPastHome(String contractId) async
    test('test getMyPastHome', () async {
      // TODO
    });

    // My expenses for a past home as a PDF: confirmed rents and charges with receipts and totals, the rest apart
    //
    //Future<String> getMyPastHomeExpensesPdf(String contractId) async
    test('test getMyPastHomeExpensesPdf', () async {
      // TODO
    });

    // My tenancies that are over, latest first (RM-M31-01)
    //
    //Future<PageResponseHomeSummary> listMyPastHomes(Pageable pageable) async
    test('test listMyPastHomes', () async {
      // TODO
    });

  });
}
