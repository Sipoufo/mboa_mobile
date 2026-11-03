import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/builders/login_builders.dart';
import '../../../_helpers/mocks/mocks.dart';
import '../../score/load_brand_fonts.dart';

class MockLoginFlowController extends Mock implements LoginFlowController {}

/// §40 A — App Mboa is not for Cameroon alone: the founder chose an email or
/// a phone, the phone's code by WhatsApp. The screen asked for a Cameroonian
/// number only.
void main() {
  late MockLoginRepository repository;
  late MockLoginFlowController flow;

  setUpAll(() async {
    await loadBrandFonts();
    registerFallbackValue(buildOtpSession());
  });

  setUp(() {
    repository = MockLoginRepository();
    flow = MockLoginFlowController();
    GetIt.I
      ..registerFactory<LoginBloc>(() => LoginBloc(repository: repository))
      ..registerSingleton<LoginFlowController>(flow);
  });

  tearDown(() => GetIt.I.reset());

  Future<void> pump(WidgetTester tester, Widget child) async {
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
        home: child,
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> toEmail(WidgetTester tester) async {
    await tester.tap(find.text('E-mail'));
    await tester.pumpAndSettle();
  }

  Future<void> send(WidgetTester tester) async {
    await tester.tap(find.text('Recevoir le code'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
  }

  testWidgets('« E-mail »: the code is asked for that address', (tester) async {
    when(() => repository.requestOtp(phoneNumber: any(named: 'phoneNumber'), email: any(named: 'email')))
        .thenAnswer((_) async => buildOtpSession(email: 'awa@example.cm', channel: OtpChannel.email));
    await pump(tester, const LoginView());
    await toEmail(tester);
    await expectLater(find.byType(LoginView), matchesGoldenFile('goldens/login_email.png'));

    await tester.enterText(find.byType(TextFormField), ' awa@example.cm ');
    await send(tester);

    verify(() => repository.requestOtp(email: 'awa@example.cm')).called(1);
    await tester.pump(const Duration(seconds: 5));
  });

  testWidgets('not an address: nothing is sent', (tester) async {
    await pump(tester, const LoginView());
    await toEmail(tester);

    await tester.enterText(find.byType(TextFormField), 'awa@example');
    await send(tester);

    expect(find.text('Adresse e-mail invalide'), findsOneWidget);
    verifyNever(() => repository.requestOtp(phoneNumber: any(named: 'phoneNumber'), email: any(named: 'email')));
  });

  testWidgets('a number without WhatsApp: said, and the screen turns to the email', (tester) async {
    when(() => repository.requestOtp(phoneNumber: any(named: 'phoneNumber'), email: any(named: 'email'))).thenAnswer(
      (_) async => throw DioException(
        requestOptions: RequestOptions(),
        response: Response(requestOptions: RequestOptions(), statusCode: 409, data: {'error': 'WHATSAPP_UNAVAILABLE'}),
      ),
    );
    await pump(tester, const LoginView());

    await tester.enterText(find.byType(TextFormField), '690000000');
    await send(tester);
    await tester.pump();

    expect(find.text("Ce numéro n'a pas WhatsApp. Connecte-toi avec ton e-mail."), findsOneWidget);
    // The email field, ready.
    expect(find.text('toi@exemple.com'), findsOneWidget);
    await tester.pump(const Duration(seconds: 5));
  });

  for (final (channel, line) in [
    (OtpChannel.whatsapp, 'Code envoyé sur WhatsApp au +237690000000'),
    (OtpChannel.sms, 'Code envoyé par SMS au +237690000000'),
  ]) {
    testWidgets('the code went by ${channel.name}: the screen says where to look', (tester) async {
      await pump(tester, OtpView(session: buildOtpSession(channel: channel)));

      expect(find.text(line), findsOneWidget);
    });
  }

  testWidgets('the code went by email: the address is named', (tester) async {
    await pump(tester, OtpView(session: buildOtpSession(email: 'awa@example.cm', channel: OtpChannel.email)));

    expect(find.text('Code envoyé par e-mail à awa@example.cm'), findsOneWidget);
  });
}
