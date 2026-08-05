import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/annonces/ui/mes_biens_page.dart';
import 'package:mboa_pro/features/home/bloc/home_bloc.dart';
import 'package:mboa_pro/features/home/models/dashboard_stats.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

/// Regression cover for a ProviderNotFoundException.
///
/// `MesBiensPage` renders the dashboard card, but it is a **sibling route** of
/// the home tab — it never had `HomeBloc` above it, so the hub crashed on open.
/// `HomeBloc` is now provided by `AuthenticatedWrapper` for the whole
/// authenticated subtree.
///
/// The general rule this encodes: a screen that reads a bloc it does not
/// provide itself needs a widget test pumping it in isolation, with **only**
/// the blocs its route actually inherits.
void main() {
  late MockHomeBloc homeBloc;

  const stats = DashboardStats(
    totalBiens: 17,
    byStatus: {AnnonceStatus.published: 12},
  );

  setUp(() {
    homeBloc = MockHomeBloc();
    when(() => homeBloc.state).thenReturn(const HomeReady(stats));
  });

  Future<void> pump(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: BlocProvider<HomeBloc>.value(
          value: homeBloc,
          child: const MesBiensPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('renders every hub entry without a provider error', (tester) async {
    await pump(tester);

    expect(tester.takeException(), isNull);

    expect(find.textContaining('En attente'), findsOneWidget);
    expect(find.textContaining('Biens'), findsWidgets);
    expect(find.text('Attributions'), findsOneWidget);
    expect(find.text('Reservations'), findsOneWidget);
    expect(find.text('Prospections'), findsOneWidget);
  });

  testWidgets('shows the dashboard figures from the shared bloc', (tester) async {
    await pump(tester);

    expect(find.text('17'), findsOneWidget);
  });

  testWidgets('omits the stats card until the figures load', (tester) async {
    when(() => homeBloc.state).thenReturn(const HomeLoadInProgress());

    await pump(tester);

    expect(tester.takeException(), isNull);
    expect(find.text('17'), findsNothing);
  });

  testWidgets('lays out without overflow on a small phone', (tester) async {
    tester.view.physicalSize = const Size(320 * 3, 568 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await pump(tester);

    expect(tester.takeException(), isNull);
  });
}
