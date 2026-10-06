import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Which colour treatment of the brand logo to render.
enum MboaLogoVariant {
  /// Vert Forêt — the default, for light surfaces.
  color,

  /// White — for the brand's own green, and over photographs.
  white,

  /// Near-black — print and monochrome contexts.
  black,
}

/// Which mark to draw (Brandbook v2 §02).
enum MboaLogoLockup {
  /// The full word. **Preferred wherever it fits** — the monogram never
  /// replaces it when there is room for the whole word.
  wordmark,

  /// "Mboa Pro", the provider app's lockup from the brand architecture.
  pro,

  /// The M alone — two gables, two homes side by side. For app icons,
  /// avatars and places too small for the word.
  monogram,
}

/// The Mboa logo, from the shared `mboa_ui` asset bundle.
///
/// **Sized by height, not by a square.** The wordmark is 3.4 times wider than
/// it is tall and "Mboa Pro" 4.2 times; a single `size` driving both axes
/// either distorts the mark or leaves it floating in a box most of which is
/// empty. Height is what a line of brand furniture is laid out against, and
/// the width follows from the drawing.
class MboaLogo extends StatelessWidget {
  const MboaLogo({
    this.height = 32,
    this.variant = MboaLogoVariant.color,
    this.lockup = MboaLogoLockup.wordmark,
    super.key,
  });

  /// Cap height of the mark. The brandbook's minimums are widths — 80px for
  /// the wordmark, 32px for the icon — which land at roughly 24 and 32 here.
  final double height;

  final MboaLogoVariant variant;
  final MboaLogoLockup lockup;

  static const String _package = 'mboa_ui';
  static const String _path = 'assets/images/logos';

  /// Width ÷ height of each drawing, from its own viewBox.
  double get _aspect => switch (lockup) {
        MboaLogoLockup.wordmark => 356 / 103.5,
        MboaLogoLockup.pro => 488 / 117,
        MboaLogoLockup.monogram => 104 / 102,
      };

  String get _asset => switch ((lockup, variant)) {
        (MboaLogoLockup.monogram, MboaLogoVariant.white) =>
          '$_path/mboa-icon-white.svg',
        (MboaLogoLockup.monogram, MboaLogoVariant.black) =>
          '$_path/mboa-icon-black.svg',
        (MboaLogoLockup.monogram, _) => '$_path/mboa-icon-color.svg',
        // The Pro lockup ships in two treatments only; black falls back to the
        // green one rather than drawing nothing.
        (MboaLogoLockup.pro, MboaLogoVariant.white) =>
          '$_path/mboa-logo-pro-white.svg',
        (MboaLogoLockup.pro, _) => '$_path/mboa-logo-pro-color.svg',
        (_, MboaLogoVariant.white) => '$_path/mboa-logo-full-white.svg',
        (_, MboaLogoVariant.black) => '$_path/mboa-logo-full-black.svg',
        (_, _) => '$_path/mboa-logo-full-color.svg',
      };

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
        _asset,
        package: _package,
        height: height,
        width: height * _aspect,
        semanticsLabel: lockup == MboaLogoLockup.pro ? 'Mboa Pro' : 'Mboa',
      );
}
