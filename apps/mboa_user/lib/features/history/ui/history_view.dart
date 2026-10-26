import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../bloc/history_bloc.dart';
import '../models/history_entry.dart';

/// The fiches the tenant opened, day by day (CDC M06, RM-M06-05) — in the
/// favourites' own cards, the time it was opened where the heart sits.
class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) => switch (state) {
        HistoryInitial() || HistoryLoading() => const Center(child: Loader()),
        HistoryFailure() => Center(
            child: TextButton(
              onPressed: () => context.read<HistoryBloc>().add(const HistoryRequested()),
              child: Text(l10n.commonRetry),
            ),
          ),
        final HistoryReady ready when ready.entries.isEmpty => const _Empty(),
        final HistoryReady ready => RefreshIndicator(
            onRefresh: () async => context.read<HistoryBloc>().add(const HistoryRequested()),
            child: ListView(
              padding: const EdgeInsets.all(Dimens.spacing),
              children: [
                if (ready.isOffline) ...[
                  Text(l10n.homeOfflineBanner, style: context.mboaText.caption.copyWith(color: colors.warning)),
                  const SizedBox(height: Dimens.spacingSm),
                ],
                for (final (day, entries) in ready.byDay) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(Dimens.spacingXs, Dimens.spacingSm, 0, Dimens.spacingSm),
                    child: Text(
                      _dayLabel(context, day),
                      style: context.mboaText.label.copyWith(color: colors.primaryDark, fontWeight: FontWeight.w700),
                    ),
                  ),
                  for (final entry in entries) _HistoryCard(entry: entry),
                ],
              ],
            ),
          ),
      },
    );
  }

  static String _dayLabel(BuildContext context, DateTime day) {
    final l10n = I18n.of(context);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (day == today) return l10n.historyToday;
    if (day == today.subtract(const Duration(days: 1))) return l10n.historyYesterday;
    final locale = Localizations.localeOf(context).toLanguageTag();
    // A heading: « Vendredi 2 octobre », not « vendredi 2 octobre ».
    return toBeginningOfSentenceCase(DateFormat.yMMMMEEEEd(locale).format(day), locale);
  }
}

class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.spacingXl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LucideIcons.history, size: Dimens.iconLg, color: colors.textTertiary),
            const SizedBox(height: Dimens.spacing),
            Text(l10n.historyEmptyTitle, style: context.mboaText.h3.copyWith(color: colors.ink)),
            const SizedBox(height: Dimens.spacingXs),
            Text(
              l10n.historyEmptyBody,
              textAlign: TextAlign.center,
              style: context.mboaText.body.copyWith(color: colors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.entry});

  final HistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final at = entry.viewedAt;

    return Container(
      margin: const EdgeInsets.only(bottom: Dimens.spacingSm),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        // A deleted listing has nothing to open; the row stays as a record.
        onTap: switch (entry.annonceId) {
          final id? => () => context.router.push(ListingDetailRoute(id: id)),
          null => null,
        },
        child: Opacity(
          opacity: entry.isAvailable ? 1 : 0.6,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacingMd),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Dimens.radius),
                  child: SizedBox(
                    width: 72,
                    height: 72,
                    child: MboaNetworkImage(
                      url: entry.photoUrl,
                      placeholder: const MboaImagePlaceholder(size: 72),
                    ),
                  ),
                ),
                const SizedBox(width: Dimens.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.title ?? '',
                        style: context.mboaText.label.copyWith(color: colors.ink),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: Dimens.spacingXs),
                      if (entry.displayPrice case final price?)
                        Text(
                          entry.rentalPeriod.priceLabel(l10n, price),
                          style: context.mboaText.caption.copyWith(color: colors.action),
                        ),
                      Text(
                        [entry.district, entry.city].nonNulls.join(', '),
                        style: context.mboaText.caption.copyWith(color: colors.textTertiary),
                      ),
                      if (!entry.isAvailable) ...[
                        const SizedBox(height: Dimens.spacingXs),
                        Text(l10n.historyUnavailable, style: context.mboaText.caption.copyWith(color: colors.error)),
                      ],
                    ],
                  ),
                ),
                if (at != null) ...[
                  const SizedBox(width: Dimens.spacingSm),
                  Text(
                    l10n.historyViewedAt(DateFormat.Hm(Localizations.localeOf(context).toLanguageTag()).format(at)),
                    style: context.mboaText.micro.copyWith(color: colors.textTertiary),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
