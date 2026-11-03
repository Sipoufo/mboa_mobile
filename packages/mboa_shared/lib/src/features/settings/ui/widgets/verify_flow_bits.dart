import 'package:flutter/material.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// The pieces the code-verified changes share — the phone number, the email
/// (§40 A) — so they read as one kind of screen.

/// A white card on the page's ground, its children spaced.
class VerifyCard extends StatelessWidget {
  const VerifyCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(Dimens.spacing),
        decoration: BoxDecoration(
          color: context.mboaColors.surface,
          borderRadius: BorderRadius.circular(Dimens.radiusLg),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final (index, child) in children.indexed) ...[
              if (index > 0) const SizedBox(height: Dimens.spacingMd),
              child,
            ],
          ],
        ),
      );
}

/// The bar at the foot: one main button (Doc05 §6.1).
class VerifyActionBar extends StatelessWidget {
  const VerifyActionBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Container(
      decoration: BoxDecoration(color: colors.surface, border: Border(top: BorderSide(color: colors.border))),
      child: SafeArea(minimum: const EdgeInsets.all(Dimens.spacing), child: child),
    );
  }
}

/// Why the codes, said once at the top of the first step: an icon in a pale
/// disc, a title, a line.
class VerifyIntro extends StatelessWidget {
  const VerifyIntro({super.key, required this.icon, required this.title, required this.body});

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(color: colors.primaryPale, shape: BoxShape.circle),
          child: Icon(icon, color: colors.primary, size: Dimens.iconLg),
        ),
        const SizedBox(height: Dimens.spacingMd),
        Text(title, style: context.mboaText.h2.copyWith(color: colors.ink)),
        const SizedBox(height: Dimens.spacingXs),
        Text(
          body,
          textAlign: TextAlign.center,
          style: context.mboaText.body.copyWith(color: colors.textSecondary),
        ),
      ],
    );
  }
}
