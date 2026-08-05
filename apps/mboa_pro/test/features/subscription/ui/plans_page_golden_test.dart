import 'package:bloc_test/bloc_test.dart';
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

  const tiers = [
    TierOption(
      tier: SubscriptionTier.gratuit,
      rank: 0,
      monthlyPrice: 0,
      activeListingLimit: 1,
    ),
    TierOption(
      tier: SubscriptionTier.basicPlus,
      rank: 1,
      monthlyPrice: 5000,
      activeListingLimit: 3,
    ),
    TierOption(
      tier: SubscriptionTier.pro,
      rank: 2,
      monthlyPrice: 10000,
      activeListingLimit: 10,
      residenceUnitAllowance: 5,
    ),
    TierOption(
      tier: SubscriptionTier.proPlus,
      rank: 3,
      monthlyPrice: 15000,
      residenceUnitAllowance: 20,
    ),
  ];

  setUpAll(loadBrandFonts);

  setUp(() {
    repository = MockSubscriptionRepository();
    bloc = MockSubscriptionBloc();

    when(repository.tiers).thenAnswer((_) async => tiers);
    // On Basic+, so that tier renders as current and the rest as purchasable.
    when(() => bloc.state).thenReturn(
      const SubscriptionReady(SubscriptionPlan(tier: SubscriptionTier.basicPlus)),
    );

    if (getIt.isRegistered<SubscriptionRepository>()) {
      getIt.unregister<SubscriptionRepository>();
    }
    getIt.registerSingleton<SubscriptionRepository>(repository);
  });

  tearDown(() => getIt.reset());

  testWidgets('plans render with the current tier marked', (tester) async {
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
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
    expect(find.text('Formule actuelle'), findsOneWidget);
    // The current plan offers no "Choisir" button; the other three do.
    expect(find.text('Choisir'), findsNWidgets(3));

    await expectLater(
      find.byType(PlansPage),
      matchesGoldenFile('goldens/plans.png'),
    );
  });
}
