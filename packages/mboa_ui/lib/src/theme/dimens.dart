/// Shared spacing / sizing scale so widgets never hardcode magic numbers.
abstract final class Dimens {
  // Spacing scale
  static const double spacingXs = 4;
  static const double spacingSm = 8;
  static const double spacingMd = 12;
  static const double spacing = 16;
  static const double spacingLg = 24;
  static const double spacingXl = 32;
  static const double spacingXxl = 48;

  // Back-compat aliases (earlier widgets used these names).
  static const double xs = spacingXs;
  static const double sm = spacingSm;
  static const double md = spacing;
  static const double lg = spacingLg;
  static const double xl = spacingXl;

  // Radius scale
  static const double radiusSm = 8;
  static const double radius = 12;
  static const double radiusMd = 16;
  static const double radiusLg = 24;
  static const double radiusFull = 999;

  // Icons
  static const double iconSm = 16;
  static const double icon = 20;
  static const double iconMd = 24;
  static const double iconLg = 32;

  // Controls
  static const double buttonHeight = 52;
  static const double buttonHeightSm = 44;
  static const double inputHeight = 52;

  // Misc
  static const double avatar = 44;
  static const double logo = 96;
  static const double loader = 24;

  // Loader
  static const double loaderSizeXs = 12.0;
  static const double loaderSizeSm = 24.0;
  static const double loaderSize = 34.0;
}
