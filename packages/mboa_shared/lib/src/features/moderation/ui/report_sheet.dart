import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/report_cubit.dart';
import '../models/report_target.dart';

/// Reports [target] to moderation (CDC M23), asking for a reason and an
/// optional note.
///
/// Opens the sheet, awaits the outcome and reports it. The caller supplies the
/// cubit — this is a shared sheet and the two apps register their own.
///
/// RM-M23-05: the confirmation says the report was received and nothing more.
/// The reporter never learns the outcome, so no copy here hints at one.
Future<void> showReportSheet(
  BuildContext context, {
  required ReportTarget target,
  required ReportCubit cubit,
  String? title,
}) async {
  final l10n = I18n.of(context);

  final sent = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => BlocProvider<ReportCubit>.value(
      value: cubit,
      child: _ReportSheet(target: target, title: title ?? l10n.reportTitle),
    ),
  );

  if (!context.mounted) return;

  if (sent ?? false) {
    MboaToast.success(context: context, title: l10n.reportSent);
  }
}

class _ReportSheet extends StatefulWidget {
  const _ReportSheet({required this.target, required this.title});

  final ReportTarget target;
  final String title;

  @override
  State<_ReportSheet> createState() => _ReportSheetState();
}

class _ReportSheetState extends State<_ReportSheet> {
  final _comment = TextEditingController();
  ReportReason? _reason;

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  String _label(I18n l10n, ReportReason reason) => switch (reason) {
        ReportReason.fraudulentListing => l10n.reportReasonFraud,
        ReportReason.abnormalPrice => l10n.reportReasonPrice,
        ReportReason.inappropriateContent => l10n.reportReasonContent,
        ReportReason.harassment => l10n.reportReasonHarassment,
        ReportReason.askedForMoney => l10n.reportReasonAskedForMoney,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocConsumer<ReportCubit, ReportState>(
      listenWhen: (prev, curr) => curr is ReportSent || curr is ReportFailed,
      listener: (context, state) {
        if (state is ReportSent) {
          Navigator.of(context).pop(true);
          return;
        }
        MboaToast.error(
          context: context,
          title: l10n.commonErrorTitle,
          description: l10n.reportFailed,
        );
      },
      builder: (context, state) {
        final isSending = state is ReportSending;

        return Container(
          padding: EdgeInsets.only(
            left: Dimens.screenMargin,
            right: Dimens.screenMargin,
            top: Dimens.spacingLg,
            bottom: MediaQuery.viewInsetsOf(context).bottom + Dimens.spacingLg,
          ),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(Dimens.radiusXl),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: context.mboaText.h3.copyWith(color: colors.ink),
                ),
                const SizedBox(height: Dimens.spacing),
                Text(
                  l10n.reportReasonLabel,
                  style: context.mboaText.label.copyWith(color: colors.ink),
                ),
                const SizedBox(height: Dimens.spacingSm),
                // Only the reasons that mean something for this kind of
                // target — a review cannot be overpriced.
                RadioGroup<ReportReason>(
                  groupValue: _reason,
                  // RadioGroup takes a non-nullable callback, so the guard
                  // lives inside it. Harmless either way: the request in
                  // flight already carries the reason it was sent with.
                  onChanged: (value) {
                    if (!isSending) setState(() => _reason = value);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final reason in widget.target.reasons)
                        RadioListTile<ReportReason>(
                          value: reason,
                          title: Text(_label(l10n, reason)),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: Dimens.spacing),
                Text(
                  l10n.reportCommentLabel,
                  style: context.mboaText.label.copyWith(color: colors.ink),
                ),
                const SizedBox(height: Dimens.spacingSm),
                TextField(
                  controller: _comment,
                  maxLines: 3,
                  maxLength: 1000,
                  enabled: !isSending,
                  decoration: InputDecoration(hintText: l10n.reportCommentHint),
                ),
                const SizedBox(height: Dimens.spacingSm),
                SizedBox(
                  width: double.infinity,
                  child: Button.primary(
                    title: l10n.reportSend,
                    isLoading: isSending,
                    // RM-M23-01 records a reason on every report, so there is
                    // no sending one without it.
                    onPressed: _reason == null || isSending
                        ? null
                        : () => context.read<ReportCubit>().send(
                              widget.target,
                              reason: _reason!,
                              comment: _comment.text,
                            ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
