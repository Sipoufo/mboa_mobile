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

  static String get apiBaseUrl {
    switch (current) {
      case MboaEnv.dev:
        return 'http://localhost:8080/api/v1';
      case MboaEnv.staging:
        return 'https://staging.api.mboa.cm/api/v1';
      case MboaEnv.production:
        return 'https://api.mboa.cm/api/v1';
    }
  }

  /// DSN is injected at build time; empty in dev disables Sentry reporting.
  static String get sentryDsn =>
      const String.fromEnvironment('SENTRY_DSN', defaultValue: '');

  static bool get isProduction => current == MboaEnv.production;
}
