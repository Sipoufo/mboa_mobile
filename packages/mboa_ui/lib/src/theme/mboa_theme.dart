import 'package:flutter/material.dart';

import 'dimens.dart';

/// The single, parameterised Material 3 theme builder shared by both apps.
/// Each app passes its own brand [seed] (see [MboaColors]) so the products stay
/// distinct while the component styling stays identical.
class MboaTheme {
  const MboaTheme._();

  static ThemeData light(Color seed) =>
      _base(ColorScheme.fromSeed(seedColor: seed));

  static ThemeData dark(Color seed) => _base(
        ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark),
      );

  static ThemeData _base(ColorScheme scheme) {
    return ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(Dimens.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.radius),
          ),
        ),
      ),
    );
  }
}
