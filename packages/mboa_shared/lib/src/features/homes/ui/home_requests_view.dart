import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../messaging/models/conversation.dart';
import '../bloc/home_request_bloc.dart';
import '../bloc/home_requests_bloc.dart';
import '../data/home_requests_repository.dart';
import '../models/home_request.dart';

/// A request type's word and icon.
({String label, IconData icon}) homeRequestTypeLook(I18n l10n, HomeRequestType type) => switch (type) {
      HomeRequestType.remark => (label: l10n.requestTypeRemark, icon: LucideIcons.messageCircle),
      HomeRequestType.maintenance => (label: l10n.requestTypeMaintenance, icon: LucideIcons.wrench),
      HomeRequestType.question => (label: l10n.requestTypeQuestion, icon: LucideIcons.circleHelp),
    };

String homeRequestStatusLabel(I18n l10n, HomeRequestStatus status) => switch (status) {
      HomeRequestStatus.sent => l10n.requestStatusSent,
      HomeRequestStatus.seen => l10n.requestStatusSeen,
      HomeRequestStatus.inProgress => l10n.requestStatusInProgress,
      HomeRequestStatus.resolved => l10n.requestStatusResolved,
      HomeRequestStatus.closed => l10n.requestStatusClosed,
      HomeRequestStatus.unknown => l10n.reservationStatusUnknown,
    };

class HomeRequestStatusChip extends StatelessWidget {
  const HomeRequestStatusChip({super.key, required this.status});

  final HomeRequestStatus status;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final tone = switch (status) {
      HomeRequestStatus.sent || HomeRequestStatus.seen => colors.warning,
      HomeRequestStatus.inProgress => colors.primary,
      HomeRequestStatus.resolved => colors.success,
      HomeRequestStatus.closed || HomeRequestStatus.unknown => colors.textTertiary,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingSm, vertical: 2),
      decoration: BoxDecoration(color: tone.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(Dimens.radiusFull)),
      child: Text(
        homeRequestStatusLabel(I18n.of(context), status),
        style: context.mboaText.caption.copyWith(color: tone, fontWeight: FontWeight.w600),
      ),
    );
  }
}

/// A list of requests (CDC M30, RM-M30-09): a home's, or the landlord's
/// inbox. The tenant's has one main action, « Nouvelle demande » ([onNew]).
class HomeRequestsView extends StatelessWidget {
  const HomeRequestsView({super.key, required this.onOpen, this.onNew, this.title, this.showTenant = false});

  final ValueChanged<HomeRequest> onOpen;
  final VoidCallback? onNew;

  /// What the list is about — a home's title.
  final String? title;

  /// The landlord's inbox names who asked.
  final bool showTenant;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocBuilder<HomeRequestsBloc, HomeRequestsState>(
      builder: (context, state) => Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(leading: const MboaHeaderBackButton(), title: Text(l10n.requestsTitle)),
        body: switch (state) {
          HomeRequestsLoading() => const Center(child: Loader()),
          HomeRequestsFailure() => Center(
              child: TextButton(
                onPressed: () => context.read<HomeRequestsBloc>().add(const HomeRequestsRequested()),
                child: Text(l10n.commonRetry),
              ),
            ),
          HomeRequestsReady(:final items, :final isOffline) => RefreshIndicator(
              onRefresh: () async => context.read<HomeRequestsBloc>().add(const HomeRequestsRequested()),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, Dimens.spacing, Dimens.screenMargin, Dimens.spacingXl),
                children: [
                  if (title case final title?) ...[
                    Text(title, style: context.mboaText.label.copyWith(color: colors.primary)),
                    const SizedBox(height: Dimens.spacingMd),
                  ],
                  if (isOffline) ...[
                    Text(l10n.requestsOffline, style: context.mboaText.caption.copyWith(color: colors.warning)),
                    const SizedBox(height: Dimens.spacingMd),
                  ],
                  if (items.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimens.spacingXl),
                      child: Column(
                        children: [
                          Icon(LucideIcons.messagesSquare, size: Dimens.iconLg, color: colors.textTertiary),
                          const SizedBox(height: Dimens.spacing),
                          Text(
                            onNew == null ? l10n.requestsEmptyLandlord : l10n.requestsEmptyTenant,
                            textAlign: TextAlign.center,
                            style: context.mboaText.body.copyWith(color: colors.textSecondary),
                          ),
                        ],
                      ),
                    )
                  else
                    for (final request in items)
                      _RequestRow(request: request, showTenant: showTenant, onTap: () => onOpen(request)),
                ],
              ),
            ),
        },
        bottomNavigationBar: onNew == null
            ? null
            : Container(
                decoration: BoxDecoration(color: colors.surface, border: Border(top: BorderSide(color: colors.border))),
                child: SafeArea(
                  minimum: const EdgeInsets.all(Dimens.spacing),
                  child: Button.primary(title: l10n.requestNew, onPressed: onNew),
                ),
              ),
      ),
    );
  }
}

class _RequestRow extends StatelessWidget {
  const _RequestRow({required this.request, required this.showTenant, required this.onTap});

  final HomeRequest request;
  final bool showTenant;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final look = homeRequestTypeLook(l10n, request.type);
    final at = request.updatedAt ?? request.createdAt;
    final meta = [
      if (showTenant) ?request.tenant?.displayName,
      if (showTenant) ?request.annonceTitle,
      if (at != null) DateFormat.MMMd(locale).format(at),
    ].join(' · ');

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Dimens.radius),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.spacingSm),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: colors.primaryPale, borderRadius: BorderRadius.circular(Dimens.radius)),
              child: Icon(look.icon, size: Dimens.icon, color: colors.primary),
            ),
            const SizedBox(width: Dimens.spacingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    request.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.mboaText.label.copyWith(color: colors.ink),
                  ),
                  Text(
                    [look.label, if (meta.isNotEmpty) meta].join(' · '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                  ),
                ],
              ),
            ),
            const SizedBox(width: Dimens.spacingSm),
            HomeRequestStatusChip(status: request.status),
          ],
        ),
      ),
    );
  }
}

/// One request (CDC M30, RM-M30-09) — what N-38 opens: what was asked, its
/// suivi, its exchanges and a reply. The step that comes next is the one
/// main action; the other behind "⋯" (Doc05 §6.1), only where the server
/// allows them.
class HomeRequestView extends StatefulWidget {
  const HomeRequestView({super.key});

  @override
  State<HomeRequestView> createState() => _HomeRequestViewState();
}

/// Only the reply's text field lives here; the exchanges are the bloc's.
class _HomeRequestViewState extends State<HomeRequestView> {
  final _reply = TextEditingController();

  @override
  void dispose() {
    _reply.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocConsumer<HomeRequestBloc, HomeRequestState>(
      listenWhen: (_, current) =>
          current is HomeRequestReady &&
          (current.moved || current.replied || current.refusal != null || current.failed || current.replyFailed),
      listener: (context, state) {
        final ready = state as HomeRequestReady;
        if (ready.replied) {
          _reply.clear();
        } else if (ready.moved) {
          MboaToast.success(context: context, title: l10n.requestMovedToast);
        } else {
          MboaToast.error(
            context: context,
            title: l10n.commonErrorTitle,
            description: switch (ready.refusal) {
              HomeRequestRefusal.transitionInvalid => l10n.requestRefusedTransition,
              HomeRequestRefusal.readOnly => l10n.requestRefusedReadOnly,
              null when ready.replyFailed => l10n.requestReplyFailed,
              null => l10n.commonError,
            },
          );
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(leading: const MboaHeaderBackButton(), title: Text(l10n.requestDetailTitle)),
        body: switch (state) {
          HomeRequestLoading() => const Center(child: Loader()),
          HomeRequestFailure(:final id) => Center(
              child: TextButton(
                onPressed: () => context.read<HomeRequestBloc>().add(HomeRequestOpened(id)),
                child: Text(l10n.commonRetry),
              ),
            ),
          final HomeRequestReady ready => _RequestBody(state: ready, reply: _reply),
        },
        bottomNavigationBar: state is HomeRequestReady ? _StepBar(state: state) : null,
      ),
    );
  }
}

class _RequestBody extends StatelessWidget {
  const _RequestBody({required this.state, required this.reply});

  final HomeRequestReady state;
  final TextEditingController reply;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final r = state.request;
    final look = homeRequestTypeLook(l10n, r.type);
    String when(DateTime d) => DateFormat.yMMMd(locale).add_Hm().format(d);
    Widget section(String text) => Padding(
          padding: const EdgeInsets.only(top: Dimens.spacingLg, bottom: Dimens.spacingSm),
          child: Text(text, style: context.mboaText.h3.copyWith(color: colors.primaryDark)),
        );

    return ListView(
      padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, Dimens.spacing, Dimens.screenMargin, Dimens.spacingXl),
      children: [
        Container(
          padding: const EdgeInsets.all(Dimens.spacing),
          decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(Dimens.radiusLg)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(look.icon, size: Dimens.iconSm, color: colors.primary),
                  const SizedBox(width: Dimens.spacingXs),
                  Text(look.label, style: context.mboaText.caption.copyWith(color: colors.primary)),
                  const Spacer(),
                  HomeRequestStatusChip(status: r.status),
                ],
              ),
              const SizedBox(height: Dimens.spacingSm),
              Text(r.title, style: context.mboaText.h3.copyWith(color: colors.ink)),
              Text(
                [?r.annonceTitle, ?r.tenant?.displayName, if (r.createdAt != null) when(r.createdAt!)].join(' · '),
                style: context.mboaText.caption.copyWith(color: colors.textSecondary),
              ),
              if (r.description case final description?) ...[
                const SizedBox(height: Dimens.spacingSm),
                Text(description, style: context.mboaText.body.copyWith(color: colors.ink)),
              ],
              if (r.photos.isNotEmpty) ...[
                const SizedBox(height: Dimens.spacingMd),
                Wrap(
                  spacing: Dimens.spacingSm,
                  runSpacing: Dimens.spacingSm,
                  children: [
                    for (final url in r.photos)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(Dimens.radius),
                        child: SizedBox.square(dimension: 88, child: MboaNetworkImage(url: url)),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
        if (r.history.isNotEmpty) ...[
          section(l10n.requestHistory),
          for (final step in r.history)
            Padding(
              padding: const EdgeInsets.only(bottom: Dimens.spacingSm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Icon(LucideIcons.circleDot, size: 12, color: colors.primary),
                  ),
                  const SizedBox(width: Dimens.spacingSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          [
                            homeRequestStatusLabel(l10n, step.status),
                            step.byLandlord ? l10n.requestByLandlord : l10n.requestByTenant,
                          ].join(' · '),
                          style: context.mboaText.label.copyWith(color: colors.ink),
                        ),
                        if (step.note case final note?)
                          Text('« $note »', style: context.mboaText.body.copyWith(color: colors.textSecondary)),
                        if (step.at case final at?)
                          Text(when(at), style: context.mboaText.micro.copyWith(color: colors.textTertiary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
        section(l10n.requestExchanges),
        if (state.messages.isEmpty)
          Text(l10n.requestNoExchange, style: context.mboaText.body.copyWith(color: colors.textSecondary)),
        for (final message in state.messages) _Exchange(message: message),
        if (state.canReply) ...[
          const SizedBox(height: Dimens.spacingSm),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: reply,
                  minLines: 1,
                  maxLines: 4,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(hintText: l10n.requestReplyHint),
                ),
              ),
              const SizedBox(width: Dimens.spacingSm),
              IconButton.filled(
                tooltip: l10n.requestSend,
                onPressed: state.isSending
                    ? null
                    : () => context.read<HomeRequestBloc>().add(HomeRequestReplySent(reply.text)),
                icon: const Icon(LucideIcons.send),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

/// One exchange: Mboa's sentence centred, the reader's own on the right,
/// the other party's on the left.
class _Exchange extends StatelessWidget {
  const _Exchange({required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final body = message.body?.trim() ?? '';
    if (body.isEmpty) return const SizedBox.shrink();

    if (message.isSystem) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.spacingXs),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingMd, vertical: Dimens.spacingXs),
            decoration: BoxDecoration(color: colors.primaryPale, borderRadius: BorderRadius.circular(Dimens.radiusFull)),
            child: Text(
              body,
              textAlign: TextAlign.center,
              style: context.mboaText.caption.copyWith(color: colors.primaryDark),
            ),
          ),
        ),
      );
    }

    return Align(
      alignment: message.isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 280),
        margin: const EdgeInsets.symmetric(vertical: Dimens.spacingXs),
        padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingMd, vertical: Dimens.spacingSm),
        decoration: BoxDecoration(
          color: message.isMine ? colors.primary : colors.surface,
          borderRadius: BorderRadius.circular(Dimens.radiusMd),
        ),
        child: Text(
          body,
          style: context.mboaText.body.copyWith(color: message.isMine ? colors.onBrand : colors.ink),
        ),
      ),
    );
  }
}

enum _Step { start, resolve, reopen, close }

/// The next step as the one main action, the other behind "⋯" — each only
/// where the server allows it; no bar when there is nothing to do.
class _StepBar extends StatelessWidget {
  const _StepBar({required this.state});

  final HomeRequestReady state;

  Future<void> _take(BuildContext context, _Step step) async {
    final l10n = I18n.of(context);
    final bloc = context.read<HomeRequestBloc>();
    // A word for the other party, if any — « Le plombier passe jeudi ».
    final note = await showDialog<String>(context: context, builder: (_) => _NoteDialog(l10n: l10n));
    if (note == null) return;
    bloc.add(switch (step) {
      _Step.start => HomeRequestMoved(HomeRequestStatus.inProgress, note: note),
      _Step.resolve => HomeRequestMoved(HomeRequestStatus.resolved, note: note),
      _Step.reopen => HomeRequestReopened(note: note),
      _Step.close => HomeRequestClosed(note: note),
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final r = state.request;
    final steps = [
      if (r.canStart) _Step.start,
      if (r.canResolve) _Step.resolve,
      if (r.canReopen) _Step.reopen,
      if (r.canClose) _Step.close,
    ];
    if (steps.isEmpty) return const SizedBox.shrink();
    String label(_Step step) => switch (step) {
          _Step.start => l10n.requestStart,
          _Step.resolve => l10n.requestResolve,
          _Step.reopen => l10n.requestReopen,
          _Step.close => l10n.requestClose,
        };
    final main = steps.first;
    final more = steps.skip(1).toList();

    return Container(
      decoration: BoxDecoration(color: colors.surface, border: Border(top: BorderSide(color: colors.border))),
      child: SafeArea(
        minimum: const EdgeInsets.all(Dimens.spacing),
        child: Row(
          children: [
            Expanded(
              child: Button.primary(
                title: label(main),
                isLoading: state.isBusy,
                onPressed: state.isBusy ? null : () => _take(context, main),
              ),
            ),
            if (more.isNotEmpty) ...[
              const SizedBox(width: Dimens.spacingSm),
              SizedBox.square(
                dimension: Dimens.buttonHeight,
                child: IconButton(
                  tooltip: l10n.listingMoreActions,
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimens.radius),
                      side: BorderSide(color: colors.primary),
                    ),
                  ),
                  icon: Icon(LucideIcons.ellipsis, color: colors.primary),
                  onPressed: state.isBusy
                      ? null
                      : () async {
                          final chosen = await showModalBottomSheet<_Step>(
                            context: context,
                            backgroundColor: colors.surface,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl)),
                            ),
                            builder: (sheetContext) => SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: Dimens.spacing),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (final step in more)
                                      ListTile(
                                        leading: Icon(
                                          step == _Step.close ? LucideIcons.circleX : LucideIcons.check,
                                          color: step == _Step.close ? colors.error : colors.primary,
                                        ),
                                        title: Text(
                                          label(step),
                                          style: context.mboaText.label.copyWith(
                                            color: step == _Step.close ? colors.error : colors.ink,
                                          ),
                                        ),
                                        onTap: () => Navigator.of(sheetContext).pop(step),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                          if (chosen != null && context.mounted) await _take(context, chosen);
                        },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// An optional word with a step; empty is fine, cancelling is not a step.
class _NoteDialog extends StatefulWidget {
  const _NoteDialog({required this.l10n});

  final I18n l10n;

  @override
  State<_NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<_NoteDialog> {
  final _note = TextEditingController();

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    return AlertDialog(
      title: Text(l10n.requestNoteTitle),
      content: TextField(
        controller: _note,
        maxLines: 3,
        maxLength: 500,
        decoration: InputDecoration(hintText: l10n.requestNoteHint),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.commonCancel)),
        TextButton(onPressed: () => Navigator.of(context).pop(_note.text.trim()), child: Text(l10n.requestNoteSend)),
      ],
    );
  }
}
