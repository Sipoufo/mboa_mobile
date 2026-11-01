import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// The back arrow — of every screen, in both apps.
///
/// **One rule:** it shows when the router that holds the page can go back,
/// itself or through its parents, and it goes back through that same router.
/// So a page pushed onto a nested router steps back to the page under it; a
/// page alone in one (everything under `/app` opens that way) closes it and
/// returns to what was beneath; a tab, which has nothing beneath it, shows no
/// arrow at all.
///
/// Two rules used to coexist and neither was that one. This button asked the
/// root navigator: inside `/app` it closed the whole nested stack instead of
/// the last page, and where the root had nothing to pop it vanished although
/// the nested stack had. The default AppBar arrow asked the nearest navigator:
/// it missed every page alone in a nested router. Screens showed an arrow that
/// went to the wrong place, none where one was needed, one on a tab.
///
/// Without a router around it — a widget test, a golden — it falls back to
/// the nearest navigator, so views stay pumpable bare.
class MboaHeaderBackButton extends StatelessWidget {
  const MboaHeaderBackButton({super.key, this.color});

  final Color? color;

  /// For an `AppBar`'s `leading`: the arrow, or null when there is nothing to
  /// go back to — so a tab's title is not pushed right by an empty slot. Pair
  /// it with `automaticallyImplyLeading: false`, or Material adds its own
  /// arrow by the other rule.
  static Widget? leading(BuildContext context, {Color? color}) =>
      _back(context) == null ? null : MboaHeaderBackButton(color: color);

  /// Goes back by the same rule — for a screen that closes itself once its
  /// work is done. `Navigator.of(context).maybePop()` does nothing on a page
  /// alone in a nested router: the save went through and the screen stayed.
  static void pop(BuildContext context) => _back(context, listen: false)?.call();

  /// What going back means from [context], or null if it means nothing.
  static VoidCallback? _back(BuildContext context, {bool listen = true}) {
    final scope = listen
        ? context.dependOnInheritedWidgetOfExactType<StackRouterScope>()
        : context.getElementForInheritedWidgetOfExactType<StackRouterScope>()?.widget as StackRouterScope?;
    final router = scope?.controller;
    if (router != null) {
      return router.canPop(ignoreChildRoutes: true) ? () => router.maybePop() : null;
    }
    final navigator = Navigator.maybeOf(context);
    return navigator != null && navigator.canPop() ? () => navigator.maybePop() : null;
  }

  @override
  Widget build(BuildContext context) {
    final back = _back(context);
    // In a header of its own the slot is kept — the button's whole footprint,
    // so neither the title nor the header's height moves with the arrow.
    if (back == null) return const SizedBox.square(dimension: kMinInteractiveDimension);

    return IconButton(
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: back,
      icon: Icon(
        LucideIcons.arrowLeft,
        color: color ?? context.mboaColors.ink,
      ),
    );
  }
}
