import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for HistoriqueApi
void main() {
  final instance = ApiClient().getHistoriqueApi();

  group(HistoriqueApi, () {
    // Reset the consultation history (RM-M06-05)
    //
    //Future clearMyHistorique() async
    test('test clearMyHistorique', () async {
      // TODO
    });

    // The 30 most recently consulted listings, newest first
    //
    //Future<PageResponseHistoriqueResponse> listMyHistorique(Pageable pageable) async
    test('test listMyHistorique', () async {
      // TODO
    });

  });
}
