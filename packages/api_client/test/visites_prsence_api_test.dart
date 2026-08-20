import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for VisitesPrsenceApi
void main() {
  final instance = ApiClient().getVisitesPrsenceApi();

  group(VisitesPrsenceApi, () {
    // Confirm you are at the property; beyond 500 m a justification is required
    //
    //Future<VisiteResponse> confirmVisitorPresence(String id, StartVisiteRequest startVisiteRequest) async
    test('test confirmVisitorPresence', () async {
      // TODO
    });

  });
}
