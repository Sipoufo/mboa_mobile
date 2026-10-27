import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for NotificationsApi
void main() {
  final instance = ApiClient().getNotificationsApi();

  group(NotificationsApi, () {
    // How many are unread — what the bell shows
    //
    //Future<UnreadCount> countMyUnreadNotifications() async
    test('test countMyUnreadNotifications', () async {
      // TODO
    });

    // My notifications, newest first — the push's title, text, type, entity and link (30 days)
    //
    // Every notification sent to the account, including those whose push was turned off in the settings: the opt-out silences the push, not this list. A burst merged into one push stays one item per notification here.
    //
    //Future<PageResponseNotificationItem> listMyNotifications(Pageable pageable) async
    test('test listMyNotifications', () async {
      // TODO
    });

    // « Tout marquer comme lu » (idempotent)
    //
    //Future markAllNotificationsRead() async
    test('test markAllNotificationsRead', () async {
      // TODO
    });

    // Mark one read (idempotent); another account's id is 404 NOTIFICATION_NOT_FOUND
    //
    //Future<NotificationItem> markNotificationRead(String id) async
    test('test markNotificationRead', () async {
      // TODO
    });

  });
}
