import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../generated/l10n.dart';

/// Convenience bundle so each app wires localisation with a single reference:
///
/// ```dart
/// MaterialApp.router(
///   localizationsDelegates: MboaLocalizations.delegates,
///   supportedLocales: MboaLocalizations.supportedLocales,
///   ...
/// )
/// ```
class MboaLocalizations {
  const MboaLocalizations._();

  static const List<LocalizationsDelegate<dynamic>> delegates = [
    I18n.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static List<Locale> get supportedLocales => I18n.delegate.supportedLocales;
}
