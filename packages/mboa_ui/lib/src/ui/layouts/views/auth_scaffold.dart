import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// The shared shell for the authentication surfaces (login, OTP, …).
///
/// Renders the brand's forest-green hero — with the white logo by default —
/// and a curved white sheet that slides up over it holding the form [child].
/// The sheet content scrolls, so it stays usable when the keyboard is open.
///
/// Purely presentational: no l10n, no business logic. Each auth screen supplies
/// its own [child] (and optionally a custom [hero]).
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.child,
    this.hero,
    this.onBack,
    this.heroHeightFactor = 0.32,
    this.padding = const EdgeInsets.all(Dimens.spacingLg),
  });

  /// The form content laid out inside the white sheet.
  final Widget child;

  /// Hero content shown on the green area. Defaults to the white brand logo.
  final Widget? hero;

  /// When set, a back arrow is shown in the top-left of the hero.
  final VoidCallback? onBack;

  /// Fraction of the screen height taken by the green hero.
  final double heroHeightFactor;

  /// Padding around [child] inside the sheet.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final heroHeight = MediaQuery.sizeOf(context).height * heroHeightFactor;

    return Scaffold(
      backgroundColor: colors.primary,
      body: Column(
        children: [
          SizedBox(
            height: heroHeight,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Full-bleed brand pattern behind the logo.
                Positioned.fill(
                  child: MboaIllustrations.illustration2(fit: BoxFit.cover),
                ),
                SafeArea(
                  bottom: false,
                  child: Stack(
                    children: [
                      if (onBack != null)
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            onPressed: onBack,
                            icon: Icon(LucideIcons.arrowLeft, color: colors.onBrand),
                          ),
                        ),
                      Center(
                        child: hero ?? const MboaLogo(size: 64, variant: MboaLogoVariant.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl)),
              ),
              child: SafeArea(
                top: false,
                child: SingleChildScrollView(
                  padding: padding,
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
