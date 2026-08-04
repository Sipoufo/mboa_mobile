import 'package:flutter/material.dart';

/// Raw brand palette (Charte Graphique, Doc 05 §2). Prefer reading colours via
/// [MboaColorScheme] / `context.mboaColors`; these constants exist for the few
/// places a raw value is needed (e.g. native config).
abstract final class MboaPalette {
  // Vert Forêt — brand colour (§2.1)
  static const Color forest = Color(0xFF1A5C45);
  static const Color forestLight = Color(0xFF2D8A67);
  static const Color forestLight2 = Color(0xFFD8F3DC);
  static const Color forestPale = Color(0xFFE8F4F0);
  static const Color forestDark = Color(0xFF0F3829);

  // Corail — action colour (§2.1)
  static const Color coral = Color(0xFFE8735A);
  static const Color coralLight = Color(0xFFF5A08C);
  static const Color coralPale = Color(0xFFFDF0EC);
  static const Color coralDark = Color(0xFFC4503A);

  // Neutrals (§2.2)
  static const Color white = Color(0xFFFFFFFF);
  static const Color warmWhite = Color(0xFFF9F7F4);
  static const Color greyLight = Color(0xFFF0EFED);
  static const Color greyMedium = Color(0xFF9CA3AF);
  static const Color greyDark = Color(0xFF6B7280);
  static const Color ink = Color(0xFF1A1A1A);

  // System (§2.3)
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);
}

/// Mboa's semantic colour roles, as a [ThemeExtension] so it rides on
/// `ThemeData` and lerps across light/dark. Read via `context.mboaColors`.
@immutable
class MboaColorScheme extends ThemeExtension<MboaColorScheme> {
  const MboaColorScheme({
    required this.primary,
    required this.primaryLight,
    required this.primaryLight2,
    required this.primaryPale,
    required this.primaryDark,
    required this.action,
    required this.actionLight,
    required this.actionPale,
    required this.actionDark,
    required this.surface,
    required this.surfaceWarm,
    required this.border,
    required this.textTertiary,
    required this.textSecondary,
    required this.ink,
    required this.onBrand,
    required this.success,
    required this.error,
    required this.warning,
    required this.info,
  });

  // Brand (Vert Forêt) + action (Corail)
  final Color primary;
  final Color primaryLight;
  final Color primaryLight2;
  final Color primaryPale;
  final Color primaryDark;
  final Color action;
  final Color actionLight;
  final Color actionPale;
  final Color actionDark;

  // Surfaces & neutrals
  final Color surface; // app background
  final Color surfaceWarm; // cards, inputs
  final Color border; // separators, unselected chips
  final Color textTertiary; // placeholders, inactive
  final Color textSecondary; // labels, metadata
  final Color ink; // titles, body

  /// Foreground on a brand/action fill (white per §2.4 contrast rules).
  final Color onBrand;

  // System
  final Color success;
  final Color error;
  final Color warning;
  final Color info;

  /// Light scheme — the canonical brandbook palette.
  static const MboaColorScheme light = MboaColorScheme(
    primary: MboaPalette.forest,
    primaryLight: MboaPalette.forestLight,
    primaryLight2: MboaPalette.forestLight2,
    primaryPale: MboaPalette.forestPale,
    primaryDark: MboaPalette.forestDark,
    action: MboaPalette.coral,
    actionLight: MboaPalette.coralLight,
    actionPale: MboaPalette.coralPale,
    actionDark: MboaPalette.coralDark,
    surface: MboaPalette.white,
    surfaceWarm: MboaPalette.warmWhite,
    border: MboaPalette.greyLight,
    textTertiary: MboaPalette.greyMedium,
    textSecondary: MboaPalette.greyDark,
    ink: MboaPalette.ink,
    onBrand: MboaPalette.white,
    success: MboaPalette.success,
    error: MboaPalette.error,
    warning: MboaPalette.warning,
    info: MboaPalette.info,
  );

  /// Dark scheme — an adaptation (Doc 05 specifies light only); brand hues kept,
  /// surfaces/neutrals inverted. Refine when the brandbook adds a dark spec.
  static const MboaColorScheme dark = MboaColorScheme(
    primary: MboaPalette.forestLight,
    primaryLight: MboaPalette.forest,
    primaryLight2: MboaPalette.forest,
    primaryPale: MboaPalette.forestDark,
    primaryDark: MboaPalette.forestPale,
    action: MboaPalette.coral,
    actionLight: MboaPalette.coralLight,
    actionPale: Color(0xFF3A241F),
    actionDark: MboaPalette.coralDark,
    surface: Color(0xFF121212),
    surfaceWarm: Color(0xFF1E1E1E),
    border: Color(0xFF2C2C2C),
    textTertiary: MboaPalette.greyDark,
    textSecondary: MboaPalette.greyMedium,
    ink: Color(0xFFF5F5F5),
    onBrand: MboaPalette.white,
    success: MboaPalette.success,
    error: MboaPalette.error,
    warning: MboaPalette.warning,
    info: MboaPalette.info,
  );

  @override
  MboaColorScheme copyWith({
    Color? primary,
    Color? primaryLight,
    Color? primaryLight2,
    Color? primaryPale,
    Color? primaryDark,
    Color? action,
    Color? actionLight,
    Color? actionPale,
    Color? actionDark,
    Color? surface,
    Color? surfaceWarm,
    Color? border,
    Color? textTertiary,
    Color? textSecondary,
    Color? ink,
    Color? onBrand,
    Color? success,
    Color? error,
    Color? warning,
    Color? info,
  }) {
    return MboaColorScheme(
      primary: primary ?? this.primary,
      primaryLight: primaryLight ?? this.primaryLight,
      primaryLight2: primaryLight2 ?? this.primaryLight2,
      primaryPale: primaryPale ?? this.primaryPale,
      primaryDark: primaryDark ?? this.primaryDark,
      action: action ?? this.action,
      actionLight: actionLight ?? this.actionLight,
      actionPale: actionPale ?? this.actionPale,
      actionDark: actionDark ?? this.actionDark,
      surface: surface ?? this.surface,
      surfaceWarm: surfaceWarm ?? this.surfaceWarm,
      border: border ?? this.border,
      textTertiary: textTertiary ?? this.textTertiary,
      textSecondary: textSecondary ?? this.textSecondary,
      ink: ink ?? this.ink,
      onBrand: onBrand ?? this.onBrand,
      success: success ?? this.success,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      info: info ?? this.info,
    );
  }

  @override
  MboaColorScheme lerp(covariant ThemeExtension<MboaColorScheme>? other, double t) {
    if (other is! MboaColorScheme) return this;
    Color mix(Color a, Color b) => Color.lerp(a, b, t)!;
    return MboaColorScheme(
      primary: mix(primary, other.primary),
      primaryLight: mix(primaryLight, other.primaryLight),
      primaryLight2: mix(primaryLight2, other.primaryLight2),
      primaryPale: mix(primaryPale, other.primaryPale),
      primaryDark: mix(primaryDark, other.primaryDark),
      action: mix(action, other.action),
      actionLight: mix(actionLight, other.actionLight),
      actionPale: mix(actionPale, other.actionPale),
      actionDark: mix(actionDark, other.actionDark),
      surface: mix(surface, other.surface),
      surfaceWarm: mix(surfaceWarm, other.surfaceWarm),
      border: mix(border, other.border),
      textTertiary: mix(textTertiary, other.textTertiary),
      textSecondary: mix(textSecondary, other.textSecondary),
      ink: mix(ink, other.ink),
      onBrand: mix(onBrand, other.onBrand),
      success: mix(success, other.success),
      error: mix(error, other.error),
      warning: mix(warning, other.warning),
      info: mix(info, other.info),
    );
  }
}
