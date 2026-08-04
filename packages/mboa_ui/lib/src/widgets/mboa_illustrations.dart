import 'package:flutter/widgets.dart';

/// The Mboa brand illustrations, loaded from the shared `mboa_ui` asset bundle.
///
/// Because the asset ships inside this package, consumers reference it through
/// the `package:` mechanism — callers just use [MboaIllustrations] and never touch the
/// asset path.

class MboaIllustrations {
  static const String _illustrationPath = 'assets/images/illustrations';
  static const String _package = 'mboa_ui';

  static Widget illustration1({double? size}) {
    return Image.asset(
      '$_illustrationPath/illustration_1.png',
      package: _package,
      width: size,
      height: size,
    );
  }

  static Widget illustration2({double? size, BoxFit? fit}) {
    return Image.asset(
      '$_illustrationPath/illustration_2.png',
      package: _package,
      width: size,
      height: size,
      fit: fit,
    );
  }

  /// Mint wave graphic used as the watermark background of profile cards.
  static Widget illustration3({double? width, double? height, BoxFit? fit, Alignment? alignment}) {
    return Image.asset(
      '$_illustrationPath/illustration_3.png',
      package: _package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment ?? Alignment.center,
    );
  }
}
