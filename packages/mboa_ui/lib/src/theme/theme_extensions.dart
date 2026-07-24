import 'package:flutter/material.dart';

import 'mboa_colors.dart';
import 'mboa_text_theme.dart';

/// Ergonomic accessors for Mboa's design tokens, à la Zeney's `context.*`.
///
/// ```dart
/// Container(color: context.mboaColors.primary);
/// Text('Titre', style: context.mboaText.h1);
/// ```
extension MboaThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  MboaColorScheme get mboaColors =>
      Theme.of(this).extension<MboaColorScheme>() ?? MboaColorScheme.light;

  MboaTextTheme get mboaText =>
      Theme.of(this).extension<MboaTextTheme>() ?? MboaTextTheme.light;
}
