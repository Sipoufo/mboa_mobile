import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/login/bloc/credential_login_bloc.dart';
import 'package:mboa_pro/features/login/ui/login_view.dart';
import 'package:mboa_ui/mboa_ui.dart';

class MockCredentialLoginBloc extends MockBloc<CredentialLoginEvent, CredentialLoginState>
    implements CredentialLoginBloc {}

/// Consolidation C — three wrong codes burn it: the field is emptied and
/// closed, and a new code may be asked at once.
void main() {
  late MockCredentialLoginBloc bloc;
  late StreamController<CredentialLoginState> states;

  setUp(() {
    bloc = MockCredentialLoginBloc();
    states = StreamController<CredentialLoginState>();
    whenListen(bloc, states.stream, initialState: const CredentialLoginEnterOtp(email: 'pro@mboa.cm'));
    getIt.registerFactory<CredentialLoginBloc>(() => bloc);
  });

  tearDown(() async {
    await states.close();
    await getIt.reset();
  });

  testWidgets('a dead code', (tester) async {
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
        home: LoginView(onForgotPassword: (_) {}),
      ),
    );
    await tester.pump();
    await tester.enterText(find.byType(TextField), '12345');
    expect(find.textContaining('Renvoyer dans'), findsOneWidget);

    states.add(const CredentialLoginEnterOtp(email: 'pro@mboa.cm', error: CredentialLoginError.codeBurnt));
    await tester.pump();
    await tester.pump();

    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.controller!.text, isEmpty);
    expect(field.enabled, isFalse);
    expect(find.text('Renvoyer le code'), findsOneWidget);
    expect(find.textContaining('trop d’essais'), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 5));
  });
}
