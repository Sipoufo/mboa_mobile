import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:mboa_ui/mboa_ui.dart';

/// A photo read from Cloudflare R2, cached on disk.
///
/// Every listing photo goes through here rather than `Image.network`, which
/// keeps nothing: swiping a carousel back and forth re-downloaded each frame,
/// and every rebuild flashed empty before the bytes arrived again. Doc 13 puts
/// `cached_network_image` in the stack for exactly this.
///
/// A missing photo and a photo that fails to load render the same pale
/// placeholder (CE-M05-02) — a broken frame tells the reader nothing, and an R2
/// key can be stale for reasons the app cannot fix.
class MboaNetworkImage extends StatelessWidget {
  const MboaNetworkImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.placeholder,
  });

  final String? url;
  final BoxFit fit;
  final double? width;
  final double? height;

  /// Shown while loading, on failure, and when [url] is null or empty — one
  /// widget for the three, so the box never changes shape under the reader.
  final Widget? placeholder;

  /// Files [bytes] as what [url] serves, in the cache every
  /// [MboaNetworkImage] reads first.
  ///
  /// For a photo this phone has just uploaded: the public R2 host takes
  /// seconds per image and is never cached at the edge, so fetching it back
  /// left the thumbnail on its placeholder while the reader wondered whether
  /// it had been sent at all.
  static Future<void> remember(String url, Uint8List bytes) =>
      DefaultCacheManager().putFile(url, bytes, fileExtension: 'jpg');

  @override
  Widget build(BuildContext context) {
    final fallback = placeholder ?? MboaImagePlaceholder(size: height);
    final source = url;
    if (source == null || source.isEmpty) return fallback;

    return CachedNetworkImage(
      imageUrl: source,
      fit: fit,
      width: width,
      height: height,
      fadeInDuration: const Duration(milliseconds: 150),
      placeholder: (_, _) => fallback,
      errorWidget: (_, _, _) => fallback,
    );
  }
}

/// The pale block behind a photo that is loading, missing or unreachable.
class MboaImagePlaceholder extends StatelessWidget {
  const MboaImagePlaceholder({super.key, this.size});

  final double? size;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return ColoredBox(
      color: colors.primaryPale,
      child: Center(
        child: Icon(
          LucideIcons.image,
          color: colors.primary,
          // Small thumbnails cannot carry the default icon.
          size: size != null && size! < 120 ? Dimens.icon : Dimens.iconLg,
        ),
      ),
    );
  }
}
