import 'package:api_client/api_client.dart' as api;
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../_helpers/mocks/mocks.dart';

class MockMonLogementApi extends Mock implements api.MonLogementApi {}

class MockHiveCache extends Mock implements HiveCache {}

Response<T> _ok<T>(T data) => Response<T>(data: data, requestOptions: RequestOptions(path: '/x'));

/// §32 — residences: which one a home, a declaration and a request are in,
/// and the unit the landlord assigned on accepting (RM-M29-16).
void main() {
  group('a reservation', () {
    test('an assigned unit keeps the one asked for, and says so — offline too', () {
      final r = Reservation.fromResponse(
        api.ReservationResponse(
          (b) => b
            ..id = 'r-1'
            ..status = api.ReservationResponseStatusEnum.ACCEPTED
            ..annonceId = 'u-4'
            ..annonceTitle = 'Chambre 4'
            ..requestedAnnonceId = 'u-2'
            ..requestedAnnonceTitle = 'Chambre 2'
            ..residenceName = 'Résidence Deido',
        ),
      );

      expect(r.wasReassigned, isTrue);
      expect(r.requestedAnnonceTitle, 'Chambre 2');
      final copy = Reservation.fromCache(r.toCache());
      expect(copy?.wasReassigned, isTrue);
      expect(copy?.requestedAnnonceTitle, 'Chambre 2');
    });

    test('the unit asked for, accepted as is: not a reassignment', () {
      final r = Reservation.fromResponse(
        api.ReservationResponse(
          (b) => b
            ..id = 'r-1'
            ..annonceId = 'u-2'
            ..requestedAnnonceId = 'u-2'
            ..canAssignUnit = true,
        ),
      );

      expect(r.wasReassigned, isFalse);
      expect(r.canAssignUnit, isTrue);
      expect(const Reservation(id: 'r', status: ReservationStatus.pending).wasReassigned, isFalse);
    });
  });

  group('a home and a declaration', () {
    test('name their residence — « Chambre 3 · Résidence Deido » — and keep it offline', () {
      final home = Home.fromResponse(
        api.HomeSummary(
          (b) => b
            ..contractId = 'c-1'
            ..annonceTitle = 'Chambre 3'
            ..residenceId = 'res-1'
            ..residenceName = 'Résidence Deido',
        ),
      );
      final declaration = Declaration.fromResponse(
        api.DeclarationResponse(
          (b) => b
            ..id = 'd-1'
            ..annonceTitle = 'Chambre 3'
            ..residenceId = 'res-1'
            ..residenceName = 'Résidence Deido',
        ),
      );

      expect(home.residenceId, 'res-1');
      expect(home.placeTitle, 'Chambre 3 · Résidence Deido');
      expect(Home.fromCache(home.toCache())?.residenceName, 'Résidence Deido');
      expect(declaration.placeTitle, 'Chambre 3 · Résidence Deido');
      expect(Declaration.fromCache(declaration.toCache())?.residenceId, 'res-1');
      // A standalone listing: its title alone.
      expect(const Home(contractId: 'c-2', annonceTitle: 'Studio Akwa').placeTitle, 'Studio Akwa');
    });

    test('a unit\'s type arrives as a plain name', () {
      expect(PropertyType.fromWire('ROOM'), PropertyType.room);
      expect(PropertyType.fromWire('STUDIO'), PropertyType.studio);
      expect(PropertyType.fromWire(null), PropertyType.apartment);
    });
  });

  group('the landlord\'s lists, narrowed by the server', () {
    late MockMonLogementApi monLogement;
    late MockHiveCache cache;
    late HomesRepository repository;

    setUpAll(() => registerFallbackValue(api.Pageable()));

    setUp(() {
      final dioClient = MockDioClient();
      final apiClient = MockApiClient();
      monLogement = MockMonLogementApi();
      cache = MockHiveCache();
      when(() => dioClient.api).thenReturn(apiClient);
      when(apiClient.getMonLogementApi).thenReturn(monLogement);
      when(() => cache.put(any(), any(), any())).thenAnswer((_) async {});
      repository = HomesRepository(dioClient: dioClient, cache: cache);
    });

    test('a residence\'s spaces — kept apart from the others for offline', () async {
      when(
        () => monLogement.listMyTenantHomes(pageable: any(named: 'pageable'), residenceId: 'res-1'),
      ).thenAnswer(
        (_) async => _ok(
          api.PageResponseHomeSummary((b) => b..content = ListBuilder([api.HomeSummary((h) => h..contractId = 'c-1')])),
        ),
      );

      final read = await repository.tenantHomes(residenceId: 'res-1');

      expect(read.value.single.contractId, 'c-1');
      verify(() => cache.put(StorageKeys.homesBox, 'tenants:all:residence:res-1', any())).called(1);
    });

    group('every running tenancy — the invoice form\'s list (RM-M24-02)', () {
      api.PageResponseHomeSummary page(List<String> ids, {required bool last}) => api.PageResponseHomeSummary(
            (b) => b
              ..content = ListBuilder([for (final id in ids) api.HomeSummary((h) => h..contractId = id)])
              ..last = last,
          );

      test('reads page after page until the last, the running ones only', () async {
        final asked = <int>[];
        when(
          () => monLogement.listMyTenantHomes(pageable: any(named: 'pageable'), state: any(named: 'state')),
        ).thenAnswer((invocation) async {
          final pageable = invocation.namedArguments[#pageable] as api.Pageable;
          asked.add(pageable.page!);
          expect(invocation.namedArguments[#state], BuiltList<String>(const ['ACTIVE']));
          return _ok(switch (pageable.page) {
            0 => page(['c-1', 'c-2'], last: false),
            1 => page(['c-3'], last: false),
            _ => page(['c-4'], last: true),
          });
        });

        final read = await repository.activeTenantHomes();

        expect([for (final h in read.value) h.contractId], ['c-1', 'c-2', 'c-3', 'c-4']);
        expect(asked, [0, 1, 2]);
        verify(() => cache.put(StorageKeys.homesBox, 'tenants:active', any())).called(1);
      });

      test('offline: the copy kept from the last read', () async {
        when(
          () => monLogement.listMyTenantHomes(pageable: any(named: 'pageable'), state: any(named: 'state')),
        ).thenThrow(DioException(requestOptions: RequestOptions(path: '/x')));
        when(() => cache.get(StorageKeys.homesBox, 'tenants:active')).thenReturn({
          'items': [const Home(contractId: 'c-9', state: HomeStage.active).toCache()],
        });

        final read = await repository.activeTenantHomes();

        expect(read.fromCache, isTrue);
        expect(read.value.single.contractId, 'c-9');
      });
    });

    test('a residence\'s declarations waiting — kept apart too', () async {
      when(
        () => monLogement.listMyReceivedDeclarations(
          pageable: any(named: 'pageable'),
          status: any(named: 'status'),
          residenceId: 'res-1',
        ),
      ).thenAnswer(
        (_) async => _ok(
          api.PageResponseDeclarationResponse(
            (b) => b..content = ListBuilder([api.DeclarationResponse((d) => d..id = 'd-1')]),
          ),
        ),
      );

      final read = await repository.waitingDeclarations(residenceId: 'res-1');

      expect(read.value.single.id, 'd-1');
      verify(() => cache.put(StorageKeys.homesBox, 'received:waiting:residence:res-1', any())).called(1);
    });
  });
}
