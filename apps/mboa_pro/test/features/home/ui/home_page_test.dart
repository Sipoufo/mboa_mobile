import 'package:flutter/material.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/home/bloc/home_bloc.dart';
import 'package:mboa_pro/features/home/models/dashboard_stats.dart';
import 'package:mboa_pro/features/home/ui/home_page.dart';
import 'package:mboa_pro/features/home/ui/widgets/metric_tile.dart';
import 'package:mboa_pro/features/profile/models/profile_data.dart';
import 'package:mboa_pro/features/profile/profile_types.dart';
import 'package:mboa_pro/features/rents/bloc/waiting_declarations_bloc.dart';
import 'package:mboa_pro/features/tenant_requests/bloc/open_requests_bloc.dart';
import 'package:mboa_pro/features/reservations/bloc/pending_reservations_bloc.dart';
import 'package:mboa_pro/features/subscription/bloc/subscription_bloc.dart';
import 'package:mboa_pro/features/subscription/models/subscription_models.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class MockPendingReservationsBloc extends MockBloc<PendingReservationsEvent, PendingReservationsState>
    implements PendingReservationsBloc {}

class MockWaitingDeclarationsBloc extends MockBloc<WaitingDeclarationsEvent, WaitingDeclarationsState>
    implements WaitingDeclarationsBloc {}

class MockOpenRequestsBloc extends MockBloc<OpenRequestsEvent, OpenRequestsState> implements OpenRequestsBloc {}

class MockProProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements ProProfileBloc {}

class MockKycCubit extends MockCubit<KycState> implements KycCubit {}

class MockSubscriptionBloc
    extends MockBloc<SubscriptionEvent, SubscriptionState>
    implements SubscriptionBloc {}

void main() {
  late MockHomeBloc homeBloc;
  late MockPendingReservationsBloc pendingBloc;
  late MockWaitingDeclarationsBloc waitingBloc;
  late MockOpenRequestsBloc requestsBloc;
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
    pendingBloc = MockPendingReservationsBloc();
    when(() => pendingBloc.state).thenReturn(const PendingReservationsUnknown());
    waitingBloc = MockWaitingDeclarationsBloc();
    when(() => waitingBloc.state).thenReturn(const WaitingDeclarationsUnknown());
    requestsBloc = MockOpenRequestsBloc();
    when(() => requestsBloc.state).thenReturn(const OpenRequestsUnknown());
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
            BlocProvider<PendingReservationsBloc>.value(value: pendingBloc),
            BlocProvider<WaitingDeclarationsBloc>.value(value: waitingBloc),
            BlocProvider<OpenRequestsBloc>.value(value: requestsBloc),
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
    expect(find.textContaining('Douala'), findsOneWidget);
    expect(find.textContaining('Gère tes biens'), findsOneWidget);

    expect(find.text('Mes biens'), findsOneWidget);
    expect(find.text('Loyers'), findsOneWidget);
    expect(find.text('Mes agents'), findsOneWidget);

    expect(find.text('17'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('M29 — waiting requests are said on the home, and opened from it', (tester) async {
    when(() => pendingBloc.state).thenReturn(const PendingReservationsCounted(3));
    await pump(tester, const HomeReady(stats));

    expect(find.text('3 demandes de réservation attendent ta réponse'), findsOneWidget);
    expect(find.text('Répondre'), findsOneWidget);
  });

  testWidgets('M29 — nothing waiting, nothing said', (tester) async {
    when(() => pendingBloc.state).thenReturn(const PendingReservationsCounted(0));
    await pump(tester, const HomeReady(stats));

    expect(find.textContaining('attend'), findsNothing);
  });

  testWidgets('M29 — the count is read on first show', (tester) async {
    await pump(tester, const HomeReady(stats));

    verify(() => pendingBloc.add(const PendingReservationsRequested())).called(1);
  });

  testWidgets('M29 — and again on coming back to the app', (tester) async {
    await pump(tester, const HomeReady(stats));
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();

    // Seen on device: read once at sign-in, the count missed a later request.
    verify(() => pendingBloc.add(const PendingReservationsRequested())).called(2);
  });

  testWidgets('M30 — declared payments waiting for an answer are said, and opened from it', (tester) async {
    when(() => waitingBloc.state).thenReturn(const WaitingDeclarationsCounted(2));
    await pump(tester, const HomeReady(stats));

    expect(find.text('2 paiements déclarés attendent ta confirmation'), findsOneWidget);
    expect(find.text('Voir'), findsOneWidget);
  });

  testWidgets('M30 — nothing waiting, nothing said', (tester) async {
    when(() => waitingBloc.state).thenReturn(const WaitingDeclarationsCounted(0));
    await pump(tester, const HomeReady(stats));

    expect(find.textContaining('attend'), findsNothing);
  });

  testWidgets('M30 — the count is read on first show, and again on coming back', (tester) async {
    await pump(tester, const HomeReady(stats));
    verify(() => waitingBloc.add(const WaitingDeclarationsRequested())).called(1);

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();

    verify(() => waitingBloc.add(const WaitingDeclarationsRequested())).called(1);
  });

  testWidgets('M30 lot 3 — tenants\' requests waiting are said, and read on first show', (tester) async {
    when(() => requestsBloc.state).thenReturn(const OpenRequestsCounted(2));
    await pump(tester, const HomeReady(stats));

    expect(find.text('2 demandes de locataires attendent ta réponse'), findsOneWidget);
    verifyNever(() => requestsBloc.add(const OpenRequestsRequested()));
  });

  testWidgets('M30 lot 3 — unknown yet: asked for', (tester) async {
    await pump(tester, const HomeReady(stats));

    verify(() => requestsBloc.add(const OpenRequestsRequested())).called(1);
  });

  testWidgets('lays out without overflow on a small phone', (tester) async {
    tester.view.physicalSize = const Size(320 * 3, 568 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // Both nudges shown: the tallest the home gets.
    when(() => pendingBloc.state).thenReturn(const PendingReservationsCounted(12));
    when(() => waitingBloc.state).thenReturn(const WaitingDeclarationsCounted(12));
    when(() => requestsBloc.state).thenReturn(const OpenRequestsCounted(12));
    await pump(tester, const HomeReady(stats));
    expect(tester.takeException(), isNull);

    // All the way down: a lazy list builds only what is on screen, so the
    // stats' tiles were never laid out here while the header was taller —
    // and their overflow went unseen.
    for (var i = 0; i < 10 && find.byType(MetricTile).evaluate().isEmpty; i++) {
      await tester.drag(find.byType(ListView).first, const Offset(0, -500));
      await tester.pumpAndSettle();
    }
    expect(find.byType(MetricTile), findsWidgets);
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
