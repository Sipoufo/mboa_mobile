import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/features/my_home/bloc/home_request_form_bloc.dart';
import 'package:mboa_user/features/my_home/ui/home_requests_pages.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/load_brand_fonts.dart';

class MockHomeRequestsRepository extends Mock implements HomeRequestsRepository {}

class MockMediaUploader extends Mock implements MediaUploader {}

class MockHomeRequestFormBloc extends MockBloc<HomeRequestFormEvent, HomeRequestFormState>
    implements HomeRequestFormBloc {}

class _FakeDraft extends Fake implements HomeRequestDraft {}

/// CDC M30 lot 3 — the tenant asks the landlord (RM-M30-09).
void main() {
  const ready = HomeRequestFormState(contractId: 'c-1', title: 'Fuite sous l\'évier', description: 'Ça goutte.');

  group('the form', () {
    test('ready once there is a title and what is going on, within the limits', () {
      expect(const HomeRequestFormState(contractId: 'c-1').isComplete, isFalse);
      expect(ready.isComplete, isTrue);
      expect(ready.copyWith(title: '   ').isComplete, isFalse);
      expect(ready.copyWith(title: 'x' * 121).isComplete, isFalse);
      expect(ready.copyWith(description: 'x' * 2001).isComplete, isFalse);
      expect(ready.copyWith(photoKeys: List.filled(5, 'p')).hasPhotoRoom, isFalse);
    });
  });

  group('the bloc', () {
    late MockHomeRequestsRepository repository;
    late MockMediaUploader uploader;

    setUpAll(() {
      registerFallbackValue(_FakeDraft());
      registerFallbackValue(ImageSource.camera);
      registerFallbackValue(CreateUploadRequestCategoryEnum.MESSAGE_ATTACHMENT);
    });

    setUp(() {
      repository = MockHomeRequestsRepository();
      uploader = MockMediaUploader();
    });

    HomeRequestFormBloc build() => HomeRequestFormBloc(repository: repository, uploader: uploader);

    blocTest<HomeRequestFormBloc, HomeRequestFormState>(
      'sends what the form says',
      setUp: () => when(() => repository.create('c-1', any()))
          .thenAnswer((_) async => const HomeRequest(id: 'hr-1', title: 'Fuite')),
      build: build,
      seed: () => ready.copyWith(photoKeys: const ['p/1.jpg']),
      act: (bloc) => bloc.add(const HomeRequestFormSubmitted()),
      verify: (bloc) {
        expect(bloc.state.sent?.id, 'hr-1');
        final draft = verify(() => repository.create('c-1', captureAny())).captured.single as HomeRequestDraft;
        expect(draft.type, HomeRequestType.maintenance);
        expect(draft.title, 'Fuite sous l\'évier');
        expect(draft.photoKeys, ['p/1.jpg']);
      },
    );

    blocTest<HomeRequestFormBloc, HomeRequestFormState>(
      'an incomplete form is not sent',
      build: build,
      seed: () => const HomeRequestFormState(contractId: 'c-1', title: 'Fuite'),
      act: (bloc) => bloc.add(const HomeRequestFormSubmitted()),
      expect: () => const <HomeRequestFormState>[],
    );

    blocTest<HomeRequestFormBloc, HomeRequestFormState>(
      'a photo is compressed and uploaded as a message attachment, its key kept',
      setUp: () => when(() => uploader.captureAndUpload(source: any(named: 'source'), category: any(named: 'category')))
          .thenAnswer((_) async => 'p/2.jpg'),
      build: build,
      seed: () => ready,
      act: (bloc) => bloc.add(const HomeRequestPhotoAdded(ImageSource.gallery)),
      verify: (bloc) {
        expect(bloc.state.photoKeys, ['p/2.jpg']);
        verify(
          () => uploader.captureAndUpload(
            source: ImageSource.gallery,
            category: CreateUploadRequestCategoryEnum.MESSAGE_ATTACHMENT,
          ),
        ).called(1);
      },
    );

    blocTest<HomeRequestFormBloc, HomeRequestFormState>(
      'a sixth photo is not asked for',
      build: build,
      seed: () => ready.copyWith(photoKeys: List.filled(5, 'p')),
      act: (bloc) => bloc.add(const HomeRequestPhotoAdded(ImageSource.camera)),
      expect: () => const <HomeRequestFormState>[],
    );

    blocTest<HomeRequestFormBloc, HomeRequestFormState>(
      'the tenancy over: said, the form kept',
      setUp: () => when(() => repository.create('c-1', any())).thenThrow(const HomeRequestRefused(HomeRequestRefusal.readOnly)),
      build: build,
      seed: () => ready,
      act: (bloc) => bloc.add(const HomeRequestFormSubmitted()),
      verify: (bloc) {
        expect(bloc.state.refusal, HomeRequestRefusal.readOnly);
        expect(bloc.state.title, ready.title);
      },
    );
  });

  group('the screen', () {
    late MockHomeRequestFormBloc bloc;

    setUpAll(() async {
      await loadBrandFonts();
      registerFallbackValue(const HomeRequestFormSubmitted());
    });

    setUp(() => bloc = MockHomeRequestFormBloc());

    Future<void> pump(WidgetTester tester, HomeRequestFormState state) async {
      tester.view.physicalSize = const Size(390 * 3, 844 * 3);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      when(() => bloc.state).thenReturn(state);
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: BlocProvider<HomeRequestFormBloc>.value(value: bloc, child: const HomeRequestFormView()),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('nothing to send before a title and what is going on', (tester) async {
      await pump(tester, const HomeRequestFormState(contractId: 'c-1'));

      expect(tester.widget<Button>(find.widgetWithText(Button, 'Envoyer la demande')).onPressed, isNull);
    });

    testWidgets('the words go to the bloc; ready, it sends', (tester) async {
      await pump(tester, ready);

      await tester.enterText(find.byType(TextField).first, 'Fuite');
      verify(() => bloc.add(const HomeRequestFormChanged(title: 'Fuite'))).called(1);
      await tester.tap(find.text('Question'));
      verify(() => bloc.add(const HomeRequestFormChanged(type: HomeRequestType.question))).called(1);
      await tester.tap(find.text('Envoyer la demande'));
      verify(() => bloc.add(const HomeRequestFormSubmitted())).called(1);
    });

    testWidgets('the form', (tester) async {
      await pump(tester, ready.copyWith(photoKeys: const ['p/1.jpg']));

      await expectLater(find.byType(HomeRequestFormView), matchesGoldenFile('goldens/home_request_form.png'));
    });
  });
}
