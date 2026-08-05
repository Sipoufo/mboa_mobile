import 'package:flutter/material.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// Gives a non-text field the same chrome as [Input]'s underline variant:
/// label above in the secondary colour, content on a 1px underline.
///
/// The dropdown, location and availability fields previously used raw Material
/// decoration, so they sat visibly apart from the text fields on the same form.
class FormFieldShell extends StatelessWidget {
  const FormFieldShell({
    super.key,
    required this.label,
    required this.child,
    this.trailing,
    this.onTap,
  });

  final String label;
  final Widget child;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.mboaText.label.copyWith(
            fontWeight: FontWeight.w400,
            color: colors.textSecondary,
          ),
        ),
        const SizedBox(height: Dimens.spacingXs),
        InkWell(
          onTap: onTap,
          child: Container(
            // Matches Input's underline contentPadding so fields line up.
            padding: const EdgeInsets.symmetric(vertical: Dimens.spacingMd),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: colors.border)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: DefaultTextStyle(
                    style: context.mboaText.label
                        .copyWith(fontWeight: FontWeight.w500),
                    child: child,
                  ),
                ),
                ?trailing,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
