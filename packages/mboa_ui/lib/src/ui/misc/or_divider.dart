import 'package:flutter/material.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// A horizontal rule with a centred [label] — the "Ou" separator between the
/// primary action and the social sign-in row.
///
/// Presentational only: the caller supplies the (localised) [label].
class OrDivider extends StatelessWidget {
  const OrDivider({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final line = Expanded(child: Divider(color: colors.border, thickness: 1));

    return Row(
      children: [
        line,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing),
          child: Text(
            label,
            style: context.mboaText.caption.copyWith(color: colors.textSecondary),
          ),
        ),
        line,
      ],
    );
  }
}
