import 'package:flutter/material.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// One slot in [ProBottomNav].
class ProBottomNavItem {
  const ProBottomNavItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

/// Pro bottom navigation: the selected slot lifts into a filled brand disc with
/// its label underneath, the others stay as flat outline icons.
class ProBottomNav extends StatelessWidget {
  const ProBottomNav({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTap,
  });

  final List<ProBottomNavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  static const double _discSize = 48;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Material(
      color: colors.surface,
      elevation: 8,
      shadowColor: colors.ink.withValues(alpha: 0.08),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 76,
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: _NavSlot(
                    item: items[i],
                    isSelected: i == selectedIndex,
                    onTap: () => onTap(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavSlot extends StatelessWidget {
  const _NavSlot({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final ProBottomNavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Semantics(
      button: true,
      selected: isSelected,
      label: item.label,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              width: ProBottomNav._discSize,
              height: ProBottomNav._discSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? colors.primaryDark : Colors.transparent,
              ),
              child: Icon(
                item.icon,
                size: Dimens.iconMd,
                color: isSelected ? colors.onBrand : colors.primary,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(height: Dimens.spacingXs),
              Text(
                item.label,
                style: context.mboaText.caption.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
