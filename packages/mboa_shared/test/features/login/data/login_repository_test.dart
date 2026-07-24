import 'package:api_client/api_client.dart' as api show AuthTokens;
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/builders/login_builders.dart';
import '../../../_helpers/mocks/mocks.dart';

class _FakeSendOtpRequest extends Fake implements SendOtpRequest {}

class _FakeVerifyOtpRequest extends Fake implements VerifyOtpRequest {}

class _FakeAuthTokens extends Fake implements AuthTokens {}

Response<T> _response<T>(String path, {T? data}) =>
    Response<T>(requestOptions: RequestOptions(path: path), data: data);

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeSendOtpRequest());
    registerFallbackValue(_FakeVerifyOtpRequest());
    registerFallbackValue(_FakeAuthTokens());
  });

  late MockDioClient dioClient;
  late MockApiClient apiClient;
  late MockAuthApi authApi;
  late MockSecureTokenStorage storage;
  late LoginRepository repository;

  setUp(() {
    dioClient = MockDioClient();
    apiClient = MockApiClient();
    authApi = MockAuthApi();
    storage = MockSecureTokenStorage();

    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getAuthenticationApi).thenReturn(authApi);

    repository = LoginRepository(dioClient: dioClient, tokenStorage: storage);
  });

  test('requestOtp sends the OTP and returns a session for the phone number', () async {
    // The endpoint returns 202 Accepted with no body.
    when(() => authApi.requestOtp(sendOtpRequest: any(named: 'sendOtpRequest')))
        .thenAnswer((_) async => _response<void>('/auth/otp/request'));

    final session = await repository.requestOtp('+237690000000');

    expect(session.phoneNumber, '+237690000000');
    verify(() => authApi.requestOtp(sendOtpRequest: any(named: 'sendOtpRequest')))
        .called(1);
  });

  test('verifyOtp persists the returned tokens to secure storage', () async {
    final tokens = api.AuthTokens(
      (b) => b
        ..accessToken = 'access_1'
        ..refreshToken = 'refresh_1',
    );
    when(() => authApi.verifyOtp(verifyOtpRequest: any(named: 'verifyOtpRequest')))
        .thenAnswer((_) async => _response('/auth/otp/verify', data: tokens));
    when(() => storage.save(any())).thenAnswer((_) async {});

    await repository.verifyOtp(session: buildOtpSession(), code: '123456');

    final captured =
        verify(() => storage.save(captureAny())).captured.single as AuthTokens;
    expect(captured.accessToken, 'access_1');
    expect(captured.refreshToken, 'refresh_1');
  });
}
