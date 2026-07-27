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
}
