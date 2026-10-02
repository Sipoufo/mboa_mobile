import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for PrestataireDashboardApi
void main() {
  final instance = ApiClient().getPrestataireDashboardApi();

  group(PrestataireDashboardApi, () {
    // Portfolio totals, gated by the current tier
    //
    //Future<DashboardSummaryResponse> getMyDashboard() async
    test('test getMyDashboard', () async {
      // TODO
    });

    // Per-listing figures, residences grouped with their units, newest first
    //
    //Future<PageResponseDashboardItem> listMyDashboardEntries(Pageable pageable) async
    test('test listMyDashboardEntries', () async {
      // TODO
    });

  });
}
