import 'package:flutter/widgets.dart';
import 'package:mboa_core/mboa_core.dart';

import '../data/app_settings_repository.dart';

/// Holds the app's selected [Locale] (null = follow the device), persists it
/// locally, and best-effort syncs it to the server settings. The root
/// `MaterialApp` rebuilds via a `ValueListenableBuilder` on this notifier.
class LocaleController extends ValueNotifier<Locale?> {
  LocaleController({required HiveCache cache, required AppSettingsRepository settings})
      : _cache = cache,
        _settings = settings,
        super(null);

  final HiveCache _cache;
  final AppSettingsRepository _settings;

  static const String _box = StorageKeys.appSettingsBox;
  static const String _key = 'locale';

  /// Loads the persisted locale (call once at startup, before `runApp`).
  Future<void> load() async {
    final code = _cache.get(_box, _key)?['code'] as String?;
    if (code != null && code.isNotEmpty) value = Locale(code);
  }

  /// Applies [locale], persists it, and best-effort syncs it to the server.
  Future<void> setLocale(Locale locale) async {
    if (value?.languageCode == locale.languageCode) return;
    value = locale;
    await _cache.put(_box, _key, {'code': locale.languageCode});
    try {
      await _settings.updateLanguage(locale.languageCode);
    } catch (_) {
      // Best-effort — the local preference already applied.
    }
  }
}
