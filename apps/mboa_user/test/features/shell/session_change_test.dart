import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/features/favorites/bloc/favorites_bloc.dart';
import 'package:mboa_user/features/favorites/ui/favorites_page.dart';
import 'package:mboa_user/features/messaging/ui/messages_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/load_brand_fonts.dart';

class MockFavoritesBloc extends MockBloc<FavoritesEvent, FavoritesState>
    implements FavoritesBloc {}

class MockConversationsBloc
    extends MockBloc<ConversationsEvent, ConversationsState>
    implements ConversationsBloc {}

/// **Signing in does not rebuild the tab shell.**
///
/// `replaceAll` lands on the same `UserShellRoute`, so the tabs stay alive:
/// their `initState` does not run again and nothing in the navigation redraws
/// them. A page that read the session once therefore kept telling a signed-in
/// tenant to create an account, and the threads they had just started were
/// reported as "no conversations".
///
/// These pump a page as a visitor, flip the session the way `AuthBloc` does,
/// and expect the page to notice by itself.
void main() {
  late MockFavoritesBloc favorites;
  late MockConversationsBloc conversations;

  setUpAll(loadBrandFonts);

  setUp(() {
    favorites = MockFavoritesBloc();
    conversations = MockConversationsBloc();
    when(() => favorites.state).thenReturn(const FavoritesReady());
    when(() => conversations.state).thenReturn(const ConversationsReady());
    if (!getIt.isRegistered<SessionSnapshot>()) {
      getIt.registerLazySingleton<SessionSnapshot>(SessionSnapshot.new);
    }
  });

  tearDown(getIt.reset);

  Future<void> pump(WidgetTester tester, Widget page) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<FavoritesBloc>.value(value: favorites),
            BlocProvider<ConversationsBloc>.value(value: conversations),
          ],
          child: page,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('the favourites tab stops asking for an account', (tester) async {
    await pump(tester, const FavoritesPage());
    expect(find.textContaining('Créez un compte'), findsOneWidget);

    getIt<SessionSnapshot>().markAuthenticated();
    await tester.pumpAndSettle();

    expect(find.textContaining('Créez un compte'), findsNothing);
    expect(find.text('Aucun favori'), findsOneWidget);
  });

  testWidgets('the messages tab stops offering to sign in', (tester) async {
    await pump(tester, const MessagesPage());
    // The visitor screen and the signed-in empty screen share their wording;
    // what separates them is the way in.
    expect(find.text('Se connecter'), findsOneWidget);

    getIt<SessionSnapshot>().markAuthenticated();
    await tester.pumpAndSettle();

    expect(find.text('Se connecter'), findsNothing);
    expect(find.text('Aucune conversation'), findsOneWidget);
  });

  testWidgets('and a sign-out puts the prompt back', (tester) async {
    getIt<SessionSnapshot>().markAuthenticated();
    await pump(tester, const FavoritesPage());
    expect(find.text('Aucun favori'), findsOneWidget);

    getIt<SessionSnapshot>().markUnauthenticated();
    await tester.pumpAndSettle();

    // The next person to open the app must not read the last one's screen.
    expect(find.textContaining('Créez un compte'), findsOneWidget);
  });
}
