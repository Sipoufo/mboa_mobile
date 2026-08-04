import 'package:mboa_core/mboa_core.dart';

/// The sole network layer for App Mboa Pro's credential login (email + password
/// with an email OTP as a second factor).
///
/// Two backend steps:
///  1. [login] — verify credentials; the backend sends an OTP to the email.
///  2. [verifyOtp] — verify that OTP and persist the issued tokens.
class CredentialAuthRepository {
  CredentialAuthRepository({
    required DioClient dioClient,
    required SecureTokenStorage tokenStorage,
  })  : _dioClient = dioClient,
        _tokenStorage = tokenStorage;

  final DioClient _dioClient;
  final SecureTokenStorage _tokenStorage;

  AuthenticationApi get _api => _dioClient.api.getAuthenticationApi();

  /// Step 1 — verify email + password. On success the backend sends an OTP.
  Future<void> login({required String email, required String password}) async {
    await _api.login(
      loginRequest: LoginRequest((b) => b
        ..email = email
        ..password = password),
    );
  }

  /// Step 2 — verify the emailed [code] and persist the issued tokens.
  Future<void> verifyOtp({required String email, required String code}) async {
    final response = await _api.verifyLoginOtp(
      loginOtpRequest: LoginOtpRequest((b) => b
        ..email = email
        ..code = code),
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
