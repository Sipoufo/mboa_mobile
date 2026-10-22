import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// The home's nudges — what waits on the prestataire (requests to answer,
/// payments to confirm, tenants' requests): an icon, what waits, the action.
/// One shape for all, so they read as one family.
class HomeNudgeCard extends StatelessWidget {
  const HomeNudgeCard({
    super.key,
    required this.icon,
    required this.text,
    required this.action,
    required this.onTap,
  });

  final IconData icon;
  final String text;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.spacingLg),
      child: Material(
        color: colors.primaryPale,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
        child: InkWell(
          borderRadius: BorderRadius.circular(Dimens.radiusLg),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacing),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(color: colors.primary, shape: BoxShape.circle),
                  child: Icon(icon, color: colors.onBrand, size: Dimens.icon),
                ),
                const SizedBox(width: Dimens.spacingMd),
                Expanded(
                  child: Text(text, style: context.mboaText.label.copyWith(color: colors.primaryDark)),
                ),
                const SizedBox(width: Dimens.spacingSm),
                Text(
                  action,
                  style: context.mboaText.label.copyWith(color: colors.primary, fontWeight: FontWeight.w700),
                ),
                Icon(LucideIcons.chevronRight, size: Dimens.icon, color: colors.primary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
