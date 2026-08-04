import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// A compact mint list row: a circular icon chip, a [title] with an optional
/// [subtitle], and a trailing affordance. Used for the KYC certification rows.
class MboaTileCard extends StatelessWidget {
  const MboaTileCard({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.subtitleColor,
    this.onTap,
    this.trailing,
    this.enabled = true,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? subtitleColor;
  final VoidCallback? onTap;
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
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacingLg),
            child: Row(
              children: [
                Container(
                  width: Dimens.avatar,
                  height: Dimens.avatar,
                  decoration: BoxDecoration(
                    color: colors.primaryLight.withValues(alpha: 0.35),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: colors.primaryDark, size: Dimens.iconMd),
                ),
                const SizedBox(width: Dimens.spacing),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: context.mboaText.h3.copyWith(
                          color: colors.primaryDark,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: Dimens.spacingXs),
                        Text(
                          subtitle!,
                          style: context.mboaText.body.copyWith(
                            color: subtitleColor ?? colors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: Dimens.spacingSm),
                trailing ??
                    Icon(LucideIcons.arrowDownRight, color: colors.primary, size: Dimens.iconMd),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
