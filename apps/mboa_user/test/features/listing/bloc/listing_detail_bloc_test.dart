import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_user/features/listing/bloc/listing_detail_bloc.dart';
import 'package:mboa_user/features/listing/data/listing_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockListingRepository extends Mock implements ListingRepository {}

/// The public fiche (CDC M05).
void main() {
  late MockListingRepository repository;

  const detail = ListingDetail(
    id: 'a-1',
    title: 'Studio meublé',
    city: 'Douala',
    canContact: true,
    canPlanVisit: true,
  );

  const review = ReviewEntry(id: 'r-1', kind: ReviewKind.resident, rating: 4);

  DioException notFound() => DioException(
        requestOptions: RequestOptions(path: '/search/annonces/a-1'),
        response: Response(
          requestOptions: RequestOptions(path: '/search/annonces/a-1'),
          statusCode: 404,
        ),
      );

  setUp(() {
    repository = MockListingRepository();
    when(() => repository.cached(any())).thenReturn(null);
    when(() => repository.reviews(any())).thenAnswer((_) async => []);
  });

  ListingDetailBloc build() => ListingDetailBloc(repository: repository);

  blocTest<ListingDetailBloc, ListingDetailState>(
    'RM-M05-08 — the reviews land after the fiche, not with it',
    setUp: () {
      when(() => repository.one('a-1')).thenAnswer((_) async => detail);
      when(() => repository.reviews('a-1')).thenAnswer((_) async => [review]);
    },
    build: build,
    act: (bloc) => bloc.add(const ListingRequested('a-1')),
    expect: () => [
      isA<ListingDetailLoadInProgress>(),
      // The fiche paints first; the feed adds to it.
      isA<ListingDetailReady>().having((s) => s.reviews, 'reviews', isEmpty),
      isA<ListingDetailReady>().having((s) => s.reviews, 'reviews', hasLength(1)),
    ],
  );

  blocTest<ListingDetailBloc, ListingDetailState>(
    'an unreachable review feed does not take the fiche down with it',
    setUp: () {
      when(() => repository.one('a-1')).thenAnswer((_) async => detail);
      when(() => repository.reviews('a-1')).thenThrow(Exception('500'));
    },
    build: build,
    act: (bloc) => bloc.add(const ListingRequested('a-1')),
    verify: (bloc) {
      // A property whose reviews are unreachable is still a property worth
      // showing.
      final state = bloc.state as ListingDetailReady;
      expect(state.detail.id, 'a-1');
      expect(state.reviews, isEmpty);
    },
  );

  blocTest<ListingDetailBloc, ListingDetailState>(
    'CE-M05-01 — a 404 is "no longer available", not an error to retry',
    setUp: () => when(() => repository.one('a-1')).thenThrow(notFound()),
    build: build,
    act: (bloc) => bloc.add(const ListingRequested('a-1')),
    verify: (bloc) {
      expect(bloc.state, isA<ListingGone>());
      // Nothing to fall back on: the listing is gone, not unreachable.
      verifyNever(() => repository.cached(any()));
    },
  );

  blocTest<ListingDetailBloc, ListingDetailState>(
    'offline falls back to the 24h copy, with the actions off',
    setUp: () {
      when(() => repository.one('a-1')).thenThrow(Exception('offline'));
      when(() => repository.cached('a-1')).thenReturn(
        const ListingDetail(id: 'a-1', title: 'Studio meublé'),
      );
    },
    build: build,
    act: (bloc) => bloc.add(const ListingRequested('a-1')),
    verify: (bloc) {
      final state = bloc.state as ListingDetailReady;
      expect(state.isOffline, isTrue);
      // `canContact` and `canPlanVisit` are server verdicts; a stale "yes"
      // would open a screen that fails.
      expect(state.detail.canContact, isFalse);
      expect(state.detail.canPlanVisit, isFalse);
    },
  );

  blocTest<ListingDetailBloc, ListingDetailState>(
    'unreachable with nothing cached is a retry screen',
    setUp: () => when(() => repository.one('a-1'))
        .thenThrow(Exception('offline')),
    build: build,
    act: (bloc) => bloc.add(const ListingRequested('a-1')),
    verify: (bloc) => expect(bloc.state, isA<ListingDetailFailure>()),
  );
}
