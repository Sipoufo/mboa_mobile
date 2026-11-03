import 'package:flutter/material.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// The pieces both apps' profile forms are built from — the Pro's (« Modifier
/// mon profil », prestataire and agent) and App Mboa's (« Mon profil »).

/// The profile form's brand band, in both apps, as on « Profil » / « Compte »:
/// back, the title, and whose profile it is — the face and the name.
class ProfileFormHeader extends StatelessWidget {
  const ProfileFormHeader({super.key, required this.title, this.name, this.avatarUrl, this.initials});

  final String title;
  final String? name;
  final String? avatarUrl;
  final String? initials;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final name = this.name ?? '';

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(Dimens.radiusLg)),
      child: ColoredBox(
        color: colors.primary,
        child: Stack(
          children: [
            // Doc05 §5.3 — the brand ground only, faint.
            Positioned.fill(child: MboaBrandPattern(color: colors.onBrand, opacity: 0.06, scale: 0.65)),
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  Dimens.spacingSm,
                  Dimens.spacingSm,
                  Dimens.spacingSm,
                  Dimens.spacingLg,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        MboaHeaderBackButton(color: colors.onBrand),
                        Expanded(
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: context.mboaText.h3.copyWith(color: colors.onBrand),
                          ),
                        ),
                        const SizedBox.square(dimension: kMinInteractiveDimension),
                      ],
                    ),
                    const SizedBox(height: Dimens.spacingSm),
                    MboaAvatar(imageUrl: avatarUrl, initials: initials, size: 72),
                    if (name.isNotEmpty) ...[
                      const SizedBox(height: Dimens.spacingSm),
                      Text(name, style: context.mboaText.h3.copyWith(color: colors.onBrand)),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// One group of the form, on its white card.
class ProfileFormSection extends StatelessWidget {
  const ProfileFormSection({super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Container(
      margin: const EdgeInsets.only(bottom: Dimens.spacing),
      padding: const EdgeInsets.all(Dimens.spacing),
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(Dimens.radiusLg)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: context.mboaText.h3.copyWith(color: colors.primaryDark)),
          for (final child in children) ...[const SizedBox(height: Dimens.spacingMd), child],
        ],
      ),
    );
  }
}

/// The bar at the foot: one main button (Doc05 §6.1).
class ProfileFormActionBar extends StatelessWidget {
  const ProfileFormActionBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: SafeArea(minimum: const EdgeInsets.all(Dimens.spacing), child: child),
    );
  }
}
