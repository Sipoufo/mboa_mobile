import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/app/router/app_router.dart';
import 'package:mboa_user/features/favorites/bloc/favorites_bloc.dart';
import 'package:mboa_user/features/my_home/bloc/my_homes_bloc.dart';
import 'package:mboa_user/features/saved_searches/bloc/saved_searches_bloc.dart';
import 'package:mboa_user/features/splash/logic/splash_cubit.dart';
import 'package:mboa_user/features/splash/ui/splash_page.dart';
import 'package:mocktail/mocktail.dart';

class MockSplashCubit extends MockCubit<SplashState> implements SplashCubit {}

class MockAppRouter extends Mock implements AppRouter {}

class MockSessionExpiryWatcher extends Mock implements SessionExpiryWatcher {}

class MockNotificationsRepository extends Mock implements NotificationsRepository {}

class MockFavoritesBloc extends MockBloc<FavoritesEvent, FavoritesState> implements FavoritesBloc {}

class MockConversationsBloc extends MockBloc<ConversationsEvent, ConversationsState> implements ConversationsBloc {}

class MockSavedSearchesBloc extends MockBloc<SavedSearchesEvent, SavedSearchesState> implements SavedSearchesBloc {}

class MockMyHomesBloc extends MockBloc<MyHomesEvent, MyHomesState> implements MyHomesBloc {}

/// **A restored session is a session.**
///
/// A sign-in goes through `AuthBloc`, which loads what belongs to the account
/// (the hearts, the threads, the saved searches, the rent banner). A restart
/// goes through the splash instead, and that path loaded none of it: the
/// tenant was signed in, with no rent banner and empty favourites.
void main() {
  late MockSplashCubit splash;
  late MockAppRouter router;
  late MockFavoritesBloc favorites;
  late MockConversationsBloc conversations;
  late MockSavedSearchesBloc savedSearches;
  late MockMyHomesBloc homes;

  setUpAll(() {
    registerFallbackValue(<PageRouteInfo>[]);
    registerFallbackValue(const FavoritesLoadRequested());
    registerFallbackValue(const ConversationsLoadRequested());
    registerFallbackValue(const SavedSearchesRequested());
    registerFallbackValue(const MyHomesRequested());
  });

  setUp(() {
    splash = MockSplashCubit();
    router = MockAppRouter();
    favorites = MockFavoritesBloc();
    conversations = MockConversationsBloc();
    savedSearches = MockSavedSearchesBloc();
    homes = MockMyHomesBloc();

    when(() => router.root).thenReturn(router);
    when(() => router.replaceAll(any())).thenAnswer((_) async {});

    final watcher = MockSessionExpiryWatcher();
    when(watcher.start).thenAnswer((_) async {});
    final notifications = MockNotificationsRepository();
    when(() => notifications.start(
          onForeground: any(named: 'onForeground'),
          onOpened: any(named: 'onOpened'),
        )).thenAnswer((_) async {});

    getIt
      ..registerSingleton<SessionSnapshot>(SessionSnapshot())
      ..registerSingleton<SessionExpiryWatcher>(watcher)
      ..registerSingleton<NotificationsRepository>(notifications)
      ..registerSingleton<FavoritesBloc>(favorites)
      ..registerSingleton<ConversationsBloc>(conversations)
      ..registerSingleton<SavedSearchesBloc>(savedSearches)
      ..registerSingleton<MyHomesBloc>(homes);
  });

  tearDown(getIt.reset);

  Future<void> pumpWith(WidgetTester tester, SplashState outcome) async {
    whenListen(
      splash,
      Stream.fromIterable([outcome]),
      initialState: const SplashLoading(),
    );
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: StackRouterScope(
          controller: router,
          stateHash: 0,
          child: BlocProvider<SplashCubit>.value(value: splash, child: const SplashPage()),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('a restored session loads what the account owns, as a sign-in does', (tester) async {
    await pumpWith(tester, const SplashAuthenticated());

    expect(getIt<SessionSnapshot>().hasSession, isTrue);
    verify(() => favorites.add(const FavoritesLoadRequested())).called(1);
    verify(() => conversations.add(const ConversationsLoadRequested())).called(1);
    verify(() => savedSearches.add(const SavedSearchesRequested())).called(1);
    verify(() => homes.add(const MyHomesRequested())).called(1);
  });

  testWidgets('a visitor loads nothing that belongs to an account', (tester) async {
    await pumpWith(tester, const SplashUnauthenticated());

    expect(getIt<SessionSnapshot>().hasSession, isFalse);
    verifyNever(() => favorites.add(any()));
    verifyNever(() => homes.add(any()));
  });
}
