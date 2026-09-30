import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/features/favorites/bloc/favorites_bloc.dart';
import 'package:mboa_user/features/favorites/data/favorites_repository.dart';
import 'package:mboa_user/features/favorites/ui/favorites_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/load_brand_fonts.dart';

class MockFavoritesBloc extends MockBloc<FavoritesEvent, FavoritesState>
    implements FavoritesBloc {}

/// `FavoritesBloc` is held **by the shell**, above every tab and above the
/// fiches pushed over them.
///
/// The heart appears in three places — a search card, a fiche, the Favoris tab
/// — and a bloc per screen would let two of them disagree about the same
/// listing. This pins the consequence: each screen is pumped with only that
/// one bloc, the way the shell hands it down.
void main() {
  late MockFavoritesBloc favorites;

  Favorite favorite(String id, {bool isAvailable = true}) => Favorite(
        annonceId: id,
        title: 'Studio $id',
        city: 'Douala',
        district: 'Deido',
        price: 110000,
        isAvailable: isAvailable,
      );

  setUpAll(loadBrandFonts);

  setUp(() {
    favorites = MockFavoritesBloc();
    when(() => favorites.state).thenReturn(const FavoritesInitial());
    if (!getIt.isRegistered<SessionSnapshot>()) {
      getIt.registerLazySingleton<SessionSnapshot>(SessionSnapshot.new);
    }
  });

  tearDown(getIt.reset);

  Future<void> pump(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: BlocProvider<FavoritesBloc>.value(value: favorites, child: child),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('a visitor is invited to sign in, not shown an empty list',
      (tester) async {
    await pump(tester, const FavoritesPage());

    // An empty list would look like the app lost their favourites.
    expect(find.text('Créez un compte pour enregistrer'), findsOneWidget);
    expect(find.text('Aucun favori'), findsNothing);
  });

  testWidgets('signed in with nothing saved says what the heart is for',
      (tester) async {
    getIt<SessionSnapshot>().markAuthenticated();
    when(() => favorites.state).thenReturn(const FavoritesReady());
    await pump(tester, const FavoritesPage());

    expect(find.text('Aucun favori'), findsOneWidget);
    expect(find.textContaining('Touchez le cœur'), findsOneWidget);
  });

  testWidgets('a rented listing keeps its row, and says it is gone',
      (tester) async {
    getIt<SessionSnapshot>().markAuthenticated();
    when(() => favorites.state).thenReturn(
      FavoritesReady(
        items: [favorite('a-1'), favorite('a-2', isAvailable: false)],
      ),
    );
    await pump(tester, const FavoritesPage());

    expect(find.text('Studio a-1'), findsOneWidget);
    // RM-M06 — 30 days of grace, flagged rather than dropped.
    expect(find.text('Ce bien n\'est plus disponible'), findsOneWidget);
  });

  testWidgets('the favourites tab', (tester) async {
    getIt<SessionSnapshot>().markAuthenticated();
    when(() => favorites.state).thenReturn(
      FavoritesReady(
        items: [favorite('a-1'), favorite('a-2', isAvailable: false)],
      ),
    );
    await pump(tester, const FavoritesPage());

    await expectLater(
      find.byType(FavoritesPage),
      matchesGoldenFile('goldens/favorites.png'),
    );
  });
}
