import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../../auth/bloc/auth_bloc.dart';
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
                                    const SizedBox(height: Dimens.spacing3Xl),
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
            const SizedBox(height: 48),
          ],
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
