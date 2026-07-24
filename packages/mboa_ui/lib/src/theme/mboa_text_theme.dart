import 'package:flutter/material.dart';

import 'mboa_colors.dart';

// Package-bundled fonts must be referenced with the `packages/<pkg>/` prefix.
const String _display = 'packages/mboa_ui/PlusJakartaSans';
const String _body = 'packages/mboa_ui/Inter';

/// Mboa's typographic scale (Charte Graphique, Doc 05 §3.2), as a
/// [ThemeExtension]. Read via `context.mboaText`.
@immutable
class MboaTextTheme extends ThemeExtension<MboaTextTheme> {
  const MboaTextTheme({
    required this.display,
    required this.h1,
    required this.h2,
    required this.h3,
    required this.bodyLarge,
    required this.body,
    required this.label,
    required this.caption,
    required this.micro,
  });

  final TextStyle display; // Plus Jakarta ExtraBold 32/40
  final TextStyle h1; // Plus Jakarta Bold 28/36
  final TextStyle h2; // Plus Jakarta Bold 22/30
  final TextStyle h3; // Plus Jakarta SemiBold 18/26
  final TextStyle bodyLarge; // Inter Regular 16/24
  final TextStyle body; // Inter Regular 14/22
  final TextStyle label; // Inter SemiBold 14/20
  final TextStyle caption; // Inter Medium 12/18
  final TextStyle micro; // Inter Regular 11/16

  /// Builds the scale with [ink] as the default text colour.
  factory MboaTextTheme.from(Color ink) {
    return MboaTextTheme(
      display: TextStyle(
        fontFamily: _display,
        fontWeight: FontWeight.w800,
        fontSize: 32,
        height: 40 / 32,
        letterSpacing: -0.5,
        color: ink,
      ),
      h1: TextStyle(
        fontFamily: _display,
        fontWeight: FontWeight.w700,
        fontSize: 28,
        height: 36 / 28,
        letterSpacing: -0.5,
        color: ink,
      ),
      h2: TextStyle(
        fontFamily: _display,
        fontWeight: FontWeight.w700,
        fontSize: 22,
        height: 30 / 22,
        color: ink,
      ),
      h3: TextStyle(
        fontFamily: _display,
        fontWeight: FontWeight.w600,
        fontSize: 18,
        height: 26 / 18,
        color: ink,
      ),
      bodyLarge: TextStyle(
        fontFamily: _body,
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 24 / 16,
        color: ink,
      ),
      body: TextStyle(
        fontFamily: _body,
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 22 / 14,
        color: ink,
      ),
      label: TextStyle(
        fontFamily: _body,
        fontWeight: FontWeight.w600,
        fontSize: 14,
        height: 20 / 14,
        color: ink,
      ),
      caption: TextStyle(
        fontFamily: _body,
        fontWeight: FontWeight.w500,
        fontSize: 12,
        height: 18 / 12,
        color: ink,
      ),
      micro: TextStyle(
        fontFamily: _body,
        fontWeight: FontWeight.w400,
        fontSize: 11,
        height: 16 / 11,
        letterSpacing: 0.2,
        color: ink,
      ),
    );
  }

  static final MboaTextTheme light = MboaTextTheme.from(MboaColorScheme.light.ink);
  static final MboaTextTheme dark = MboaTextTheme.from(MboaColorScheme.dark.ink);

  /// Maps the scale onto a Material [TextTheme] so stock widgets pick up the
  /// brand fonts/sizes without having to read [MboaTextTheme] directly.
  TextTheme toMaterialTextTheme() => TextTheme(
        displayLarge: display,
        headlineLarge: h1,
        headlineMedium: h2,
        titleLarge: h3,
        bodyLarge: bodyLarge,
        bodyMedium: body,
        labelLarge: label,
        bodySmall: caption,
        labelSmall: micro,
      );

  @override
  MboaTextTheme copyWith({
    TextStyle? display,
    TextStyle? h1,
    TextStyle? h2,
    TextStyle? h3,
    TextStyle? bodyLarge,
    TextStyle? body,
    TextStyle? label,
    TextStyle? caption,
    TextStyle? micro,
  }) {
    return MboaTextTheme(
      display: display ?? this.display,
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      h3: h3 ?? this.h3,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      body: body ?? this.body,
      label: label ?? this.label,
      caption: caption ?? this.caption,
      micro: micro ?? this.micro,
    );
  }

  @override
  MboaTextTheme lerp(covariant ThemeExtension<MboaTextTheme>? other, double t) {
    if (other is! MboaTextTheme) return this;
    return MboaTextTheme(
      display: TextStyle.lerp(display, other.display, t)!,
      h1: TextStyle.lerp(h1, other.h1, t)!,
      h2: TextStyle.lerp(h2, other.h2, t)!,
      h3: TextStyle.lerp(h3, other.h3, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      label: TextStyle.lerp(label, other.label, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
      micro: TextStyle.lerp(micro, other.micro, t)!,
    );
  }
}
