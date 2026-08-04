import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// A mint, rounded tappable card for the profile / settings surfaces.
///
/// Layout matches the design: an icon chip + [title] on the top row, optional
/// [child] (e.g. a prominent name) and [subtitle] below, a down-right arrow in
/// the bottom-right corner, and an optional [background] watermark.
class MboaActionCard extends StatelessWidget {
  const MboaActionCard({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.child,
    this.onTap,
    this.trailing,
    this.enabled = true,
  });

  final IconData icon;
  final String title;
  final String? subtitle;

  /// Extra content rendered under the title row (e.g. a prominent name).
  final Widget? child;

  final VoidCallback? onTap;

  /// Bottom-right affordance; defaults to a down-right arrow.
  final Widget? trailing;

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Material(
        color: colors.primaryLight2,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: enabled ? onTap : null,
          child: Stack(
            children: [
              Positioned.fill(
                child: FittedBox(
                  fit: BoxFit.cover,
                  alignment: Alignment.topRight,
                  clipBehavior: Clip.hardEdge,
                  child: MboaIllustrations.illustration3(),
                ),
              ),
              Container(
                height: 180.0,
                padding: const EdgeInsets.all(Dimens.spacingLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(icon, color: colors.primary, size: Dimens.iconMd),
                        const SizedBox(width: Dimens.spacing),
                        Flexible(
                          child: Text(
                            title,
                            style: context.mboaText.h3.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (child != null) ...[
                      const SizedBox(height: Dimens.spacingMd),
                      child!,
                    ],
                    if (subtitle != null) ...[
                      const SizedBox(height: Dimens.spacingSm),
                      Padding(
                        padding: const EdgeInsets.only(right: Dimens.spacingXl),
                        child: Text(
                          subtitle!,
                          style: context.mboaText.bodyLarge,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Positioned(
                right: Dimens.spacingLg,
                bottom: Dimens.spacingLg,
                child: trailing ??
                    Icon(LucideIcons.arrowDownRight, color: colors.primary, size: Dimens.iconMd),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
