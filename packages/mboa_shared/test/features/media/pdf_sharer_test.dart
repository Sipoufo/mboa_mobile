import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:share_plus/share_plus.dart';

/// Regression: iOS refused every share — receipts, contracts, the register's
/// CSV — with « sharePositionOrigin: argument must be set » ({{0, 0}, {0, 0}}
/// must be non-zero and within the source view). Android shared them fine.
void main() {
  testWidgets('the share sheet hangs from a point inside the screen, never from nothing', (tester) async {
    tester.view.physicalSize = const Size(402 * 3, 874 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final shared = <(List<XFile>, Rect)>[];
    await tester.runAsync(() async {
      final dir = await Directory.systemTemp.createTemp('pdf_sharer_test');
      addTearDown(() => dir.delete(recursive: true));
      final sharer = PdfSharer(
        share: (files, origin) async => shared.add((files, origin)),
        tempDir: () async => dir,
      );

      await sharer.shareBytes(Uint8List.fromList([0x25, 0x50, 0x44, 0x46]), name: 'Quittance — octobre');
    });

    final (files, origin) = shared.single;
    expect(files.single.path, endsWith('Quittance — octobre.pdf'));
    expect(origin.isEmpty, isFalse);
    expect(const Rect.fromLTWH(0, 0, 402, 874).contains(origin.topLeft), isTrue);
  });
}
