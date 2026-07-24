import 'package:mboa_core/mboa_core.dart';

/// Session gate for App Mboa Pro: clears the session on logout. The startup
/// authentication check is done by the shared [SessionRepository]; the shared
/// login flow persists the tokens.
class AuthRepository {
  AuthRepository({required SecureTokenStorage tokenStorage})
      : _tokenStorage = tokenStorage;

  final SecureTokenStorage _tokenStorage;

  Future<void> logout() => _tokenStorage.clear();
}
