import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/mocks/mocks.dart';

class MockPhoneChangeApi extends Mock implements PhoneChangeApi {}

/// §40 B — `POST /account/phone/change` requires the current number: without
/// it every phone change was refused once the backend shipped.
void main() {
  late MockPhoneChangeApi api;
  late AccountRepository repository;

  setUpAll(() => registerFallbackValue(RequestPhoneChangeRequest((b) => b..newPhoneNumber = '+237690000000')));

  setUp(() {
    api = MockPhoneChangeApi();
    final dioClient = MockDioClient();
    final client = MockApiClient();
    when(() => dioClient.api).thenReturn(client);
    when(client.getPhoneChangeApi).thenReturn(api);
    when(() => api.requestPhoneChange(requestPhoneChangeRequest: any(named: 'requestPhoneChangeRequest')))
        .thenAnswer((_) async => Response<void>(requestOptions: RequestOptions(), statusCode: 202));
    repository = AccountRepository(dioClient: dioClient);
  });

  test('a phone change sends the current number with the new one', () async {
    await repository.requestPhoneChange(currentPhoneNumber: '+237690000014', newPhoneNumber: '+237690000000');

    final sent = verify(
      () => api.requestPhoneChange(requestPhoneChangeRequest: captureAny(named: 'requestPhoneChangeRequest')),
    ).captured.single as RequestPhoneChangeRequest;
    expect(sent.currentPhoneNumber, '+237690000014');
    expect(sent.newPhoneNumber, '+237690000000');
  });
}
