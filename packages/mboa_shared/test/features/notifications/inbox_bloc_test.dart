import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

class MockInboxRepository extends Mock implements InboxRepository {}

/// The notifications page and the bell (§38).
void main() {
  late MockInboxRepository repository;
  final now = DateTime(2026, 10, 27, 12);

  InboxItem item(String id, {bool read = false}) => InboxItem(
        id: id,
        type: PushType.message,
        title: 'Nouveau message',
        entityId: 'c-$id',
        createdAt: DateTime(2026, 10, 27, 9),
        readAt: read ? DateTime(2026, 10, 27, 10) : null,
      );

  setUp(() {
    repository = MockInboxRepository();
    when(() => repository.unreadCount()).thenAnswer((_) async => 5);
    when(() => repository.markRead(any())).thenAnswer((_) async {});
    when(() => repository.markAllRead()).thenAnswer((_) async {});
  });

  InboxBloc build() => InboxBloc(repository: repository, now: () => now);

  blocTest<InboxBloc, InboxState>(
    'the bell counts before the page was ever opened',
    build: build,
    act: (bloc) => bloc.add(const InboxUnreadCountRequested()),
    expect: () => [const InboxInitial(unread: 5)],
  );

  blocTest<InboxBloc, InboxState>(
    'online: the page, and the server\'s count — it covers the 30 days, not one page',
    setUp: () => when(() => repository.page(0)).thenAnswer(
      (_) async => Cached(InboxPage(items: [item('a'), item('b', read: true)], isLast: false)),
    ),
    build: build,
    act: (bloc) => bloc.add(const InboxRequested()),
    expect: () => [
      const InboxLoading(),
      InboxReady(items: [item('a'), item('b', read: true)], isLast: false, unread: 5),
    ],
  );

  blocTest<InboxBloc, InboxState>(
    'offline: the kept page, counted from what it holds, and no paging',
    setUp: () => when(() => repository.page(0)).thenAnswer(
      (_) async => Cached(InboxPage(items: [item('a'), item('b', read: true)], isLast: true), fromCache: true),
    ),
    build: build,
    act: (bloc) => bloc
      ..add(const InboxRequested())
      ..add(const InboxNextPageRequested()),
    verify: (bloc) {
      final state = bloc.state as InboxReady;
      expect(state.isOffline, isTrue);
      expect(state.unread, 1);
      verifyNever(() => repository.page(1));
    },
  );

  blocTest<InboxBloc, InboxState>(
    'opened: read on screen at once, one less on the bell, and the server told',
    seed: () => InboxReady(items: [item('a'), item('b')], unread: 2),
    build: build,
    act: (bloc) => bloc.add(const InboxItemOpened('a')),
    expect: () => [
      InboxReady(items: [item('a').readOn(now), item('b')], unread: 1),
    ],
    verify: (_) => verify(() => repository.markRead('a')).called(1),
  );

  blocTest<InboxBloc, InboxState>(
    'an item already read changes nothing — not the bell, not the server',
    seed: () => InboxReady(items: [item('a', read: true), item('b')], unread: 3),
    build: build,
    act: (bloc) => bloc.add(const InboxItemOpened('a')),
    expect: () => const <InboxState>[],
    verify: (_) => verifyNever(() => repository.markRead(any())),
  );

  blocTest<InboxBloc, InboxState>(
    'offline, there is no next page to ask for, whatever the kept page said',
    seed: () => InboxReady(items: [item('a')], isLast: false, isOffline: true),
    build: build,
    act: (bloc) => bloc.add(const InboxNextPageRequested()),
    verify: (_) => verifyNever(() => repository.page(any())),
  );

  blocTest<InboxBloc, InboxState>(
    '« Tout marquer comme lu »: everything read, the bell at 0',
    seed: () => InboxReady(items: [item('a'), item('b')], unread: 7),
    build: build,
    act: (bloc) => bloc.add(const InboxAllReadRequested()),
    expect: () => [
      InboxReady(items: [item('a').readOn(now), item('b').readOn(now)], unread: 0),
    ],
  );

  blocTest<InboxBloc, InboxState>(
    'refused or offline: nothing marked, and the screen says so',
    setUp: () => when(() => repository.markAllRead())
        .thenThrow(DioException(requestOptions: RequestOptions(path: '/notifications/read-all'))),
    seed: () => InboxReady(items: [item('a')], unread: 1),
    build: build,
    act: (bloc) => bloc.add(const InboxAllReadRequested()),
    expect: () => [
      InboxReady(items: [item('a').readOn(now)], unread: 0),
      InboxReady(items: [item('a')], unread: 1, allReadFailed: true),
    ],
  );

  blocTest<InboxBloc, InboxState>(
    'the next page is added below',
    setUp: () => when(() => repository.page(1))
        .thenAnswer((_) async => Cached(InboxPage(items: [item('c')], isLast: true))),
    seed: () => InboxReady(items: [item('a')], unread: 1, isLast: false),
    build: build,
    act: (bloc) => bloc.add(const InboxNextPageRequested()),
    verify: (bloc) {
      final state = bloc.state as InboxReady;
      expect(state.items.map((i) => i.id), ['a', 'c']);
      expect((state.page, state.isLast), (1, true));
    },
  );

  test('an item opens what its push opens', () {
    final push = item('a').asPush;

    expect((push.type, push.entityId), (PushType.message, 'c-a'));
  });
}
