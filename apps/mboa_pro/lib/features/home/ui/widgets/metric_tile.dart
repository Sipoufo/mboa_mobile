import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// One M14 metric, in whichever of its three states applies:
///
///  * **available** — the value, plainly;
///  * **tier-locked** — blurred value + lock, per RM-M14-02 / CA-M14-02. The
///    upgrade CTA lives once on the card, not on every tile;
///  * **unavailable** — the backend exposes no such figure yet, so say so
///    rather than showing a fabricated zero.
class MetricTile extends StatelessWidget {
  const MetricTile({
    super.key,
    required this.label,
    required this.value,
    required this.decision,
  });

  /// Formatted value, or null when there is no data source for it yet.
  final String? value;
  final String label;
  final AccessDecision decision;

  bool get _isTierLocked =>
      decision is AccessDenied &&
      (decision as AccessDenied).restriction == AccessRestriction.tierRequired;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final l10n = I18n.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_isTierLocked)
          _BlurredValue(
            // Locked values are never fetched; the blur sits over a decoy so
            // the tile keeps its shape and the lock reads as "there's data here".
            child: Text('••', style: context.mboaText.h3),
          )
        else
          Text(
            value ?? l10n.homeStatsUnavailable,
            style: context.mboaText.h3.copyWith(
              color: value == null ? colors.textTertiary : colors.ink,
            ),
          ),
        const SizedBox(height: Dimens.spacingXs),
        Row(
          children: [
            if (_isTierLocked) ...[
              Icon(LucideIcons.lock, size: 12, color: colors.textTertiary),
              const SizedBox(width: Dimens.spacingXs),
            ],
            Flexible(
              child: Text(
                label,
                style: context.mboaText.caption
                    .copyWith(color: colors.textSecondary),
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
