import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// The back arrow of a screen that paints its own header instead of an AppBar.
///
/// It asks the **root** navigator, not the nearest one. A screen pushed into a
/// nested router — everything under `/app` — sits alone in that router's stack,
/// so `Navigator.of(context).canPop()` is false there and the arrow never
/// appeared, stranding the reader on the Settings hub. The stack that actually
/// has something to go back to is the one above.
///
/// A screen with an ordinary `AppBar` uses auto_route's `AutoLeadingButton`
/// instead, which does the same reasoning and also knows close from back.
///
/// When there is nothing to pop it holds the space instead, so a centred title
/// stays centred. `Navigator.maybeOf` rather than `of`, because these views are
/// pumped in golden tests with no navigator at all.
class MboaHeaderBackButton extends StatelessWidget {
  const MboaHeaderBackButton({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.maybeOf(context, rootNavigator: true);
    if (navigator == null || !navigator.canPop()) {
      return const SizedBox(width: Dimens.iconLg);
    }

    return IconButton(
      onPressed: navigator.maybePop,
      icon: Icon(
        LucideIcons.arrowLeft,
        color: color ?? context.mboaColors.ink,
      ),
    );
  }
}
