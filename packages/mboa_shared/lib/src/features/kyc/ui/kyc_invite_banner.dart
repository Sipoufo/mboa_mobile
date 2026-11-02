import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../profile/models/account_role.dart';
import '../logic/kyc_cubit.dart';
import '../models/kyc_status.dart';

/// RM-M01bis-01 — the invitation to verify one's identity, on the profile of
/// both apps and on the Pro home, for as long as the KYC is not approved.
///
/// Three faces, from the session's [KycCubit]: to do (on the brand ground),
/// under review, refused (with the reason). Approved, it draws nothing — the
/// « Certifications » or « Identité » tile stays for reading. A status never
/// read (offline at start) draws nothing either, rather than a guess.
///
/// [padding] wraps the banner only when it shows, so a screen's spacing does
/// not leave a gap where it is absent.
class KycInviteBanner extends StatelessWidget {
  const KycInviteBanner({super.key, required this.role, required this.onOpen, this.padding = EdgeInsets.zero});

  /// Words what the verification opens: required for a prestataire or an
  /// agent, optional for a tenant (RM-M01bis-13).
  final AccountRole role;

  /// Opens the KYC — to start it, follow it, or take it up again.
  final VoidCallback onOpen;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => BlocBuilder<KycCubit, KycState>(
        buildWhen: (previous, current) => _shown(previous) != _shown(current),
        builder: (context, state) {
          final banner = switch (_shown(state)) {
            null => null,
            (KycStatus.pending, _) => _Pending(onOpen: onOpen),
            (KycStatus.rejected, final reason) => _Rejected(reason: reason, onOpen: onOpen),
            _ => _ToDo(role: role, onOpen: onOpen),
          };
          if (banner == null || role == AccountRole.admin) return const SizedBox.shrink();
          return Padding(padding: padding, child: banner);
        },
      );

  /// What the banner shows of [state]: the status and the refusal's reason,
  /// or null when it shows nothing.
  static (KycStatus, String?)? _shown(KycState state) => switch (state) {
        KycReady(:final status) when status.status != KycStatus.approved => (
            status.status,
            status.rejectionReason,
          ),
        _ => null,
      };
}

/// Not yet submitted: the brand ground, the texture faint (Doc05 §5.3).
class _ToDo extends StatelessWidget {
  const _ToDo({required this.role, required this.onOpen});

  final AccountRole role;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return _Shape(
      color: colors.primary,
      texture: true,
      onTap: onOpen,
      icon: Icon(LucideIcons.shieldCheck, color: colors.onBrand),
      title: Text(l10n.kycBannerTitle, style: context.mboaText.label.copyWith(color: colors.onBrand)),
      body: Text(
        switch (role) {
          AccountRole.agent => l10n.kycBannerBodyAgent,
          AccountRole.user => l10n.kycBannerBodyTenant,
          _ => l10n.kycBannerBodyPrestataire,
        },
        style: context.mboaText.caption.copyWith(color: colors.onBrand),
      ),
      action: Text(l10n.kycBannerStart, style: context.mboaText.label.copyWith(color: colors.onBrand)),
    );
  }
}

/// Submitted, under review: nothing to do but wait.
class _Pending extends StatelessWidget {
  const _Pending({required this.onOpen});

  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return _Shape(
      color: colors.primaryPale,
      onTap: onOpen,
      icon: Icon(LucideIcons.hourglass, color: colors.primary),
      title: Text(l10n.kycBannerPendingTitle, style: context.mboaText.label.copyWith(color: colors.ink)),
      body: Text(
        l10n.kycBannerPendingBody,
        style: context.mboaText.caption.copyWith(color: colors.textSecondary),
      ),
      action: Icon(LucideIcons.chevronRight, size: Dimens.icon, color: colors.textTertiary),
    );
  }
}

/// Refused: why, and the way back in.
class _Rejected extends StatelessWidget {
  const _Rejected({required this.reason, required this.onOpen});

  final String? reason;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final why = reason?.trim();

    return _Shape(
      color: colors.error.withValues(alpha: 0.1),
      onTap: onOpen,
      icon: Icon(LucideIcons.shieldX, color: colors.error),
      title: Text(l10n.kycBannerRejectedTitle, style: context.mboaText.label.copyWith(color: colors.error)),
      body: Text(
        why == null || why.isEmpty ? l10n.kycBannerRejectedBody : l10n.kycRejectionReason(why),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: context.mboaText.caption.copyWith(color: colors.ink),
      ),
      action: Text(l10n.kycBannerResume, style: context.mboaText.label.copyWith(color: colors.error)),
    );
  }
}

/// The one shape the three faces share — the profile's other banner's.
class _Shape extends StatelessWidget {
  const _Shape({
    required this.color,
    required this.onTap,
    required this.icon,
    required this.title,
    required this.body,
    required this.action,
    this.texture = false,
  });

  final Color color;
  final VoidCallback onTap;
  final Widget icon;
  final Widget title;
  final Widget body;
  final Widget action;
  final bool texture;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.all(Dimens.spacing),
      child: Row(
        children: [
          icon,
          const SizedBox(width: Dimens.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [title, const SizedBox(height: Dimens.spacingXs), body],
            ),
          ),
          const SizedBox(width: Dimens.spacingSm),
          action,
        ],
      ),
    );

    return Material(
      color: color,
      borderRadius: BorderRadius.circular(Dimens.radiusLg),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: texture
            ? Stack(
                children: [
                  Positioned.fill(child: MboaBrandPattern(color: context.mboaColors.onBrand)),
                  content,
                ],
              )
            : content,
      ),
    );
  }
}
