import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../models/prestataire_type.dart';
import '../models/profile_data.dart';
import '../profile_types.dart';

/// Settings hub (CDC M02): profile summary, certifications entry, password and
/// logout. Adapts to the loaded [ProfileData].
class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<ProProfileBloc>();
    // if (bloc.state is ProfileInitial) bloc.add(const ProfileLoadRequested());
    bloc.add(const ProfileLoadRequested());
  }

  Future<void> _changePhoto() async {
    final source = await showCaptureSourceSheet(context);
    if (source != null && mounted) {
      context.read<ProProfileBloc>().add(ProfilePhotoChangeRequested(source));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<ProProfileBloc, ProfileState>(
                listenWhen: (prev, curr) =>
                    curr is ProProfileReady && (curr.photoJustUpdated || curr.photoFailed),
                listener: (context, state) {
                  if (state is! ProProfileReady) return;
                  if (state.photoJustUpdated) {
                    MboaToast.success(context: context, title: l10n.profilePhotoUpdated);
                  } else if (state.photoFailed) {
                    MboaToast.error(
                      context: context,
                      title: l10n.commonErrorTitle,
                      description: l10n.commonError,
                    );
                  }
                },
                builder: (context, state) {
                  final data = state is ProProfileReady ? state.data : null;
                  final busy = state is ProProfileReady && state.saving || state is ProfileLoadInProgress;

                  return StackedLoaderView(
                    isLoading: busy,
                    child: Column(
                      children: [
                        _Header(data: data, onEditPhoto: data == null ? null : _changePhoto),
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async{
                              context.read<ProProfileBloc>().add(const ProfileLoadRequested());
                            },
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(
                                  Dimens.spacingLg,
                                  0,
                                  Dimens.spacingLg,
                                  Dimens.spacingLg,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: Dimens.spacingXl),
                                    if (data != null) ...[
                                      _Identity(data: data),
                                      const SizedBox(height: Dimens.spacingLg),
                                    ],
                                    // RM-M10-01 — the one thing that stops him
                                    // publishing, said here rather than only at
                                    // the moment publish is refused.
                                    if (data != null && !data.isProfileComplete) ...[
                                      _IncompleteBanner(
                                        onTap: () => context.router
                                            .push(const EditProfileRoute()),
                                      ),
                                      const SizedBox(height: Dimens.spacing),
                                    ],
                                    MboaActionCard(
                                      icon: LucideIcons.squareUserRound,
                                      title: l10n.settingsProfileCard,
                                      subtitle: data?.email,
                                      onTap: data == null ? null : () => context.router.push(const EditProfileRoute()),
                                      child: Text(
                                        data?.fullName ?? '',
                                        style: context.mboaText.display.copyWith(
                                          color: colors.primary,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                    if (data != null && data.isPrestataire) ...[
                                      const SizedBox(height: Dimens.spacing),
                                      _BusinessCard(data: data),
                                    ],
                                    const SizedBox(height: Dimens.spacing),
                                    MboaActionCard(
                                      icon: LucideIcons.shieldCheck,
                                      title: l10n.settingsCertificationsTitle,
                                      subtitle: l10n.settingsCertificationsBody,
                                      onTap: data == null
                                          ? null
                                          : () => context.router.push(CertificationsRoute(accountRole: data.role)),
                                    ),
                                    const SizedBox(height: Dimens.spacingLg),
                                    // Per the Profil design. "Paramètres"
                                    // (language, phone, deletion) is reached
                                    // from the Pro slide menu instead, so it
                                    // stays one tap away without a second
                                    // button competing here.
                                    Button.outline(
                                      title: l10n.settingsChangePassword,
                                      icon: const Icon(LucideIcons.keyRound, size: Dimens.icon),
                                      iconAlignment: IconAlignment.start,
                                      onPressed: () => context.router.push(const ChangePasswordRoute()),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            TextButton.icon(
              onPressed: () => context.read<AuthBloc>().add(const AuthLogoutRequested()),
              icon: const Icon(LucideIcons.logOut, size: Dimens.icon),
              label: Text(l10n.settingsLogout),
              style: TextButton.styleFrom(foregroundColor: colors.primary),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({this.data, this.onEditPhoto});

  final ProfileData? data;
  final VoidCallback? onEditPhoto;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Green header + a transparent overhang; the Column sizes the Stack so
        // the bottom-aligned avatar stays within bounds (and hit-testable).
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              color: colors.primary,
              padding: const EdgeInsets.only(bottom: Dimens.spacing3Xl),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing, vertical: Dimens.spacingSm),
                  child: Row(
                    children: [
                      if (Navigator.of(context).canPop())
                        IconButton(
                          onPressed: () => Navigator.of(context).maybePop(),
                          icon: Icon(LucideIcons.arrowLeft, color: colors.onBrand),
                        )
                      else
                        const SizedBox(width: Dimens.iconLg),
                      Expanded(
                        child: Text(
                          l10n.settingsTitle,
                          textAlign: TextAlign.center,
                          style: context.mboaText.h3.copyWith(color: colors.onBrand),
                        ),
                      ),
                      const SizedBox(width: Dimens.iconLg),
                    ],
                  ),
                ),
              ),
            ),
            // The design laps a rounded white sheet over the green band; the
            // avatar sits astride the seam.
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(Dimens.radiusXl),
                ),
              ),
            ),
          ],
        ),
        // Drawn *over* the last band of green, which is what makes the sheet
        // read as lapped rather than as two stacked blocks.
        Positioned(
          left: 0,
          right: 0,
          bottom: 48,
          child: Container(
            height: Dimens.radiusXl,
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(Dimens.radiusXl),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Center(
            child: MboaAvatar(
              imageUrl: data?.avatarUrl,
              initials: data?.initials,
              size: 96,
              showEditBadge: true,
              onEdit: onEditPhoto,
            ),
          ),
        ),
      ],
    );
  }
}

/// Name, business name and type, right under the avatar.
///
/// The hub showed a bare avatar and put the name inside a card: a prestataire
/// opening his profile could not see, at a glance, which business the account
/// speaks for.
class _Identity extends StatelessWidget {
  const _Identity({required this.data});

  final ProfileData data;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Column(
      children: [
        // Not the person's name: the Profil card below carries that, and the
        // design puts it there. What was missing is which business the account
        // speaks for.
        if (data.displayName case final business?
            when business.trim().isNotEmpty && business != data.fullName)
          Text(
            business,
            textAlign: TextAlign.center,
            style: context.mboaText.h3.copyWith(color: colors.primaryDark),
          ),
        if (data.type case final type?) ...[
          const SizedBox(height: Dimens.spacingSm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.spacingMd,
              vertical: Dimens.spacingXs,
            ),
            decoration: BoxDecoration(
              color: colors.primaryPale,
              borderRadius: BorderRadius.circular(Dimens.radiusFull),
            ),
            child: Text(
              switch (type) {
                PrestataireType.particulier => l10n.profileTypeParticulier,
                PrestataireType.agence => l10n.profileTypeAgence,
                PrestataireType.promoteur => l10n.profileTypePromoteur,
              },
              style: context.mboaText.caption.copyWith(color: colors.primaryDark),
            ),
          ),
        ],
      ],
    );
  }
}

/// RM-M10-01 — publishing is refused until the profile is complete, and the
/// refusal used to be the first the prestataire heard of it.
class _IncompleteBanner extends StatelessWidget {
  const _IncompleteBanner({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Material(
      color: colors.warning.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(Dimens.radiusLg),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacing),
          child: Row(
            children: [
              Icon(LucideIcons.triangleAlert, color: colors.warning),
              const SizedBox(width: Dimens.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.profileIncompleteTitle,
                      style: context.mboaText.label.copyWith(color: colors.ink),
                    ),
                    const SizedBox(height: Dimens.spacingXs),
                    Text(
                      l10n.profileIncompleteBody,
                      style: context.mboaText.caption
                          .copyWith(color: colors.textSecondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: Dimens.spacingSm),
              Text(
                l10n.profileIncompleteAction,
                style: context.mboaText.label.copyWith(color: colors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// What the account trades as: city and registration.
///
/// Both are business facts the app already holds and never displayed — and the
/// registration is what the Contrat Mboa prints (M08), so its absence is worth
/// seeing before a contract needs it.
class _BusinessCard extends StatelessWidget {
  const _BusinessCard({required this.data});

  final ProfileData data;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Dimens.spacingLg),
      decoration: BoxDecoration(
        color: colors.surfaceWarm,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.profileBusinessTitle,
            style: context.mboaText.h3.copyWith(color: colors.primaryDark),
          ),
          const SizedBox(height: Dimens.spacing),
          _Fact(
            icon: LucideIcons.mapPin,
            label: l10n.profileMainCity,
            value: data.mainCity,
          ),
          const SizedBox(height: Dimens.spacingMd),
          _Fact(
            icon: LucideIcons.idCard,
            label: l10n.profileRegistrationNumber,
            value: data.registrationNumber,
          ),
        ],
      ),
    );
  }
}

class _Fact extends StatelessWidget {
  const _Fact({required this.icon, required this.label, this.value});

  final IconData icon;
  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final missing = value == null || value!.trim().isEmpty;

    return Row(
      children: [
        Icon(icon, size: Dimens.icon, color: colors.primary),
        const SizedBox(width: Dimens.spacingMd),
        Expanded(
          child: Text(
            label,
            style: context.mboaText.body.copyWith(color: colors.textSecondary),
          ),
        ),
        Text(
          missing ? l10n.profileBusinessMissing : value!,
          style: context.mboaText.label.copyWith(
            color: missing ? colors.textTertiary : colors.ink,
          ),
        ),
      ],
    );
  }
}
