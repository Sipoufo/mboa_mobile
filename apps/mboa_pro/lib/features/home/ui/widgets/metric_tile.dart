import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../models/dashboard_stats.dart';

/// One M14 figure, in whichever of its four states the server put it:
///
///  * **a value** — plainly;
///  * **locked** — blurred decoy + lock, per RM-M14-02 / CA-M14-02. The value
///    is not even in the payload; the upgrade CTA lives once on the card;
///  * **not available yet** — "Bientôt", for everyone, whatever the tier;
///  * **nothing to measure yet** — "—", never a made-up 0.
class MetricTile extends StatelessWidget {
  const MetricTile({
    super.key,
    required this.label,
    required this.figure,
    required this.format,
  });

  final String label;

  /// Null when it was never loaded — read as "Bientôt", like not available.
  final DashboardFigure? figure;
  final String Function(num value) format;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final l10n = I18n.of(context);
    final figure = this.figure;
    final locked = figure?.locked ?? false;

    final String? shown = switch (figure) {
      null || DashboardFigure(available: false) => l10n.homeStatsUnavailable,
      DashboardFigure(value: final value?) => format(value),
      _ => null,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (locked)
          _BlurredValue(
            // Locked values are never sent; the blur sits over a decoy so the
            // tile keeps its shape and the lock reads as "there's data here".
            child: Text('••', style: context.mboaText.h3),
          )
        else
          Text(
            shown ?? l10n.homeStatsNoData,
            style: context.mboaText.h3.copyWith(
              color: figure?.value == null ? colors.textTertiary : colors.ink,
            ),
          ),
        const SizedBox(height: Dimens.spacingXs),
        Row(
          children: [
            if (locked) ...[
              Icon(LucideIcons.lock, size: 12, color: colors.textTertiary),
              const SizedBox(width: Dimens.spacingXs),
            ],
            Flexible(
              child: Text(
                label,
                style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BlurredValue extends StatelessWidget {
  const _BlurredValue({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: ImageFiltered(
        imageFilter: ui.ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: child,
      ),
    );
  }
}
