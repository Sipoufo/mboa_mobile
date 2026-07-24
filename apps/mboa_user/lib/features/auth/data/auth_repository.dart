import 'package:mboa_core/mboa_core.dart';

/// Session gate for App Mboa: reads whether a valid session exists and clears
/// it on logout. The actual login (SMS OTP) lives in the shared `mboa_shared`
/// login feature, which persists the tokens this repository then observes.
class AuthRepository {
  AuthRepository({required SecureTokenStorage tokenStorage})
      : _tokenStorage = tokenStorage;

  final SecureTokenStorage _tokenStorage;

  Future<bool> hasSession() => _tokenStorage.hasTokens();

  Future<void> logout() => _tokenStorage.clear();
}
