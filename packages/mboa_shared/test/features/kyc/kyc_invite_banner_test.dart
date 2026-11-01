import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../score/load_brand_fonts.dart';

class MockKycCubit extends MockCubit<KycState> implements KycCubit {}

/// RM-M01bis-01 — « La soumission KYC est accessible depuis le profil via un
/// bandeau d'invitation visible tant que le KYC n'est pas validé. » No screen
/// had one: a tile, the same whether the KYC was to do, under review, refused
/// or approved.
void main() {
  late MockKycCubit kyc;

  KycReady ready(KycStatus status, {String? reason}) {
    final data = KycStatusData(status: status, rejectionReason: reason);
    return KycReady(data, KycDraft.of(data));
  }

  setUpAll(loadBrandFonts);
  setUp(() => kyc = MockKycCubit());

  Future<void> pump(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: Scaffold(
          body: BlocProvider<KycCubit>.value(value: kyc, child: child),
        ),
      ),
    );
    await tester.pump();
  }

  group('to do', () {
    for (final (role, body) in [
      (AccountRole.prestataire, 'Nécessaire pour gérer tes biens et tes agents.'),
      (AccountRole.agent, 'Nécessaire pour accepter des missions et mener des visites.'),
      // RM-M01bis-13 — optional for a tenant, and said so.
      (AccountRole.user, 'Facultatif — +20 points à ton Mboa Score.'),
    ]) {
      testWidgets('${role.name}: what the verification opens, and « Commencer »', (tester) async {
        when(() => kyc.state).thenReturn(ready(KycStatus.notSubmitted));
        var opened = 0;
        await pump(tester, KycInviteBanner(role: role, onOpen: () => opened++));

        expect(find.text('Vérifie ton identité'), findsOneWidget);
        expect(find.text(body), findsOneWidget);
        await tester.tap(find.text('Commencer'));
        expect(opened, 1);
      });
    }
  });

  testWidgets('under review: says so, and opens the status', (tester) async {
    when(() => kyc.state).thenReturn(ready(KycStatus.pending));
    var opened = 0;
    await pump(tester, KycInviteBanner(role: AccountRole.prestataire, onOpen: () => opened++));

    expect(find.text('Vérification en cours'), findsOneWidget);
    expect(find.text('Commencer'), findsNothing);
    await tester.tap(find.text('Vérification en cours'));
    expect(opened, 1);
  });

  testWidgets('refused: why, and « Reprendre »', (tester) async {
    when(() => kyc.state).thenReturn(ready(KycStatus.rejected, reason: 'Photo floue'));
    var opened = 0;
    await pump(tester, KycInviteBanner(role: AccountRole.agent, onOpen: () => opened++));

    expect(find.text('Vérification refusée'), findsOneWidget);
    expect(find.text('Motif : Photo floue'), findsOneWidget);
    await tester.tap(find.text('Reprendre'));
    expect(opened, 1);
  });

  testWidgets('refused without a reason: says what to do', (tester) async {
    when(() => kyc.state).thenReturn(ready(KycStatus.rejected));
    await pump(tester, KycInviteBanner(role: AccountRole.agent, onOpen: () {}));

    expect(find.text("Regarde ce qui n'allait pas, puis reprends."), findsOneWidget);
  });

  group('nothing at all', () {
    for (final (name, state) in [
      ('approved — the tile stays for reading', ready(KycStatus.approved)),
      ('a status never read — no guess', const KycInitial()),
      ('still loading', const KycLoadInProgress()),
      ('unreadable, offline at start', const KycLoadFailure()),
    ]) {
      testWidgets(name, (tester) async {
        when(() => kyc.state).thenReturn(state);
        await pump(
          tester,
          KycInviteBanner(
            role: AccountRole.prestataire,
            onOpen: () {},
            padding: const EdgeInsets.all(40),
          ),
        );

        expect(find.byType(InkWell), findsNothing);
        // Its padding goes with it: no gap where it is absent.
        expect(find.byType(Padding), findsNothing);
      });
    }
  });

  testWidgets('approved after a submission: it goes', (tester) async {
    whenListen(
      kyc,
      Stream.fromIterable([ready(KycStatus.approved)]),
      initialState: ready(KycStatus.pending),
    );
    await pump(tester, KycInviteBanner(role: AccountRole.prestataire, onOpen: () {}));
    await tester.pump();

    expect(find.text('Vérification en cours'), findsNothing);
  });

  testWidgets('the three faces', (tester) async {
    tester.view.physicalSize = const Size(390 * 3, 480 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final todo = MockKycCubit();
    final pending = MockKycCubit();
    final refused = MockKycCubit();
    when(() => todo.state).thenReturn(ready(KycStatus.notSubmitted));
    when(() => pending.state).thenReturn(ready(KycStatus.pending));
    when(() => refused.state).thenReturn(
      ready(KycStatus.rejected, reason: 'La photo du recto est floue, le numéro ne se lit pas.'),
    );

    Widget face(KycCubit cubit, AccountRole role) => BlocProvider<KycCubit>.value(
          value: cubit,
          child: KycInviteBanner(
            role: role,
            onOpen: () {},
            padding: const EdgeInsets.only(bottom: Dimens.spacing),
          ),
        );

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: Scaffold(
          backgroundColor: MboaTheme.light().scaffoldBackgroundColor,
          body: Padding(
            padding: const EdgeInsets.all(Dimens.spacing),
            child: Column(
              children: [
                face(todo, AccountRole.prestataire),
                face(todo, AccountRole.user),
                face(pending, AccountRole.agent),
                face(refused, AccountRole.agent),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    await expectLater(find.byType(Scaffold), matchesGoldenFile('goldens/kyc_invite_banner.png'));
  });
}
