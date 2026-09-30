import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../media/capture_source_sheet.dart';
import '../../media/media_uploader.dart';
import '../bloc/thread_bloc.dart';
import '../models/conversation.dart';

/// One conversation (CDC M12), identical in both apps.
///
/// **No phone number and no call button anywhere.** RM-M12-03 masks the
/// prestataire's number server-side and CA-M12-02 keeps it out of this
/// interface — the point of the module is that a first contact does not cost
/// anyone their number.
class ThreadView extends StatefulWidget {
  const ThreadView({super.key, required this.uploader});

  /// RM-M12-04 — attachments go through the same compression as a listing
  /// photo; the uploader is each app's, the rule is shared.
  final MediaUploader uploader;

  @override
  State<ThreadView> createState() => _ThreadViewState();
}

class _ThreadViewState extends State<ThreadView> {
  final _controller = TextEditingController();
  final _scroll = ScrollController();
  final _attachments = <String>[];
  bool _uploading = false;

  /// RM-M12-04.
  static const int _maxAttachments = 3;

  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _attach() async {
    final l10n = I18n.of(context);
    if (_attachments.length >= _maxAttachments) {
      MboaToast.info(context: context, title: l10n.messagingAttachmentsMax);
      return;
    }

    final source = await showCaptureSourceSheet(context);
    if (source == null || !mounted) return;

    setState(() => _uploading = true);
    final key = await widget.uploader.captureAndUpload(
      source: source,
      category: CreateUploadRequestCategoryEnum.MESSAGE_ATTACHMENT,
    );
    if (!mounted) return;

    setState(() {
      _uploading = false;
      if (key != null) _attachments.add(key);
    });
  }

  void _send() {
    final bloc = context.read<ThreadBloc>();
    final body = _controller.text.trim();
    if (body.isEmpty && _attachments.isEmpty) return;

    bloc.add(ThreadMessageSent(body, attachmentKeys: [..._attachments]));
    setState(() {
      _controller.clear();
      _attachments.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return BlocConsumer<ThreadBloc, ThreadState>(
      listenWhen: (prev, curr) => curr is ThreadReady,
      listener: (context, state) {
        // Follow the conversation down as it grows.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scroll.hasClients) {
            _scroll.jumpTo(_scroll.position.maxScrollExtent);
          }
        });
      },
      builder: (context, state) => switch (state) {
        ThreadInitial() || ThreadLoadInProgress() =>
          const Center(child: Loader()),
        ThreadFailure() => Center(child: Text(l10n.commonError)),
        final ThreadReady ready => Column(
            children: [
              Expanded(
                child: ready.visible.isEmpty
                    ? const SizedBox.shrink()
                    : ListView.builder(
                        controller: _scroll,
                        padding: const EdgeInsets.all(Dimens.spacing),
                        itemCount: ready.visible.length,
                        itemBuilder: (context, index) =>
                            _Bubble(message: ready.visible[index]),
                      ),
              ),
              if (ready.canWrite)
                _Composer(
                  controller: _controller,
                  attachments: _attachments,
                  isUploading: _uploading,
                  onAttach: _attach,
                  onRemoveAttachment: (key) =>
                      setState(() => _attachments.remove(key)),
                  onSend: _send,
                )
              else
                const _ReadOnlyNotice(),
            ],
          ),
      },
    );
  }
}

/// CE-M12-02 — the listing was archived: the thread stays readable and says
/// why writing stopped.
class _ReadOnlyNotice extends StatelessWidget {
  const _ReadOnlyNotice();

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Container(
      width: double.infinity,
      color: colors.surfaceWarm,
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.all(Dimens.spacing),
        child: Row(
          children: [
            Icon(LucideIcons.lock, size: Dimens.iconSm, color: colors.textTertiary),
            const SizedBox(width: Dimens.spacingSm),
            Expanded(
              child: Text(
                l10n.messagingReadOnly,
                style:
                    context.mboaText.caption.copyWith(color: colors.textSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final mine = message.isMine;

    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: Dimens.spacingSm),
        padding: const EdgeInsets.all(Dimens.spacingMd),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.78,
        ),
        decoration: BoxDecoration(
          color: mine ? colors.primaryLight2 : colors.surface,
          borderRadius: BorderRadius.circular(Dimens.radiusLg),
        ),
        child: Column(
          crossAxisAlignment:
              mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (message.attachmentUrls.isNotEmpty) ...[
              Wrap(
                spacing: Dimens.spacingXs,
                runSpacing: Dimens.spacingXs,
                children: [
                  for (final url in message.attachmentUrls)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(Dimens.radius),
                      child: Image.network(
                        url,
                        width: 96,
                        height: 96,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stack) => Container(
                          width: 96,
                          height: 96,
                          color: colors.primaryPale,
                          child: Icon(LucideIcons.image, color: colors.primary),
                        ),
                      ),
                    ),
                ],
              ),
              if (message.body?.isNotEmpty ?? false)
                const SizedBox(height: Dimens.spacingSm),
            ],
            if (message.body?.isNotEmpty ?? false)
              Text(
                message.body!,
                style: context.mboaText.body.copyWith(color: colors.ink),
              ),
            const SizedBox(height: Dimens.spacingXs),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  switch (message.status) {
                    // CE-M12-01 — written, waiting for a line. Said in words:
                    // a clock icon alone reads as "failed" to most people.
                    MessageStatus.pending => l10n.messagingPending,
                    MessageStatus.failed => l10n.messagingFailed,
                    MessageStatus.sent => message.sentAt == null
                        ? ''
                        : DateFormat.Hm().format(message.sentAt!),
                  },
                  style: context.mboaText.caption.copyWith(
                    color: message.status == MessageStatus.sent
                        ? colors.textTertiary
                        : colors.warning,
                  ),
                ),
                if (mine && message.isRead) ...[
                  const SizedBox(width: Dimens.spacingXs),
                  Icon(
                    LucideIcons.checkCheck,
                    size: Dimens.iconSm,
                    color: colors.primary,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer({
    required this.controller,
    required this.attachments,
    required this.isUploading,
    required this.onAttach,
    required this.onRemoveAttachment,
    required this.onSend,
  });

  final TextEditingController controller;
  final List<String> attachments;
  final bool isUploading;
  final VoidCallback onAttach;
  final ValueChanged<String> onRemoveAttachment;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.all(Dimens.spacingSm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (attachments.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: Dimens.spacingSm),
                child: Row(
                  children: [
                    for (final key in attachments)
                      Padding(
                        padding: const EdgeInsets.only(right: Dimens.spacingXs),
                        child: Chip(
                          label: Text(l10n.messagingAttachment),
                          onDeleted: () => onRemoveAttachment(key),
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                  ],
                ),
              ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  tooltip: l10n.messagingAttach,
                  onPressed: isUploading ? null : onAttach,
                  icon: isUploading
                      ? const SizedBox(
                          width: Dimens.icon,
                          height: Dimens.icon,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Icon(LucideIcons.paperclip, color: colors.primary),
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    minLines: 1,
                    maxLines: 4,
                    maxLength: 2000,
                    decoration: InputDecoration(
                      hintText: l10n.messagingHint,
                      counterText: '',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: l10n.messagingSend,
                  onPressed: onSend,
                  icon: Icon(LucideIcons.send, color: colors.primary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
