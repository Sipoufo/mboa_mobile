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
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/load_brand_fonts.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class MockProProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements ProProfileBloc {}

class MockKycCubit extends MockCubit<KycState> implements KycCubit {}

void main() {
  late MockHomeBloc homeBloc;
  late MockProProfileBloc profileBloc;
  late MockKycCubit kycCubit;

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

  setUpAll(loadBrandFonts);

  setUp(() {
    homeBloc = MockHomeBloc();
    profileBloc = MockProProfileBloc();
    kycCubit = MockKycCubit();

    when(() => homeBloc.state).thenReturn(const HomeReady(stats));
    when(() => profileBloc.state).thenReturn(const ProProfileReady(profile));
    when(() => kycCubit.state).thenReturn(
      const KycReady(KycStatusData(status: KycStatus.approved), KycDraft()),
    );

    if (!getIt.isRegistered<AccessPolicy>()) {
      getIt.registerLazySingleton<AccessPolicy>(AccessPolicy.new);
    }
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
            BlocProvider<HomeBloc>.value(value: homeBloc),
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
