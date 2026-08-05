import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../models/annonce_draft.dart';

/// The dashed photo area from the creation design.
///
/// Empty it is one large drop target; once there are photos it becomes a strip
/// with an add tile, so the minimum-3 rule stays visible as you go.
class PhotoStrip extends StatelessWidget {
  const PhotoStrip({
    super.key,
    required this.photoKeys,
    required this.onAdd,
    required this.onRemove,
    this.isUploading = false,
  });

  final List<String> photoKeys;
  final VoidCallback onAdd;
  final ValueChanged<String> onRemove;
  final bool isUploading;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final canAdd = photoKeys.length < AnnonceDraft.maxPhotos;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (photoKeys.isEmpty)
          _AddTarget(
            height: 160,
            isUploading: isUploading,
            onTap: canAdd && !isUploading ? onAdd : null,
          )
        else
          SizedBox(
            height: 104,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (final key in photoKeys)
                  _Thumb(key: ValueKey(key), photoKey: key, onRemove: onRemove),
                if (canAdd)
                  _AddTarget(
                    width: 104,
                    height: 104,
                    isUploading: isUploading,
                    onTap: isUploading ? null : onAdd,
                  ),
              ],
            ),
          ),
        const SizedBox(height: Dimens.spacingSm),
        Center(
          child: Text(
            l10n.annonceFormPhotosHint(AnnonceDraft.minPhotos),
            style: context.mboaText.caption.copyWith(
              // Turns neutral once the minimum is met.
              color: photoKeys.length >= AnnonceDraft.minPhotos
                  ? colors.textTertiary
                  : colors.textSecondary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}

class _AddTarget extends StatelessWidget {
  const _AddTarget({
    required this.height,
    required this.isUploading,
    required this.onTap,
    this.width,
  });

  final double height;
  final double? width;
  final bool isUploading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Padding(
      padding: const EdgeInsets.only(right: Dimens.spacingSm),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
        child: DottedBorderBox(
          width: width,
          height: height,
          color: colors.primaryLight,
          background: colors.primaryPale,
          child: Center(
            child: isUploading
                ? const Loader()
                : Icon(
                    LucideIcons.circlePlus,
                    size: Dimens.iconLg,
                    color: colors.primary,
                  ),
          ),
        ),
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  const _Thumb({super.key, required this.photoKey, required this.onRemove});

  final String photoKey;
  final ValueChanged<String> onRemove;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final url = BaseProfile.mediaUrl(photoKey);

    return Padding(
      padding: const EdgeInsets.only(right: Dimens.spacingSm),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.radius),
            child: SizedBox(
              width: 104,
              height: 104,
              child: url == null
                  ? ColoredBox(color: colors.primaryPale)
                  : Image.network(
                      url,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) => ColoredBox(
                        color: colors.primaryPale,
                        child: Icon(LucideIcons.image, color: colors.primary),
                      ),
                    ),
            ),
          ),
          Positioned(
            top: 2,
            right: 2,
            child: InkWell(
              onTap: () => onRemove(photoKey),
              child: CircleAvatar(
                radius: 12,
                backgroundColor: colors.ink.withValues(alpha: 0.6),
                child: Icon(LucideIcons.x, size: 14, color: colors.onBrand),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A dashed-outline container, matching the creation design's photo area.
class DottedBorderBox extends StatelessWidget {
  const DottedBorderBox({
    super.key,
    required this.height,
    required this.color,
    required this.background,
    required this.child,
    this.width,
  });

  final double height;
  final double? width;
  final Color color;
  final Color background;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(color: color, background: background),
      child: SizedBox(width: width, height: height, child: child),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({required this.color, required this.background});

  final Color color;
  final Color background;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(Dimens.radiusLg),
    );
    canvas.drawRRect(rect, Paint()..color = background);

    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Walk the rounded rect and draw alternating dashes.
    final path = Path()..addRRect(rect);
    const dash = 6.0;
    const gap = 5.0;
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final next = (distance + dash).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(distance, next), stroke);
        distance = next + gap;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter old) =>
      old.color != color || old.background != background;
}
