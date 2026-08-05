import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../../kyc/logic/kyc_cubit.dart';
import '../../kyc/models/kyc_status.dart';
import '../../profile/profile_types.dart';
import '../../subscription/bloc/subscription_bloc.dart';
import '../bloc/home_bloc.dart';
import 'widgets/global_stats_card.dart';
import 'widgets/home_cta_card.dart';
import 'widgets/home_header.dart';

/// Prestataire home / dashboard (CDC M14).
@RoutePage()
class HomePage extends StatelessWidget implements AutoRouteWrapper {
  const HomePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => getIt<HomeBloc>()..add(const HomeLoadRequested()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.surfaceWarm,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async =>
              context.read<HomeBloc>().add(const HomeRefreshRequested()),
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: Dimens.spacing),
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.spacing),
                child: HomeHeader(),
              ),
              const SizedBox(height: Dimens.spacingLg),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.spacing,
                ),
                child: Text(l10n.homeTitle, style: context.mboaText.h1),
              ),
              const SizedBox(height: Dimens.spacing),
              const _CtaCarousel(),
              const SizedBox(height: Dimens.spacingLg),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.spacing),
                child: _StatsSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CtaCarousel extends StatelessWidget {
  const _CtaCarousel();

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return SizedBox(
      height: HomeCtaCard.height,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing),
        children: [
          HomeCtaCard(
            icon: LucideIcons.building2,
            title: l10n.homeCtaBiensTitle,
            body: l10n.homeCtaBiensBody,
            actionLabel: l10n.homeCtaBiensAction,
            onPressed: () => _open(context, FeatureKey.mesBiens),
          ),
          const SizedBox(width: Dimens.spacingMd),
          HomeCtaCard(
            tone: HomeCtaTone.dark,
            icon: LucideIcons.handCoins,
            title: l10n.homeCtaPortefeuilleTitle,
            body: l10n.homeCtaPortefeuilleBody,
            actionLabel: l10n.homeCtaPortefeuilleAction,
            onPressed: () => _open(context, FeatureKey.portefeuille),
          ),
          const SizedBox(width: Dimens.spacingMd),
          HomeCtaCard(
            icon: LucideIcons.users,
            title: l10n.homeCtaAgentsTitle,
            body: l10n.homeCtaAgentsBody,
            actionLabel: l10n.homeCtaAgentsAction,
            onPressed: () => _open(context, FeatureKey.mesAgents),
          ),
        ],
      ),
    );
  }

  /// Routes to the destination when allowed, or to the explainer that says what
  /// would unblock it.
  void _open(BuildContext context, FeatureKey feature) {
    final decision = getIt<AccessPolicy>().check(feature, _accessOf(context));

    if (decision case AccessDenied(:final restriction, :final requiredTier)) {
      context.router.push(
        AccessRestrictedRoute(
          restriction: restriction,
          requiredTier: requiredTier,
        ),
      );
      return;
    }

    context.router.push(const MesBiensRoute());
  }
}

class _StatsSection extends StatelessWidget {
  const _StatsSection();

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => switch (state) {
        HomeInitial() || HomeLoadInProgress() => const Padding(
            padding: EdgeInsets.all(Dimens.spacingXl),
            child: Center(child: Loader()),
          ),
        HomeFailure() => _StatsError(
            message: l10n.commonError,
            retryLabel: l10n.commonRetry,
            onRetry: () =>
                context.read<HomeBloc>().add(const HomeLoadRequested()),
          ),
        HomeReady(:final stats, :final fromCache) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (fromCache) ...[
                _OfflineBanner(label: l10n.homeOfflineBanner),
                const SizedBox(height: Dimens.spacingSm),
              ],
              GlobalStatsCard(
                stats: stats,
                access: _accessOf(context),
                policy: getIt<AccessPolicy>(),
                // Straight to the plans — the explainer would be a detour now
                // that there is somewhere real to send them.
                onUpgrade: () => context.router.push(const PlansRoute()),
              ),
            ],
          ),
      },
    );
  }
}

class _OfflineBanner extends StatelessWidget {
  const _OfflineBanner({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.spacingMd,
        vertical: Dimens.spacingXs,
      ),
      decoration: BoxDecoration(
        color: colors.warning.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(Dimens.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LucideIcons.cloudOff, size: Dimens.iconSm, color: colors.warning),
          const SizedBox(width: Dimens.spacingXs),
          Text(
            label,
            style: context.mboaText.caption.copyWith(color: colors.warning),
          ),
        ],
      ),
    );
  }
}

class _StatsError extends StatelessWidget {
  const _StatsError({
    required this.message,
    required this.retryLabel,
    required this.onRetry,
  });

  final String message;
  final String retryLabel;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(message, style: context.mboaText.body),
        const SizedBox(height: Dimens.spacingSm),
        TextButton(onPressed: onRetry, child: Text(retryLabel)),
      ],
    );
  }
}

/// Assembles the gating context from the session-scoped blocs, so the policy
/// stays a pure function and the UI never re-derives the rules.
AccessContext _accessOf(BuildContext context) {
  final profileState = context.read<ProProfileBloc>().state;
  final kycState = context.read<KycCubit>().state;

  final role = profileState is ProProfileReady
      ? profileState.data.role
      : AccountRole.user;
  final kyc = kycState is KycReady ? kycState.status.status : null;

  return AccessContext(
    role: role,
    isKycApproved: kyc == KycStatus.approved,
    isKycPending: kyc == KycStatus.pending,
    tier: context.read<SubscriptionBloc>().state.tier,
  );
}
