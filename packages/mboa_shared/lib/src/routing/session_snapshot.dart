import '../features/profile/models/account_role.dart';

/// Synchronous view of "is there a live session right now?", readable from a
/// route guard.
///
/// Guards run on every navigation, so they cannot afford the async keychain
/// read that [SecureTokenStorage] requires — and duplicating the token read
/// would create a second source of truth next to the auth bloc. Instead the
/// splash (startup) and the app's `AuthBloc` (runtime) keep this boolean warm,
/// and the guards read it for free.
///
/// This deliberately holds **no token material** — only whether one exists.
/// Tokens stay exclusively in `SecureTokenStorage`.
class SessionSnapshot {
  bool _hasSession = false;
  AccountRole? _role;

  /// Whether the app currently holds a session.
  bool get hasSession => _hasSession;

  /// The signed-in account's role, or **null when not yet known**.
  ///
  /// Known on resume, because the startup check calls `/me` anyway. Null after
  /// a fresh sign-in — the login response carries tokens and nothing else — and
  /// on an offline start. Nullable rather than defaulted so "unknown" cannot be
  /// mistaken for "an ordinary user", which would route an agent wrongly.
  AccountRole? get role => _role;

  void markAuthenticated({AccountRole? role}) {
    _hasSession = true;
    _role = role;
  }

  void markUnauthenticated() {
    _hasSession = false;
    _role = null;
  }
}
