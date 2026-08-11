import 'package:flutter/material.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// An info affordance next to a form field's label.
///
/// Tapping opens a bottom sheet rather than a tooltip: a `Tooltip` needs a
/// long-press on touch, advertises nothing, and leaves no room for the two or
/// three sentences these explanations actually need.
class FieldHelp extends StatelessWidget {
  const FieldHelp({super.key, required this.label, required this.text});

  /// The field's label — the sheet's title, so the sheet stands on its own.
  final String label;

  /// The explanation. Comes from the CDC (Doc 10); see the ARB `@` entries.
  final String text;

  static const double _tapTarget = 44;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Semantics(
      button: true,
      label: label,
      child: InkWell(
        onTap: () => _show(context),
        customBorder: const CircleBorder(),
        child: SizedBox(
          // Below this the icon is a coin-toss to hit; the icon itself stays
          // small so the label still reads as the primary element.
          width: _tapTarget,
          height: _tapTarget,
          child: Icon(
            Icons.info_outline,
            size: Dimens.iconSm,
            color: colors.textTertiary,
          ),
        ),
      ),
    );
  }

  void _show(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: context.mboaColors.surface,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusLg)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Dimens.spacing,
            0,
            Dimens.spacing,
            Dimens.spacingLg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: context.mboaText.h3),
              const SizedBox(height: Dimens.spacingSm),
              Text(
                text,
                style: context.mboaText.body.copyWith(
                  color: context.mboaColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
