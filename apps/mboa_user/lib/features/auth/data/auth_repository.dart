import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// Session gate for App Mboa: reads whether a valid session exists and clears
/// it on logout. The actual login (SMS OTP) lives in the shared `mboa_shared`
/// login feature, which persists the tokens this repository then observes.
class AuthRepository {
  AuthRepository({
    required DioClient dioClient,
    required SecureTokenStorage tokenStorage,
    required HiveCache cache,
    NotificationsRepository? notifications,
  })  : _dioClient = dioClient,
        _tokenStorage = tokenStorage,
        _cache = cache,
        _notifications = notifications;

  final DioClient _dioClient;
  final SecureTokenStorage _tokenStorage;
  final HiveCache _cache;
  final NotificationsRepository? _notifications;

  Future<bool> hasSession() => _tokenStorage.hasTokens();

  /// Logs out: revokes this device's push registration, then the refresh token
  /// server-side (best-effort — a network failure must not strand the user in a
  /// signed-in-looking state), then clears local tokens. Satisfies CA-M01-04.
  ///
  /// Order matters: both revokes are authenticated calls, so they must happen
  /// **before** the tokens are cleared.
  Future<void> logout() async {
    try {
      await _notifications?.stop();
    } catch (_) {
      // Best-effort — failing to deregister must not strand the user.
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
    await _clearAccountCache();
  }

  /// A new session starts from an empty account cache.
  ///
  /// [logout] already emptied it; this catches what landed after — a fetch
  /// still in flight when the tokens went writes its result on return — and a
  /// purge that failed. Only an account reads these boxes, so clearing them
  /// before it is signed in is all that has to hold.
  Future<void> beginSession() => _clearAccountCache();

  /// The account's visits, unsent messages and the rest go with it — see
  /// `StorageKeys.accountScopedBoxes`; the device's last search and language
  /// stay. Best-effort, like the revokes: a failing disk must not keep anyone
  /// signed in, and [beginSession] clears again before the next account.
  Future<void> _clearAccountCache() async {
    try {
      await _cache.clearAccountScoped();
    } catch (_) {}
  }
}
