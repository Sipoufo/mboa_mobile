import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/password_reset/bloc/password_reset_bloc.dart';
import 'package:mboa_pro/features/password_reset/data/password_reset_repository.dart';
import 'package:mboa_pro/features/password_reset/ui/forgot_password_page.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/mocks/mocks.dart';

class MockPasswordResetRepository extends Mock implements PasswordResetRepository {}

class MockPasswordResetBloc extends MockBloc<PasswordResetEvent, PasswordResetState> implements PasswordResetBloc {}

DioException _refused(String code) => DioException(
  requestOptions: RequestOptions(path: '/auth/password/reset'),
  response: Response(
    requestOptions: RequestOptions(path: '/auth/password/reset'),
    statusCode: 400,
    data: {'error': code},
  ),
);

/// M02 — a forgotten password on App Mboa Pro: the email, then the SMS code.
void main() {
  setUpAll(() {
    registerFallbackValue(const PasswordResetCodeResent());
    registerFallbackValue(ForgotPasswordRequest((b) => b..email = 'x'));
    registerFallbackValue(
      ResetPasswordRequest(
        (b) => b
          ..email = 'x'
          ..code = '000000'
          ..newPassword = 'xxxxxxxx',
      ),
    );
  });

  group('PasswordResetRepository', () {
    late MockAuthApi api;
    late PasswordResetRepository repository;

    setUp(() {
      final dioClient = MockDioClient();
      final apiClient = MockApiClient();
      api = MockAuthApi();
      when(() => dioClient.api).thenReturn(apiClient);
      when(apiClient.getAuthenticationApi).thenReturn(api);
      repository = PasswordResetRepository(dioClient: dioClient);
    });

    test('asks for a code with the trimmed email', () async {
      when(() => api.forgotPassword(forgotPasswordRequest: any(named: 'forgotPasswordRequest'))).thenAnswer(
        (_) async => Response<void>(requestOptions: RequestOptions(path: '/forgot'), statusCode: 204),
      );

      await repository.requestCode(' pro@mboa.cm ');

      final sent =
          verify(
                () => api.forgotPassword(forgotPasswordRequest: captureAny(named: 'forgotPasswordRequest')),
              ).captured.single
              as ForgotPasswordRequest;
      expect(sent.email, 'pro@mboa.cm');
    });

    for (final (code, reason) in [
      ('OTP_INVALID', PasswordResetRefusal.wrongCode),
      ('OTP_INVALID_OR_EXPIRED', PasswordResetRefusal.expired),
      ('OTP_MAX_ATTEMPTS', PasswordResetRefusal.tooManyAttempts),
    ]) {
      test('$code is told apart', () {
        when(
          () => api.resetPassword(resetPasswordRequest: any(named: 'resetPasswordRequest')),
        ).thenThrow(_refused(code));

        expect(
          () => repository.reset(email: 'pro@mboa.cm', code: '123456', newPassword: 'nouveau-mdp'),
          throwsA(isA<PasswordResetRefused>().having((e) => e.reason, 'reason', reason)),
        );
      });
    }
  });

  group('PasswordResetBloc', () {
    late MockPasswordResetRepository repository;

    setUp(() => repository = MockPasswordResetRepository());

    PasswordResetBloc build() => PasswordResetBloc(repository: repository);

    blocTest<PasswordResetBloc, PasswordResetState>(
      'the email moves to the code step — whether or not it has an account',
      setUp: () => when(() => repository.requestCode(any())).thenAnswer((_) async {}),
      build: build,
      act: (bloc) => bloc.add(const PasswordResetRequested(' pro@mboa.cm ')),
      expect: () => [
        const PasswordResetEnterEmail(loading: true),
        const PasswordResetEnterCode(email: 'pro@mboa.cm'),
      ],
    );

    blocTest<PasswordResetBloc, PasswordResetState>(
      'a good code and password end the flow',
      setUp: () => when(
        () => repository.reset(email: 'pro@mboa.cm', code: '123456', newPassword: 'nouveau-mdp'),
      ).thenAnswer((_) async {}),
      build: build,
      seed: () => const PasswordResetEnterCode(email: 'pro@mboa.cm'),
      act: (bloc) => bloc.add(const PasswordResetSubmitted(code: '123456', newPassword: 'nouveau-mdp')),
      expect: () => [
        const PasswordResetEnterCode(email: 'pro@mboa.cm', loading: true),
        const PasswordResetDone(email: 'pro@mboa.cm'),
      ],
    );

    for (final (reason, error) in [
      (PasswordResetRefusal.wrongCode, PasswordResetError.wrongCode),
      (PasswordResetRefusal.expired, PasswordResetError.expired),
      (PasswordResetRefusal.tooManyAttempts, PasswordResetError.tooManyAttempts),
    ]) {
      blocTest<PasswordResetBloc, PasswordResetState>(
        'a refused code stays on the step and says why ($reason)',
        setUp: () => when(
          () => repository.reset(
            email: any(named: 'email'),
            code: any(named: 'code'),
            newPassword: any(named: 'newPassword'),
          ),
        ).thenThrow(PasswordResetRefused(reason)),
        build: build,
        seed: () => const PasswordResetEnterCode(email: 'pro@mboa.cm'),
        act: (bloc) => bloc.add(const PasswordResetSubmitted(code: '000000', newPassword: 'nouveau-mdp')),
        skip: 1,
        expect: () => [PasswordResetEnterCode(email: 'pro@mboa.cm', error: error)],
      );
    }

    blocTest<PasswordResetBloc, PasswordResetState>(
      'a new code can be asked for',
      setUp: () => when(() => repository.requestCode('pro@mboa.cm')).thenAnswer((_) async {}),
      build: build,
      seed: () => const PasswordResetEnterCode(email: 'pro@mboa.cm'),
      act: (bloc) => bloc.add(const PasswordResetCodeResent()),
      expect: () => [
        const PasswordResetEnterCode(email: 'pro@mboa.cm', loading: true),
        const PasswordResetEnterCode(email: 'pro@mboa.cm', justResent: true),
      ],
    );
  });

  group('the screen', () {
    late MockPasswordResetBloc bloc;

    setUp(() => bloc = MockPasswordResetBloc());

    Future<void> pump(WidgetTester tester, PasswordResetState state, {String? email}) async {
      when(() => bloc.state).thenReturn(state);
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: BlocProvider<PasswordResetBloc>.value(
            value: bloc,
            child: ForgotPasswordFlow(email: email),
          ),
        ),
      );
      await tester.pump();
    }

    testWidgets('the email typed on the login is already there, and the SMS is announced', (tester) async {
      await pump(tester, const PasswordResetEnterEmail(), email: 'pro@mboa.cm');

      expect(find.text('pro@mboa.cm'), findsOneWidget);
      expect(find.textContaining('par SMS'), findsOneWidget);

      await tester.tap(find.text('Envoyer le code'));
      verify(() => bloc.add(const PasswordResetRequested('pro@mboa.cm'))).called(1);
    });

    testWidgets('a short or mismatched password is not sent', (tester) async {
      await pump(tester, const PasswordResetEnterCode(email: 'pro@mboa.cm'));

      await tester.enterText(find.byType(EditableText).first, '123456');
      final passwords = find.byType(PasswordField);
      await tester.enterText(find.descendant(of: passwords.at(0), matching: find.byType(EditableText)), 'court');
      await tester.enterText(find.descendant(of: passwords.at(1), matching: find.byType(EditableText)), 'autre');
      await tester.ensureVisible(find.text('Changer le mot de passe'));
      await tester.tap(find.text('Changer le mot de passe'));
      await tester.pump();

      expect(find.text('8 caractères minimum.'), findsOneWidget);
      verifyNever(() => bloc.add(any(that: isA<PasswordResetSubmitted>())));
    });
  });
}
