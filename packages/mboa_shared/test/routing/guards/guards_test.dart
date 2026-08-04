import 'package:auto_route/auto_route.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigationResolver extends Mock implements NavigationResolver {}

class MockStackRouter extends Mock implements StackRouter {}

void main() {
  late MockNavigationResolver resolver;
  late MockStackRouter router;
  late SessionSnapshot snapshot;

  setUp(() {
    resolver = MockNavigationResolver();
    router = MockStackRouter();
    snapshot = SessionSnapshot();
    when(() => resolver.next(any())).thenReturn(null);
  });

  group('SessionSnapshot', () {
    test('starts unauthenticated and tracks both transitions', () {
      expect(snapshot.hasSession, isFalse);

      snapshot.markAuthenticated();
      expect(snapshot.hasSession, isTrue);

      snapshot.markUnauthenticated();
      expect(snapshot.hasSession, isFalse);
    });
  });

  group('SessionGuard', () {
    test('lets navigation through when a session exists', () {
      var deniedCalls = 0;
      snapshot.markAuthenticated();

      SessionGuard(
        snapshot: snapshot,
        onDenied: (_) => deniedCalls++,
      ).onNavigation(resolver, router);

      verify(() => resolver.next(true)).called(1);
      expect(deniedCalls, 0);
    });

    test('aborts and redirects when there is no session', () {
      StackRouter? redirectedWith;

      SessionGuard(
        snapshot: snapshot,
        onDenied: (router) => redirectedWith = router,
      ).onNavigation(resolver, router);

      verify(() => resolver.next(false)).called(1);
      verifyNever(() => resolver.next(true));
      expect(redirectedWith, same(router));
    });

    test('reflects a logout that happened after construction', () {
      var deniedCalls = 0;
      snapshot.markAuthenticated();
      final guard = SessionGuard(
        snapshot: snapshot,
        onDenied: (_) => deniedCalls++,
      );

      snapshot.markUnauthenticated();
      guard.onNavigation(resolver, router);

      verify(() => resolver.next(false)).called(1);
      expect(deniedCalls, 1);
    });
  });

  group('GuestGuard', () {
    test('lets guests reach the login/welcome routes', () {
      var redirects = 0;

      GuestGuard(
        snapshot: snapshot,
        onAuthenticated: (_) => redirects++,
      ).onNavigation(resolver, router);

      verify(() => resolver.next(true)).called(1);
      expect(redirects, 0);
    });

    test('bounces an authenticated user away', () {
      StackRouter? redirectedWith;
      snapshot.markAuthenticated();

      GuestGuard(
        snapshot: snapshot,
        onAuthenticated: (router) => redirectedWith = router,
      ).onNavigation(resolver, router);

      verify(() => resolver.next(false)).called(1);
      expect(redirectedWith, same(router));
    });
  });
}
