import 'package:flutter/material.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// Empty state for a tab whose module has no backend yet.
class TabPlaceholder extends StatelessWidget {
  const TabPlaceholder({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacingXl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(Dimens.spacingLg),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.primaryPale,
                ),
                child: Icon(icon, size: Dimens.iconLg, color: colors.primary),
              ),
              const SizedBox(height: Dimens.spacingLg),
              Text(title, style: context.mboaText.h2),
              const SizedBox(height: Dimens.spacingMd),
              Text(
                body,
                textAlign: TextAlign.center,
                style: context.mboaText.body.copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
