import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

import '../homes/models/evidence.dart';

/// Picks photos and makes them ready to send as proof (CDC M30, RM-M30-11):
/// compressed per the media rules (JPEG 85 %, 1920×1080 at most — which also
/// strips EXIF), then fingerprinted on the exact bytes that will travel.
///
/// Storage refuses any content but the one announced (§27.6), so the hash
/// is computed **after** compression, never on the original.
class PhotoPreparer {
  PhotoPreparer({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  /// From the camera, one; from the gallery, up to [limit]. Empty when the
  /// picker was cancelled.
  Future<List<PreparedPhoto>> pick(ImageSource source, {required int limit}) async {
    final picked = source == ImageSource.camera
        ? [?await _picker.pickImage(source: ImageSource.camera, maxWidth: 1920, maxHeight: 1080, imageQuality: 90)]
        : await _picker.pickMultiImage(maxWidth: 1920, maxHeight: 1080, imageQuality: 90, limit: limit > 1 ? limit : null);
    return [
      for (final file in picked.take(limit))
        prepare(
          await FlutterImageCompress.compressWithFile(file.path, minWidth: 1920, minHeight: 1080, quality: 85) ??
              await file.readAsBytes(),
        ),
    ];
  }

  /// The fingerprint storage checks: base64 of the SHA-256 of [bytes].
  static PreparedPhoto prepare(Uint8List bytes) =>
      PreparedPhoto(bytes: bytes, sha256: base64.encode(sha256.convert(bytes).bytes));
}
