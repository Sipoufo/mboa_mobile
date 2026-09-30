import 'package:flutter/material.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// The tenant's first word (RM-M12-01), written from a listing's fiche.
///
/// Returns the conversation the server opened — or the one that already
/// existed, since a second tap on "Contacter" is a 409 and not a failure.
Future<Conversation?> showContactSheet(
  BuildContext context, {
  required String annonceId,
  String? annonceTitle,
}) {
  final colors = context.mboaColors;

  return showModalBottomSheet<Conversation>(
    context: context,
    backgroundColor: colors.surface,
    isScrollControlled: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusLg)),
    ),
    builder: (_) => _ContactSheet(
      annonceId: annonceId,
      annonceTitle: annonceTitle,
    ),
  );
}

class _ContactSheet extends StatefulWidget {
  const _ContactSheet({required this.annonceId, this.annonceTitle});

  final String annonceId;
  final String? annonceTitle;

  @override
  State<_ContactSheet> createState() => _ContactSheetState();
}

class _ContactSheetState extends State<_ContactSheet> {
  final _controller = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final body = _controller.text.trim();
    if (body.isEmpty) return;

    setState(() => _sending = true);
    try {
      final conversation = await getIt<MessagingRepository>()
          .start(widget.annonceId, body: body);
      if (!mounted) return;
      Navigator.of(context).pop(conversation);
    } catch (_) {
      if (!mounted) return;
      setState(() => _sending = false);
      MboaToast.error(
        context: context,
        title: I18n.of(context).commonErrorTitle,
        description: I18n.of(context).commonError,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: Dimens.spacingLg,
          right: Dimens.spacingLg,
          bottom: MediaQuery.viewInsetsOf(context).bottom + Dimens.spacingLg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.listingContact, style: context.mboaText.h3),
            if (widget.annonceTitle case final title?) ...[
              const SizedBox(height: Dimens.spacingXs),
              // RM-M12-02 — the thread belongs to this property, and the sheet
              // says which before a word is written.
              Text(
                title,
                style: context.mboaText.caption.copyWith(color: colors.primary),
              ),
            ],
            const SizedBox(height: Dimens.spacing),
            TextField(
              controller: _controller,
              autofocus: true,
              minLines: 3,
              maxLines: 6,
              maxLength: 2000,
              decoration: InputDecoration(hintText: l10n.messagingHint),
            ),
            const SizedBox(height: Dimens.spacingSm),
            Button.primary(
              title: l10n.messagingSend,
              isLoading: _sending,
              onPressed: _sending ? null : _send,
            ),
            const SizedBox(height: Dimens.spacingSm),
          ],
        ),
      ),
    );
  }
}
