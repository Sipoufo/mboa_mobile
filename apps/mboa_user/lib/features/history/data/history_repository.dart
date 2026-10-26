import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../models/history_entry.dart';

/// The fiches the tenant opened (CDC M06). The server writes it as the fiches
/// are read; the app only reads it, and clears it (RM-M06-05).
class HistoryRepository {
  HistoryRepository({required DioClient dioClient, required HiveCache cache})
      : _dioClient = dioClient,
        _cache = cache;

  final DioClient _dioClient;
  final HiveCache _cache;

  /// The account's own: kept in an account-scoped box, emptied at sign-out.
  static const String _key = 'historique';

  /// The server keeps the last 30.
  static const int _pageSize = 30;

  HistoriqueApi get _api => _dioClient.api.getHistoriqueApi();

  /// Newest first. Offline, the last read.
  Future<Cached<List<HistoryEntry>>> list() async {
    try {
      final response = await _api.listMyHistorique(
        pageable: Pageable((b) => b
          ..page = 0
          ..size = _pageSize),
      );
      final items = (response.data?.content ?? const <HistoriqueResponse>[]).map(HistoryEntry.fromResponse).toList();
      await _cache.put(StorageKeys.favoritesBox, _key, {'items': [for (final e in items) e.toCache()]});
      return Cached(items);
    } catch (error) {
      final raw = _cache.get(StorageKeys.favoritesBox, _key)?['items'];
      if (raw is! List) Error.throwWithStackTrace(error, StackTrace.current);
      return Cached([for (final e in raw) ?HistoryEntry.fromCache(e)], fromCache: true);
    }
  }

  /// Everything goes, the device's copy with it.
  Future<void> clear() async {
    await _api.clearMyHistorique();
    await _cache.put(StorageKeys.favoritesBox, _key, {'items': const <Object>[]});
  }
}
