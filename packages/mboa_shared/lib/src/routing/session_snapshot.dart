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

  /// Whether the app currently holds a session.
  bool get hasSession => _hasSession;

  void markAuthenticated() => _hasSession = true;

  void markUnauthenticated() => _hasSession = false;
}
