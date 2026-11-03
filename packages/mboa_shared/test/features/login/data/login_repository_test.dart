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
    // 202 Accepted, saying where the code went (§40 A).
    when(() => authApi.requestOtp(sendOtpRequest: any(named: 'sendOtpRequest'))).thenAnswer(
      (_) async => _response<OtpSentResponse>(
        '/auth/otp/request',
        data: OtpSentResponse((b) => b..channel = OtpSentResponseChannelEnum.SMS),
      ),
    );

    final session = await repository.requestOtp(phoneNumber: '+237690000000');

    expect(session.phoneNumber, '+237690000000');
    expect(session.channel, OtpChannel.sms);
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

  test('§40 A — an email: the request carries it, and no phone; the session says it went by email', () async {
    when(() => authApi.requestOtp(sendOtpRequest: any(named: 'sendOtpRequest'))).thenAnswer(
      (_) async => _response<OtpSentResponse>(
        '/auth/otp/request',
        data: OtpSentResponse((b) => b..channel = OtpSentResponseChannelEnum.EMAIL),
      ),
    );

    final session = await repository.requestOtp(email: 'awa@example.cm');

    final sent = verify(() => authApi.requestOtp(sendOtpRequest: captureAny(named: 'sendOtpRequest')))
        .captured
        .single as SendOtpRequest;
    expect((sent.email, sent.phoneNumber), ('awa@example.cm', null));
    expect((session.email, session.channel), ('awa@example.cm', OtpChannel.email));
  });

  test('§40 A — verifying an email session sends the email', () async {
    when(() => authApi.verifyOtp(verifyOtpRequest: any(named: 'verifyOtpRequest'))).thenAnswer(
      (_) async => _response('/auth/otp/verify', data: api.AuthTokens((b) => b
        ..accessToken = 'a'
        ..refreshToken = 'r')),
    );
    when(() => storage.save(any())).thenAnswer((_) async {});

    await repository.verifyOtp(session: buildOtpSession(email: 'awa@example.cm'), code: '123456');

    final sent = verify(() => authApi.verifyOtp(verifyOtpRequest: captureAny(named: 'verifyOtpRequest')))
        .captured
        .single as VerifyOtpRequest;
    expect((sent.email, sent.phoneNumber), ('awa@example.cm', null));
  });
}
