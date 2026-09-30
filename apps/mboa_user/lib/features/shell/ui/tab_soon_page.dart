import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// Messagerie (M12) — the module exists on the backend and is unbuilt in both
/// apps; the tab is here so the product's map is visible, not to promise a
/// date.
@RoutePage()
class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) => _Soon(
        icon: LucideIcons.messageSquare,
        title: I18n.of(context).navMessages,
      );
}

class _Soon extends StatelessWidget {
  const _Soon({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacingXl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: Dimens.iconLg, color: colors.textTertiary),
              const SizedBox(height: Dimens.spacing),
              Text(
                l10n.commonComingSoon,
                textAlign: TextAlign.center,
                style: context.mboaText.h3.copyWith(color: colors.ink),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
