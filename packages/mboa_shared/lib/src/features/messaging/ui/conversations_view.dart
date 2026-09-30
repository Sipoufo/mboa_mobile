import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/conversations_bloc.dart';
import '../models/conversation.dart';

/// The list of threads (CDC M12), identical in both apps.
///
/// Each app wraps it in its own route and decides where a tap goes; what a
/// conversation *looks like* is the same on both sides, so it lives here.
class ConversationsView extends StatelessWidget {
  const ConversationsView({super.key, required this.onOpen, this.emptyBody});

  final ValueChanged<Conversation> onOpen;

  /// The two sides have different reasons for an empty list: a tenant has not
  /// written to anyone yet, a prestataire has not been written to (RM-M12-01
  /// gives the tenant the first word).
  final String? emptyBody;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return BlocBuilder<ConversationsBloc, ConversationsState>(
      builder: (context, state) => switch (state) {
        ConversationsInitial() || ConversationsLoadInProgress() =>
          const Center(child: Loader()),
        ConversationsFailure() => Center(
            child: TextButton(
              onPressed: () => context
                  .read<ConversationsBloc>()
                  .add(const ConversationsLoadRequested()),
              child: Text(l10n.commonRetry),
            ),
          ),
        final ConversationsReady ready => ready.items.isEmpty
            ? _Empty(body: emptyBody)
            : RefreshIndicator(
                onRefresh: () async => context
                    .read<ConversationsBloc>()
                    .add(const ConversationsRefreshed()),
                child: ListView.builder(
                  padding: const EdgeInsets.all(Dimens.spacing),
                  itemCount: ready.items.length,
                  itemBuilder: (context, index) => _ConversationTile(
                    conversation: ready.items[index],
                    onTap: () => onOpen(ready.items[index]),
                  ),
                ),
              ),
      },
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({this.body});

  final String? body;

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
            Icon(
              LucideIcons.messageSquare,
              size: Dimens.iconLg,
              color: colors.textTertiary,
            ),
            const SizedBox(height: Dimens.spacing),
            Text(
              l10n.messagingEmptyTitle,
              style: context.mboaText.h3.copyWith(color: colors.ink),
            ),
            if (body != null) ...[
              const SizedBox(height: Dimens.spacingXs),
              Text(
                body!,
                textAlign: TextAlign.center,
                style:
                    context.mboaText.body.copyWith(color: colors.textSecondary),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  const _ConversationTile({required this.conversation, required this.onTap});

  final Conversation conversation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Container(
      margin: const EdgeInsets.only(bottom: Dimens.spacingSm),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacing),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MboaAvatar(
                imageUrl: conversation.peerPhotoUrl,
                initials: (conversation.peerName ?? '').isEmpty
                    ? ''
                    : conversation.peerName![0].toUpperCase(),
                size: Dimens.avatar,
              ),
              const SizedBox(width: Dimens.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            conversation.peerName ?? '',
                            style: context.mboaText.label
                                .copyWith(color: colors.ink),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (conversation.lastMessageAt case final at?)
                          Text(
                            _stamp(at),
                            style: context.mboaText.caption
                                .copyWith(color: colors.textTertiary),
                          ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    // RM-M12-02 — the thread is about a property, and the
                    // subtitle says which: two threads with the same person
                    // are two different conversations.
                    Text(
                      conversation.annonceTitle ?? '',
                      style: context.mboaText.caption
                          .copyWith(color: colors.primary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: Dimens.spacingXs),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            conversation.lastMessage ?? '',
                            style: context.mboaText.caption.copyWith(
                              color: conversation.hasUnread
                                  ? colors.ink
                                  : colors.textSecondary,
                              fontWeight: conversation.hasUnread
                                  ? FontWeight.w600
                                  : null,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (conversation.hasUnread) ...[
                          const SizedBox(width: Dimens.spacingSm),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimens.spacingSm,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: colors.primary,
                              borderRadius:
                                  BorderRadius.circular(Dimens.radiusFull),
                            ),
                            child: Text(
                              '${conversation.unreadCount}',
                              style: context.mboaText.caption
                                  .copyWith(color: colors.onBrand),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Today's exchanges read as an hour; older ones as a date.
  static String _stamp(DateTime at) {
    final now = DateTime.now();
    final sameDay =
        at.year == now.year && at.month == now.month && at.day == now.day;
    return sameDay ? DateFormat.Hm().format(at) : DateFormat.yMMMd().format(at);
  }
}
