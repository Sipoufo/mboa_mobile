import 'package:flutter/material.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// One option in a [MboaSegmentedControl].
class MboaSegment<T> {
  const MboaSegment({required this.value, required this.label});

  final T value;
  final String label;
}

/// A pill-style segmented control (single choice) — e.g. the PRESTATAIRE /
/// AGENT role picker, or the Statut / Identification tab switch.
///
/// The selected pill defaults to a solid brand fill; pass [selectedColor] /
/// [selectedTextColor] for the white-on-mint tab style.
class MboaSegmentedControl<T> extends StatelessWidget {
  const MboaSegmentedControl({
    super.key,
    required this.segments,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.selectedColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.backgroundColor,
  });

  final List<MboaSegment<T>> segments;
  final T value;
  final ValueChanged<T> onChanged;
  final bool enabled;
  final Color? selectedColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    return Container(
      padding: const EdgeInsets.all(Dimens.spacingXs),
      decoration: BoxDecoration(
        color: backgroundColor ?? colors.surfaceWarm,
        borderRadius: BorderRadius.circular(Dimens.radiusMd),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        children: [
          for (final segment in segments)
            Expanded(
              child: _Segment<T>(
                segment: segment,
                selected: segment.value == value,
                selectedColor: selectedColor ?? colors.primary,
                selectedTextColor: selectedTextColor ?? colors.onBrand,
                unselectedTextColor: unselectedTextColor ?? colors.textSecondary,
                onTap: enabled ? () => onChanged(segment.value) : null,
              ),
            ),
        ],
      ),
    );
  }
}

class _Segment<T> extends StatelessWidget {
  const _Segment({
    required this.segment,
    required this.selected,
    required this.selectedColor,
    required this.selectedTextColor,
    required this.unselectedTextColor,
    required this.onTap,
  });

  final MboaSegment<T> segment;
  final bool selected;
  final Color selectedColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(vertical: Dimens.spacingMd),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? selectedColor : Colors.transparent,
          borderRadius: BorderRadius.circular(Dimens.radius),
        ),
        child: Text(
          segment.label,
          style: context.mboaText.label.copyWith(
            fontWeight: FontWeight.w700,
            color: selected ? selectedTextColor : unselectedTextColor,
          ),
        ),
      ),
    );
  }
}
