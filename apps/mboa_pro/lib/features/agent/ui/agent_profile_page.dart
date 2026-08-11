import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../bloc/agent_profile_bloc.dart';
import '../models/agent_profile.dart';

/// The agent's own profile (CDC M15): who they are, whether they are taking
/// work, and the two things that decide what they get offered — their zones and
/// their availability.
@RoutePage()
class AgentProfilePage extends StatefulWidget {
  const AgentProfilePage({super.key});

  @override
  State<AgentProfilePage> createState() => _AgentProfilePageState();
}

class _AgentProfilePageState extends State<AgentProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<AgentProfileBloc>().add(const AgentProfileLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: Text(l10n.agentProfileTitle)),
      body: BlocConsumer<AgentProfileBloc, AgentProfileState>(
        listenWhen: (prev, curr) =>
            curr is AgentProfileReady &&
            (curr.lastActionFailed || curr.justSaved),
        listener: (context, state) {
          final ready = state as AgentProfileReady;
          if (ready.lastActionFailed) {
            MboaToast.error(
              context: context,
              title: l10n.commonErrorTitle,
              description: l10n.agentSaveFailed,
            );
          } else {
            MboaToast.success(context: context, title: l10n.agentSaved);
          }
        },
        builder: (context, state) => switch (state) {
          AgentProfileInitial() ||
          AgentProfileLoadInProgress() =>
            const Center(child: Loader()),
          AgentProfileFailure() => Center(
              child: TextButton(
                onPressed: () => context
                    .read<AgentProfileBloc>()
                    .add(const AgentProfileLoadRequested()),
                child: Text(l10n.commonRetry),
              ),
            ),
          AgentProfileReady(:final profile, :final isUploadingPhoto) =>
            RefreshIndicator(
              onRefresh: () async => context
                  .read<AgentProfileBloc>()
                  .add(const AgentProfileLoadRequested()),
              child: ListView(
                padding: const EdgeInsets.all(Dimens.spacing),
                children: [
                  _Header(profile: profile, isUploading: isUploadingPhoto),
                  if (!profile.profileComplete) ...[
                    const SizedBox(height: Dimens.spacing),
                    _IncompleteBanner(),
                  ],
                  const SizedBox(height: Dimens.spacingLg),
                  _Stats(profile: profile),
                  const SizedBox(height: Dimens.spacingLg),
                  _AcceptingCard(profile: profile),
                  const SizedBox(height: Dimens.spacingLg),
                  MboaTileCard(
                    icon: LucideIcons.mapPin,
                    title: l10n.agentZonesTitle,
                    subtitle: profile.zones.isEmpty
                        ? l10n.agentZonesNone
                        : l10n.agentZonesSubtitle(profile.zones.length),
                    subtitleColor:
                        profile.zones.isEmpty ? colors.error : null,
                    onTap: () => context.router.push(const AgentZonesRoute()),
                  ),
                  const SizedBox(height: Dimens.spacingSm),
                  MboaTileCard(
                    icon: LucideIcons.calendarClock,
                    title: l10n.agentAvailabilityTitle,
                    onTap: () =>
                        context.router.push(const AgentAvailabilityRoute()),
                  ),

                  // The agent shell has no slide menu, so the account surfaces
                  // the prestataire reaches from theirs live here. Without them
                  // an agent could sign in and never sign out.
                  const SizedBox(height: Dimens.spacingLg),
                  Text(l10n.menuOther, style: context.mboaText.h3),
                  const SizedBox(height: Dimens.spacingSm),
                  MboaTileCard(
                    icon: LucideIcons.badgeCheck,
                    title: l10n.settingsCertificationsTitle,
                    onTap: () =>
                        context.router.push(CertificationsRoute()),
                  ),
                  const SizedBox(height: Dimens.spacingSm),
                  MboaTileCard(
                    icon: LucideIcons.bell,
                    title: l10n.menuNotifications,
                    // Coming-soon, exactly as on the prestataire menu: push
                    // notifications are delivered, but there is no preferences
                    // screen for either persona yet.
                    onTap: () => context.router.push(
                      AccessRestrictedRoute(
                        restriction: AccessRestriction.comingSoon,
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimens.spacingSm),
                  MboaTileCard(
                    icon: LucideIcons.settings,
                    title: l10n.settingsMenuTitle,
                    onTap: () =>
                        context.router.push(const SettingsMenuRoute()),
                  ),
                  const SizedBox(height: Dimens.spacingLg),
                  const _LogoutButton(),
                  const SizedBox(height: Dimens.spacingLg),
                ],
              ),
            ),
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.profile, required this.isUploading});

  final AgentProfile profile;
  final bool isUploading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isUploading)
          const SizedBox(height: 96, width: 96, child: Loader())
        else
          MboaAvatar(
            imageUrl: profile.photoUrl,
            initials: profile.initials,
            showEditBadge: true,
            onEdit: () => _pickPhoto(context),
          ),
        const SizedBox(height: Dimens.spacingSm),
        Text(profile.fullName, style: context.mboaText.h2),
        const SizedBox(height: Dimens.spacingXs),
        _StatusChip(status: profile.status),
      ],
    );
  }

  /// Reuses the shared capture sheet, so the agent's photo flow looks like
  /// every other media capture in both apps.
  Future<void> _pickPhoto(BuildContext context) async {
    final bloc = context.read<AgentProfileBloc>();
    final source = await showCaptureSourceSheet(context);
    if (source != null) bloc.add(AgentPhotoChangeRequested(source));
  }
}

/// The agent needs to know *why* nothing is arriving. Suspended and pending are
/// both states where the app looks fine and no work comes (RM-M11-05).
class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final AgentStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    final (label, color) = switch (status) {
      AgentStatus.active => (l10n.agentStatusActive, colors.success),
      AgentStatus.pending => (l10n.agentStatusPending, colors.warning),
      AgentStatus.suspended => (l10n.agentStatusSuspended, colors.error),
      AgentStatus.deleted => (l10n.agentStatusDeleted, colors.error),
      AgentStatus.unknown => (l10n.agentStatusUnknown, colors.textTertiary),
    };

    return Chip(
      label: Text(label),
      labelStyle: context.mboaText.caption.copyWith(color: color),
      backgroundColor: color.withValues(alpha: 0.12),
      side: BorderSide.none,
    );
  }
}

/// Spells out the server's own completeness rule, so "no missions" has a cause
/// the agent can act on rather than being a mystery.
class _IncompleteBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Container(
      padding: const EdgeInsets.all(Dimens.spacing),
      decoration: BoxDecoration(
        color: colors.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(Dimens.radius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(LucideIcons.triangleAlert, color: colors.warning, size: Dimens.icon),
          const SizedBox(width: Dimens.spacingSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.agentIncompleteTitle,
                  style: context.mboaText.label
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: Dimens.spacingXs),
                Text(
                  l10n.agentIncompleteBody,
                  style: context.mboaText.caption
                      .copyWith(color: colors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Stats extends StatelessWidget {
  const _Stats({required this.profile});

  final AgentProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Row(
      children: [
        Expanded(
          child: _StatTile(
            icon: LucideIcons.checkCheck,
            label: l10n.agentStatsVisits,
            value: '${profile.completedVisitCount}',
          ),
        ),
        const SizedBox(width: Dimens.spacingMd),
        Expanded(
          child: _StatTile(
            icon: LucideIcons.star,
            label: l10n.agentStatsRating,
            // Never invent a rating: an agent with no reviews has no average,
            // and "0" would read as a bad one.
            value: profile.hasRating
                ? profile.averageRating!.toStringAsFixed(1)
                : '—',
            caption: profile.hasRating
                ? l10n.agentStatsRatingCount(profile.ratingCount)
                : l10n.agentStatsNoRating,
          ),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.label,
    required this.value,
    this.caption,
  });

  final IconData icon;
  final String label;
  final String value;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Container(
      padding: const EdgeInsets.all(Dimens.spacing),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: Dimens.icon, color: colors.primary),
          const SizedBox(height: Dimens.spacingSm),
          Text(value, style: context.mboaText.h2),
          Text(
            label,
            style: context.mboaText.caption
                .copyWith(color: colors.textSecondary),
          ),
          if (caption case final caption?)
            Text(
              caption,
              style: context.mboaText.caption
                  .copyWith(color: colors.textTertiary),
            ),
        ],
      ),
    );
  }
}

/// RM-M15-05 — "Inactif". Doc 10 is explicit that visits already booked are
/// still carried out, so the off-state copy says so.
class _AcceptingCard extends StatelessWidget {
  const _AcceptingCard({required this.profile});

  final AgentProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Container(
      padding: const EdgeInsets.all(Dimens.spacing),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.agentAcceptingTitle,
                  style: context.mboaText.label
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Switch(
                value: profile.acceptingAssignments,
                onChanged: (value) => context
                    .read<AgentProfileBloc>()
                    .add(AgentAcceptingAssignmentsToggled(value)),
              ),
            ],
          ),
          const SizedBox(height: Dimens.spacingXs),
          Text(
            profile.acceptingAssignments
                ? l10n.agentAcceptingOn
                : l10n.agentAcceptingOff,
            style:
                context.mboaText.caption.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}


/// Signing out. The agent shell has no slide menu, so this is the only way out
/// of the app for an agent — it is not decoration.
class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return TextButton.icon(
      onPressed: () =>
          context.read<AuthBloc>().add(const AuthLogoutRequested()),
      icon: Icon(LucideIcons.logOut, color: colors.error),
      label: Text(
        l10n.menuQuit,
        style: context.mboaText.bodyLarge.copyWith(color: colors.error),
      ),
    );
  }
}
