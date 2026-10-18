import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AdminKPIsApi
void main() {
  final instance = ApiClient().getAdminKPIsApi();

  group(AdminKPIsApi, () {
    // The daily series as CSV for any period up to 366 days (RM-M22-02)
    //
    // `;`-separated with a UTF-8 BOM so Excel in French opens it as is; an empty cell is a figure that was not recorded that day.
    //
    //Future<String> exportAdminKpis({ Date from, Date to }) async
    test('test exportAdminKpis', () async {
      // TODO
    });

    // The KPI dashboard as of now: each figure with its 7/30-day windows and its target
    //
    //Future<KpiDashboardResponse> getAdminKpis() async
    test('test getAdminKpis', () async {
      // TODO
    });

    // One row per day (Africa/Douala), oldest first; at most 366 days, today provisional
    //
    //Future<BuiltList<KpiDayResponse>> listAdminKpiDays({ Date from, Date to }) async
    test('test listAdminKpiDays', () async {
      // TODO
    });

  });
}
