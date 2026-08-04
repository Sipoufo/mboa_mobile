import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mboa_core/mboa_core.dart';

/// Picks an image (camera/gallery), compresses it per the media rules
/// (JPEG 85%, max 1920×1080) and uploads it to Cloudflare R2 via a per-request
/// presigned URL — returning the stored object key.
///
/// The presigned PUT goes through a bare [Dio] (not [DioClient]) so it does not
/// carry the app's auth interceptor to the external R2 host. Shared by both
/// apps for KYC documents, profile photos, listing photos, …
class MediaUploader {
  MediaUploader({
    required DioClient dioClient,
    Dio? uploadClient,
    ImagePicker? picker,
  })  : _dioClient = dioClient,
        _uploadClient = uploadClient ?? Dio(),
        _picker = picker ?? ImagePicker();

  final DioClient _dioClient;
  final Dio _uploadClient;
  final ImagePicker _picker;

  static const String _contentType = 'image/jpeg';

  /// Returns the uploaded object key, or null if the user cancelled the picker.
  /// Throws on a compression/upload failure.
  Future<String?> captureAndUpload({
    required ImageSource source,
    required CreateUploadRequestCategoryEnum category,
  }) async {
    final picked = await _picker.pickImage(
      source: source,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 90,
    );
    if (picked == null) return null;

    final Uint8List bytes = await FlutterImageCompress.compressWithFile(
          picked.path,
          minWidth: 1920,
          minHeight: 1080,
          quality: 85,
        ) ??
        await picked.readAsBytes();

    final presigned = (await _dioClient.api.getMediaApi().createUpload(
          createUploadRequest: CreateUploadRequest((b) => b
            ..category = category
            ..contentType = _contentType
            ..contentLength = bytes.length),
        ))
        .data;

    final uploadUrl = presigned?.uploadUrl;
    final objectKey = presigned?.objectKey;
    if (uploadUrl == null || objectKey == null) {
      throw StateError('Presigned upload response was incomplete');
    }

    await _uploadClient.requestUri<void>(
      Uri.parse(uploadUrl),
      data: Stream<List<int>>.fromIterable([bytes]),
      options: Options(
        method: presigned?.method ?? 'PUT',
        headers: {
          Headers.contentTypeHeader: _contentType,
          Headers.contentLengthHeader: bytes.length,
        },
      ),
    );

    return objectKey;
  }
}
