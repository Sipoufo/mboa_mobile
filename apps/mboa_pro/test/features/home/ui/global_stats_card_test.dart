import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/home/models/dashboard_stats.dart';
import 'package:mboa_pro/features/home/ui/widgets/global_stats_card.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// CA-M14-02 — the figures, locked or not as the server decided.
void main() {
  // A Basic+ account: views, contacts and contracts are open; conversion and
  // agent visits too; the average position is Pro+.
  const stats = DashboardStats(
    totalBiens: 17,
    byStatus: {
      AnnonceStatus.published: 12,
      AnnonceStatus.rented: 5,
    },
    views: DashboardFigure(value: 340),
    contacts: DashboardFigure(value: 12),
    conversionRate: DashboardFigure(value: 3.5, requiredTier: SubscriptionTier.basicPlus),
    agentVisits: DashboardFigure(value: 4, requiredTier: SubscriptionTier.basicPlus),
    signedContracts: DashboardFigure(value: 2),
    averagePosition: DashboardFigure(locked: true, requiredTier: SubscriptionTier.proPlus),
  );

  Future<void> pump(WidgetTester tester, {DashboardStats data = stats, VoidCallback? onUpgrade}) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(
            child: GlobalStatsCard(stats: data, onUpgrade: onUpgrade),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('shows the headline count and the status breakdown', (tester) async {
    await pump(tester);

    expect(find.text('17'), findsOneWidget);
    expect(find.text('12 Publiés'), findsOneWidget);
    expect(find.text('5 Loués'), findsOneWidget);
  });

  testWidgets('shows the empty-portfolio copy instead of a bare zero', (tester) async {
    await pump(tester, data: const DashboardStats.empty());

    expect(find.text('0'), findsOneWidget);
    expect(find.textContaining('aucun bien'), findsOneWidget);
    expect(find.textContaining('Publiés'), findsNothing);
  });

  testWidgets('the open figures are shown as the server counted them', (tester) async {
    await pump(tester);

    expect(find.text('340'), findsOneWidget);
    expect(find.text('12'), findsOneWidget);
    // Contacts per 100 views, already a percentage on the wire.
    expect(find.text('3.5 %'), findsOneWidget);
    expect(find.text('4'), findsOneWidget);
  });

  testWidgets('a locked figure is blurred, and the CTA names the tier the server asked for', (tester) async {
    var upgrades = 0;
    await pump(tester, onUpgrade: () => upgrades++);

    // Only the position is locked here, so the CTA is Pro+ — not Basic+, which
    // a client-side rule would have guessed from the conversion tile.
    final cta = find.text('Passer à Pro+');
    expect(cta, findsOneWidget);
    expect(find.text('Passer à Basic+'), findsNothing);

    await tester.tap(cta);
    expect(upgrades, 1);
  });

  testWidgets('nothing to measure yet reads "—", never a made-up 0', (tester) async {
    await pump(
      tester,
      data: const DashboardStats(
        totalBiens: 1,
        conversionRate: DashboardFigure(),
        averagePosition: DashboardFigure(),
      ),
    );

    expect(find.text('—'), findsNWidgets(2));
    expect(find.text('0.0 %'), findsNothing);
  });

  testWidgets('a figure nobody can see yet is "Bientôt", without an upgrade', (tester) async {
    await pump(
      tester,
      data: const DashboardStats(
        totalBiens: 1,
        views: DashboardFigure(value: 3),
        averagePosition: DashboardFigure(available: false),
      ),
    );

    expect(find.text('Bientôt'), findsWidgets);
    expect(find.textContaining('Passer à'), findsNothing);
    expect(find.textContaining('arrivent bientôt'), findsOneWidget);
  });
}
