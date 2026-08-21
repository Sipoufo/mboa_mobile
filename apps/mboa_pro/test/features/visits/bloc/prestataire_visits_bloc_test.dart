import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/features/annonces/data/location_capture.dart';
import 'package:mboa_pro/features/visits/bloc/prestataire_visits_bloc.dart';
import 'package:mboa_pro/features/visits/data/prestataire_visit_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockPrestataireVisitRepository extends Mock implements PrestataireVisitRepository {}

class MockLocationCapture extends Mock implements LocationCapture {}

/// What a prestataire does with the visits he carries out himself
/// (RM-M15-06 / RM-M07-05).
void main() {
  late MockPrestataireVisitRepository repository;
  late MockLocationCapture location;

  const fix = (latitude: 4.0500, longitude: 9.7000, cityName: 'Douala');

  setUp(() {
    repository = MockPrestataireVisitRepository();
    location = MockLocationCapture();
  });

  PrestataireVisitsBloc build() => PrestataireVisitsBloc(
    repository: repository,
    location: location,
  );

  blocTest<PrestataireVisitsBloc, PrestataireVisitsState>(
    'RM-M15-06 — confirming a proposed time reports done, and patches nothing',
    setUp: () => when(() => repository.confirm('v-1')).thenAnswer((_) async {}),
    build: build,
    act: (bloc) => bloc.add(const VisitRequestConfirmed('v-1')),
    // The screen reloads the week on `done`: the server owns what the answer
    // did to the visit, and a locally patched status would be a guess.
    expect: () => [
      const PrestataireVisitsBusy('v-1'),
      const PrestataireVisitsDone(),
    ],
  );

  blocTest<PrestataireVisitsBloc, PrestataireVisitsState>(
    'declining goes through the prestataire endpoint, not the client one',
    setUp: () => when(() => repository.decline('v-1')).thenAnswer((_) async {}),
    build: build,
    act: (bloc) => bloc.add(const VisitRequestDeclined('v-1')),
    verify: (_) {
      verify(() => repository.decline('v-1')).called(1);
      verifyNever(() => repository.confirm(any()));
    },
  );

  blocTest<PrestataireVisitsBloc, PrestataireVisitsState>(
    'RM-M07-05 — his presence goes with a position',
    setUp: () {
      when(location.current).thenAnswer((_) async => fix);
      when(
        () => repository.confirmPresence(
          'v-1',
          latitude: any(named: 'latitude'),
          longitude: any(named: 'longitude'),
        ),
      ).thenAnswer((_) async {});
    },
    build: build,
    act: (bloc) => bloc.add(const OwnerPresenceConfirmed('v-1')),
    verify: (_) => verify(
      () => repository.confirmPresence(
        'v-1',
        latitude: fix.latitude,
        longitude: fix.longitude,
      ),
    ).called(1),
  );

  blocTest<PrestataireVisitsBloc, PrestataireVisitsState>(
    'no position, no confirmation — and it says which permission is missing',
    setUp: () => when(location.current).thenThrow(
      const LocationCaptureException(LocationFailure.deniedForever),
    ),
    build: build,
    act: (bloc) => bloc.add(const OwnerPresenceConfirmed('v-1')),
    expect: () => [
      const PrestataireVisitsBusy('v-1'),
      const PrestataireVisitsLocationFailed(LocationFailure.deniedForever),
    ],
    verify: (_) => verifyNever(
      () => repository.confirmPresence(
        any(),
        latitude: any(named: 'latitude'),
        longitude: any(named: 'longitude'),
      ),
    ),
  );

  blocTest<PrestataireVisitsBloc, PrestataireVisitsState>(
    'a refused answer leaves the request standing',
    setUp: () => when(() => repository.confirm('v-1')).thenThrow(Exception('409')),
    build: build,
    act: (bloc) => bloc.add(const VisitRequestConfirmed('v-1')),
    expect: () => [
      const PrestataireVisitsBusy('v-1'),
      const PrestataireVisitsFailed(),
    ],
  );
}
