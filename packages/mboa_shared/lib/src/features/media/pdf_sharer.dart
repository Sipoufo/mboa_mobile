import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// What actually opens the share sheet — the real one unless a test says
/// otherwise.
typedef ShareFiles = Future<void> Function(List<XFile> files, Rect origin);

Future<void> _shareWithPlugin(List<XFile> files, Rect origin) =>
    Share.shareXFiles(files, sharePositionOrigin: origin);

/// Hands a PDF to the operating system: written to the cache and offered on
/// the share sheet, which is where saving to Files, printing and sending live
/// on a phone. Nothing in the app opens a browser.
///
/// [shareLink] fetches a short-lived storage link (a receipt, a contract)
/// through a bare [Dio] — never [DioClient]'s, so the app's token does not
/// travel to the storage host.
class PdfSharer {
  PdfSharer({Dio? client, ShareFiles? share, Future<Directory> Function()? tempDir})
      : _client = client,
        _share = share ?? _shareWithPlugin,
        _tempDir = tempDir ?? getTemporaryDirectory;

  final Dio? _client;
  final ShareFiles _share;
  final Future<Directory> Function() _tempDir;

  /// Downloads [url] and offers it as `[name].pdf` — [name] is what the user
  /// sees, so it says what the document is, not an id.
  Future<void> shareLink(String url, {required String name}) async {
    final Response<List<int>> response;
    try {
      response = await (_client ?? Dio()).get<List<int>>(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
    } on DioException catch (error) {
      throw PdfDownloadFailed.from(url, error);
    }
    final bytes = response.data;
    if (bytes == null || bytes.isEmpty) throw StateError('empty PDF at the link');
    await shareBytes(Uint8List.fromList(bytes), name: name);
  }

  Future<void> shareBytes(Uint8List bytes, {required String name}) =>
      shareFile(bytes, name: name, extension: 'pdf', mimeType: 'application/pdf');

  /// Any document the same way — the register's CSV (RM-M25-05), say.
  Future<void> shareFile(
    Uint8List bytes, {
    required String name,
    required String extension,
    required String mimeType,
  }) async {
    final dir = await _tempDir();
    final file = File('${dir.path}/${_safe(name)}.$extension');
    await file.writeAsBytes(bytes, flush: true);
    await _share([XFile(file.path, mimeType: mimeType)], origin());
  }

  /// Where the sheet hangs from. iOS refuses a share without one — a zero
  /// rect included — so every PDF and CSV failed to open there while Android
  /// shared them fine. Sharing is asked from blocs, which hold no widget to
  /// point at: the bottom centre of the screen, where the action bars that
  /// offer it sit, is inside the view on any phone or tablet.
  static Rect origin() {
    final views = WidgetsBinding.instance.platformDispatcher.views;
    if (views.isEmpty) return const Rect.fromLTWH(0, 0, 1, 1);
    final view = views.first;
    final size = view.physicalSize / view.devicePixelRatio;
    return Rect.fromLTWH(size.width / 2, size.height - 1, 1, 1);
  }

  /// A file name, not a path: no separators, no reserved characters.
  static String _safe(String name) {
    final cleaned = name.replaceAll(RegExp(r'[\\/:*?"<>|]+'), '-').trim();
    return cleaned.isEmpty ? 'document' : cleaned;
  }
}

/// Storage refused the link. Says what storage said — its status, its error
/// code (« NoSuchKey », « AccessDenied »…) and where the link pointed,
/// without the signature — so a report can tell a missing file from an
/// expired or wrong link.
class PdfDownloadFailed implements Exception {
  const PdfDownloadFailed({this.status, this.storageCode, required this.where});

  factory PdfDownloadFailed.from(String url, DioException error) {
    final data = error.response?.data;
    final body = data is List<int> ? utf8.decode(data, allowMalformed: true) : '$data';
    final uri = Uri.tryParse(url);
    return PdfDownloadFailed(
      status: error.response?.statusCode,
      storageCode: RegExp('<Code>([^<]+)</Code>').firstMatch(body)?.group(1),
      where: uri == null ? '?' : '${uri.host}${uri.path}',
    );
  }

  final int? status;
  final String? storageCode;
  final String where;

  @override
  String toString() => 'PdfDownloadFailed(status: $status, code: $storageCode, at: $where)';
}
