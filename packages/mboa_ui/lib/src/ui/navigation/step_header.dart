import 'package:flutter/material.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// The top of one step in a multi-step flow: « Étape 2 sur 3 », the step's
/// question, and a bar of [total] segments, the ones done and the current one
/// in the brand's green.
///
/// [current] counts from 1. [onStepTap], when set, makes the segments of the
/// steps already reached tappable — a correction jumps straight to the step
/// it needs instead of walking through the others.
class MboaStepHeader extends StatelessWidget {
  const MboaStepHeader({
    super.key,
    required this.current,
    required this.total,
    required this.title,
    this.onStepTap,
  }) : assert(current >= 1 && current <= total);

  final int current;
  final int total;
  final String title;
  final ValueChanged<int>? onStepTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            for (var step = 1; step <= total; step++) ...[
              if (step > 1) const SizedBox(width: Dimens.spacingXs),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onStepTap == null || step == current ? null : () => onStepTap!(step),
                  child: Padding(
                    // A taller target than the 4 px it draws.
                    padding: const EdgeInsets.symmetric(vertical: Dimens.spacingSm),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 4,
                      decoration: BoxDecoration(
                        color: step <= current ? colors.primary : colors.border,
                        borderRadius: BorderRadius.circular(Dimens.radiusFull),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
        Text(
          I18n.of(context).commonStepOf(current, total),
          style: context.mboaText.caption.copyWith(color: colors.textSecondary, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: Dimens.spacingXs),
        Text(title, style: context.mboaText.h3.copyWith(color: colors.ink)),
      ],
    );
  }
}
