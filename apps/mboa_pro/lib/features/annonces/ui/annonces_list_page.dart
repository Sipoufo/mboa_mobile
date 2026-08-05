import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../bloc/annonces_bloc.dart';
import '../models/annonce.dart';
import '../models/annonce_draft.dart';
import '../models/annonce_status.dart';
import 'widgets/annonce_card.dart';

/// Biens Uniques list, Disponibles / Occupés (CDC M10).
@RoutePage()
class AnnoncesListPage extends StatefulWidget {
  const AnnoncesListPage({super.key});

  @override
  State<AnnoncesListPage> createState() => _AnnoncesListPageState();
}

class _AnnoncesListPageState extends State<AnnoncesListPage> {
  @override
  void initState() {
    super.initState();
    // The bloc is session-scoped (AuthenticatedWrapper); loading happens here
    // so nothing is fetched until this screen is actually opened.
    context.read<AnnoncesBloc>().add(const AnnoncesLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: Text(l10n.annoncesSingleTitle)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.router.push(
          AnnonceFormRoute(kind: AnnonceKind.single),
        ),
        backgroundColor: colors.primary,
        foregroundColor: colors.onBrand,
        child: const Icon(LucideIcons.plus),
      ),
      body: BlocConsumer<AnnoncesBloc, AnnoncesState>(
        listenWhen: (prev, curr) =>
            curr is AnnoncesReady && curr.lastActionFailed,
        listener: (context, state) => MboaToast.error(
          context: context,
          title: l10n.commonErrorTitle,
          description: l10n.annonceActionFailed,
        ),
        builder: (context, state) => switch (state) {
          AnnoncesInitial() || AnnoncesLoadInProgress() =>
            const Center(child: Loader()),
          AnnoncesFailure() => _Error(
              onRetry: () =>
                  context.read<AnnoncesBloc>().add(const AnnoncesLoadRequested()),
            ),
          AnnoncesReady() => _Loaded(state: state),
        },
      ),
    );
  }
}

class _Loaded extends StatelessWidget {
  const _Loaded({required this.state});

  final AnnoncesReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final items = state.visible;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(Dimens.spacing),
          child: MboaSegmentedControl<AnnonceFilter>(
            value: state.filter,
            segments: [
              MboaSegment(
                value: AnnonceFilter.available,
                label: l10n.annoncesTabAvailable,
              ),
              MboaSegment(
                value: AnnonceFilter.occupied,
                label: l10n.annoncesTabOccupied,
              ),
            ],
            onChanged: (filter) =>
                context.read<AnnoncesBloc>().add(AnnoncesFilterChanged(filter)),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async => context
                .read<AnnoncesBloc>()
                .add(const AnnoncesRefreshRequested()),
            child: items.isEmpty
                ? _Empty(
                    label: state.filter == AnnonceFilter.available
                        ? l10n.annoncesEmptyAvailable
                        : l10n.annoncesEmptyOccupied,
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      Dimens.spacing,
                      0,
                      Dimens.spacing,
                      Dimens.spacing3Xl,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final annonce = items[index];
                      return AnnonceCard(
                        annonce: annonce,
                        activeCount: state.activeCount,
                        isBusy: state.mutatingId == annonce.id,
                        onTransition: (transition) => context
                            .read<AnnoncesBloc>()
                            .add(AnnonceStatusChangeRequested(
                              annonce.id,
                              transition,
                            )),
                        onTap: () => context.router
                            .push(AnnonceDetailRoute(id: annonce.id)),
                        onEdit: () => _edit(context, annonce),
                        onHistory: () => _comingSoon(context),
                        onAttributions: () => _comingSoon(context),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }

  void _edit(BuildContext context, Annonce annonce) => context.router.push(
        AnnonceFormRoute(kind: AnnonceKind.single, annonceId: annonce.id),
      );

  void _comingSoon(BuildContext context) => context.router.push(
        AccessRestrictedRoute(restriction: AccessRestriction.comingSoon),
      );
}

class _Empty extends StatelessWidget {
  const _Empty({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    // Scrollable so pull-to-refresh still works with nothing on screen.
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        const SizedBox(height: Dimens.spacing3Xl),
        Padding(
          padding: const EdgeInsets.all(Dimens.spacingXl),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: context.mboaText.body
                .copyWith(color: context.mboaColors.textSecondary),
          ),
        ),
      ],
    );
  }
}

class _Error extends StatelessWidget {
  const _Error({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.commonError, style: context.mboaText.body),
          const SizedBox(height: Dimens.spacingSm),
          TextButton(onPressed: onRetry, child: Text(l10n.commonRetry)),
        ],
      ),
    );
  }
}
