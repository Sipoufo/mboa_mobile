import 'package:mboa_core/mboa_core.dart';

import '../../homes/data/homes_repository.dart' show Cached;
import '../models/inbox_item.dart';

/// One page of the notifications list.
class InboxPage {
  const InboxPage({required this.items, required this.isLast});

  final List<InboxItem> items;
  final bool isLast;
}

/// The notifications page (§38): every notification sent to the account,
/// kept 30 days by the server. Both apps, every role, the same routes.
class InboxRepository {
  InboxRepository({required DioClient dioClient, required HiveCache cache})
      : _dioClient = dioClient,
        _cache = cache;

  final DioClient _dioClient;
  final HiveCache _cache;

  /// The account's own: an account-scoped box, emptied at sign-out.
  static const String _key = 'notifications';
  static const int _pageSize = 30;

  NotificationsApi get _api => _dioClient.api.getNotificationsApi();

  /// Newest first. Offline, the first page as last read.
  Future<Cached<InboxPage>> page(int page) async {
    try {
      final response = await _api.listMyNotifications(
        pageable: Pageable((b) => b
          ..page = page
          ..size = _pageSize),
      );
      final data = response.data;
      final items = (data?.content ?? const <NotificationItem>[]).map(InboxItem.fromResponse).toList();
      if (page == 0) {
        await _cache.put(StorageKeys.favoritesBox, _key, {'items': [for (final item in items) item.toCache()]});
      }
      return Cached(InboxPage(items: items, isLast: data?.last ?? true));
    } catch (error) {
      final raw = _cache.get(StorageKeys.favoritesBox, _key)?['items'];
      if (page != 0 || raw is! List) Error.throwWithStackTrace(error, StackTrace.current);
      return Cached(
        // Offline there is no page 2: what was kept is all there is.
        InboxPage(items: [for (final item in raw) ?InboxItem.fromCache(item)], isLast: true),
        fromCache: true,
      );
    }
  }

  /// For the bell — cheap, asked on each return to the home screen.
  Future<int> unreadCount() async => (await _api.countMyUnreadNotifications()).data?.count ?? 0;

  Future<void> markRead(String id) => _api.markNotificationRead(id: id);

  Future<void> markAllRead() => _api.markAllNotificationsRead();
}
