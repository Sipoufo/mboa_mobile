import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../../../app/widgets/day_timeline.dart';
import '../bloc/rents_bloc.dart';
import '../bloc/waiting_declarations_bloc.dart';

/// "Loyers" (CDC M30, the landlord's side) — after the reservation inbox, so
/// the two read as one family: what waits for an answer first, as a timeline
/// by day; then the tenants' spaces.
///
/// Every rent on his listings, or one listing's (a residence's units') when
/// opened from its fiche.
@RoutePage()
class RentsPage extends StatelessWidget implements AutoRouteWrapper {
  const RentsPage({super.key, this.annonceId, this.annonceTitle, this.unitIds});

  /// Set to list one listing's rents.
  final String? annonceId;

  /// What the list is about — a listing's title, or a residence's name.
  final String? annonceTitle;

  /// Set to list a residence's units' rents.
  final List<String>? unitIds;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<RentsBloc>(
        create: (_) => getIt<RentsBloc>(param1: unitIds?.toSet() ?? (annonceId == null ? null : {annonceId!}))
          ..add(const RentsRequested()),
        child: this,
      );

  @override
  Widget build(BuildContext context) => RentsView(annonceTitle: annonceTitle);
}

/// The lists under their bloc — public so they can be pumped with a mock one.
class RentsView extends StatelessWidget {
  const RentsView({super.key, this.annonceTitle});

  final String? annonceTitle;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(leading: const MboaHeaderBackButton(), title: Text(l10n.proRentsTitle)),
      body: BlocBuilder<RentsBloc, RentsState>(
        builder: (context, state) => switch (state) {
          RentsLoading() => const Center(child: Loader()),
          RentsFailure() => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n.commonError, style: context.mboaText.body.copyWith(color: colors.textSecondary)),
                  TextButton(
                    onPressed: () => context.read<RentsBloc>().add(const RentsRequested()),
                    child: Text(l10n.commonRetry),
                  ),
                ],
              ),
            ),
          final RentsReady ready => _Lists(state: ready, annonceTitle: annonceTitle),
        },
      ),
    );
  }
}

enum _Tab { waiting, homes }

class _Lists extends StatefulWidget {
  const _Lists({required this.state, this.annonceTitle});

  final RentsReady state;
  final String? annonceTitle;

  @override
  State<_Lists> createState() => _ListsState();
}

/// The tab is view state, not data — the lists themselves are the bloc's.
class _ListsState extends State<_Lists> {
  _Tab _tab = _Tab.waiting;

  /// Back from an answer or a space: the lists and the home's counter are
  /// read again.
  Future<void> _open(PageRouteInfo route) async {
    final bloc = context.read<RentsBloc>();
    await context.router.push(route);
    bloc.add(const RentsRequested());
    if (getIt.isRegistered<WaitingDeclarationsBloc>()) {
      getIt<WaitingDeclarationsBloc>().add(const WaitingDeclarationsRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final state = widget.state;
    final empty = switch (_tab) {
      _Tab.waiting when state.waiting.isEmpty => l10n.proRentsEmptyWaiting,
      _Tab.homes when state.homes.isEmpty => l10n.proRentsEmptyHomes,
      _ => null,
    };

    return RefreshIndicator(
      onRefresh: () async => context.read<RentsBloc>().add(const RentsRequested()),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, Dimens.spacing, Dimens.screenMargin, Dimens.spacingXl),
        children: [
          if (widget.annonceTitle case final title?) ...[
            Row(
              children: [
                Icon(LucideIcons.house, size: Dimens.iconSm, color: colors.primary),
                const SizedBox(width: Dimens.spacingXs),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.mboaText.label.copyWith(color: colors.primary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimens.spacingMd),
          ],
          if (state.isOffline) ...[
            _OfflineBanner(text: l10n.proRentsOffline),
            const SizedBox(height: Dimens.spacingMd),
          ],
          MboaSegmentedControl<_Tab>(
            value: _tab,
            onChanged: (tab) => setState(() => _tab = tab),
            segments: [
              MboaSegment(value: _Tab.waiting, label: '${l10n.proRentsTabWaiting} (${state.waiting.length})'),
              MboaSegment(value: _Tab.homes, label: '${l10n.proRentsTabHomes} (${state.homes.length})'),
            ],
          ),
          const SizedBox(height: Dimens.spacingLg),
          if (empty != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.spacingXl),
              child: Column(
                children: [
                  Icon(
                    _tab == _Tab.waiting ? LucideIcons.handCoins : LucideIcons.house,
                    size: Dimens.iconLg,
                    color: colors.textTertiary,
                  ),
                  const SizedBox(height: Dimens.spacing),
                  Text(
                    empty,
                    textAlign: TextAlign.center,
                    style: context.mboaText.body.copyWith(color: colors.textSecondary),
                  ),
                ],
              ),
            )
          else if (_tab == _Tab.waiting)
            DayTimeline<Declaration>(
              items: state.waiting,
              dayOf: (d) => d.declaredAt,
              itemBuilder: (d) => _Row(
                declaration: d,
                onTap: () => _open(ReceivedDeclarationRoute(declarationId: d.id)),
              ),
            )
          else
            for (final (index, home) in state.homes.indexed) ...[
              if (index > 0) const SizedBox(height: Dimens.spacingMd),
              HomeCard(
                home: home,
                viewer: ContractParty.prestataire,
                onTap: () => _open(TenantHomeRoute(contractId: home.contractId)),
              ),
            ],
        ],
      ),
    );
  }
}

/// A declared payment in the inbox: how much, from whom on what, how.
class _Row extends StatelessWidget {
  const _Row({required this.declaration, required this.onTap});

  final Declaration declaration;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final d = declaration;
    final at = d.declaredAt;
    final what = declarationWhat(l10n, d);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Dimens.radius),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.spacingSm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MethodTile(method: d.method, size: 32),
            const SizedBox(width: Dimens.spacingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(fcfaOf(context, d.amount), style: context.mboaText.label.copyWith(color: colors.primaryDark)),
                  Text(
                    [d.tenant?.displayName ?? l10n.declarationTenant, d.annonceTitle ?? l10n.reservationUntitled].join(' · '),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.mboaText.caption.copyWith(color: colors.ink),
                  ),
                  Text(
                    '$what · ${methodLabel(l10n, d.method)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                  ),
                  const SizedBox(height: Dimens.spacingXs),
                  Wrap(
                    spacing: Dimens.spacingSm,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      if (at != null)
                        Text(DateFormat.Hm(locale).format(at), style: context.mboaText.micro.copyWith(color: colors.textTertiary)),
                      DeclarationStatusChip(status: d.status),
                      if (!d.hasProof)
                        Text(l10n.myHomeNoProof, style: context.mboaText.micro.copyWith(color: colors.textTertiary)),
                    ],
                  ),
                ],
              ),
            ),
            Icon(LucideIcons.chevronRight, size: Dimens.icon, color: colors.textTertiary),
          ],
        ),
      ),
    );
  }
}

class _OfflineBanner extends StatelessWidget {
  const _OfflineBanner({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Container(
      padding: const EdgeInsets.all(Dimens.spacingMd),
      decoration: BoxDecoration(
        color: colors.warning.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(Dimens.radius),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.wifiOff, size: Dimens.iconSm, color: colors.warning),
          const SizedBox(width: Dimens.spacingSm),
          Expanded(child: Text(text, style: context.mboaText.caption.copyWith(color: colors.warning))),
        ],
      ),
    );
  }
}
