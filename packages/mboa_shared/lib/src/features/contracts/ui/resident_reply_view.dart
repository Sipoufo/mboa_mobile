import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../listings/models/property_review.dart';
import '../bloc/resident_reply_bloc.dart';

/// The landlord reading his tenant's review, and answering it once (CDC M27).
///
/// Shows the review whole — rating, bullets and words — before offering the
/// composer. RM-M27-03 gives a right of reply, not a right of veto: there is
/// nothing on this screen that edits or removes what the tenant wrote, and
/// the copy says so before the field rather than after the send.
class ResidentReplyView extends StatelessWidget {
  const ResidentReplyView({
    super.key,
    required this.contractId,
    this.onReport,
  });

  final String contractId;

  /// RM-M27-06 — reports the review to moderation. A landlord is the likeliest
  /// person to need this, and **one upheld report removes a review** where a
  /// listing takes three, so the affordance is deliberately quiet: a text
  /// button under the answer, not a button beside it.
  final void Function(ReviewEntry review)? onReport;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        leading: const MboaHeaderBackButton(),
        title: Text(l10n.residentReviewReadTitle),
      ),
      body: BlocConsumer<ResidentReplyBloc, ResidentReplyState>(
        listenWhen: (prev, curr) =>
            curr is ResidentReplyReady && (curr.justSent || curr.sendFailed),
        listener: (context, state) {
          final ready = state as ResidentReplyReady;
          if (ready.justSent) {
            MboaToast.success(
              context: context,
              title: l10n.residentReplySent,
            );
            return;
          }
          MboaToast.error(
            context: context,
            title: l10n.commonErrorTitle,
            description: l10n.commonError,
          );
        },
        builder: (context, state) => switch (state) {
          ResidentReplyInitial() || ResidentReplyLoadInProgress() =>
            const Center(child: Loader()),
          ResidentReplyFailure() => Center(
              child: TextButton(
                onPressed: () => context
                    .read<ResidentReplyBloc>()
                    .add(ResidentReplyOpened(contractId)),
                child: Text(l10n.commonRetry),
              ),
            ),
          final ResidentReplyReady ready => ready.hasReview
              ? _Review(state: ready, onReport: onReport)
              : const _NoReviewYet(),
        },
      ),
    );
  }
}

/// RM-M27-02 — the tenant may write at any point in the tenancy, so this is
/// the ordinary state of most contracts, and it is phrased as waiting rather
/// than as absence.
class _NoReviewYet extends StatelessWidget {
  const _NoReviewYet();

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Padding(
      padding: const EdgeInsets.all(Dimens.screenMargin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LucideIcons.messageSquare,
            size: Dimens.iconLg,
            color: colors.textTertiary,
          ),
          const SizedBox(height: Dimens.spacing),
          Text(
            l10n.reviewNoneTitle,
            textAlign: TextAlign.center,
            style: context.mboaText.h3.copyWith(color: colors.ink),
          ),
          const SizedBox(height: Dimens.spacingXs),
          Text(
            l10n.residentReviewNoneBody,
            textAlign: TextAlign.center,
            style: context.mboaText.body.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _Review extends StatelessWidget {
  const _Review({required this.state, this.onReport});

  final ResidentReplyReady state;
  final void Function(ReviewEntry review)? onReport;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final review = state.review!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(Dimens.screenMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MboaStarRating(value: review.rating, onPick: (_) {}),
          const SizedBox(height: Dimens.spacingXs),
          // A Wrap rather than a Row with a Spacer: both halves are as long as
          // their content and their language, and nothing guarantees they fit
          // on one line at 390 px. The second drops below instead of
          // overflowing.
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: Dimens.spacingSm,
            runSpacing: Dimens.spacingXs,
            children: [
              if (review.residenceMonths case final months? when months > 0)
                Text(
                  l10n.listingReviewMonths(months),
                  style: context.mboaText.caption
                      .copyWith(color: colors.textTertiary),
                ),
              if (review.publishedAt case final at?)
                Text(
                  l10n.reviewPublishedOn(DateFormat.yMMMd().format(at)),
                  style: context.mboaText.caption
                      .copyWith(color: colors.textTertiary),
                ),
            ],
          ),
          // RM-M27-02 — a corrected review says so, so an answer written
          // against the old wording is not read as an answer to the new one.
          if (review.editedAt case final at?) ...[
            const SizedBox(height: Dimens.spacingXs),
            Text(
              l10n.listingReviewEdited(DateFormat.yMMMd().format(at)),
              style:
                  context.mboaText.caption.copyWith(color: colors.textTertiary),
            ),
          ],
          if (review.comment case final comment?
              when comment.trim().isNotEmpty) ...[
            const SizedBox(height: Dimens.spacing),
            Text(comment,
                style: context.mboaText.body.copyWith(color: colors.ink)),
          ],
          if (review.pros.isNotEmpty || review.cons.isNotEmpty) ...[
            const SizedBox(height: Dimens.spacing),
            Wrap(
              spacing: Dimens.spacingSm,
              runSpacing: Dimens.spacingSm,
              children: [
                for (final pro in review.pros)
                  Chip(label: Text(pro), backgroundColor: colors.primaryPale),
                for (final con in review.cons)
                  Chip(label: Text(con), backgroundColor: colors.actionPale),
              ],
            ),
          ],
          const SizedBox(height: Dimens.spacingXl),

          Text(
            l10n.residentReplyTitle,
            style: context.mboaText.h3.copyWith(color: colors.ink),
          ),
          const SizedBox(height: Dimens.spacingXs),
          Text(
            l10n.residentReplyRule,
            style: context.mboaText.caption.copyWith(color: colors.textSecondary),
          ),
          const SizedBox(height: Dimens.spacing),

          if (state.canReply)
            _Composer(isSending: state.isSending)
          else
            for (final reply in review.replies) _Reply(reply: reply),

          if (onReport != null)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => onReport!(review),
                icon: Icon(
                  LucideIcons.flag,
                  size: Dimens.iconSm,
                  color: colors.textTertiary,
                ),
                label: Text(
                  l10n.listingReport,
                  style: context.mboaText.caption
                      .copyWith(color: colors.textTertiary),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Reply extends StatelessWidget {
  const _Reply({required this.reply});

  final ReviewReply reply;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Dimens.spacingMd),
      decoration: BoxDecoration(
        color: colors.surfaceWarm,
        borderRadius: BorderRadius.circular(Dimens.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            reply.body ?? '',
            style: context.mboaText.body.copyWith(color: colors.ink),
          ),
          const SizedBox(height: Dimens.spacingSm),
          Row(
            children: [
              Icon(LucideIcons.lock, size: 14, color: colors.textTertiary),
              const SizedBox(width: Dimens.spacingXs),
              Expanded(
                child: Text(
                  l10n.residentReplyDone,
                  style: context.mboaText.caption
                      .copyWith(color: colors.textTertiary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Owns its controller, so the framework disposes it with the screen.
class _Composer extends StatefulWidget {
  const _Composer({required this.isSending});

  final bool isSending;

  @override
  State<_Composer> createState() => _ComposerState();
}

class _ComposerState extends State<_Composer> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final canSend = _controller.text.trim().isNotEmpty && !widget.isSending;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          maxLines: 5,
          maxLength: 2000,
          decoration: InputDecoration(hintText: l10n.residentReplyHint),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: Dimens.spacingSm),
        SizedBox(
          width: double.infinity,
          child: Button.primary(
            title: l10n.residentReplySend,
            isLoading: widget.isSending,
            // One answer, so an empty one must not be spent.
            onPressed: canSend
                ? () => context
                    .read<ResidentReplyBloc>()
                    .add(ResidentReplySent(_controller.text))
                : null,
          ),
        ),
      ],
    );
  }
}
