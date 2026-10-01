import 'package:flutter/foundation.dart';

/// Runtime environment, selected at build time via `--dart-define=ENV=...`.
///
/// CLAUDE.md rule: no API URL, key, or secret is ever hardcoded in feature
/// code — everything funnels through this single source of truth.
enum MboaEnv {
  dev,
  staging,
  production;

  static MboaEnv fromName(String value) {
    return MboaEnv.values.firstWhere(
      (e) => e.name == value,
      orElse: () => MboaEnv.dev,
    );
  }
}

@immutable
class Environment {
  const Environment._();

  /// Resolved once from the compile-time define. Defaults to `dev`.
  static final MboaEnv current = MboaEnv.fromName(
    const String.fromEnvironment('ENV', defaultValue: 'dev'),
  );

  /// Origin only — the generated `api_client` paths already include the
  /// `/api/v1` version prefix, so appending it here would double it
  /// (`/api/v1/api/v1/...` → 401).
  static String get apiBaseUrl {
    switch (current) {
      case MboaEnv.dev:
        return 'http://localhost:8080';
      case MboaEnv.staging:
        return 'https://staging.api.mboa.cm';
      case MboaEnv.production:
        return 'https://api.mboa.cm';
    }
  }

  /// Public base URL for reading media stored in Cloudflare R2 (avatars, logos,
  /// KYC previews). Object keys returned by the API are appended to this.
  ///
  /// Uploads use per-request presigned URLs (no client credentials needed);
  /// this is only for *displaying* stored objects.
  // TODO(r2): replace with the real R2 public bucket URL per environment.
  static String get r2PublicBaseUrl {
    switch (current) {
      case MboaEnv.dev:
        return const String.fromEnvironment(
          'R2_PUBLIC_BASE_URL',
          defaultValue: 'https://pub-f76049c2b3fc47e79f2c9a437a81c89f.r2.dev',
        );
      case MboaEnv.staging:
        return const String.fromEnvironment(
          'R2_PUBLIC_BASE_URL',
          defaultValue: 'https://TODO-r2-public-staging.example.com',
        );
      case MboaEnv.production:
        return const String.fromEnvironment(
          'R2_PUBLIC_BASE_URL',
          defaultValue: 'https://TODO-r2-public-production.example.com',
        );
    }
  }

  /// DSN is injected at build time; empty in dev disables Sentry reporting.
  static String get sentryDsn =>
      const String.fromEnvironment('SENTRY_DSN', defaultValue: '');

  /// MapTiler Cloud key for the vector tiles the map view loads (Doc 13 §8).
  ///
  /// Injected at build time like every other secret — see `env/README.md`.
  /// Empty is a supported state, not a bug: a checkout without the key still
  /// runs, and the map view says what is missing instead of showing a blank
  /// grey square.
  static String get mapTilerKey =>
      const String.fromEnvironment('MAPTILER_KEY', defaultValue: '');

  /// A whole style URL, which takes the place of the MapTiler one when set.
  ///
  /// Doc 13 §8 plans the move to self-hosted PMTiles once MapTiler's free
  /// 100k tiles/month is passed, and calls it transparent for the client —
  /// this is what makes it transparent. It also lets a developer with no key
  /// point at MapLibre's public demo style to check the map renders at all.
  static String get mapStyleOverride =>
      const String.fromEnvironment('MAP_STYLE_URL', defaultValue: '');

  /// Whether the map has tiles to load — a key, or a style of its own.
  static bool get hasMapTilerKey =>
      mapTilerKey.isNotEmpty || mapStyleOverride.isNotEmpty;

  /// The style the map loads. MapTiler's `streets-v2` reads well at the zoom
  /// levels a city search uses, and labels Douala and Yaoundé in French.
  static String get mapStyleUrl =>
      resolveStyleUrl(override: mapStyleOverride, key: mapTilerKey);

  /// Resolves the two settings into the one URL the map loads.
  ///
  /// A MapTiler style URL **without** `key=` is answered with 403 and the map
  /// stays blank, so an override that points at MapTiler and carries no key
  /// gets the configured one appended. Copying a style URL out of MapTiler's
  /// own catalogue, which is how anyone would find `streets-v4`, gives exactly
  /// that URL — the key is on a different page.
  ///
  /// An override pointing anywhere else is used untouched: a self-hosted
  /// PMTiles style (Doc 13 §8) has no MapTiler key to add.
  static String resolveStyleUrl({
    required String override,
    required String key,
  }) {
    if (override.isEmpty) {
      return 'https://api.maptiler.com/maps/streets-v2/style.json?key=$key';
    }
    final needsKey = override.contains('api.maptiler.com') &&
        !override.contains('key=') &&
        key.isNotEmpty;
    if (!needsKey) return override;
    return '$override${override.contains('?') ? '&' : '?'}key=$key';
  }

  static bool get isProduction => current == MboaEnv.production;
}
