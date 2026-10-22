import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/contacts/bloc/contact_form_bloc.dart';
import 'package:mboa_pro/features/contacts/bloc/my_contacts_bloc.dart';
import 'package:mboa_pro/features/contacts/ui/contacts_pages.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/load_brand_fonts.dart';

class MockContactsRepository extends Mock implements ContactsRepository {}

class MockMyContactsBloc extends MockBloc<MyContactsEvent, MyContactsState> implements MyContactsBloc {}

class _FakeDraft extends Fake implements ContactDraft {}

/// CDC M30 lot 3 — the landlord's useful contacts (RM-M30-13).
void main() {
  const paul = UsefulContact(id: 'k-1', name: 'Paul', role: 'Gardien', phone: '+237690000000', shared: true);
  const awa = UsefulContact(
    id: 'k-2',
    name: 'Awa',
    role: 'Ménagère',
    phone: '+237677000000',
    shared: true,
    annonceIds: {'a-1', 'a-2'},
  );
  const jean = UsefulContact(id: 'k-3', name: 'Jean', role: 'Plombier', phone: '+237655000000');

  group('the blocs', () {
    late MockContactsRepository repository;

    setUpAll(() => registerFallbackValue(_FakeDraft()));

    setUp(() => repository = MockContactsRepository());

    blocTest<MyContactsBloc, MyContactsState>(
      'deleted: gone from the list',
      setUp: () => when(() => repository.delete('k-1')).thenAnswer((_) async {}),
      build: () => MyContactsBloc(repository: repository),
      seed: () => const MyContactsReady(items: [paul, jean]),
      act: (bloc) => bloc.add(const MyContactDeleted('k-1')),
      expect: () => const [MyContactsReady(items: [jean])],
    );

    blocTest<MyContactsBloc, MyContactsState>(
      'offline: nothing deleted from the copy',
      build: () => MyContactsBloc(repository: repository),
      seed: () => const MyContactsReady(items: [paul], isOffline: true),
      act: (bloc) => bloc.add(const MyContactDeleted('k-1')),
      expect: () => const <MyContactsState>[],
    );

    test('ready with a name, a role and nine digits', () {
      const form = ContactFormState(name: 'Paul', role: 'Gardien', nationalNumber: '690000000');
      expect(form.isComplete, isTrue);
      expect(form.copyWith(nationalNumber: '69000').isComplete, isFalse);
      expect(form.copyWith(role: 'x' * 61).isComplete, isFalse);
      expect(form.copyWith(name: ' ').isComplete, isFalse);
    });

    blocTest<ContactFormBloc, ContactFormState>(
      'a contact changed starts from its national digits, and is saved in E.164 as an update',
      setUp: () => when(() => repository.update('k-1', any())).thenAnswer((_) async => paul),
      build: () => ContactFormBloc(repository: repository),
      act: (bloc) => bloc
        ..add(const ContactFormStarted(paul))
        ..add(const ContactFormChanged(nationalNumber: '691 111 111'))
        ..add(const ContactFormSaved()),
      verify: (bloc) {
        final draft = verify(() => repository.update('k-1', captureAny())).captured.single as ContactDraft;
        expect(draft.phone, '+237691111111');
        expect(bloc.state.saved, paul);
        verifyNever(() => repository.create(any()));
      },
    );

    blocTest<ContactFormBloc, ContactFormState>(
      'prefilled: the dial code is the field\'s, not the text\'s',
      build: () => ContactFormBloc(repository: repository),
      act: (bloc) => bloc.add(const ContactFormStarted(paul)),
      verify: (bloc) => expect(bloc.state.nationalNumber, '690000000'),
    );
  });

  group('the screens', () {
    setUpAll(() async {
      await loadBrandFonts();
      registerFallbackValue(const MyContactsRequested());
    });

    Future<void> pump(WidgetTester tester, MyContactsState state) async {
      tester.view.physicalSize = const Size(390 * 3, 844 * 3);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final bloc = MockMyContactsBloc();
      when(() => bloc.state).thenReturn(state);
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: BlocProvider<MyContactsBloc>.value(value: bloc, child: const ContactsView()),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('each says whether, and where, tenants see it', (tester) async {
      await pump(tester, const MyContactsReady(items: [paul, awa, jean]));

      expect(find.text('Tous mes biens'), findsOneWidget);
      expect(find.text('Partagé sur 2 biens'), findsOneWidget);
      expect(find.text('Privé'), findsOneWidget);
      expect(find.text('Ajouter un contact'), findsOneWidget);
    });

    testWidgets('fifteen: no more to add, and said', (tester) async {
      await pump(tester, MyContactsReady(items: List.generate(15, (i) => UsefulContact(id: '$i', name: 'C$i', role: 'r', phone: 'p'))));

      expect(find.text('Ajouter un contact'), findsNothing);
      await tester.scrollUntilVisible(find.text('15 contacts au plus.'), 300, scrollable: find.byType(Scrollable).first);
      expect(find.text('15 contacts au plus.'), findsOneWidget);
    });

    testWidgets('the contacts', (tester) async {
      await pump(tester, const MyContactsReady(items: [paul, awa, jean]));

      await expectLater(find.byType(ContactsView), matchesGoldenFile('goldens/contacts.png'));
    });
  });
}
