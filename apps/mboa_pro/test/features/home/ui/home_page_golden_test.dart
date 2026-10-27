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
import 'package:mboa_pro/features/rents/bloc/waiting_declarations_bloc.dart';
import 'package:mboa_pro/features/tenant_requests/bloc/open_requests_bloc.dart';
import 'package:mboa_pro/features/reservations/bloc/pending_reservations_bloc.dart';
import 'package:mboa_pro/features/subscription/bloc/subscription_bloc.dart';
import 'package:mboa_pro/features/subscription/models/subscription_models.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/load_brand_fonts.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class MockPendingReservationsBloc extends MockBloc<PendingReservationsEvent, PendingReservationsState>
    implements PendingReservationsBloc {}

class MockWaitingDeclarationsBloc extends MockBloc<WaitingDeclarationsEvent, WaitingDeclarationsState>
    implements WaitingDeclarationsBloc {}

class MockOpenRequestsBloc extends MockBloc<OpenRequestsEvent, OpenRequestsState> implements OpenRequestsBloc {}

class MockInboxBloc extends MockBloc<InboxEvent, InboxState> implements InboxBloc {}

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

  // What the server sends a Gratuit account (CA-M14-02): views, contacts and
  // contracts open; conversion and agent visits locked to Basic+; the
  // position locked to Pro+ — with no value for any locked figure.
  const stats = DashboardStats(
    totalBiens: 17,
    byStatus: {AnnonceStatus.published: 12, AnnonceStatus.rented: 5},
    views: DashboardFigure(value: 340),
    contacts: DashboardFigure(value: 12),
    conversionRate: DashboardFigure(locked: true, requiredTier: SubscriptionTier.basicPlus),
    agentVisits: DashboardFigure(locked: true, requiredTier: SubscriptionTier.basicPlus),
    signedContracts: DashboardFigure(value: 2),
    averagePosition: DashboardFigure(locked: true, requiredTier: SubscriptionTier.proPlus),
  );

  setUpAll(loadBrandFonts);

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

    when(() => homeBloc.state).thenReturn(const HomeReady(stats));
    when(() => profileBloc.state).thenReturn(const ProProfileReady(profile));
    when(() => kycCubit.state).thenReturn(
      const KycReady(KycStatusData(status: KycStatus.approved), KycDraft()),
    );
    // Gratuit; the figures above are locked by the server, not by this state.
    when(() => subscriptionBloc.state)
        .thenReturn(const SubscriptionReady(SubscriptionPlan.free()));

    if (!getIt.isRegistered<AccessPolicy>()) {
      getIt.registerLazySingleton<AccessPolicy>(AccessPolicy.new);
    }
    // §38 — the bell reads the session's inbox; nothing unread here.
    final inbox = MockInboxBloc();
    when(() => inbox.state).thenReturn(const InboxInitial());
    getIt.registerSingleton<InboxBloc>(inbox);
  });

  tearDown(() => getIt.reset());

  testWidgets('Pro home matches the reference design', (tester) async {
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
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(HomePage),
      matchesGoldenFile('goldens/pro_home.png'),
    );
  });
}
