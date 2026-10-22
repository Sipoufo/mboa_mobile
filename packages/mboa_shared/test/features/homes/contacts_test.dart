import 'package:api_client/api_client.dart' as api;
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/mocks/mocks.dart';

class MockMonLogementApi extends Mock implements api.MonLogementApi {}

class MockHiveCache extends Mock implements HiveCache {}

class _FakeRequest extends Fake implements api.UsefulContactRequest {}

Response<T> _ok<T>(T data) => Response<T>(data: data, requestOptions: RequestOptions(path: '/x'));

DioException _refused(String code, {int status = 409}) => DioException(
      requestOptions: RequestOptions(path: '/x'),
      response: Response(requestOptions: RequestOptions(path: '/x'), statusCode: status, data: {'error': code}),
    );

/// CDC M30 lot 3 — useful contacts (RM-M30-13).
void main() {
  late MockMonLogementApi monLogement;
  late MockHiveCache cache;
  late ContactsRepository repository;

  setUpAll(() => registerFallbackValue(_FakeRequest()));

  setUp(() {
    final dioClient = MockDioClient();
    final apiClient = MockApiClient();
    monLogement = MockMonLogementApi();
    cache = MockHiveCache();
    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getMonLogementApi).thenReturn(monLogement);
    when(() => cache.put(any(), any(), any())).thenAnswer((_) async {});
    when(() => cache.get(any(), any(), ttl: any(named: 'ttl'))).thenReturn(null);
    repository = ContactsRepository(dioClient: dioClient, cache: cache);
    when(() => monLogement.createUsefulContact(usefulContactRequest: any(named: 'usefulContactRequest')))
        .thenAnswer((_) async => _ok(api.UsefulContactResponse((b) => b..id = 'k-1')));
  });

  api.UsefulContactRequest sent() => verify(
        () => monLogement.createUsefulContact(usefulContactRequest: captureAny(named: 'usefulContactRequest')),
      ).captured.single as api.UsefulContactRequest;

  test('a shared contact goes with the properties chosen, trimmed', () async {
    await repository.create(
      const ContactDraft(name: ' Paul ', role: ' Gardien ', phone: '+237690000000', shared: true, annonceIds: {'a-1'}),
    );

    final body = sent();
    expect(body.name, 'Paul');
    expect(body.role, 'Gardien');
    expect(body.shared, isTrue);
    expect(body.annonceIds, {'a-1'});
  });

  test('a private one names no property, whatever was ticked', () async {
    await repository.create(
      const ContactDraft(name: 'Paul', role: 'Gardien', phone: '+237690000000', annonceIds: {'a-1'}),
    );

    expect(sent().annonceIds, isEmpty);
  });

  test('the sixteenth, and a wrong number, are told as such', () async {
    when(() => monLogement.createUsefulContact(usefulContactRequest: any(named: 'usefulContactRequest')))
        .thenThrow(_refused('CONTACT_LIMIT_REACHED'));
    await expectLater(
      repository.create(const ContactDraft(name: 'a', role: 'b', phone: '+237690000000')),
      throwsA(isA<ContactRefused>().having((e) => e.reason, 'reason', ContactRefusal.limitReached)),
    );

    when(() => monLogement.createUsefulContact(usefulContactRequest: any(named: 'usefulContactRequest')))
        .thenThrow(_refused('VALIDATION_ERROR', status: 400));
    await expectLater(
      repository.create(const ContactDraft(name: 'a', role: 'b', phone: '+2376')),
      throwsA(isA<ContactRefused>().having((e) => e.reason, 'reason', ContactRefusal.invalid)),
    );
  });

  test('the tenant\'s list, kept per home for offline', () async {
    when(() => monLogement.listHomeContacts(contractId: 'c-1')).thenAnswer(
      (_) async => _ok(
        BuiltList<api.UsefulContactResponse>([
          api.UsefulContactResponse((b) => b
            ..id = 'k-1'
            ..name = 'Paul'
            ..role = 'Gardien'
            ..phone = '+237690000000'),
        ]),
      ),
    );

    final read = await repository.ofHome('c-1');

    expect(read.value.single.role, 'Gardien');
    verify(() => cache.put(StorageKeys.homesBox, 'contacts:c-1', any())).called(1);
    final contact = read.value.single;
    expect(UsefulContact.fromCache(contact.toCache()), contact);
  });
}
