import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/features/my_home/bloc/evidence_send_bloc.dart';
import 'package:mboa_user/features/my_home/ui/evidence_pages.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/load_brand_fonts.dart';

class MockEvidenceRepository extends Mock implements EvidenceRepository {}

class MockPhotoPreparer extends Mock implements PhotoPreparer {}

class MockEvidenceSendBloc extends MockBloc<EvidenceSendEvent, EvidenceSendState> implements EvidenceSendBloc {}

/// A real, tiny PNG — the screen draws the photo from its bytes.
final _png = Uint8List.fromList(const [
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52, //
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
  0x89, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x60, 0x68, 0x60, 0x60,
  0x00, 0x00, 0x00, 0x84, 0x00, 0x81, 0x9D, 0x77, 0x6B, 0x2F, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45,
  0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
]);

/// CDC M30 lot 3 — the tenant sends photo proofs (RM-M30-11).
void main() {
  final a = PhotoPreparer.prepare(_png);
  final b = PhotoPreparer.prepare(Uint8List.fromList([..._png, 0]));

  group('the bloc', () {
    late MockEvidenceRepository repository;
    late MockPhotoPreparer preparer;

    setUpAll(() {
      registerFallbackValue(ImageSource.camera);
      registerFallbackValue(EvidencePhase.entry);
    });

    setUp(() {
      repository = MockEvidenceRepository();
      preparer = MockPhotoPreparer();
    });

    EvidenceSendBloc build() => EvidenceSendBloc(repository: repository, preparer: preparer);

    blocTest<EvidenceSendBloc, EvidenceSendState>(
      'photos picked are added once each — the same photo twice would be refused',
      setUp: () => when(() => preparer.pick(ImageSource.gallery, limit: 19)).thenAnswer((_) async => [a, b]),
      build: build,
      seed: () => EvidenceSendState(contractId: 'c-1', shots: [EvidenceShot(photo: a)]),
      act: (bloc) => bloc.add(const EvidencePhotosPicked(ImageSource.gallery)),
      verify: (bloc) => expect(bloc.state.shots.map((s) => s.photo), [a, b]),
    );

    blocTest<EvidenceSendBloc, EvidenceSendState>(
      'twenty at most: no more asked for',
      build: build,
      seed: () => EvidenceSendState(contractId: 'c-1', shots: List.filled(20, EvidenceShot(photo: a))),
      act: (bloc) => bloc.add(const EvidencePhotosPicked(ImageSource.camera)),
      expect: () => const <EvidenceSendState>[],
    );

    blocTest<EvidenceSendBloc, EvidenceSendState>(
      'a photo\'s room and word are its own',
      build: build,
      seed: () => EvidenceSendState(contractId: 'c-1', shots: [EvidenceShot(photo: a), EvidenceShot(photo: b)]),
      act: (bloc) => bloc
        ..add(const EvidenceShotChanged(1, room: EvidenceRoom.kitchen))
        ..add(const EvidenceShotChanged(1, comment: 'Évier fêlé')),
      verify: (bloc) {
        expect(bloc.state.shots[0].room, EvidenceRoom.livingRoom);
        expect(bloc.state.shots[1].room, EvidenceRoom.kitchen);
        expect(bloc.state.shots[1].comment, 'Évier fêlé');
      },
    );

    blocTest<EvidenceSendBloc, EvidenceSendState>(
      'sent in its phase, the progress said as it goes',
      setUp: () => when(
        () => repository.send('c-1', EvidencePhase.exit, any(), onUploaded: any(named: 'onUploaded')),
      ).thenAnswer((invocation) async {
        final onUploaded = invocation.namedArguments[#onUploaded] as void Function(int, int);
        onUploaded(1, 2);
        onUploaded(2, 2);
        return const EvidenceBatch(id: 'eb-1');
      }),
      build: build,
      seed: () => EvidenceSendState(
        contractId: 'c-1',
        phase: EvidencePhase.exit,
        shots: [EvidenceShot(photo: a), EvidenceShot(photo: b)],
      ),
      act: (bloc) => bloc.add(const EvidenceSendSubmitted()),
      verify: (bloc) {
        expect(bloc.state.sent?.id, 'eb-1');
        expect(bloc.state.uploaded, 2);
      },
    );

    blocTest<EvidenceSendBloc, EvidenceSendState>(
      'CE-M30-01 — a photo that would not go: said, the photos kept',
      setUp: () => when(() => repository.send('c-1', any(), any(), onUploaded: any(named: 'onUploaded')))
          .thenThrow(const EvidenceUploadFailed()),
      build: build,
      seed: () => EvidenceSendState(contractId: 'c-1', shots: [EvidenceShot(photo: a)]),
      act: (bloc) => bloc.add(const EvidenceSendSubmitted()),
      verify: (bloc) {
        expect(bloc.state.uploadFailed, isTrue);
        expect(bloc.state.shots, hasLength(1));
      },
    );
  });

  group('the screen', () {
    setUpAll(() async {
      await loadBrandFonts();
      registerFallbackValue(const EvidenceSendSubmitted());
    });

    testWidgets('the photos to send, each with its room', (tester) async {
      tester.view.physicalSize = const Size(390 * 3, 844 * 3);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final bloc = MockEvidenceSendBloc();
      when(() => bloc.state).thenReturn(
        EvidenceSendState(
          contractId: 'c-1',
          shots: [
            EvidenceShot(photo: a),
            EvidenceShot(photo: b, room: EvidenceRoom.bathroom, comment: 'Fissure au plafond'),
          ],
        ),
      );
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: BlocProvider<EvidenceSendBloc>.value(value: bloc, child: const EvidenceSendView()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Envoyer 2 photos'), findsOneWidget);
      await tester.tap(find.text('Envoyer 2 photos'));
      verify(() => bloc.add(const EvidenceSendSubmitted())).called(1);
      await tester.pumpAndSettle();
      await expectLater(find.byType(EvidenceSendView), matchesGoldenFile('goldens/evidence_send.png'));
    });
  });
}
