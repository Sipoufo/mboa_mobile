import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/inbox_bloc.dart';
import '../models/inbox_item.dart';
import '../models/push_message.dart';

/// The notifications page (§38), both apps: what Mboa said, day by day, 30
/// days back. An item opens where its push opens — [onOpen] is the app's own
/// push router (CA-M03-02).
class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key, required this.onOpen});

  final void Function(PushMessage message) onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return BlocConsumer<InboxBloc, InboxState>(
      listenWhen: (previous, current) => current is InboxReady && current.allReadFailed,
      listener: (context, state) => MboaToast.error(context: context, title: l10n.notificationsMarkAllFailed),
      builder: (context, state) => switch (state) {
        InboxInitial() || InboxLoading() => const Center(child: Loader()),
        InboxFailure() => Center(
            child: TextButton(
              onPressed: () => context.read<InboxBloc>().add(const InboxRequested()),
              child: Text(l10n.commonRetry),
            ),
          ),
        final InboxReady ready when ready.items.isEmpty => const _Empty(),
        final InboxReady ready => _List(state: ready, onOpen: onOpen),
      },
    );
  }
}

class _List extends StatelessWidget {
  const _List({required this.state, required this.onOpen});

  final InboxReady state;
  final void Function(PushMessage message) onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final bloc = context.read<InboxBloc>();

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.extentAfter < 400) bloc.add(const InboxNextPageRequested());
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () async => bloc.add(const InboxRequested()),
        child: ListView(
          padding: const EdgeInsets.all(Dimens.spacing),
          children: [
            if (state.isOffline) ...[
              Text(l10n.homeOfflineBanner, style: context.mboaText.caption.copyWith(color: colors.warning)),
              const SizedBox(height: Dimens.spacingSm),
            ],
            if (state.unread > 0 && !state.isOffline)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () => bloc.add(const InboxAllReadRequested()),
                  icon: const Icon(LucideIcons.checkCheck, size: Dimens.iconSm),
                  label: Text(l10n.notificationsMarkAllRead),
                ),
              ),
            for (final (day, items) in state.byDay) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(Dimens.spacingXs, Dimens.spacingSm, 0, Dimens.spacingSm),
                child: Text(
                  _dayLabel(context, day),
                  style: context.mboaText.label.copyWith(color: colors.primaryDark, fontWeight: FontWeight.w700),
                ),
              ),
              for (final item in items)
                _Tile(
                  item: item,
                  onTap: () {
                    bloc.add(InboxItemOpened(item.id));
                    onOpen(item.asPush);
                  },
                ),
            ],
            if (state.isLoadingMore)
              const Padding(padding: EdgeInsets.all(Dimens.spacing), child: Center(child: Loader())),
          ],
        ),
      ),
    );
  }

  static String _dayLabel(BuildContext context, DateTime day) {
    final l10n = I18n.of(context);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (day == today) return l10n.historyToday;
    if (day == today.subtract(const Duration(days: 1))) return l10n.historyYesterday;
    final locale = Localizations.localeOf(context).toLanguageTag();
    return toBeginningOfSentenceCase(DateFormat.yMMMMEEEEd(locale).format(day), locale);
  }
}

/// One notification: what it is about, its words, its time — and, unread,
/// the brand's tint and a dot.
class _Tile extends StatelessWidget {
  const _Tile({required this.item, required this.onTap});

  final InboxItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final at = item.createdAt;
    final unread = !item.isRead;

    return Container(
      margin: const EdgeInsets.only(bottom: Dimens.spacingSm),
      decoration: BoxDecoration(
        color: unread ? colors.primaryPale : colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacingMd),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(Dimens.spacingSm),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: unread ? colors.surface : colors.surfaceWarm,
                ),
                child: Icon(_icon(item.type), size: Dimens.icon, color: colors.primary),
              ),
              const SizedBox(width: Dimens.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title ?? '',
                      style: context.mboaText.label.copyWith(
                        color: colors.ink,
                        fontWeight: unread ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                    if (item.body case final body? when body.trim().isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        body,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: Dimens.spacingSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (at != null)
                    Text(
                      DateFormat.Hm(Localizations.localeOf(context).toLanguageTag()).format(at),
                      style: context.mboaText.micro.copyWith(color: colors.textTertiary),
                    ),
                  if (unread) ...[
                    const SizedBox(height: Dimens.spacingSm),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(color: colors.action, shape: BoxShape.circle),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static IconData _icon(PushType type) => switch (type) {
        PushType.message => LucideIcons.messageCircle,
        PushType.visit => LucideIcons.calendarCheck,
        PushType.contract => LucideIcons.fileSignature,
        PushType.annonce || PushType.residence => LucideIcons.house,
        PushType.savedSearch => LucideIcons.bookmark,
        PushType.reservation => LucideIcons.ticket,
        PushType.home || PushType.homeRequest || PushType.homeEvidence => LucideIcons.keyRound,
        PushType.invoice => LucideIcons.receipt,
        PushType.paymentConfirmed || PushType.financeAddon => LucideIcons.wallet,
        PushType.kyc => LucideIcons.badgeCheck,
        PushType.unknown => LucideIcons.bell,
      };
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
            Icon(LucideIcons.bellOff, size: Dimens.iconLg, color: colors.textTertiary),
            const SizedBox(height: Dimens.spacing),
            Text(l10n.notificationsEmptyTitle, style: context.mboaText.h3.copyWith(color: colors.ink)),
            const SizedBox(height: Dimens.spacingXs),
            Text(
              l10n.notificationsEmptyBody,
              textAlign: TextAlign.center,
              style: context.mboaText.body.copyWith(color: colors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
