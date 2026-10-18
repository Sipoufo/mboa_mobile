import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../theme/theme_extensions.dart';

/// A score out of a maximum, as a ring that is never closed.
///
/// The track covers nine tenths of the circle and leaves its gap at twelve
/// o'clock, even full: the Mboa Score's 90 is a ceiling on purpose, "le point
/// parfait n'existe pas" (Doc 10 M09), and the gap is that sentence drawn.
///
/// One colour at every value — no bands, no red/green verdict: the number is
/// a decision aid, not a judgment. The arc animates once on entrance, from
/// its previous value (never back from 0), and not at all when the platform
/// asks for reduced motion.
class MboaScoreRing extends StatelessWidget {
  const MboaScoreRing({
    super.key,
    required this.score,
    required this.max,
    required this.caption,
    required this.semanticsLabel,
    this.size = 168,
    this.stroke = 12,
    this.compact = false,
  });

  final int score;
  final int max;

  /// Under the number — "sur 90".
  final String caption;

  /// What a screen reader says instead of drawing — "Mboa Score : 55 sur 90".
  final String semanticsLabel;
  final double size;
  final double stroke;

  /// The smaller type scale, for a ring inside a sheet.
  final bool compact;

  /// The share of the circle the track covers; the rest is the gap.
  static const double sweepShare = 0.9;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final text = context.mboaText;
    final target = max <= 0 ? 0.0 : (score / max).clamp(0.0, 1.0);
    final duration = MediaQuery.disableAnimationsOf(context) ? Duration.zero : const Duration(milliseconds: 600);
    final inner = size - stroke * 2;

    return Semantics(
      container: true,
      label: semanticsLabel,
      excludeSemantics: true,
      child: SizedBox.square(
        dimension: size,
        child: TweenAnimationBuilder<double>(
          // From 0 on entrance; on a later value, from wherever the arc is.
          tween: Tween(begin: 0, end: target),
          duration: duration,
          curve: Curves.easeOutCubic,
          builder: (context, value, child) => CustomPaint(
            painter: _RingPainter(
              progress: value,
              stroke: stroke,
              track: colors.primaryPale,
              arc: colors.primary,
            ),
            child: child,
          ),
          child: Center(
            child: SizedBox.square(
              dimension: inner * 0.72,
              child: MediaQuery.withClampedTextScaling(
                maxScaleFactor: 1.3,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$score',
                        style: (compact ? text.h2 : text.display).copyWith(
                          color: colors.primary,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                      Text(
                        caption,
                        style: (compact ? text.micro : text.caption).copyWith(color: colors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({required this.progress, required this.stroke, required this.track, required this.arc});

  final double progress;
  final double stroke;
  final Color track;
  final Color arc;

  // The gap is centred on twelve o'clock.
  static const double _sweep = 2 * math.pi * MboaScoreRing.sweepShare;
  static const double _start = -math.pi / 2 + (2 * math.pi - _sweep) / 2;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final circle = rect.deflate(stroke / 2);
    Paint pen(Color color) => Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(circle, _start, _sweep, false, pen(track));
    // At 0, a round cap alone would draw a dot that reads as a point earned.
    if (progress > 0) canvas.drawArc(circle, _start, _sweep * progress, false, pen(arc));
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress || old.stroke != stroke || old.track != track || old.arc != arc;
}
