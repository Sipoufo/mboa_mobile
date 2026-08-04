import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// A rounded avatar that shows a network [imageUrl] when available and falls
/// back to [initials] (or a person icon). Optionally overlays a small camera
/// edit badge; the badge is tappable only when [onEdit] is provided.
class MboaAvatar extends StatelessWidget {
  const MboaAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.size = 96,
    this.onEdit,
    this.showEditBadge = false,
  });

  final String? imageUrl;
  final String? initials;
  final double size;
  final VoidCallback? onEdit;
  final bool showEditBadge;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: size,
            height: size,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: colors.primaryPale,
              borderRadius: BorderRadius.circular(Dimens.radiusMd),
            ),
            child: _buildImage(context, colors),
          ),
          if (showEditBadge)
            Positioned(
              // Kept inside the avatar's box so the badge stays hit-testable
              // (a negative offset would overflow the parent and drop taps).
              right: -10,
              bottom: -10,
              child: Opacity(
                opacity: onEdit != null ? 1 : 0.5,
                child: Material(
                  color: colors.primary,
                  shape: const CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: onEdit,
                    child: Padding(
                      padding: const EdgeInsets.all(Dimens.spacingSm),
                      child: Icon(LucideIcons.scan, color: colors.onBrand, size: Dimens.icon),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context, MboaColorScheme colors) {
    final url = imageUrl;
    if (url != null && url.isNotEmpty) {
      return Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (context, _, _) => _placeholder(context, colors),
      );
    }
    return _placeholder(context, colors);
  }

  Widget _placeholder(BuildContext context, MboaColorScheme colors) {
    final text = initials?.trim();
    return Center(
      child: text != null && text.isNotEmpty
          ? Text(
              text,
              style: context.mboaText.h1.copyWith(color: colors.primary),
            )
          : Icon(LucideIcons.user, color: colors.primary, size: size * 0.4),
    );
  }
}
