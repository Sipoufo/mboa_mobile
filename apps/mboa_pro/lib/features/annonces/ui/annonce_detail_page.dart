import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../profile/profile_types.dart';
import '../../subscription/bloc/subscription_bloc.dart';
import '../bloc/annonces_bloc.dart';
import '../models/annonce.dart';
import '../models/annonce_status.dart';
import '../models/publish_gate.dart';
import 'widgets/annonce_status_chip.dart';

/// "Details du bien" (CDC M10).
///
/// Statistiques, Occupant and Historique have no endpoints, so they render the
/// "Aucune information disponible pour le moment" state the design itself
/// specifies for an empty listing.
@RoutePage()
class AnnonceDetailPage extends StatelessWidget {
  const AnnonceDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(title: Text(l10n.annonceDetailTitle)),
      body: BlocBuilder<AnnoncesBloc, AnnoncesState>(
        builder: (context, state) {
          if (state is! AnnoncesReady) {
            return const Center(child: Loader());
          }

          final annonce =
              state.items.where((a) => a.id == id).firstOrNull;
          if (annonce == null) {
            return Center(child: Text(l10n.commonError));
          }

          return ListView(
            padding: const EdgeInsets.all(Dimens.spacing),
            children: [
              _Header(annonce: annonce),
              const SizedBox(height: Dimens.spacing),
              _Actions(annonce: annonce, activeCount: state.activeCount),
              const SizedBox(height: Dimens.spacing),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: _EmptyCard(title: l10n.annonceDetailStats)),
                    const SizedBox(width: Dimens.spacingMd),
                    Expanded(
                      child: _EmptyCard(title: l10n.annonceDetailOccupant),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Dimens.spacingLg),
              Text(l10n.annonceDetailHistory, style: context.mboaText.h3),
              const SizedBox(height: Dimens.spacingLg),
              Center(
                child: Text(
                  l10n.annonceDetailNoInfo,
                  textAlign: TextAlign.center,
                  style: context.mboaText.body
                      .copyWith(color: context.mboaColors.primary),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.annonce});

  final Annonce annonce;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimens.radiusLg),
      child: Stack(
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: annonce.coverUrl == null
                ? ColoredBox(
                    color: colors.primaryPale,
                    child: Icon(LucideIcons.image, color: colors.primary),
                  )
                : Image.network(
                    annonce.coverUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) => ColoredBox(
                      color: colors.primaryPale,
                      child: Icon(LucideIcons.image, color: colors.primary),
                    ),
                  ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, colors.ink.withValues(alpha: 0.7)],
                ),
              ),
            ),
          ),
          Positioned(
            left: Dimens.spacing,
            right: Dimens.spacing,
            bottom: Dimens.spacing,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (annonce.monthlyRent case final rent?)
                  Text(
                    l10n.annoncesPerMonth(
                      NumberFormat.decimalPattern().format(rent),
                    ),
                    style: context.mboaText.label
                        .copyWith(color: colors.onBrand),
                  ),
                Text(
                  annonce.title,
                  style: context.mboaText.h2.copyWith(color: colors.onBrand),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: Dimens.spacingXs),
                Row(
                  children: [
                    Icon(
                      LucideIcons.mapPin,
                      size: Dimens.iconSm,
                      color: colors.onBrand,
                    ),
                    const SizedBox(width: Dimens.spacingXs),
                    Expanded(
                      child: Text(
                        annonce.district ?? annonce.city ?? '',
                        style: context.mboaText.caption
                            .copyWith(color: colors.onBrand),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    AnnonceStatusChip(status: annonce.status),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The lifecycle transitions available from this status, with the publish gate
/// applied (RM-M10-01 / RM-M10-02 / CE-M10-03).
class _Actions extends StatelessWidget {
  const _Actions({required this.annonce, required this.activeCount});

  final Annonce annonce;
  final int activeCount;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    final transitions = switch (annonce.status) {
      AnnonceStatus.draft => [AnnonceTransition.publish],
      AnnonceStatus.published => [
          AnnonceTransition.reserve,
          AnnonceTransition.markRented,
          AnnonceTransition.archive,
        ],
      AnnonceStatus.reserved => [
          AnnonceTransition.markRented,
          AnnonceTransition.archive,
        ],
      AnnonceStatus.rented => [AnnonceTransition.archive],
      AnnonceStatus.archived => [AnnonceTransition.unarchive],
      AnnonceStatus.unknown => <AnnonceTransition>[],
    };

    if (transitions.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: Dimens.spacingSm,
      runSpacing: Dimens.spacingSm,
      children: [
        for (final transition in transitions)
          OutlinedButton(
            onPressed: () => _run(context, transition),
            child: Text(
              switch (transition) {
                AnnonceTransition.publish => l10n.annonceActionPublish,
                AnnonceTransition.reserve => l10n.annonceActionReserve,
                AnnonceTransition.markRented => l10n.annonceActionMarkRented,
                AnnonceTransition.archive => l10n.annonceActionArchive,
                AnnonceTransition.unarchive => l10n.annonceActionUnarchive,
              },
            ),
          ),
      ],
    );
  }

  void _run(BuildContext context, AnnonceTransition transition) {
    if (transition == AnnonceTransition.publish && !_canPublish(context)) {
      return;
    }
    context
        .read<AnnoncesBloc>()
        .add(AnnonceStatusChangeRequested(annonce.id, transition));
  }

  /// Runs the publish gate and explains the block. Returns false when blocked.
  bool _canPublish(BuildContext context) {
    final l10n = I18n.of(context);
    const gate = PublishGate();

    final profileState = context.read<ProProfileBloc>().state;
    final profile =
        profileState is ProProfileReady ? profileState.data : null;
    final subscription = context.read<SubscriptionBloc>().state;
    final plan = subscription is SubscriptionReady ? subscription.plan : null;

    final decision = gate.check(
      // RM-M10-01 — photo, type and city.
      profileComplete: profile != null &&
          profile.photoObjectKey != null &&
          profile.type != null &&
          (profile.mainCityId ?? profile.searchCityId) != null,
      photoCount: annonce.photoKeys.length,
      activeCount: activeCount,
      activeListingLimit: plan?.activeListingLimit,
    );

    if (decision.isAllowed) return true;

    final (title, body) = switch (decision.blocker!) {
      PublishBlocker.incompleteProfile => (
          l10n.publishBlockedProfileTitle,
          l10n.publishBlockedProfileBody,
        ),
      PublishBlocker.notEnoughPhotos => (
          l10n.publishBlockedPhotosTitle,
          l10n.publishBlockedPhotosBody(3),
        ),
      PublishBlocker.listingLimitReached => (
          l10n.publishBlockedLimitTitle,
          l10n.publishBlockedLimitBody(
            (gate.nextTier(subscription.tier) ?? SubscriptionTier.proPlus).label,
          ),
        ),
    };

    MboaToast.warning(context: context, title: title, description: body);
    return false;
  }
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({required this.title});

  final String title;

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
          Text(title, style: context.mboaText.h3),
          const SizedBox(height: Dimens.spacingLg),
          Text(
            l10n.annonceDetailNoInfo,
            textAlign: TextAlign.center,
            style: context.mboaText.caption.copyWith(color: colors.primary),
          ),
          const SizedBox(height: Dimens.spacingSm),
          Center(
            child: Icon(LucideIcons.info, size: Dimens.icon, color: colors.primary),
          ),
        ],
      ),
    );
  }
}
