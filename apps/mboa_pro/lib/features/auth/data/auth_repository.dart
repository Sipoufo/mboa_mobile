import 'package:mboa_core/mboa_core.dart';

/// Session gate for App Mboa Pro. The startup authentication check is done by
/// the shared [SessionRepository]; the login/registration flows persist tokens.
class AuthRepository {
  AuthRepository({
    required DioClient dioClient,
    required SecureTokenStorage tokenStorage,
  })  : _dioClient = dioClient,
        _tokenStorage = tokenStorage;

  final DioClient _dioClient;
  final SecureTokenStorage _tokenStorage;

  /// Logs out: revokes the refresh token server-side (best-effort — a network
  /// failure must not strand the user in a signed-in-looking state), then
  /// clears local tokens. Satisfies CA-M01-04 (server-side invalidation).
  Future<void> logout() async {
    final refreshToken = await _tokenStorage.readRefreshToken();
    if (refreshToken != null && refreshToken.isNotEmpty) {
      try {
        await _dioClient.api.getAuthenticationApi().logout(
              logoutRequest: LogoutRequest((b) => b..refreshToken = refreshToken),
            );
      } catch (_) {
        // Best-effort revoke — proceed to clear locally regardless.
      }
    }
    await _tokenStorage.clear();
  }
}
