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
    this.helpText,
  });

  final String label;
  final Widget child;
  final Widget? trailing;
  final VoidCallback? onTap;

  /// Doc 10's definition of the field, shown behind an info icon on the label.
  final String? helpText;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                label,
                style: context.mboaText.label.copyWith(
                  fontWeight: FontWeight.w400,
                  color: colors.textSecondary,
                ),
              ),
            ),
            if (helpText case final help?) FieldHelp(label: label, text: help),
          ],
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
