import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Loads the real brand fonts into the test binding.
///
/// Without this, widget tests render every glyph in Ahem, which makes goldens
/// useless as a visual check. Font files live in `mboa_ui`, resolved through the
/// workspace's package layout.
Future<void> loadBrandFonts() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Package-bundled fonts are registered under `packages/<pkg>/<family>`, and
  // FontLoader's family must match exactly what the theme asks for.
  const families = {
    'packages/mboa_ui/PlusJakartaSans': [
      'PlusJakartaSans-SemiBold.ttf',
      'PlusJakartaSans-Bold.ttf',
      'PlusJakartaSans-ExtraBold.ttf',
    ],
    'packages/mboa_ui/Inter': [
      'Inter-Regular.ttf',
      'Inter-Medium.ttf',
      'Inter-SemiBold.ttf',
    ],
  };

  final root = Directory.current.path;
  for (final entry in families.entries) {
    final loader = FontLoader(entry.key);
    var loaded = false;

    for (final file in entry.value) {
      final path = '$root/../../packages/mboa_ui/assets/fonts/$file';
      final handle = File(path);
      if (!handle.existsSync()) continue;
      loader.addFont(
        handle.readAsBytes().then((b) => ByteData.view(b.buffer)),
      );
      loaded = true;
    }

    if (loaded) await loader.load();
  }
}
