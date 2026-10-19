import 'package:flutter/material.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// A reason from the fixed list, and a word more if wanted (RM-M29-06 /
/// RM-M29-08).
typedef Decision = ({RefusalReason reason, String? note});

/// The reason sheet for refusing a request or cancelling a reservation.
/// Resolves to the reason and note, or null when dismissed — the screen then
/// dispatches; nothing is sent from here.
Future<Decision?> showDecisionSheet(
  BuildContext context, {
  required String title,
  required String hint,
  required String confirm,
}) =>
    showModalBottomSheet<Decision>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.mboaColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl)),
      ),
      builder: (_) => DecisionSheet(title: title, hint: hint, confirm: confirm),
    );

/// Public so it can be pumped on its own.
class DecisionSheet extends StatefulWidget {
  const DecisionSheet({super.key, required this.title, required this.hint, required this.confirm});

  final String title;
  final String hint;
  final String confirm;

  @override
  State<DecisionSheet> createState() => _DecisionSheetState();
}

/// Form state only: what is picked before anything is sent.
class _DecisionSheetState extends State<DecisionSheet> {
  RefusalReason? _reason;
  final _note = TextEditingController();

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimens.spacingLg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(widget.title, style: context.mboaText.h3.copyWith(color: colors.primaryDark)),
              const SizedBox(height: Dimens.spacingXs),
              Text(widget.hint, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
              const SizedBox(height: Dimens.spacing),
              RadioGroup<RefusalReason>(
                groupValue: _reason,
                onChanged: (reason) => setState(() => _reason = reason),
                child: Column(
                  children: [
                    for (final reason in RefusalReason.values)
                      RadioListTile<RefusalReason>(
                        value: reason,
                        contentPadding: EdgeInsets.zero,
                        title: Text(refusalReasonLabel(l10n, reason), style: context.mboaText.body),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: Dimens.spacingSm),
              TextField(
                controller: _note,
                maxLength: 500,
                minLines: 2,
                maxLines: 4,
                decoration: InputDecoration(labelText: l10n.proReservationNoteLabel),
              ),
              const SizedBox(height: Dimens.spacing),
              Button.primary(
                title: widget.confirm,
                onPressed: _reason == null
                    ? null
                    : () => Navigator.of(context).pop<Decision>((reason: _reason!, note: _note.text)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
