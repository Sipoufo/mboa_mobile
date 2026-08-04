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

  setUpAll(() => registerFallbackValue(buildOtpSession()));

  setUp(() {
    repository = MockLoginRepository();
    flowController = MockLoginFlowController();
    GetIt.I
      ..registerFactory<LoginBloc>(() => LoginBloc(repository: repository))
      ..registerSingleton<LoginFlowController>(flowController);
  });

  tearDown(() => GetIt.I.reset());

  Future<void> pumpLogin(WidgetTester tester, {AuthMode mode = AuthMode.login}) {
    return tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: LoginView(mode: mode),
      ),
    );
  }

  testWidgets('composes the E.164 number with the +237 dial code', (tester) async {
    when(() => repository.requestOtp(any()))
        .thenAnswer((_) async => buildOtpSession());

    await pumpLogin(tester);
    await tester.enterText(find.byType(TextFormField), '690000000');
    await tester.tap(find.text('Recevoir le code'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    verify(() => repository.requestOtp('+237690000000')).called(1);
  });

  testWidgets('rejects a number that is not 9 digits', (tester) async {
    await pumpLogin(tester);
    await tester.enterText(find.byType(TextFormField), '123');
    await tester.tap(find.text('Recevoir le code'));
    await tester.pump();

    verifyNever(() => repository.requestOtp(any()));
    expect(find.text('Numéro invalide'), findsOneWidget);
  });

  testWidgets('toggles between sign-in and sign-up copy', (tester) async {
    await pumpLogin(tester);
    expect(find.text('Se connecter'), findsOneWidget);

    final switchLink = find.textContaining('Inscrivez-vous');
    await tester.ensureVisible(switchLink);
    await tester.tap(switchLink);
    await tester.pump();

    expect(find.text('Créer un compte'), findsOneWidget);
  });
}
