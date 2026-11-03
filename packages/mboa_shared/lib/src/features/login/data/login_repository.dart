import 'package:mboa_core/mboa_core.dart';

import '../../../api/otp_guard.dart';

import '../models/otp_session.dart';

/// The sole network layer for the shared code sign-in (a phone or, since
/// §40 A, an email).
///
/// Drives the generated [AuthApi] via [DioClient] and persists the resulting
/// tokens through [SecureTokenStorage]. Identical for both apps — which is why
/// it lives in `mboa_shared` rather than in a single app.
class LoginRepository {
  LoginRepository({
    required DioClient dioClient,
    required SecureTokenStorage tokenStorage,
  })  : _dioClient = dioClient,
        _tokenStorage = tokenStorage;

  final DioClient _dioClient;
  final SecureTokenStorage _tokenStorage;

  AuthenticationApi get _api => _dioClient.api.getAuthenticationApi();

  /// Requests a sign-in code for a phone number or an email (§40 A: exactly
  /// one) and returns the pending session, with where the code went.
  Future<OtpSession> requestOtp({String? phoneNumber, String? email}) async {
    final response = await _api.requestOtp(sendOtpRequest: _request(phoneNumber: phoneNumber, email: email));
    return OtpSession(
      phoneNumber: phoneNumber,
      email: email,
      channel: OtpChannel.parse(response.data?.channel?.name),
    );
  }

  /// Re-sends the code for the pending [session] (dedicated resend endpoint,
  /// distinct from the initial request); the session, with where it went.
  Future<OtpSession> resendOtp(OtpSession session) async {
    final response = await _api.resendOtp(
      sendOtpRequest: _request(phoneNumber: session.phoneNumber, email: session.email),
    );
    return session.withChannel(OtpChannel.parse(response.data?.channel?.name));
  }

  static SendOtpRequest _request({String? phoneNumber, String? email}) => SendOtpRequest((b) => b
    ..phoneNumber = phoneNumber
    ..email = email);

  /// Verifies [code] against [session] and persists the issued tokens.
  /// Throws [OtpCodeBurnt] once the code can no longer be accepted.
  Future<void> verifyOtp({required OtpSession session, required String code}) async {
    final response = await guardOtp(
      () => _api.verifyOtp(
        verifyOtpRequest: VerifyOtpRequest(
          (b) => b
            ..phoneNumber = session.phoneNumber
            ..email = session.email
            ..code = code,
        ),
      ),
    );
    final pair = response.data!;
    await _tokenStorage.save(
      AuthTokens(
        accessToken: pair.accessToken ?? '',
        refreshToken: pair.refreshToken ?? '',
        accessTokenExpiresAt: pair.accessTokenExpiresAt,
        refreshTokenExpiresAt: pair.refreshTokenExpiresAt,
      ),
    );
  }
}
