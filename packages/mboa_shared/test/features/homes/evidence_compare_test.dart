import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../score/load_brand_fonts.dart';

class MockEvidenceRepository extends Mock implements EvidenceRepository {}

class MockEvidenceBloc extends MockBloc<EvidenceEvent, EvidenceState> implements EvidenceBloc {}

class MockEvidenceCompareBloc extends MockBloc<EvidenceCompareEvent, EvidenceCompareState>
    implements EvidenceCompareBloc {}

/// CA-M31-04 — entry and exit photos side by side, each with its time.
void main() {
  EvidencePhoto photo(String id, EvidenceRoom room, EvidencePhase phase, DateTime at, {String? comment}) =>
      EvidencePhoto(
        id: id,
        room: room,
        phase: phase,
        recordedAt: at,
        comment: comment,
        // No link: the cache behind network images has no plugin in tests.
      );

  final rooms = [
    EvidenceRoomPair(
      room: EvidenceRoom.livingRoom,
      entry: [
        photo('p-1', EvidenceRoom.livingRoom, EvidencePhase.entry, DateTime(2025, 1, 2, 10, 42)),
        photo('p-2', EvidenceRoom.livingRoom, EvidencePhase.entry, DateTime(2025, 1, 2, 10, 43)),
      ],
      exit: [
        photo(
          'p-3',
          EvidenceRoom.livingRoom,
          EvidencePhase.exit,
          DateTime(2026, 9, 30, 16, 5),
          comment: 'Trace sur le mur',
        ),
      ],
    ),
    EvidenceRoomPair(
      room: EvidenceRoom.other,
      roomLabel: 'Balcon',
      entry: [photo('p-4', EvidenceRoom.other, EvidencePhase.entry, DateTime(2025, 1, 2, 10, 50))],
    ),
  ];

  group('EvidenceCompareBloc', () {
    late MockEvidenceRepository repository;

    setUp(() => repository = MockEvidenceRepository());

    blocTest<EvidenceCompareBloc, EvidenceCompareState>(
      'reads the rooms',
      setUp: () => when(() => repository.compare('c-1')).thenAnswer((_) async => rooms),
      build: () => EvidenceCompareBloc(repository: repository),
      act: (bloc) => bloc.add(const EvidenceCompareRequested('c-1')),
      expect: () => [const EvidenceCompareLoading(), EvidenceCompareReady(rooms)],
    );

    blocTest<EvidenceCompareBloc, EvidenceCompareState>(
      'offline, nothing kept: a failure, to try again',
      setUp: () => when(() => repository.compare('c-1')).thenThrow(Exception('offline')),
      build: () => EvidenceCompareBloc(repository: repository),
      act: (bloc) => bloc.add(const EvidenceCompareRequested('c-1')),
      expect: () => const [EvidenceCompareLoading(), EvidenceCompareFailure('c-1')],
    );
  });

  group('a before and an after', () {
    EvidenceBatch batch(String id, EvidencePhase phase) =>
        EvidenceBatch(id: id, photos: [EvidencePhoto(id: '$id-1', room: EvidenceRoom.kitchen, phase: phase)]);

    test('only once both entry and exit photos exist', () {
      expect(EvidenceReady(items: [batch('b-1', EvidencePhase.entry)]).canCompare, isFalse);
      expect(
        EvidenceReady(items: [batch('b-1', EvidencePhase.entry), batch('b-2', EvidencePhase.stay)]).canCompare,
        isFalse,
      );
      expect(
        EvidenceReady(items: [batch('b-1', EvidencePhase.entry), batch('b-2', EvidencePhase.exit)]).canCompare,
        isTrue,
      );
    });
  });

  group('the screens', () {
    setUpAll(loadBrandFonts);

    Future<void> pump(WidgetTester tester, Widget child, {double height = 844}) async {
      tester.view.physicalSize = Size(390 * 3, height * 3);
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

    testWidgets('the list offers « Avant / après » once both sides exist', (tester) async {
      final bloc = MockEvidenceBloc();
      var compared = 0;
      final both = EvidenceReady(
        items: [
          EvidenceBatch(id: 'b-1', photos: [rooms.first.entry.first]),
          EvidenceBatch(id: 'b-2', photos: [rooms.first.exit.first]),
        ],
      );
      when(() => bloc.state).thenReturn(both);
      await pump(
        tester,
        BlocProvider<EvidenceBloc>.value(
          value: bloc,
          child: EvidenceView(onOpen: (_) {}, onCompare: () => compared++),
        ),
      );
      await expectLater(find.byType(EvidenceView), matchesGoldenFile('goldens/evidence_list_compare.png'));
      await tester.tap(find.text('Avant / après'));
      expect(compared, 1);
    });

    testWidgets('…and not with one side only', (tester) async {
      final bloc = MockEvidenceBloc();
      when(() => bloc.state).thenReturn(
        EvidenceReady(items: [EvidenceBatch(id: 'b-1', photos: [rooms.first.entry.first])]),
      );
      await pump(
        tester,
        BlocProvider<EvidenceBloc>.value(value: bloc, child: EvidenceView(onOpen: (_) {}, onCompare: () {})),
      );
      expect(find.text('Avant / après'), findsNothing);
    });

    testWidgets('room by room: entry beside exit, each photo with its time', (tester) async {
      final bloc = MockEvidenceCompareBloc();
      when(() => bloc.state).thenReturn(EvidenceCompareReady(rooms));
      await pump(tester, BlocProvider<EvidenceCompareBloc>.value(value: bloc, child: const EvidenceCompareView()));

      expect(find.text('Salon'), findsOneWidget);
      expect(find.text('Balcon'), findsOneWidget);
      expect(find.text('Entrée'), findsNWidgets(2));
      expect(find.text('Sortie'), findsNWidgets(2));
      expect(find.text('2 janv. 2025 10:42'), findsOneWidget);
      expect(find.text('30 sept. 2026 16:05'), findsOneWidget);
      expect(find.text('Trace sur le mur'), findsOneWidget);
      // The balcony was never photographed on the way out — said once.
      expect(find.text('Pas de photo'), findsOneWidget);
      expect(find.byType(Button), findsNothing);

      await expectLater(find.byType(EvidenceCompareView), matchesGoldenFile('goldens/evidence_compare.png'));
    });

    testWidgets('offline: says it needs a connection, and tries again', (tester) async {
      final bloc = MockEvidenceCompareBloc();
      when(() => bloc.state).thenReturn(const EvidenceCompareFailure('c-1'));
      await pump(tester, BlocProvider<EvidenceCompareBloc>.value(value: bloc, child: const EvidenceCompareView()));

      expect(find.textContaining('demande une connexion'), findsOneWidget);
      await tester.tap(find.text('Réessayer'));
      verify(() => bloc.add(const EvidenceCompareRequested('c-1'))).called(1);
    });
  });
}
