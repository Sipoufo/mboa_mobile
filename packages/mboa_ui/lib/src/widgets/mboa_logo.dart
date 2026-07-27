import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// The Mboa brand logo, loaded from the shared `mboa_ui` asset bundle.
///
/// Because the asset ships inside this package, consumers reference it through
/// the `package:` mechanism — callers just use [MboaLogo] and never touch the
/// asset path.
class MboaLogo extends StatelessWidget {
  const MboaLogo({this.size = 96, super.key});

  final double size;

  static const String _asset = 'assets/images/logos/mboa-logo-full-color.svg';
  static const String _package = 'mboa_ui';

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
