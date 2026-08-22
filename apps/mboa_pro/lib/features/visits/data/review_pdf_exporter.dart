import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Hands a generated PDF to the operating system (RM-M07bis-06).
///
/// The endpoint answers with bytes, not a link, so there is nothing to open in
/// a browser: the file is written to the cache and passed to the share sheet,
/// which is where printing, saving to Files and sending live on a phone. Split
/// out of the bloc so the bloc stays testable without a device.
class ReviewPdfExporter {
  const ReviewPdfExporter();

  /// Writes [bytes] and offers them. [name] becomes the file name the user
  /// sees, so it carries the property rather than an id.
  Future<void> share(Uint8List bytes, {required String name}) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$name.pdf');
    await file.writeAsBytes(bytes, flush: true);

    await Share.shareXFiles([XFile(file.path, mimeType: 'application/pdf')]);
  }
}
