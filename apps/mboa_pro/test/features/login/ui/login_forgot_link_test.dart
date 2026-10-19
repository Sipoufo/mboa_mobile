import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/login/bloc/credential_login_bloc.dart';
import 'package:mboa_pro/features/login/ui/login_view.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockCredentialLoginBloc extends MockBloc<CredentialLoginEvent, CredentialLoginState>
    implements CredentialLoginBloc {}

/// M02 — "Mot de passe oublié ?" carries what was typed in the email field.
void main() {
  setUp(() {
    final bloc = MockCredentialLoginBloc();
    when(() => bloc.state).thenReturn(const CredentialLoginEnterCredentials());
    getIt.registerFactory<CredentialLoginBloc>(() => bloc);
  });

  tearDown(getIt.reset);

  testWidgets('the forgotten-password link hands over the typed email', (tester) async {
    String? handed;
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: LoginView(onForgotPassword: (email) => handed = email),
      ),
    );
    await tester.pump();

    await tester.enterText(find.byType(EditableText).first, ' pro@mboa.cm ');
    await tester.tap(find.text('Mot de passe oublié ?'));

    expect(handed, 'pro@mboa.cm');
  });
}
