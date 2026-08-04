import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// A single circular social sign-in button (Google, Apple, …).
///
/// Presentational only: pass [onPressed] to enable it. When null the button
/// renders in a disabled state — used while the provider SDKs are not yet
/// wired. The brand marks ship with `mboa_ui`, so callers use the named
/// constructors and never touch asset paths.
class SocialAuthButton extends StatelessWidget {
  const SocialAuthButton({
    super.key,
    required this.icon,
    required this.semanticLabel,
    this.onPressed,
    this.size = _defaultSize,
  });

  /// Google sign-in button with the multi-colour brand mark.
  factory SocialAuthButton.google({
    Key? key,
    VoidCallback? onPressed,
    String semanticLabel = 'Google',
    double size = _defaultSize,
  }) {
    return SocialAuthButton(
      key: key,
      onPressed: onPressed,
      semanticLabel: semanticLabel,
      size: size,
      icon: _brandMark('google'),
    );
  }

  /// Apple sign-in button with the Apple brand mark.
  factory SocialAuthButton.apple({
    Key? key,
    VoidCallback? onPressed,
    String semanticLabel = 'Apple',
    double size = _defaultSize,
  }) {
    return SocialAuthButton(
      key: key,
      onPressed: onPressed,
      semanticLabel: semanticLabel,
      size: size,
      icon: _brandMark('apple'),
    );
  }

  final Widget icon;
  final String semanticLabel;
  final VoidCallback? onPressed;
  final double size;

  static const double _defaultSize = 56;
  static const double _iconSize = 26;

  static Widget _brandMark(String name) => SvgPicture.asset(
        'assets/images/social/$name.svg',
        package: 'mboa_ui',
        width: _iconSize,
        height: _iconSize,
      );

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final enabled = onPressed != null;

    return Semantics(
      button: true,
      enabled: enabled,
      label: semanticLabel,
      child: Opacity(
        opacity: enabled ? 1 : 0.5,
        child: Material(
          color: colors.surface,
          shape: CircleBorder(side: BorderSide(color: colors.border)),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onPressed,
            child: SizedBox(
              width: size,
              height: size,
              child: Center(child: icon),
            ),
          ),
        ),
      ),
    );
  }
}
