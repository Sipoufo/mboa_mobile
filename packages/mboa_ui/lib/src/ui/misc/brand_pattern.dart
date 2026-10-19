import 'dart:math' as math;

import 'package:flutter/material.dart';

/// The splash's field of "M" monograms, as a texture behind a brand surface.
///
/// Drawn, not loaded: the monogram is the logo's own polygon
/// (`mboa-icon-*.svg`, viewBox 104 × 102), so the texture takes any palette
/// colour, stays crisp at any size and shows in a golden. It is a **texture,
/// not an illustration** (Doc 05 §5.2 keeps illustrations for empty states,
/// onboarding and errors): keep it faint — the default 8 % is the splash's own
/// contrast — and only on brand-tinted surfaces, never behind body text that
/// must be read at a glance.
///
/// The placements are fixed, so a card looks the same on every build and the
/// golden of a screen does not flicker.
class MboaBrandPattern extends StatelessWidget {
  const MboaBrandPattern({super.key, required this.color, this.opacity = 0.08, this.scale = 1});

  final Color color;
  final double opacity;

  /// Grows or shrinks every monogram — a small card wants fewer, larger ones.
  final double scale;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
        child: IgnorePointer(
          child: CustomPaint(
            painter: _PatternPainter(color: color.withValues(alpha: opacity), scale: scale),
            size: Size.infinite,
          ),
        ),
      );
}

class _PatternPainter extends CustomPainter {
  const _PatternPainter({required this.color, required this.scale});

  final Color color;
  final double scale;

  /// The logo's polygon, in its own 104-wide units (viewBox "0 -2 104 102").
  static final Path _monogram = Path()
    ..moveTo(0, 100)
    ..lineTo(0, 28)
    ..lineTo(33, -2)
    ..lineTo(52, 60)
    ..lineTo(71, -2)
    ..lineTo(104, 28)
    ..lineTo(104, 100)
    ..lineTo(84, 100)
    ..lineTo(84, 20.42)
    ..lineTo(59.61, 100)
    ..lineTo(44.39, 100)
    ..lineTo(20, 20.42)
    ..lineTo(20, 100)
    ..close();

  /// (x, y) as fractions of the surface, width in logical pixels, tilt in
  /// degrees — the splash's scatter: uneven sizes, a few leaning a little.
  static const List<(double, double, double, double)> _placements = [
    (0.06, 0.08, 34, -6),
    (0.30, 0.02, 22, 4),
    (0.55, 0.12, 40, -3),
    (0.82, 0.04, 26, 7),
    (0.92, 0.30, 36, -8),
    (0.18, 0.34, 28, 5),
    (0.44, 0.40, 18, -4),
    (0.68, 0.46, 30, 3),
    (0.04, 0.60, 24, -2),
    (0.30, 0.66, 38, 6),
    (0.58, 0.74, 22, -7),
    (0.86, 0.70, 32, 2),
    (0.14, 0.90, 30, 4),
    (0.44, 0.94, 26, -5),
    (0.74, 0.96, 36, -1),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    for (final (fx, fy, width, tilt) in _placements) {
      final w = width * scale;
      canvas
        ..save()
        ..translate(fx * size.width, fy * size.height)
        ..rotate(tilt * math.pi / 180)
        ..scale(w / 104)
        ..drawPath(_monogram, paint)
        ..restore();
    }
  }

  @override
  bool shouldRepaint(_PatternPainter old) => old.color != color || old.scale != scale;
}

/// The floating discs of the Pro home's cards (founder's mockup): one large
/// soft disc bleeding off a corner and two small ones — depth without a
/// gradient (Doc 05: "pas de dégradés complexes").
class MboaDecorDiscs extends StatelessWidget {
  const MboaDecorDiscs({super.key, required this.color, this.opacity = 0.14});

  final Color color;
  final double opacity;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
        child: IgnorePointer(
          child: CustomPaint(
            painter: _DiscsPainter(color.withValues(alpha: opacity)),
            size: Size.infinite,
          ),
        ),
      );
}

class _DiscsPainter extends CustomPainter {
  const _DiscsPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    // The big one, two thirds off the top-right corner.
    canvas
      ..drawCircle(Offset(size.width * 0.86, size.height * 0.12), size.width * 0.42, paint)
      // Two small ones, as in the mockup: one near the top, one low right.
      ..drawCircle(Offset(size.width * 0.52, size.height * 0.07), size.width * 0.05, paint)
      ..drawCircle(Offset(size.width * 0.9, size.height * 0.62), size.width * 0.07, paint);
  }

  @override
  bool shouldRepaint(_DiscsPainter old) => old.color != color;
}
