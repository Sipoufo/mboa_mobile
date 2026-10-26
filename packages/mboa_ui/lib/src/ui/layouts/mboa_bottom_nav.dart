import 'package:flutter/material.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// One slot in [MboaBottomNav].
class MboaBottomNavItem {
  const MboaBottomNavItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

/// Bottom navigation: the selected slot is a filled brand disc **cradled in a
/// pale-green wave** (the founder's mockup), its label underneath; the others
/// stay flat outline icons.
///
/// The disc and the wave travel together to the tapped slot — one motion that
/// says "you are here" — and simply jump when the platform asks for reduced
/// motion.
///
/// Lives in the design system because both apps carry one — the prestataire's
/// and the tenant's four slots — and two copies would drift apart on the first
/// restyle.
class MboaBottomNav extends StatelessWidget {
  const MboaBottomNav({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTap,
  });

  final List<MboaBottomNavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  static const double _barHeight = 72;
  static const double _discSize = 48;

  /// The disc rises this far above the bar's top edge, as in the mockup.
  static const double _lift = 14;

  /// Where the unselected icons and the label sit, below the edge.
  static const double _iconBand = 46;
  static const Duration _travel = Duration(milliseconds: 320);

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final duration = MediaQuery.disableAnimationsOf(context) ? Duration.zero : _travel;

    return Material(
      color: colors.surface,
      elevation: 8,
      shadowColor: colors.ink.withValues(alpha: 0.08),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: _barHeight,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final slot = constraints.maxWidth / items.length;
              final target = slot * (selectedIndex + 0.5);

              return TweenAnimationBuilder<double>(
                tween: Tween(end: target),
                duration: duration,
                curve: Curves.easeOutCubic,
                builder: (context, centre, _) => Stack(
                  // The disc rises above the bar; nothing else leaves it.
                  clipBehavior: Clip.none,
                  children: [
                    // The wave, behind everything.
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _WavePainter(
                          centre: centre,
                          halfWidth: slot * 0.6,
                          // A belly that shows under the disc, ending above
                          // the label.
                          depth: _discSize - _lift + 10,
                          color: colors.primaryPale,
                        ),
                      ),
                    ),
                    // The slots: icons, labels and the tap targets.
                    Row(
                      children: [
                        for (var i = 0; i < items.length; i++)
                          Expanded(
                            child: _NavSlot(
                              item: items[i],
                              isSelected: i == selectedIndex,
                              onTap: () => onTap(i),
                            ),
                          ),
                      ],
                    ),
                    // The disc, travelling with the wave. Drawn above the slots
                    // but untouchable: the slot under it takes the tap.
                    Positioned(
                      left: centre - _discSize / 2,
                      top: -_lift,
                      child: IgnorePointer(
                        child: ExcludeSemantics(
                          child: Container(
                            width: _discSize,
                            height: _discSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors.primaryDark,
                              boxShadow: [
                                BoxShadow(
                                  color: colors.primaryDark.withValues(alpha: 0.28),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: AnimatedSwitcher(
                              duration: duration,
                              child: Icon(
                                items[selectedIndex].icon,
                                key: ValueKey(selectedIndex),
                                size: Dimens.iconMd,
                                color: colors.onBrand,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NavSlot extends StatelessWidget {
  const _NavSlot({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final MboaBottomNavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Semantics(
      button: true,
      selected: isSelected,
      label: item.label,
      excludeSemantics: true,
      child: InkResponse(
        onTap: onTap,
        // The ripple stays inside the slot; the whole slot is the target
        // (well over 48 × 48).
        containedInkWell: true,
        highlightShape: BoxShape.rectangle,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Column(
          children: [
            SizedBox(
              height: MboaBottomNav._iconBand,
              child: Center(
                // The selected icon is drawn by the travelling disc.
                child: isSelected ? null : Icon(item.icon, size: Dimens.iconMd, color: colors.primary),
              ),
            ),
            // Only the selected slot is named; the others fade out of the tree.
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              child: isSelected
                  ? Text(
                      item.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.mboaText.caption.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

/// A pale bell hanging from the bar's top edge, centred on the selected slot:
/// flared where it meets the edge, round under the disc.
class _WavePainter extends CustomPainter {
  const _WavePainter({
    required this.centre,
    required this.halfWidth,
    required this.depth,
    required this.color,
  });

  final double centre;
  final double halfWidth;
  final double depth;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final left = centre - halfWidth;
    final right = centre + halfWidth;
    // Soft shoulders where it leaves the edge, a round belly under the disc.
    final path = Path()
      ..moveTo(left, 0)
      ..cubicTo(left + halfWidth * 0.35, 0, centre - halfWidth * 0.72, depth, centre, depth)
      ..cubicTo(centre + halfWidth * 0.72, depth, right - halfWidth * 0.35, 0, right, 0)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_WavePainter old) =>
      old.centre != centre || old.halfWidth != halfWidth || old.depth != depth || old.color != color;
}
