import 'hive_cache.dart';
import 'secure_token_storage.dart';
import '../constants/storage_keys.dart';

/// The marker that says this install has started once.
const String _installMarker = 'install';

/// Forgets the tokens a **previous install** left behind.
///
/// iOS keeps the Keychain when an app is deleted; everything else the app
/// stored (Hive, its files) goes with it. Reinstalled, the app found a session
/// it had no record of: the splash could judge it gone while the interceptor
/// kept sending its access token, so the reader saw « Se connecter » while the
/// server answered as the previous account (its rent banner, « Position exacte,
/// car tu as contacté ce prestataire »). Whoever had the phone before is not
/// signed back in by reinstalling the app either.
///
/// The marker lives in a device-scoped Hive box — gone on uninstall, kept on
/// sign-out — so this clears exactly once per install. Run it after
/// [HiveCache.init] and before anything reads a token.
Future<void> forgetTokensOfPreviousInstall({
  required HiveCache cache,
  required SecureTokenStorage tokens,
}) async {
  if (cache.get(StorageKeys.appSettingsBox, _installMarker) != null) return;
  await tokens.clear();
  await cache.put(StorageKeys.appSettingsBox, _installMarker, {'at': DateTime.now().toIso8601String()});
}
