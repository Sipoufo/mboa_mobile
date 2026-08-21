import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Loads the real brand fonts into the test binding.
///
/// Without this, widget tests render every glyph in Ahem, which makes goldens
/// useless as a visual check. Font files live in `mboa_ui`, resolved through the
/// workspace's package layout — and the icon font in the pub cache, since
/// icons drawn as empty boxes make a golden lie about a screen built of them.
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

  await _loadLucide();

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

/// The icon font ships inside `lucide_icons_flutter`, not in this repo.
///
/// Its path comes from the package config rather than a guessed pub-cache
/// layout, which differs between machines and CI. The config lives at the
/// **workspace root**, not in the app — this is a pub workspace — so the walk
/// upwards is the point.
Future<void> _loadLucide() async {
  File? config;
  for (var dir = Directory.current; ; dir = dir.parent) {
    final candidate = File('${dir.path}/.dart_tool/package_config.json');
    if (candidate.existsSync()) {
      config = candidate;
      break;
    }
    if (dir.path == dir.parent.path) break;
  }
  if (config == null) return;

  final packages = (jsonDecode(config.readAsStringSync()) as Map<String, dynamic>)['packages'] as List<dynamic>;
  final entry = packages.cast<Map<String, dynamic>>().firstWhere(
    (p) => p['name'] == 'lucide_icons_flutter',
    orElse: () => const <String, dynamic>{},
  );
  final rootUri = entry['rootUri'] as String?;
  if (rootUri == null) return;

  final root = rootUri.startsWith('file://')
      ? Uri.parse(rootUri).toFilePath()
      : Directory('${config.parent.path}/$rootUri').absolute.path;

  final font = File('$root/assets/lucide.ttf');
  if (!font.existsSync()) return;

  final loader = FontLoader('packages/lucide_icons_flutter/Lucide')
    ..addFont(font.readAsBytes().then((b) => ByteData.view(b.buffer)));
  await loader.load();
}
