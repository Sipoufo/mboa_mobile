import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';

/// Explains why a surface is unavailable and offers the way forward.
///
/// One screen for every [AccessRestriction] so the reasons stay in sync with
/// `AccessPolicy` — a new restriction is a compile error here, not a silent
/// blank screen.
@RoutePage()
class AccessRestrictedPage extends StatelessWidget {
  const AccessRestrictedPage({
    super.key,
    required this.restriction,
    this.requiredTier,
  });

  final AccessRestriction restriction;

  /// Set for [AccessRestriction.tierRequired] — the tier the CTA points at.
  final SubscriptionTier? requiredTier;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final tier = (requiredTier ?? SubscriptionTier.proPlus).label;

    final (icon, title, body) = switch (restriction) {
      AccessRestriction.comingSoon => (
          LucideIcons.clock,
          l10n.accessComingSoonTitle,
          l10n.accessComingSoonBody,
        ),
      AccessRestriction.kycRequired => (
          LucideIcons.shieldCheck,
          l10n.accessKycRequiredTitle,
          l10n.accessKycRequiredBody,
        ),
      AccessRestriction.kycPending => (
          LucideIcons.hourglass,
          l10n.accessKycPendingTitle,
          l10n.accessKycPendingBody,
        ),
      AccessRestriction.tierRequired => (
          LucideIcons.sparkles,
          l10n.accessTierRequiredTitle,
          l10n.accessTierRequiredBody(tier),
        ),
      AccessRestriction.roleRequired => (
          LucideIcons.userX,
          l10n.accessRoleRequiredTitle,
          l10n.accessRoleRequiredBody,
        ),
    };

    return Scaffold(
      appBar: AppBar(title: Text(l10n.accessRestrictedTitle)),
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
              Text(
                title,
                textAlign: TextAlign.center,
                style: context.mboaText.h2,
              ),
              const SizedBox(height: Dimens.spacingMd),
              Text(
                body,
                textAlign: TextAlign.center,
                style: context.mboaText.body.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              if (_cta(context, l10n, tier) case final cta?) ...[
                const SizedBox(height: Dimens.spacingXl),
                cta,
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget? _cta(BuildContext context, I18n l10n, String tier) => switch (restriction) {
        // Sends the prestataire to the screen that actually unblocks them.
        AccessRestriction.kycRequired => Button.primary(
            title: l10n.accessKycRequiredCta,
            onPressed: () => context.router.push(CertificationsRoute()),
          ),
        // Subscriptions (M13) aren't built — the CTA lands when they are.
        AccessRestriction.tierRequired => Button.primary(
            title: l10n.accessUpgradeCta(tier),
            onPressed: null,
          ),
        _ => null,
      };
}
