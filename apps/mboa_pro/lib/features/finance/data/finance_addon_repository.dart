import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../models/finance_addon.dart';

/// Where the landlord stands with « Gestion financière » (RM-M13-09). Buying
/// it goes through the subscription checkout (`FinanceAddonPurchase`).
class FinanceAddonRepository {
  FinanceAddonRepository({required DioClient dioClient, required HiveCache cache})
      : _dioClient = dioClient,
        _cache = cache;

  final DioClient _dioClient;
  final HiveCache _cache;

  static const String _key = 'addon';

  /// Offline, the last read — enough to open what was recorded.
  Future<Cached<FinanceAddon>> addon() async {
    try {
      final data = (await _dioClient.api.getFinanceAddOnApi().getFinanceAddon()).data;
      final addon = data == null ? const FinanceAddon() : FinanceAddon.fromResponse(data);
      await _cache.put(StorageKeys.financeBox, _key, addon.toCache());
      return Cached(addon);
    } catch (error) {
      final cached = FinanceAddon.fromCache(_cache.get(StorageKeys.financeBox, _key));
      if (cached == null) Error.throwWithStackTrace(error, StackTrace.current);
      return Cached(cached, fromCache: true);
    }
  }
}
