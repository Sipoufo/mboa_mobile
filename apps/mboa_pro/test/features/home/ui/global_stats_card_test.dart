import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/home/models/dashboard_stats.dart';
import 'package:mboa_pro/features/home/ui/widgets/global_stats_card.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

void main() {
  const stats = DashboardStats(
    totalBiens: 17,
    byStatus: {
      AnnonceStatus.published: 12,
      AnnonceStatus.rented: 5,
    },
  );

  Future<void> pump(
    WidgetTester tester, {
    DashboardStats data = stats,
    SubscriptionTier tier = SubscriptionTier.gratuit,
    VoidCallback? onUpgrade,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(
            child: GlobalStatsCard(
              stats: data,
              access: AccessContext(
                role: AccountRole.prestataire,
                isKycApproved: true,
                tier: tier,
              ),
              onUpgrade: onUpgrade,
            ),
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
    // The status pills are meaningless with nothing to break down.
    expect(find.textContaining('Publiés'), findsNothing);
  });

  testWidgets('marks the metrics with no endpoint as unavailable', (tester) async {
    await pump(tester);

    // Views and contacts are free on Gratuit per M14, but nothing serves them.
    expect(find.text('Vues'), findsOneWidget);
    expect(find.text('Contacts'), findsOneWidget);
    expect(find.text('Bientôt'), findsWidgets);
  });

  testWidgets('offers a single upgrade CTA for the cheapest locked tier', (tester) async {
    var upgrades = 0;
    await pump(tester, onUpgrade: () => upgrades++);

    // Conversion + visites need Basic+, position needs Pro+ — the CTA points at
    // the cheapest of them.
    final cta = find.text('Passer à Basic+');
    expect(cta, findsOneWidget);
    expect(find.text('Passer à Pro+'), findsNothing);

    await tester.tap(cta);
    expect(upgrades, 1);
  });

  testWidgets('drops the CTA once every metric is unlocked', (tester) async {
    await pump(tester, tier: SubscriptionTier.proPlus);

    expect(find.textContaining('Passer à'), findsNothing);
    // Still honest that the figures themselves aren't served yet.
    expect(find.textContaining('backend'), findsOneWidget);
  });
}
