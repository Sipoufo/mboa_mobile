import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/mocks/mocks.dart';

class MockNotificationsApi extends Mock implements NotificationsApi {}

class MockHiveCache extends Mock implements HiveCache {}

/// §38 — the first page is kept for a tunnel; the account's, emptied at sign-out.
void main() {
  late MockNotificationsApi api;
  late InboxRepository repository;
  final stored = <String, Map<String, dynamic>>{};

  setUpAll(() => registerFallbackValue(Pageable()));

  setUp(() {
    stored.clear();
    final dioClient = MockDioClient();
    final apiClient = MockApiClient();
    final cache = MockHiveCache();
    api = MockNotificationsApi();
    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getNotificationsApi).thenReturn(api);
    when(() => cache.put(any(), any(), any())).thenAnswer((call) async {
      stored['${call.positionalArguments[0]}/${call.positionalArguments[1]}'] =
          jsonDecode(jsonEncode(call.positionalArguments[2])) as Map<String, dynamic>;
    });
    when(() => cache.get(any(), any(), ttl: any(named: 'ttl')))
        .thenAnswer((call) => stored['${call.positionalArguments[0]}/${call.positionalArguments[1]}']);
    repository = InboxRepository(dioClient: dioClient, cache: cache);
  });

  void online() => when(() => api.listMyNotifications(pageable: any(named: 'pageable'))).thenAnswer(
        (_) async => Response(
          data: PageResponseNotificationItem((b) => b
            ..content = ListBuilder<NotificationItem>([
              NotificationItem((n) => n
                ..id = 'n-1'
                ..type = NotificationItemTypeEnum.CONTRACT
                ..title = 'Contrat signé'
                ..entityId = 'k-1'
                ..createdAt = DateTime.utc(2026, 10, 27, 8)),
            ])
            ..last = false),
          requestOptions: RequestOptions(path: '/notifications'),
          statusCode: 200,
        ),
      );

  void offline() => when(() => api.listMyNotifications(pageable: any(named: 'pageable')))
      .thenThrow(DioException(requestOptions: RequestOptions(path: '/notifications')));

  test('read once, then offline: the same first page, and nothing after it', () async {
    online();
    final read = await repository.page(0);
    offline();

    final kept = await repository.page(0);

    expect(kept.fromCache, isTrue);
    expect(kept.value.items, read.value.items);
    expect(kept.value.items.single.type, PushType.contract);
    expect(kept.value.isLast, isTrue);
    expect(stored.keys.single, startsWith(StorageKeys.favoritesBox));
  });

  test('offline, a page beyond the first is a failure, not the first again', () async {
    online();
    await repository.page(0);
    offline();

    await expectLater(repository.page(1), throwsA(isA<DioException>()));
  });

  test('a type this build does not know still lists, and opens the shell', () {
    final item = InboxItem.fromResponse(NotificationItem((n) => n
      ..id = 'n-2'
      ..type = NotificationItemTypeEnum.BADGE));

    expect(item.type, PushType.unknown);
  });
}
