import 'package:flutter/material.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// The two brand treatments the Pro home cards use.
enum HomeCtaTone { light, dark }

/// A brand call-to-action card from the Pro home design: tinted panel, floating
/// decorative discs, glyph, copy, and an outlined pill action.
class HomeCtaCard extends StatelessWidget {
  const HomeCtaCard({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    required this.actionLabel,
    required this.onPressed,
    this.tone = HomeCtaTone.light,
  });

  final IconData icon;
  final String title;
  final String body;
  final String actionLabel;
  final VoidCallback onPressed;
  final HomeCtaTone tone;

  static const double width = 232;
  static const double height = 268;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final background =
        tone == HomeCtaTone.dark ? colors.primary : colors.primaryLight;

    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _DiscPainter(color: colors.onBrand),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimens.spacing),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(Dimens.spacingSm),
                          decoration: BoxDecoration(
                            color: colors.primaryDark,
                            borderRadius:
                                BorderRadius.circular(Dimens.radiusSm),
                          ),
                          child: Icon(
                            icon,
                            size: Dimens.icon,
                            color: colors.onBrand,
                          ),
                        ),
                        const SizedBox(width: Dimens.spacingSm),
                        Expanded(
                          child: Text(
                            title,
                            style: context.mboaText.h3
                                .copyWith(color: colors.onBrand),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimens.spacingMd),
                    Expanded(
                      child: Text(
                        body,
                        style: context.mboaText.caption.copyWith(
                          color: colors.onBrand,
                          height: 1.5,
                        ),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: Dimens.spacingMd),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: onPressed,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: colors.onBrand,
                          side: BorderSide(color: colors.onBrand),
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(
                            vertical: Dimens.spacingMd,
                          ),
                        ),
                        child: Text(
                          actionLabel,
                          style: context.mboaText.label
                              .copyWith(color: colors.onBrand),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The three translucent discs in the card's top-right, per the design assets.
class _DiscPainter extends CustomPainter {
  const _DiscPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color.withValues(alpha: 0.12);

    canvas.drawCircle(Offset(size.width * 0.86, size.height * 0.22), 82, paint);
    canvas.drawCircle(Offset(size.width * 0.42, size.height * 0.06), 12, paint);
    canvas.drawCircle(Offset(size.width * 0.78, size.height * 0.58), 20, paint);
  }

  @override
  bool shouldRepaint(_DiscPainter oldDelegate) => oldDelegate.color != color;
}
