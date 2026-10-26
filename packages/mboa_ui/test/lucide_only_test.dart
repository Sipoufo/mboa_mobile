import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Every icon in the apps is Lucide's (project rule). Material's `Icons.*`
/// draw fine on a phone, which is how four of them went unnoticed — and as an
/// empty box in a golden, which is how they were found. This walks the
/// hand-written sources so the next one fails here instead.
void main() {
  test('no Material icon in the apps or the shared packages', () {
    final root = Directory.current.parent.parent; // packages/mboa_ui → mobile/
    final sources = [
      for (final dir in [
        'apps/mboa_user/lib',
        'apps/mboa_pro/lib',
        'packages/mboa_ui/lib',
        'packages/mboa_shared/lib',
        'packages/mboa_core/lib',
      ])
        ...Directory('${root.path}/$dir')
            .listSync(recursive: true)
            .whereType<File>()
            .where((f) => f.path.endsWith('.dart') && !f.path.endsWith('.g.dart') && !f.path.endsWith('.gr.dart')),
    ];
    // `Icons.x`, but not `LucideIcons.x` or `CupertinoIcons.x`.
    final material = RegExp(r'(?<![A-Za-z_])Icons\.[a-z]');

    final found = [
      for (final file in sources)
        for (final (i, line) in file.readAsLinesSync().indexed)
          if (material.hasMatch(line)) '${file.path.substring(root.path.length + 1)}:${i + 1}: ${line.trim()}',
    ];

    expect(sources, isNotEmpty, reason: 'the walk found no source — wrong root?');
    expect(found, isEmpty);
  });
}
