import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../score/load_brand_fonts.dart';

class MockInboxBloc extends MockBloc<InboxEvent, InboxState> implements InboxBloc {}

/// §40 E — the founder: « En cas de compte refusé, afficher en rouge dans la
/// rubrique des notifications ». An approval and a refusal were both `KYC`;
/// each notification now says which it is, and whether it is good news.
void main() {
  setUpAll(loadBrandFonts);

  group('reading it', () {
    test('a push carries its code and its outcome', () {
      final push = PushMessage.fromData({'type': 'KYC', 'code': 'N-12', 'outcome': 'NEGATIVE'});

      expect(push.code, 'N-12');
      expect(push.outcome, NotificationOutcome.negative);
    });

    test('absent or unknown: neither — shown as before', () {
      expect(PushMessage.fromData({'type': 'KYC'}).outcome, NotificationOutcome.none);
      expect(NotificationOutcome.parse('SOMETIMES'), NotificationOutcome.none);
      expect(NotificationOutcome.parse('positive'), NotificationOutcome.positive);
    });

    test('a kept notification carries them, and keeps them offline', () {
      final item = InboxItem.fromResponse(
        NotificationItem((b) => b
          ..id = 'n-1'
          ..type = NotificationItemTypeEnum.KYC
          ..title = 'Compte refusé'
          ..code = 'N-12'
          ..outcome = NotificationItemOutcomeEnum.NEGATIVE),
      );

      expect((item.code, item.outcome), ('N-12', NotificationOutcome.negative));
      expect(InboxItem.fromCache(item.toCache()), item);
      // Opened, it routes as its push would — the outcome with it.
      expect(item.asPush.outcome, NotificationOutcome.negative);
      expect(item.readOn(DateTime(2026, 11, 3)).outcome, NotificationOutcome.negative);
    });

    test('kept before §40 E: none', () {
      final item = InboxItem.fromCache({'id': 'n-1', 'type': 'kyc', 'title': 'Compte validé'});

      expect(item?.outcome, NotificationOutcome.none);
    });
  });

  group('the page', () {
    late MockInboxBloc bloc;
    final now = DateTime.now();

    final items = [
      InboxItem(
        id: 'n-1',
        type: PushType.kyc,
        title: 'Compte refusé',
        body: 'Motif : la photo du recto est floue.',
        code: 'N-12',
        outcome: NotificationOutcome.negative,
        createdAt: DateTime(now.year, now.month, now.day, 10),
      ),
      InboxItem(
        id: 'n-2',
        type: PushType.contract,
        title: 'Contrat signé',
        body: 'Ton contrat pour « Studio Akwa » est signé par les deux parties.',
        code: 'N-08',
        outcome: NotificationOutcome.positive,
        createdAt: DateTime(now.year, now.month, now.day, 9),
        readAt: DateTime(now.year, now.month, now.day, 9),
      ),
      InboxItem(
        id: 'n-3',
        type: PushType.message,
        title: 'Nouveau message',
        body: 'Awa : « Le studio est-il toujours libre ? »',
        createdAt: DateTime(now.year, now.month, now.day, 8),
        readAt: DateTime(now.year, now.month, now.day, 8),
      ),
    ];

    setUpAll(() => registerFallbackValue(const InboxRequested()));

    setUp(() {
      bloc = MockInboxBloc();
      when(() => bloc.state).thenReturn(InboxReady(items: items, unread: 1));
    });

    Future<void> pump(WidgetTester tester) async {
      tester.view.physicalSize = const Size(390 * 3, 844 * 3);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: Scaffold(
            backgroundColor: MboaColorScheme.light.background,
            appBar: AppBar(title: const Text('Notifications')),
            body: BlocProvider<InboxBloc>.value(value: bloc, child: NotificationsView(onOpen: (_) {})),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    Color? titleColor(WidgetTester tester, String title) => tester.widget<Text>(find.text(title)).style?.color;

    testWidgets('a refusal reads red, under the crossed shield; good news is green; the rest as before',
        (tester) async {
      await pump(tester);
      const colors = MboaColorScheme.light;

      expect(titleColor(tester, 'Compte refusé'), colors.error);
      expect(titleColor(tester, 'Contrat signé'), colors.ink);
      expect(titleColor(tester, 'Nouveau message'), colors.ink);

      final refusal = tester.widget<Icon>(find.byIcon(LucideIcons.shieldX));
      expect(refusal.color, colors.error);
      expect(tester.widget<Icon>(find.byIcon(LucideIcons.fileSignature)).color, colors.success);
      expect(tester.widget<Icon>(find.byIcon(LucideIcons.messageCircle)).color, colors.primary);

      await expectLater(find.byType(MaterialApp), matchesGoldenFile('goldens/notifications_outcomes.png'));
    });
  });

  group('with the app open', () {
    Future<void> show(WidgetTester tester, PushMessage message) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MboaTheme.light(),
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () => showForegroundPush(context, message),
                child: const Text('push'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('push'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
    }

    Future<void> drain(WidgetTester tester) async {
      // The toast goes by itself.
      await tester.pump(const Duration(seconds: 10));
      await tester.pumpAndSettle();
    }

    for (final (outcome, icon) in [
      (NotificationOutcome.negative, LucideIcons.circleX),
      (NotificationOutcome.positive, LucideIcons.circleCheck),
      (NotificationOutcome.none, LucideIcons.info),
    ]) {
      testWidgets('${outcome.name}: the toast in its colour', (tester) async {
        await show(tester, PushMessage(type: PushType.kyc, title: 'Compte', outcome: outcome));

        expect(find.text('Compte'), findsOneWidget);
        expect(find.byIcon(icon), findsOneWidget);
        await drain(tester);
      });
    }

    testWidgets('nothing to say without a title', (tester) async {
      await show(tester, const PushMessage(type: PushType.kyc, outcome: NotificationOutcome.negative));

      expect(find.byIcon(LucideIcons.circleX), findsNothing);
    });
  });
}
