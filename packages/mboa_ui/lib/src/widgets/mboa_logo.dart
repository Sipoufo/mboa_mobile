import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Which colour treatment of the brand logo to render.
enum MboaLogoVariant {
  /// Full-colour logo — for light surfaces.
  color,

  /// White logo — for brand/dark surfaces (e.g. the forest-green auth hero).
  white,

  /// Black logo — for monochrome contexts.
  black,
}

/// The Mboa brand logo, loaded from the shared `mboa_ui` asset bundle.
///
/// Because the asset ships inside this package, consumers reference it through
/// the `package:` mechanism — callers just use [MboaLogo] and never touch the
/// asset path.
class MboaLogo extends StatelessWidget {
  const MboaLogo({
    this.size = 96,
    this.variant = MboaLogoVariant.color,
    super.key,
  });

  final double size;
  final MboaLogoVariant variant;

  static const String _package = 'mboa_ui';

  String get _asset => switch (variant) {
        MboaLogoVariant.color => 'assets/images/logos/mboa-logo-full-color.svg',
        MboaLogoVariant.white => 'assets/images/logos/mboa-logo-full-white.svg',
        MboaLogoVariant.black => 'assets/images/logos/mboa-logo-full-black.svg',
      };

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      _asset,
      package: _package,
      width: size,
      height: size,
      semanticsLabel: 'Mboa',
    );
  }
}
