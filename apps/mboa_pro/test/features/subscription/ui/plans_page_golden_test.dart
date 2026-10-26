import 'package:bloc_test/bloc_test.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/subscription/bloc/subscription_bloc.dart';
import 'package:mboa_pro/features/subscription/data/subscription_repository.dart';
import 'package:mboa_pro/features/subscription/models/subscription_models.dart';
import 'package:mboa_pro/features/subscription/ui/plans_page.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/load_brand_fonts.dart';

class MockSubscriptionRepository extends Mock
    implements SubscriptionRepository {}

class MockSubscriptionBloc
    extends MockBloc<SubscriptionEvent, SubscriptionState>
    implements SubscriptionBloc {}

void main() {
  late MockSubscriptionRepository repository;
  late MockSubscriptionBloc bloc;

  // The entry prices of 2026-10-26 (RM-M13-09) — the server's, never the app's.
  const tiers = [
    TierOption(
      tier: SubscriptionTier.gratuit,
      rank: 0,
      monthlyPrice: 0,
      activeListingLimit: 1,
      residenceUnitAllowance: 5,
    ),
    TierOption(
      tier: SubscriptionTier.basicPlus,
      rank: 1,
      monthlyPrice: 3000,
      activeListingLimit: 3,
      residenceUnitAllowance: 10,
      descriptions: {'fr': 'Meilleure visibilité que Gratuit.', 'en': 'Better visibility than Free.'},
    ),
    TierOption(
      tier: SubscriptionTier.pro,
      rank: 2,
      monthlyPrice: 7500,
      activeListingLimit: 10,
      residenceUnitAllowance: 50,
      includesFinance: true,
      descriptions: {'fr': 'Visibilité renforcée, statistiques avancées et suivi financier.'},
    ),
    TierOption(
      tier: SubscriptionTier.proPlus,
      rank: 3,
      monthlyPrice: 10000,
      includesFinance: true,
    ),
  ];

  setUpAll(loadBrandFonts);

  setUp(() {
    repository = MockSubscriptionRepository();
    bloc = MockSubscriptionBloc();

    when(repository.tiers).thenAnswer((_) async => tiers);
    // On Basic+, so that tier renders as current and the rest as purchasable.
    when(() => bloc.state).thenReturn(
      SubscriptionReady(SubscriptionPlan(tier: SubscriptionTier.basicPlus, periodEnd: DateTime(2099, 11, 22))),
    );

    if (getIt.isRegistered<SubscriptionRepository>()) {
      getIt.unregister<SubscriptionRepository>();
    }
    getIt.registerSingleton<SubscriptionRepository>(repository);
  });

  tearDown(() => getIt.reset());

  testWidgets('plans render with the current tier marked', (tester) async {
    // Tall enough for every plan: the golden is the whole page.
    tester.view.physicalSize = const Size(390 * 3, 1700 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: BlocProvider<SubscriptionBloc>.value(
          value: bloc,
          child: const PlansPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Basic+'), findsOneWidget);
    expect(find.text('Ta formule · jusqu\'au 22 nov. 2099'), findsOneWidget);
    // RM-M13-08 — the server's words, in the reader's language.
    expect(find.text('Meilleure visibilité que Gratuit.'), findsOneWidget);
    // The plan held offers no way to itself; the other three each one.
    expect(find.text('Passer à Basic+'), findsNothing);
    expect(find.text('Passer à Gratuit'), findsOneWidget);
    expect(find.text('Passer à Pro'), findsOneWidget);
    expect(find.text('Passer à Pro+'), findsOneWidget);
    // RM-M13-09 — the finance tools come with the plans that include them.
    expect(find.text('Suivi financier inclus'), findsNWidgets(2));

    await expectLater(
      find.byType(PlansPage),
      matchesGoldenFile('goldens/plans.png'),
    );
  });

  test('RM-M13-08 — a plan\'s words come from the server, in the reader\'s language, else in French', () {
    final option = TierOption.fromResponse(
      TierInfo(
        (b) => b
          ..tier = TierInfoTierEnum.PRO
          ..descriptions = MapBuilder<String, String>({'fr': 'Suivi financier inclus.', 'en': 'Finance included.'}),
      ),
    );

    expect(option.description('en'), 'Finance included.');
    expect(option.description('fr'), 'Suivi financier inclus.');
    expect(option.description('de'), 'Suivi financier inclus.');
    expect(const TierOption(tier: SubscriptionTier.pro).description('fr'), isNull);
  });
}

