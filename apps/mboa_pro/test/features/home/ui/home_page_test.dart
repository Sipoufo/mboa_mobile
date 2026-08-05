import 'package:flutter/material.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/home/bloc/home_bloc.dart';
import 'package:mboa_pro/features/home/models/dashboard_stats.dart';
import 'package:mboa_pro/features/home/ui/home_page.dart';
import 'package:mboa_pro/features/kyc/logic/kyc_cubit.dart';
import 'package:mboa_pro/features/kyc/models/kyc_draft.dart';
import 'package:mboa_pro/features/kyc/models/kyc_status.dart';
import 'package:mboa_pro/features/profile/models/profile_data.dart';
import 'package:mboa_pro/features/profile/profile_types.dart';
import 'package:mboa_pro/features/subscription/bloc/subscription_bloc.dart';
import 'package:mboa_pro/features/subscription/models/subscription_models.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class MockProProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements ProProfileBloc {}

class MockKycCubit extends MockCubit<KycState> implements KycCubit {}

class MockSubscriptionBloc
    extends MockBloc<SubscriptionEvent, SubscriptionState>
    implements SubscriptionBloc {}

void main() {
  late MockHomeBloc homeBloc;
  late MockProProfileBloc profileBloc;
  late MockKycCubit kycCubit;
  late MockSubscriptionBloc subscriptionBloc;

  const profile = ProfileData(
    firstName: 'Inesse',
    lastName: 'Kiawantio',
    role: AccountRole.prestataire,
    mainCity: 'Douala',
  );

  const stats = DashboardStats(
    totalBiens: 17,
    byStatus: {AnnonceStatus.published: 12, AnnonceStatus.rented: 5},
  );

  setUp(() {
    homeBloc = MockHomeBloc();
    profileBloc = MockProProfileBloc();
    kycCubit = MockKycCubit();
    subscriptionBloc = MockSubscriptionBloc();

    when(() => profileBloc.state).thenReturn(const ProProfileReady(profile));
    when(() => kycCubit.state).thenReturn(
      const KycReady(KycStatusData(status: KycStatus.approved), KycDraft()),
    );
    // Gratuit, so the M14 tier-gated metrics render locked.
    when(() => subscriptionBloc.state)
        .thenReturn(const SubscriptionReady(SubscriptionPlan.free()));

    if (!getIt.isRegistered<AccessPolicy>()) {
      getIt.registerLazySingleton<AccessPolicy>(AccessPolicy.new);
    }
  });

  tearDown(() => getIt.reset());

  /// [settle] must be false for states that animate forever (the loader).
  Future<void> pump(
    WidgetTester tester,
    HomeState state, {
    bool settle = true,
  }) async {
    when(() => homeBloc.state).thenReturn(state);

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<ProProfileBloc>.value(value: profileBloc),
            BlocProvider<KycCubit>.value(value: kycCubit),
            BlocProvider<SubscriptionBloc>.value(value: subscriptionBloc),
            BlocProvider<HomeBloc>.value(value: homeBloc),
          ],
          child: const HomePage(),
        ),
      ),
    );
    if (settle) {
      await tester.pumpAndSettle();
    } else {
      await tester.pump();
    }
  }

  testWidgets('renders header, title, the three CTAs and the stats', (tester) async {
    await pump(tester, const HomeReady(stats));

    expect(find.text('Inesse Kiawantio'), findsOneWidget);
    expect(find.text('Douala'), findsOneWidget);
    expect(find.textContaining('Gérez vos biens'), findsOneWidget);

    expect(find.text('Mes biens'), findsOneWidget);
    expect(find.text('Portefeuille'), findsOneWidget);
    expect(find.text('Mes agents'), findsOneWidget);

    expect(find.text('17'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('lays out without overflow on a small phone', (tester) async {
    tester.view.physicalSize = const Size(320 * 3, 568 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await pump(tester, const HomeReady(stats));

    expect(tester.takeException(), isNull);
  });

  testWidgets('shows the offline banner for cached figures', (tester) async {
    await pump(tester, const HomeReady(stats, fromCache: true));

    expect(find.text('Données hors ligne'), findsOneWidget);
  });

  testWidgets('shows a retry affordance when there is nothing to show', (tester) async {
    await pump(tester, const HomeFailure());

    expect(find.text('Réessayer'), findsOneWidget);

    await tester.tap(find.text('Réessayer'));
    verify(() => homeBloc.add(const HomeLoadRequested())).called(1);
  });

  testWidgets('shows a loader while the first fetch runs', (tester) async {
    await pump(tester, const HomeLoadInProgress(), settle: false);

    expect(find.byType(Loader), findsOneWidget);
  });
}
