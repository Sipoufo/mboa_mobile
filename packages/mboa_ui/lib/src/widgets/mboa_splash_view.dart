import 'package:flutter/material.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// Presentational splash screen shared by both apps.
///
/// Pure UI — no bootstrap logic, routing or DI (those stay per-app in each
/// app's `SplashPage`). Everything is parameterised so each product can restyle
/// it: swap the [logo], set a brand [backgroundColor], toggle the [showProgress]
/// spinner, or add a [footer] (e.g. a version string).
class MboaSplashView extends StatelessWidget {
  const MboaSplashView({
    this.logo,
    this.backgroundColor,
    this.showProgress = true,
    this.footer,
    super.key,
  });

  /// Branding shown centre-screen. Defaults to [MboaLogo].
  final Widget? logo;

  /// Background fill. Defaults to the theme's surface colour.
  final Color? backgroundColor;

  /// Whether to show a loading indicator beneath the logo.
  final bool showProgress;

  /// Optional bottom-aligned widget (version, tagline, partner logo…).
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Scaffold(
      // Vert Forêt and the same wallpaper as the OS-level splash this replaces
      // a frame later, so the hand-off is invisible. It used to be the dark
      // green with the logo in its default green — a green mark on a green
      // ground, all but unreadable.
      backgroundColor: backgroundColor ?? colors.primary,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/illustrations/brand_pattern.png',
            package: 'mboa_ui',
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      logo ??
                          const MboaLogo(
                            height: 52,
                            variant: MboaLogoVariant.white,
                          ),
                      if (showProgress) ...[
                        const SizedBox(height: 32),
                        SizedBox.square(
                          dimension: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: colors.onBrand,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (footer != null)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: footer,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
