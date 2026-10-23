import 'package:dio/dio.dart';

import 'api_error.dart';

/// The code can no longer be accepted, even the right one: three wrong
/// tries burnt it (`OTP_MAX_ATTEMPTS`), or it expired or was replaced
/// (`OTP_INVALID_OR_EXPIRED`). Only a new code helps — the screen clears the
/// field and offers « Renvoyer un code » at once.
class OtpCodeBurnt implements Exception {
  const OtpCodeBurnt();
}

/// Runs a code check, turning the server's « this code is dead » into
/// [OtpCodeBurnt]. Every other failure goes up as it came.
Future<T> guardOtp<T>(Future<T> Function() check) async {
  try {
    return await check();
  } on DioException catch (error) {
    final api = ApiError.from(error);
    if (api.hasCode('OTP_MAX_ATTEMPTS') || api.hasCode('OTP_INVALID_OR_EXPIRED')) throw const OtpCodeBurnt();
    rethrow;
  }
}
