import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/profile/profile_types.dart';
import 'package:mboa_pro/features/shell/ui/pro_menu_page.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/load_brand_fonts.dart';

class MockProProfileBloc extends MockBloc<ProfileEvent, ProfileState> implements ProProfileBloc {}

/// The slide menu promises no screen that does not exist.
void main() {
  setUpAll(loadBrandFonts);

  testWidgets('Recherche, Explorer, Signets and Autres are gone — nothing in Doc 10 behind them', (tester) async {
    tester.view.physicalSize = const Size(390 * 3, 1400 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final profile = MockProProfileBloc();
    when(() => profile.state).thenReturn(const ProfileInitial());

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: BlocProvider<ProProfileBloc>.value(value: profile, child: const ProMenuPage()),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Contrats Mboa'), findsOneWidget);
    for (final gone in ['Recherche', 'Explorer', 'Signets', 'Autres']) {
      expect(find.text(gone), findsNothing, reason: gone);
    }
  });
}
