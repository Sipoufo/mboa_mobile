import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationPreferencesBloc extends MockBloc<NotificationPreferencesEvent, NotificationPreferencesState>
    implements NotificationPreferencesBloc {}

/// RM-M03-01 — the notification switches in Paramètres.
void main() {
  late MockNotificationPreferencesBloc bloc;

  setUp(() => bloc = MockNotificationPreferencesBloc());

  Future<void> pump(WidgetTester tester, NotificationPreferencesState state) async {
    when(() => bloc.state).thenReturn(state);
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: BlocProvider<NotificationPreferencesBloc>.value(
          value: bloc,
          child: const NotificationPreferencesScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  const ready = NotificationPreferencesReady(
    all: [
      NotificationPreference(code: 'N05', enabled: true),
      NotificationPreference(code: 'N07', enabled: true, mandatory: true),
      NotificationPreference(code: 'N21', enabled: false),
    ],
    visible: [
      NotificationPreference(code: 'N05', enabled: true),
      NotificationPreference(code: 'N21', enabled: false),
    ],
  );

  testWidgets('a labelled switch per type, and one line for the mandatory ones', (tester) async {
    await pump(tester, ready);

    expect(find.byType(SwitchListTile), findsNWidgets(2));
    expect(find.text('Visites annulées'), findsOneWidget);
    // The label the backend asked for (N-21).
    expect(find.text('Réponses à mes avis'), findsOneWidget);
    expect(find.textContaining('restent toujours actives'), findsOneWidget);
  });

  testWidgets('a flip is sent to the bloc', (tester) async {
    await pump(tester, ready);

    await tester.tap(find.text('Réponses à mes avis'));

    verify(() => bloc.add(const NotificationPreferenceToggled('N21', enabled: true))).called(1);
  });

  testWidgets('while one saves, the switches wait', (tester) async {
    await pump(
      tester,
      const NotificationPreferencesReady(
        all: [],
        visible: [
          NotificationPreference(code: 'N05', enabled: true),
        ],
        savingCode: 'N05',
      ),
    );

    expect(tester.widget<SwitchListTile>(find.byType(SwitchListTile)).onChanged, isNull);
  });

  testWidgets('not loaded, it offers a retry — not an empty screen', (tester) async {
    await pump(tester, const NotificationPreferencesFailure());

    expect(find.byType(SwitchListTile), findsNothing);
    await tester.tap(find.text('Réessayer'));

    verify(() => bloc.add(const NotificationPreferencesRequested())).called(1);
  });
}
