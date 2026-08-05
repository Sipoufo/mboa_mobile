import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/annonces/models/annonce_status.dart';
import 'package:mboa_pro/features/annonces/ui/widgets/status_actions_menu.dart';
import 'package:mboa_pro/features/profile/models/profile_data.dart';
import 'package:mboa_pro/features/profile/models/prestataire_type.dart';
import 'package:mboa_pro/features/profile/profile_types.dart';
import 'package:mboa_pro/features/subscription/bloc/subscription_bloc.dart';
import 'package:mboa_pro/features/subscription/models/subscription_models.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockProProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements ProProfileBloc {}

class MockSubscriptionBloc
    extends MockBloc<SubscriptionEvent, SubscriptionState>
    implements SubscriptionBloc {}

void main() {
  late MockProProfileBloc profile;
  late MockSubscriptionBloc subscription;

  const completeProfile = ProfileData(
    role: AccountRole.prestataire,
    photoObjectKey: 'photo',
    type: PrestataireType.agence,
    mainCityId: 'c-1',
  );

  setUp(() {
    profile = MockProProfileBloc();
    subscription = MockSubscriptionBloc();
    when(() => profile.state).thenReturn(const ProProfileReady(completeProfile));
    when(() => subscription.state).thenReturn(
      const SubscriptionReady(
        SubscriptionPlan(tier: SubscriptionTier.gratuit, activeListingLimit: 1),
      ),
    );
  });

  Future<List<AnnonceTransition>> open(
    WidgetTester tester, {
    required AnnonceStatus status,
    int photoCount = 3,
    int activeCount = 0,
  }) async {
    final selected = <AnnonceTransition>[];

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<ProProfileBloc>.value(value: profile),
            BlocProvider<SubscriptionBloc>.value(value: subscription),
          ],
          child: Scaffold(
            body: StatusActionsMenu(
              status: status,
              photoCount: photoCount,
              activeCount: activeCount,
              onSelected: selected.add,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    if (find.byIcon(LucideIcons.ellipsisVertical).evaluate().isNotEmpty) {
      await tester.tap(find.byIcon(LucideIcons.ellipsisVertical));
      await tester.pumpAndSettle();
    }
    return selected;
  }

  group('which transitions are offered', () {
    test('a draft can be published or archived', () {
      expect(
        StatusActionsMenu.transitionsFor(AnnonceStatus.draft),
        [AnnonceTransition.publish, AnnonceTransition.archive],
      );
    });

    test('a published listing cannot be published again', () {
      expect(
        StatusActionsMenu.transitionsFor(AnnonceStatus.published),
        isNot(contains(AnnonceTransition.publish)),
      );
    });

    test('a rented listing can only be archived', () {
      expect(
        StatusActionsMenu.transitionsFor(AnnonceStatus.rented),
        [AnnonceTransition.archive],
      );
    });

    test('an archived listing can be republished', () {
      // Un-archiving is republishing; Doc 10 draws no arrow back from Archivée,
      // so the backend may still refuse — the action is offered, not hidden.
      expect(
        StatusActionsMenu.transitionsFor(AnnonceStatus.archived),
        [AnnonceTransition.publish],
      );
    });

    test('an unknown status offers nothing', () {
      expect(StatusActionsMenu.transitionsFor(AnnonceStatus.unknown), isEmpty);
    });
  });

  testWidgets('renders nothing when there is no action and no delete', (tester) async {
    await open(tester, status: AnnonceStatus.unknown);

    expect(find.byIcon(LucideIcons.ellipsisVertical), findsNothing);
  });

  testWidgets('an archived listing offers Republier', (tester) async {
    final selected = await open(tester, status: AnnonceStatus.archived);

    await tester.tap(find.text('Republier'));
    await tester.pumpAndSettle();

    expect(selected, [AnnonceTransition.publish]);
  });

  testWidgets('publishing a valid draft is allowed through', (tester) async {
    final selected = await open(tester, status: AnnonceStatus.draft);

    await tester.tap(find.text('Publier'));
    await tester.pumpAndSettle();

    expect(selected, [AnnonceTransition.publish]);
  });

  testWidgets('CE-M10-03 blocks publishing under three photos', (tester) async {
    final selected =
        await open(tester, status: AnnonceStatus.draft, photoCount: 2);

    await tester.tap(find.text('Publier'));
    await tester.pumpAndSettle();

    expect(selected, isEmpty);
    expect(find.textContaining('Ajoute au moins'), findsOneWidget);
  });

  testWidgets('CE-M10-02 blocks publishing past the tier limit', (tester) async {
    final selected =
        await open(tester, status: AnnonceStatus.draft, activeCount: 1);

    await tester.tap(find.text('Publier'));
    await tester.pumpAndSettle();

    expect(selected, isEmpty);
    // Points at the next tier up, per the CDC copy.
    expect(find.textContaining('Basic+'), findsOneWidget);
  });

  testWidgets('archiving is never gated by the publish rules', (tester) async {
    final selected =
        await open(tester, status: AnnonceStatus.draft, photoCount: 0);

    await tester.tap(find.text('Archiver'));
    await tester.pumpAndSettle();

    expect(selected, [AnnonceTransition.archive]);
  });
}
