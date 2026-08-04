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

  static bool get isProduction => current == MboaEnv.production;
}
