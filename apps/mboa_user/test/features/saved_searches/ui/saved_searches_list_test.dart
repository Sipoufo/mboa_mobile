import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/features/saved_searches/bloc/saved_searches_bloc.dart';
import 'package:mboa_user/features/saved_searches/models/saved_search.dart';
import 'package:mboa_user/features/saved_searches/ui/saved_searches_page.dart';
import 'package:mocktail/mocktail.dart';

class MockSavedSearchesBloc extends MockBloc<SavedSearchesEvent, SavedSearchesState> implements SavedSearchesBloc {}

/// RM-M04-07 — the list: what is new, and the switch that says so.
void main() {
  late MockSavedSearchesBloc bloc;

  const akwa = SavedSearch(id: 's-1', name: 'Appartement · Akwa', newMatchCount: 3);
  const deido = SavedSearch(id: 's-2', name: 'Deido', alertsEnabled: false);

  setUp(() => bloc = MockSavedSearchesBloc());

  Future<void> pump(WidgetTester tester, SavedSearchesReady state) async {
    when(() => bloc.state).thenReturn(state);
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: BlocProvider<SavedSearchesBloc>.value(
          value: bloc,
          child: Scaffold(body: SavedSearchesList(state: state)),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('each search says what is new, out of three', (tester) async {
    await pump(tester, const SavedSearchesReady(searches: [akwa, deido]));

    expect(find.text('2 sur 3'), findsOneWidget);
    expect(find.text('Appartement · Akwa'), findsOneWidget);
    expect(find.text('3 nouveaux'), findsOneWidget);
    // Nothing new is not a "0 nouveaux" badge.
    expect(find.textContaining(RegExp(r'^\d+ nouveaux?$')), findsOneWidget);
  });

  testWidgets('the switch sends N-01 on or off for that search', (tester) async {
    await pump(tester, const SavedSearchesReady(searches: [akwa, deido]));

    await tester.tap(find.byType(Switch).last);

    verify(() => bloc.add(const SavedSearchAlertsToggled('s-2', enabled: true))).called(1);
  });

  testWidgets('offline, it is read, not changed — and it says why', (tester) async {
    await pump(tester, const SavedSearchesReady(searches: [akwa], isOffline: true));

    expect(find.textContaining('Hors ligne'), findsOneWidget);
    expect(tester.widget<Switch>(find.byType(Switch)).onChanged, isNull);
    final menu = tester.widget(find.byWidgetPredicate((w) => w is PopupMenuButton));
    expect((menu as PopupMenuButton).enabled, isFalse);
  });

  testWidgets('none saved: how to save one, not a blank screen', (tester) async {
    await pump(tester, const SavedSearchesReady(searches: []));

    expect(find.text('0 sur 3'), findsOneWidget);
    expect(find.textContaining('Aucune recherche sauvegardée'), findsOneWidget);
  });
}
