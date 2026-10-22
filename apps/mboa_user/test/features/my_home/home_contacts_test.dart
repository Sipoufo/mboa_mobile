import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/features/my_home/bloc/home_contacts_bloc.dart';
import 'package:mboa_user/features/my_home/ui/home_contacts_page.dart';
import 'package:mocktail/mocktail.dart';

class MockContactsRepository extends Mock implements ContactsRepository {}

class MockHomeContactsBloc extends MockBloc<HomeContactsEvent, HomeContactsState> implements HomeContactsBloc {}

/// CDC M30 lot 3 — the contacts the landlord shares (CA-M30-05).
void main() {
  const paul = UsefulContact(id: 'k-1', name: 'Paul', role: 'Gardien', phone: '+237690000000');

  blocTest<HomeContactsBloc, HomeContactsState>(
    'the home\'s; offline, marked',
    setUp: () {},
    build: () {
      final repository = MockContactsRepository();
      when(() => repository.ofHome('c-1')).thenAnswer((_) async => const Cached([paul], fromCache: true));
      return HomeContactsBloc(repository: repository, contractId: 'c-1');
    },
    act: (bloc) => bloc.add(const HomeContactsRequested()),
    expect: () => const [HomeContactsLoading(), HomeContactsReady(items: [paul], isOffline: true)],
  );

  testWidgets('a name, a role, a number — and « Appeler »; empty, said', (tester) async {
    final bloc = MockHomeContactsBloc();
    when(() => bloc.state).thenReturn(const HomeContactsReady(items: [paul]));
    Future<void> pump() => tester.pumpWidget(
          MaterialApp(
            locale: const Locale('fr'),
            theme: MboaTheme.light(),
            localizationsDelegates: MboaLocalizations.delegates,
            supportedLocales: MboaLocalizations.supportedLocales,
            home: BlocProvider<HomeContactsBloc>.value(value: bloc, child: const HomeContactsView()),
          ),
        );
    await pump();
    await tester.pumpAndSettle();

    expect(find.text('Gardien'), findsOneWidget);
    expect(find.text('+237690000000'), findsOneWidget);
    expect(find.byTooltip('Appeler'), findsOneWidget);

    final empty = MockHomeContactsBloc();
    when(() => empty.state).thenReturn(const HomeContactsReady());
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: BlocProvider<HomeContactsBloc>.value(value: empty, child: const HomeContactsView()),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('aucun contact'), findsOneWidget);
  });
}
