import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/builders/login_builders.dart';
import '../../../_helpers/mocks/mocks.dart';

class MockLoginFlowController extends Mock implements LoginFlowController {}

void main() {
  late MockLoginRepository repository;
  late MockLoginFlowController flowController;
  final session = buildOtpSession();

  setUpAll(() => registerFallbackValue(session));

  setUp(() {
    repository = MockLoginRepository();
    flowController = MockLoginFlowController();
    GetIt.I
      ..registerFactory<LoginBloc>(() => LoginBloc(repository: repository))
      ..registerSingleton<LoginFlowController>(flowController);
  });

  tearDown(() => GetIt.I.reset());

  Future<void> pumpOtp(WidgetTester tester) {
    return tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: OtpView(session: session),
      ),
    );
  }

  testWidgets('shows the destination number and a disabled resend countdown', (tester) async {
    await pumpOtp(tester);

    expect(find.text('Code envoyé au ${session.phoneNumber}'), findsOneWidget);
    expect(find.textContaining('Renvoyer dans'), findsOneWidget);
  });

  testWidgets('auto-submits once the 6-digit code is complete', (tester) async {
    when(
      () => repository.verifyOtp(
        session: any(named: 'session'),
        code: any(named: 'code'),
      ),
    ).thenAnswer((_) async {});

    await pumpOtp(tester);
    await tester.enterText(find.byType(TextField), '123456');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    verify(() => repository.verifyOtp(session: session, code: '123456')).called(1);
  });
}
