import 'package:flutter/material.dart';

import 'mboa_logo.dart';

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
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: backgroundColor ?? theme.colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  logo ?? const MboaLogo(size: 120),
                  if (showProgress) ...[
                    const SizedBox(height: 32),
                    const SizedBox.square(
                      dimension: 24,
                      child: CircularProgressIndicator(strokeWidth: 2.5),
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
    );
  }
}
