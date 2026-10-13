import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../listings/models/property_review.dart';
import '../bloc/resident_review_bloc.dart';

/// The tenant's review of a place they lived in (CDC M27).
///
/// Reached only from a contract whose `residentReviewEligible` is true — the
/// server's verdict (CA-M27-02), never worked out here.
///
/// One screen for writing and for correcting, because it is one form: the
/// bloc knows from the initial read which verb to use, so nothing here has to
/// remember whether a review already existed.
class ResidentReviewView extends StatelessWidget {
  const ResidentReviewView({super.key, required this.contractId});

  final String contractId;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        leading: const MboaHeaderBackButton(),
        title: Text(l10n.residentReviewTitle),
      ),
      body: BlocConsumer<ResidentReviewBloc, ResidentReviewState>(
        listenWhen: (prev, curr) =>
            curr is ResidentReviewPublished ||
            (curr is ResidentReviewEditing && curr.saveFailed),
        listener: (context, state) {
          if (state is ResidentReviewPublished) {
            MboaToast.success(context: context, title: l10n.reviewPublished);
            return;
          }
          MboaToast.error(
            context: context,
            title: l10n.commonErrorTitle,
            description: l10n.commonError,
          );
        },
        builder: (context, state) => switch (state) {
          ResidentReviewInitial() || ResidentReviewLoadInProgress() =>
            const Center(child: Loader()),
          ResidentReviewFailure() => Center(
              child: TextButton(
                onPressed: () => context
                    .read<ResidentReviewBloc>()
                    .add(ResidentReviewOpened(contractId)),
                child: Text(l10n.commonRetry),
              ),
            ),
          final ResidentReviewEditing editing => _Form(state: editing),
          final ResidentReviewPublished published =>
            _Published(review: published.review),
          final ResidentReviewLocked locked =>
            _Published(review: locked.review, isLocked: true),
        },
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form({required this.state});

  final ResidentReviewEditing state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final bloc = context.read<ResidentReviewBloc>();

    return StackedLoaderView(
      isLoading: state.isSaving,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimens.screenMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // RM-M27-02 is the thing a tenant most needs to know before
            // writing: unlike a visit report, this one can be corrected.
            Text(
              l10n.residentReviewSubtitle,
              style: context.mboaText.body.copyWith(color: colors.textSecondary),
            ),
            const SizedBox(height: Dimens.spacingSm),
            // RG-06 — why it is worth the trouble.
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(LucideIcons.info, size: Dimens.iconSm, color: colors.primary),
                const SizedBox(width: Dimens.spacingSm),
                Expanded(
                  child: Text(
                    l10n.residentReviewWeight,
                    style: context.mboaText.caption
                        .copyWith(color: colors.textSecondary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimens.spacingLg),

            _Label(l10n.reviewRatingLabel),
            MboaStarRating(
              value: state.rating,
              label: l10n.reviewRatingLabel,
              onPick: (value) => bloc.add(ResidentReviewRatingChanged(value)),
            ),
            if (state.rating == 0) ...[
              const SizedBox(height: Dimens.spacingXs),
              Text(
                l10n.reviewRatingRequired,
                style: context.mboaText.caption.copyWith(color: colors.textTertiary),
              ),
            ],
            const SizedBox(height: Dimens.spacingLg),

            _Label(l10n.reviewPros),
            MboaPointEditor(
              values: state.pros,
              isPro: true,
              hintText: l10n.reviewPointHint,
              addLabel: l10n.reviewAddPoint,
              onAdd: (value) =>
                  bloc.add(ResidentReviewPointAdded(label: value, isPro: true)),
              onRemove: (value) => bloc
                  .add(ResidentReviewPointRemoved(label: value, isPro: true)),
            ),
            const SizedBox(height: Dimens.spacingLg),

            _Label(l10n.reviewCons),
            MboaPointEditor(
              values: state.cons,
              isPro: false,
              hintText: l10n.reviewPointHint,
              addLabel: l10n.reviewAddPoint,
              onAdd: (value) =>
                  bloc.add(ResidentReviewPointAdded(label: value, isPro: false)),
              onRemove: (value) => bloc
                  .add(ResidentReviewPointRemoved(label: value, isPro: false)),
            ),
            const SizedBox(height: Dimens.spacingLg),

            _Label(l10n.reviewCommentLabel),
            TextFormField(
              initialValue: state.comment,
              maxLines: 6,
              maxLength: 2000,
              decoration: InputDecoration(hintText: l10n.reviewFreeTextHint),
              onChanged: (value) =>
                  bloc.add(ResidentReviewCommentChanged(value)),
            ),
            const SizedBox(height: Dimens.spacingLg),

            SizedBox(
              width: double.infinity,
              child: Button.primary(
                title: state.isRevision
                    ? l10n.residentReviewSave
                    : l10n.reviewPublish,
                isLoading: state.isSaving,
                // RM-M27 makes the rating the one required field, so the
                // button is dead until there is one rather than live and
                // refused.
                onPressed: state.canSubmit
                    ? () => bloc.add(const ResidentReviewSubmitted())
                    : null,
              ),
            ),
            const SizedBox(height: Dimens.spacingLg),
          ],
        ),
      ),
    );
  }
}

/// The review as it now stands — after publishing, after a correction, or once
/// the window has closed.
class _Published extends StatelessWidget {
  const _Published({required this.review, this.isLocked = false});

  final ReviewEntry review;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(Dimens.screenMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isLocked ? LucideIcons.lock : LucideIcons.circleCheck,
                color: isLocked ? colors.textSecondary : colors.success,
                size: Dimens.iconMd,
              ),
              const SizedBox(width: Dimens.spacingSm),
              Expanded(
                child: Text(
                  isLocked
                      ? l10n.residentReviewLockedTitle
                      : l10n.reviewPublished,
                  style: context.mboaText.h3.copyWith(color: colors.ink),
                ),
              ),
            ],
          ),
          if (isLocked) ...[
            const SizedBox(height: Dimens.spacingXs),
            Text(
              l10n.residentReviewLockedBody,
              style: context.mboaText.body.copyWith(color: colors.textSecondary),
            ),
          ],
          const SizedBox(height: Dimens.spacingLg),

          MboaStarRating(value: review.rating, onPick: (_) {}),
          if (review.publishedAt case final at?) ...[
            const SizedBox(height: Dimens.spacingXs),
            Text(
              l10n.reviewPublishedOn(DateFormat.yMMMd().format(at)),
              style: context.mboaText.caption.copyWith(color: colors.textTertiary),
            ),
          ],
          // RM-M27-02 — a correction is visible as one; the fiche says the
          // same thing.
          if (review.editedAt case final at?) ...[
            const SizedBox(height: Dimens.spacingXs),
            Text(
              l10n.listingReviewEdited(DateFormat.yMMMd().format(at)),
              style: context.mboaText.caption.copyWith(color: colors.textTertiary),
            ),
          ],
          if (review.comment case final comment?
              when comment.trim().isNotEmpty) ...[
            const SizedBox(height: Dimens.spacing),
            Text(comment, style: context.mboaText.body.copyWith(color: colors.ink)),
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
          // RM-M27-03 — the landlord may answer beside it. Shown here so the
          // tenant sees the reply without going to the fiche.
          for (final reply in review.replies) ...[
            const SizedBox(height: Dimens.spacing),
            Container(
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
                    reply.authorName ?? '',
                    style: context.mboaText.caption
                        .copyWith(color: colors.primaryDark),
                  ),
                  const SizedBox(height: Dimens.spacingXs),
                  Text(
                    reply.body ?? '',
                    style: context.mboaText.body
                        .copyWith(color: colors.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: Dimens.spacingSm),
        child: Text(
          text,
          style: context.mboaText.label.copyWith(color: context.mboaColors.ink),
        ),
      );
}
