import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/storage_keys.dart';
import '../models/auth_tokens.dart';

/// The single gateway to JWT tokens, backed by Keychain (iOS) /
/// EncryptedSharedPreferences (Android).
///
/// CLAUDE.md rule: tokens live *exclusively* here — only the [AuthInterceptor]
/// (and the auth flow that first obtains them) reads or writes this class.
class SecureTokenStorage {
  SecureTokenStorage({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(encryptedSharedPreferences: true),
              iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
            );

  final FlutterSecureStorage _storage;

  Future<void> save(AuthTokens tokens) async {
    await _storage.write(key: StorageKeys.accessToken, value: tokens.accessToken);
    await _storage.write(key: StorageKeys.refreshToken, value: tokens.refreshToken);
    await _writeDate(StorageKeys.accessTokenExpiresAt, tokens.accessTokenExpiresAt);
    await _writeDate(StorageKeys.refreshTokenExpiresAt, tokens.refreshTokenExpiresAt);
  }

  Future<String?> readAccessToken() =>
      _storage.read(key: StorageKeys.accessToken);

  Future<String?> readRefreshToken() =>
      _storage.read(key: StorageKeys.refreshToken);

  Future<AuthTokens?> readTokens() async {
    final access = await readAccessToken();
    final refresh = await readRefreshToken();
    if (access == null || refresh == null) return null;
    return AuthTokens(
      accessToken: access,
      refreshToken: refresh,
      accessTokenExpiresAt: await _readDate(StorageKeys.accessTokenExpiresAt),
      refreshTokenExpiresAt: await _readDate(StorageKeys.refreshTokenExpiresAt),
    );
  }

  Future<bool> hasTokens() async => (await readAccessToken()) != null;

  Future<void> clear() async {
    await _storage.delete(key: StorageKeys.accessToken);
    await _storage.delete(key: StorageKeys.refreshToken);
    await _storage.delete(key: StorageKeys.accessTokenExpiresAt);
    await _storage.delete(key: StorageKeys.refreshTokenExpiresAt);
  }

  /// Stores a date as epoch-millis; deletes the key when [date] is null so the
  /// stored state stays consistent with the tokens it accompanies.
  Future<void> _writeDate(String key, DateTime? date) {
    if (date == null) return _storage.delete(key: key);
    return _storage.write(key: key, value: '${date.millisecondsSinceEpoch}');
  }

  Future<DateTime?> _readDate(String key) async {
    final raw = await _storage.read(key: key);
    final millis = raw == null ? null : int.tryParse(raw);
    return millis == null ? null : DateTime.fromMillisecondsSinceEpoch(millis);
  }
}
