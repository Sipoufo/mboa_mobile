import 'package:mboa_core/mboa_core.dart';

import '../models/otp_session.dart';

/// The sole network layer for the shared SMS-OTP login flow.
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

  /// Requests an SMS OTP for [phoneNumber] and returns the pending session.
  Future<OtpSession> requestOtp(String phoneNumber) async {
    await _api.requestOtp(
      sendOtpRequest: SendOtpRequest((b) => b..phoneNumber = phoneNumber),
    );

    return OtpSession(
      phoneNumber: phoneNumber,
    );
  }

  /// Re-sends the SMS OTP for an already-pending [phoneNumber] (dedicated
  /// resend endpoint, distinct from the initial request).
  Future<void> resendOtp(String phoneNumber) async {
    await _api.resendOtp(
      sendOtpRequest: SendOtpRequest((b) => b..phoneNumber = phoneNumber),
    );
  }

  /// Verifies [code] against [session] and persists the issued tokens.
  Future<void> verifyOtp({required OtpSession session, required String code}) async {
    final response = await _api.verifyOtp(
      verifyOtpRequest: VerifyOtpRequest(
        (b) => b
          ..phoneNumber = session.phoneNumber
          ..code = code,
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
