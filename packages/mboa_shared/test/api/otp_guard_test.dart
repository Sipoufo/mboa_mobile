import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';

DioException _refused(String code) => DioException(
      requestOptions: RequestOptions(path: '/auth/otp/verify'),
      response: Response(requestOptions: RequestOptions(path: '/x'), statusCode: 400, data: {'error': code}),
    );

/// Three wrong codes burn it; an expired one is as dead (Consolidation C).
void main() {
  test('OTP_MAX_ATTEMPTS and OTP_INVALID_OR_EXPIRED: the code is dead', () async {
    for (final code in ['OTP_MAX_ATTEMPTS', 'OTP_INVALID_OR_EXPIRED']) {
      await expectLater(guardOtp<void>(() async => throw _refused(code)), throwsA(isA<OtpCodeBurnt>()));
    }
  });

  test('a wrong code is just wrong; anything else goes up as it came', () async {
    await expectLater(guardOtp<void>(() async => throw _refused('OTP_INVALID')), throwsA(isA<DioException>()));
    await expectLater(guardOtp<void>(() async => throw StateError('x')), throwsStateError);
    expect(await guardOtp(() async => 42), 42);
  });
}
