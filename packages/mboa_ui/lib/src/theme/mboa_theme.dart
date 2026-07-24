import 'package:flutter/material.dart';

import 'dimens.dart';
import 'mboa_colors.dart';
import 'mboa_text_theme.dart';

/// Builds the Mboa [ThemeData] from the brand tokens (Charte Graphique, Doc 05).
/// Both apps share one identity, so there is no per-app seed. The custom
/// [MboaColorScheme] / [MboaTextTheme] ride along as theme extensions; stock
/// Material widgets pick up the mapped [ColorScheme] / [TextTheme].
class MboaTheme {
  const MboaTheme._();

  static ThemeData light() =>
      _build(MboaColorScheme.light, MboaTextTheme.light, Brightness.light);

  static ThemeData dark() =>
      _build(MboaColorScheme.dark, MboaTextTheme.dark, Brightness.dark);

  static const String _bodyFont = 'packages/mboa_ui/Inter';

  static ThemeData _build(MboaColorScheme c, MboaTextTheme t, Brightness b) {
    // primary = Vert Forêt (brand); secondary = Corail (action/CTA).
    final colorScheme = ColorScheme(
      brightness: b,
      primary: c.primary,
      onPrimary: c.onBrand,
      primaryContainer: c.primaryPale,
      onPrimaryContainer: c.primaryDark,
      secondary: c.action,
      onSecondary: c.onBrand,
      secondaryContainer: c.actionPale,
      onSecondaryContainer: c.actionDark,
      error: c.error,
      onError: c.onBrand,
      surface: c.surface,
      onSurface: c.ink,
      surfaceContainerHighest: c.surfaceWarm,
      outline: c.border,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: b,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: c.surface,
      fontFamily: _bodyFont,
      textTheme: t.toMaterialTextTheme(),
      extensions: <ThemeExtension<dynamic>>[c, t],
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.surfaceWarm,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.radius),
          borderSide: BorderSide(color: c.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.radius),
          borderSide: BorderSide(color: c.border),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(Dimens.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.radius),
          ),
          textStyle: t.label,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: c.surface,
        foregroundColor: c.ink,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: t.h3,
      ),
    );
  }
}
