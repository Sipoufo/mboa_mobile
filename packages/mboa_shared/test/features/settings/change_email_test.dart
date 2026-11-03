import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/mocks/mocks.dart';
import '../score/load_brand_fonts.dart';

class MockEmailChangeApi extends Mock implements EmailChangeApi {}

class MockPhoneChangeApi extends Mock implements PhoneChangeApi {}

class MockChangeEmailBloc extends MockBloc<ChangeEmailEvent, ChangeEmailState> implements ChangeEmailBloc {}

class MockChangePhoneBloc extends MockBloc<ChangePhoneEvent, ChangePhoneState> implements ChangePhoneBloc {}

/// §40 A — App Mboa: an account adds or changes its email (a code to the
/// address, one to the phone when it has one), and an account made by email
/// adds its first number (one code). Neither existed.
void main() {
  setUpAll(() async {
    await loadBrandFonts();
    registerFallbackValue(RequestEmailChangeRequest((b) => b..newEmail = 'x'));
    registerFallbackValue(ConfirmEmailChangeRequest((b) => b
      ..newEmail = 'x'
      ..newCode = '1'));
    registerFallbackValue(RequestPhoneChangeRequest((b) => b..newPhoneNumber = 'x'));
    registerFallbackValue(ConfirmPhoneChangeRequest((b) => b
      ..newPhoneNumber = 'x'
      ..newCode = '1'));
  });

  group('the repository', () {
    late MockEmailChangeApi email;
    late MockPhoneChangeApi phone;
    late AccountRepository repository;

    setUp(() {
      email = MockEmailChangeApi();
      phone = MockPhoneChangeApi();
      final dioClient = MockDioClient();
      final client = MockApiClient();
      when(() => dioClient.api).thenReturn(client);
      when(client.getEmailChangeApi).thenReturn(email);
      when(client.getPhoneChangeApi).thenReturn(phone);
      repository = AccountRepository(dioClient: dioClient);
    });

    test('an email change: the address, then its code and the phone\'s', () async {
      when(() => email.requestEmailChange(requestEmailChangeRequest: any(named: 'requestEmailChangeRequest')))
          .thenAnswer((_) async => Response<void>(requestOptions: RequestOptions(), statusCode: 202));
      when(() => email.confirmEmailChange(confirmEmailChangeRequest: any(named: 'confirmEmailChangeRequest')))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(),
                data: EmailChangeResponse((b) => b..email = 'awa@example.cm'),
              ));

      await repository.requestEmailChange('awa@example.cm');
      final now = await repository.confirmEmailChange(newEmail: 'awa@example.cm', oldCode: '111111', newCode: '222222');

      final asked = verify(() => email.requestEmailChange(requestEmailChangeRequest: captureAny(named: 'requestEmailChangeRequest')))
          .captured
          .single as RequestEmailChangeRequest;
      final confirmed = verify(() => email.confirmEmailChange(confirmEmailChangeRequest: captureAny(named: 'confirmEmailChangeRequest')))
          .captured
          .single as ConfirmEmailChangeRequest;
      expect(asked.newEmail, 'awa@example.cm');
      expect((confirmed.oldCode, confirmed.newCode), ('111111', '222222'));
      expect(now, 'awa@example.cm');
    });

    test('a first number: no current one, one code', () async {
      when(() => phone.requestPhoneChange(requestPhoneChangeRequest: any(named: 'requestPhoneChangeRequest')))
          .thenAnswer((_) async => Response<void>(requestOptions: RequestOptions(), statusCode: 202));

      await repository.requestPhoneChange(newPhoneNumber: '+237690000000');

      final sent = verify(() => phone.requestPhoneChange(requestPhoneChangeRequest: captureAny(named: 'requestPhoneChangeRequest')))
          .captured
          .single as RequestPhoneChangeRequest;
      expect((sent.currentPhoneNumber, sent.newPhoneNumber), (null, '+237690000000'));
    });
  });

  group('the bloc', () {
    late MockAccountRepository repository;

    setUp(() => repository = MockAccountRepository());

    DioException refused(String code, int status) => DioException(
          requestOptions: RequestOptions(),
          response: Response(requestOptions: RequestOptions(), statusCode: status, data: {'error': code}),
        );

    blocTest<ChangeEmailBloc, ChangeEmailState>(
      'with a phone: two codes, both sent',
      setUp: () {
        when(() => repository.requestEmailChange(any())).thenAnswer((_) async {});
        when(() => repository.confirmEmailChange(
              newEmail: any(named: 'newEmail'),
              oldCode: any(named: 'oldCode'),
              newCode: any(named: 'newCode'),
            )).thenAnswer((_) async => 'awa@example.cm');
      },
      build: () => ChangeEmailBloc(repository: repository),
      act: (bloc) => bloc
        ..add(const ChangeEmailRequested(newEmail: 'awa@example.cm', hasPhone: true))
        ..add(const ChangeEmailConfirmed(emailCode: '222222', phoneCode: '111111')),
      expect: () => const [
        ChangeEmailEnterAddress(loading: true),
        ChangeEmailEnterCodes(newEmail: 'awa@example.cm', withPhoneCode: true),
        ChangeEmailEnterCodes(newEmail: 'awa@example.cm', withPhoneCode: true, loading: true),
        ChangeEmailSuccess(),
      ],
      verify: (_) => verify(() => repository.confirmEmailChange(
            newEmail: 'awa@example.cm',
            oldCode: '111111',
            newCode: '222222',
          )).called(1),
    );

    for (final (code, status, error) in [
      ('EMAIL_UNCHANGED', 400, ChangeEmailError.unchanged),
      ('EMAIL_ALREADY_USED', 409, ChangeEmailError.alreadyUsed),
    ]) {
      blocTest<ChangeEmailBloc, ChangeEmailState>(
        '$code: said under the address',
        setUp: () => when(() => repository.requestEmailChange(any())).thenAnswer((_) async => throw refused(code, status)),
        build: () => ChangeEmailBloc(repository: repository),
        act: (bloc) => bloc.add(const ChangeEmailRequested(newEmail: 'awa@example.cm', hasPhone: false)),
        expect: () => [const ChangeEmailEnterAddress(loading: true), ChangeEmailEnterAddress(error: error)],
      );
    }
  });

  group('the screens', () {
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

    testWidgets('adding an email to a phone account: the address, then two codes', (tester) async {
      final bloc = MockChangeEmailBloc();
      when(() => bloc.state).thenReturn(const ChangeEmailEnterAddress());
      GetIt.I.registerFactory<ChangeEmailBloc>(() => bloc);
      await pump(tester, const ChangeEmailView(phoneNumber: '+237690000000'));

      expect(find.text('Ajouter un e-mail'), findsOneWidget);
      expect(find.textContaining('et un à ton téléphone'), findsOneWidget);
      await expectLater(find.byType(ChangeEmailView), matchesGoldenFile('goldens/change_email.png'));

      await tester.enterText(find.byType(TextFormField), 'awa@example.cm');
      await tester.pump();
      await tester.tap(find.widgetWithText(Button, 'Recevoir les codes'));
      await tester.pump();

      verify(() => bloc.add(const ChangeEmailRequested(newEmail: 'awa@example.cm', hasPhone: true))).called(1);
    });

    testWidgets('the codes: the address\'s and the phone\'s, each named', (tester) async {
      final bloc = MockChangeEmailBloc();
      when(() => bloc.state)
          .thenReturn(const ChangeEmailEnterCodes(newEmail: 'awa@example.cm', withPhoneCode: true));
      GetIt.I.registerFactory<ChangeEmailBloc>(() => bloc);
      await pump(tester, const ChangeEmailView(currentEmail: 'old@example.cm', phoneNumber: '+237690000000'));

      expect(find.text('Code reçu sur awa@example.cm'), findsOneWidget);
      expect(find.text('Code reçu sur +237690000000'), findsOneWidget);
    });

    testWidgets('an account made by email adds its first number: one field, then one code', (tester) async {
      final bloc = MockChangePhoneBloc();
      when(() => bloc.state).thenReturn(const ChangePhoneEnterPhone());
      GetIt.I.registerFactory<ChangePhoneBloc>(() => bloc);
      await pump(tester, const ChangePhoneView(adding: true));

      expect(find.text('Ajouter un numéro'), findsOneWidget);
      expect(find.text('Ton numéro actuel'), findsNothing);
      expect(find.byType(TextFormField), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), '690000000');
      await tester.pump();
      await tester.tap(find.widgetWithText(Button, 'Recevoir le code'));
      await tester.pump();

      verify(() => bloc.add(const ChangePhoneRequested(newPhoneNumber: '+237690000000'))).called(1);
    });

    testWidgets('its code: one card', (tester) async {
      final bloc = MockChangePhoneBloc();
      when(() => bloc.state).thenReturn(const ChangePhoneEnterCodes(newPhoneNumber: '+237690000000'));
      GetIt.I.registerFactory<ChangePhoneBloc>(() => bloc);
      await pump(tester, const ChangePhoneView(adding: true));

      expect(find.byType(OtpField), findsOneWidget);
      expect(find.text('Ajouter ce numéro'), findsOneWidget);
    });
  });
}
