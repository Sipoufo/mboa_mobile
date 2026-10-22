import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Hands a PDF to the operating system: written to the cache and offered on
/// the share sheet, which is where saving to Files, printing and sending live
/// on a phone. Nothing in the app opens a browser.
///
/// [shareLink] fetches a short-lived storage link (a receipt, a contract)
/// through a bare [Dio] — never [DioClient]'s, so the app's token does not
/// travel to the storage host.
class PdfSharer {
  PdfSharer({Dio? client}) : _client = client;

  final Dio? _client;

  /// Downloads [url] and offers it as `[name].pdf` — [name] is what the user
  /// sees, so it says what the document is, not an id.
  Future<void> shareLink(String url, {required String name}) async {
    final response = await (_client ?? Dio()).get<List<int>>(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    final bytes = response.data;
    if (bytes == null || bytes.isEmpty) throw StateError('empty PDF at the link');
    await shareBytes(Uint8List.fromList(bytes), name: name);
  }

  Future<void> shareBytes(Uint8List bytes, {required String name}) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/${_safe(name)}.pdf');
    await file.writeAsBytes(bytes, flush: true);
    await Share.shareXFiles([XFile(file.path, mimeType: 'application/pdf')]);
  }

  /// A file name, not a path: no separators, no reserved characters.
  static String _safe(String name) {
    final cleaned = name.replaceAll(RegExp(r'[\\/:*?"<>|]+'), '-').trim();
    return cleaned.isEmpty ? 'document' : cleaned;
  }
}
