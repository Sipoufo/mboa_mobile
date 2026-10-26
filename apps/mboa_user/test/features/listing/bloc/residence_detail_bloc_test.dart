import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_user/features/listing/bloc/residence_detail_bloc.dart';
import 'package:mboa_user/features/listing/data/listing_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockListingRepository extends Mock implements ListingRepository {}

/// A residence's public fiche (M10bis, §36).
void main() {
  late MockListingRepository repository;

  const residence = ResidenceDetail(id: 'r-1', name: 'Cité blanche', city: 'Douala');
  const review = ReviewEntry(id: 'v-1', kind: ReviewKind.visit, annonceId: 'u-4', rating: 5);

  DioException failure({int? status}) => DioException(
        requestOptions: RequestOptions(path: '/search/residences/r-1'),
        response: status == null
            ? null
            : Response(requestOptions: RequestOptions(path: '/search/residences/r-1'), statusCode: status),
      );

  setUp(() {
    repository = MockListingRepository();
    when(() => repository.cachedResidence(any())).thenReturn(null);
    when(() => repository.residenceReviews(any())).thenAnswer((_) async => []);
  });

  ResidenceDetailBloc build() => ResidenceDetailBloc(repository: repository);

  blocTest<ResidenceDetailBloc, ResidenceDetailState>(
    '§36 — the reviews land after the fiche, not with it',
    setUp: () {
      when(() => repository.residence('r-1')).thenAnswer((_) async => residence);
      when(() => repository.residenceReviews('r-1')).thenAnswer((_) async => [review]);
    },
    build: build,
    act: (bloc) => bloc.add(const ResidenceRequested('r-1')),
    expect: () => [
      isA<ResidenceDetailLoadInProgress>(),
      const ResidenceDetailReady(detail: residence),
      const ResidenceDetailReady(detail: residence, reviews: [review]),
    ],
  );

  blocTest<ResidenceDetailBloc, ResidenceDetailState>(
    'an unreachable review feed does not take the fiche down with it',
    setUp: () {
      when(() => repository.residence('r-1')).thenAnswer((_) async => residence);
      when(() => repository.residenceReviews('r-1')).thenThrow(failure());
    },
    build: build,
    act: (bloc) => bloc.add(const ResidenceRequested('r-1')),
    expect: () => [isA<ResidenceDetailLoadInProgress>(), const ResidenceDetailReady(detail: residence)],
  );

  blocTest<ResidenceDetailBloc, ResidenceDetailState>(
    'withdrawn is said, not retried — even with a copy in the cache',
    setUp: () {
      when(() => repository.residence('r-1')).thenThrow(failure(status: 404));
      when(() => repository.cachedResidence('r-1')).thenReturn(residence);
    },
    build: build,
    act: (bloc) => bloc.add(const ResidenceRequested('r-1')),
    expect: () => [isA<ResidenceDetailLoadInProgress>(), isA<ResidenceGone>()],
  );

  blocTest<ResidenceDetailBloc, ResidenceDetailState>(
    'offline — the copy read in the last 24h, marked as such',
    setUp: () {
      when(() => repository.residence('r-1')).thenThrow(failure());
      when(() => repository.cachedResidence('r-1')).thenReturn(residence);
    },
    build: build,
    act: (bloc) => bloc.add(const ResidenceRequested('r-1')),
    expect: () => [
      isA<ResidenceDetailLoadInProgress>(),
      const ResidenceDetailReady(detail: residence, isOffline: true),
    ],
    verify: (_) => verifyNever(() => repository.residenceReviews(any())),
  );

  blocTest<ResidenceDetailBloc, ResidenceDetailState>(
    'offline and never read — a failure to retry, not a blank screen',
    setUp: () => when(() => repository.residence('r-1')).thenThrow(StateError('no data')),
    build: build,
    act: (bloc) => bloc.add(const ResidenceRequested('r-1')),
    expect: () => [isA<ResidenceDetailLoadInProgress>(), isA<ResidenceDetailFailure>()],
  );
}
