import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// Session gate for App Mboa Pro. The startup authentication check is done by
/// the shared [SessionRepository]; the login/registration flows persist tokens.
class AuthRepository {
  AuthRepository({
    required DioClient dioClient,
    required SecureTokenStorage tokenStorage,
    NotificationsRepository? notifications,
  })  : _dioClient = dioClient,
        _tokenStorage = tokenStorage,
        _notifications = notifications;

  final DioClient _dioClient;
  final SecureTokenStorage _tokenStorage;
  final NotificationsRepository? _notifications;

  /// Logs out: revokes this device's push registration, then the refresh token
  /// server-side (best-effort — a network failure must not strand the user in a
  /// signed-in-looking state), then clears local tokens. Satisfies CA-M01-04
  /// (server-side invalidation).
  ///
  /// Order matters: both revokes are authenticated calls, so they must happen
  /// **before** the tokens are cleared. Keeping them here rather than in the
  /// bloc means no future logout path can forget one.
  Future<void> logout() async {
    try {
      await _notifications?.stop();
    } catch (_) {
      // Best-effort, like the token revoke below: failing to deregister the
      // device must never leave the user stuck in a signed-in-looking state.
    }

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
