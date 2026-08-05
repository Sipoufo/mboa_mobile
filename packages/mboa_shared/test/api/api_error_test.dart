import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// The OpenAPI spec documents no error schema, so parsing has to tolerate
/// whatever the backend actually sends — and must never throw, because that
/// would replace a bad message with a crash.
void main() {
  DioException dioError(Object? body, {int status = 400}) => DioException(
        requestOptions: RequestOptions(path: '/api/v1/residences'),
        response: Response(
          data: body,
          statusCode: status,
          requestOptions: RequestOptions(path: '/api/v1/residences'),
        ),
      );

  test('reads a code/message pair', () {
    final error = ApiError.from(
      dioError({'code': 'RESIDENCE_UNIT_LIMIT', 'message': 'Too many units'}),
    );

    expect(error.code, 'RESIDENCE_UNIT_LIMIT');
    expect(error.message, 'Too many units');
    expect(error.statusCode, 400);
    expect(error.hasCode('residence_unit_limit'), isTrue);
  });

  test('accepts the other common key spellings', () {
    expect(ApiError.from(dioError({'errorCode': 'KYC_REQUIRED'})).code,
        'KYC_REQUIRED');
    expect(ApiError.from(dioError({'error_code': 'KYC_REQUIRED'})).code,
        'KYC_REQUIRED');
    expect(ApiError.from(dioError({'detail': 'Nope'})).message, 'Nope');
  });

  test("ignores Spring's reason phrase in `error`", () {
    // {"error": "Bad Request"} is not a machine code; treating it as one would
    // make every 400 look like a named failure.
    final error = ApiError.from(
      dioError({'error': 'Bad Request', 'message': 'Invalid payload'}),
    );

    expect(error.code, isNull);
    expect(error.message, 'Invalid payload');
  });

  test('still reads `error` when it looks like a code', () {
    expect(ApiError.from(dioError({'error': 'LISTING_LIMIT'})).code,
        'LISTING_LIMIT');
  });

  test('handles a bare string body', () {
    expect(ApiError.from(dioError('Something broke')).message, 'Something broke');
  });

  test('degrades quietly on shapes it does not know', () {
    for (final body in <Object?>[null, 42, <int>[1, 2], <String, dynamic>{}]) {
      final error = ApiError.from(dioError(body));
      expect(error.code, isNull, reason: '$body');
      expect(error.hasCode('ANYTHING'), isFalse);
    }
  });

  test('a non-Dio error yields an empty ApiError rather than throwing', () {
    final error = ApiError.from(Exception('boom'));

    expect(error.code, isNull);
    expect(error.message, isNull);
    expect(error.statusCode, isNull);
  });

  test('survives a response with no body at all', () {
    final error = ApiError.from(
      DioException(requestOptions: RequestOptions(path: '/x')),
    );

    expect(error.code, isNull);
  });
}
