import 'package:flutter/material.dart';

/// The two shadows the design system uses (Doc 05 §6.2).
///
/// Cards carry [card]; anything that floats over a map or a list carries
/// [floating]. Nothing else casts a shadow — the brand is "pas chargé"
/// (Doc 05 §1.2), and a third depth would start a hierarchy no screen needs.
abstract final class MboaShadows {
  /// `0 2px 12px rgba(0,0,0,0.08)` — a card lifted off the canvas.
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 12,
      offset: Offset(0, 2),
    ),
  ];

  /// Deeper, for what sits over something else: the card on the map.
  static const List<BoxShadow> floating = [
    BoxShadow(
      color: Color(0x1F000000),
      blurRadius: 20,
      offset: Offset(0, 4),
    ),
  ];
}
