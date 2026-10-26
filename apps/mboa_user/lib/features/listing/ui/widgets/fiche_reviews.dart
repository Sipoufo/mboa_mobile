import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import 'listing_bits.dart';

/// Read from the 24h cache — a fiche's first line when the network is gone.
class FicheOfflineBanner extends StatelessWidget {
  const FicheOfflineBanner({super.key, this.text});

  /// The listing's own words by default: its actions are off offline.
  final String? text;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: Dimens.spacing),
      padding: const EdgeInsets.all(Dimens.spacingMd),
      decoration: BoxDecoration(
        color: colors.warning.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(Dimens.radius),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.wifiOff, size: Dimens.iconSm, color: colors.warning),
          const SizedBox(width: Dimens.spacingSm),
          Expanded(
            child: Text(
              text ?? l10n.listingOfflineBanner,
              style: context.mboaText.caption.copyWith(color: colors.warning),
            ),
          ),
        ],
      ),
    );
  }
}

/// RM-M05-08 — the weighted average and the feed behind it.
class FicheReviews extends StatelessWidget {
  const FicheReviews({super.key, required this.title, required this.rating, required this.reviews, this.unitOf});

  final String title;
  final PropertyRatingSummary rating;
  final List<ReviewEntry> reviews;

  /// §36 — on a residence, the unit a review describes: « Chambre 4 ».
  final String? Function(ReviewEntry review)? unitOf;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return ListingSection(
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (rating.hasRating) ...[
            Row(
              children: [
                Icon(LucideIcons.star, size: Dimens.icon, color: colors.primary),
                const SizedBox(width: Dimens.spacingSm),
                Text(
                  l10n.listingRatingSummary(
                    rating.reviewCount,
                    rating.average!.toStringAsFixed(1),
                  ),
                  style: context.mboaText.label.copyWith(color: colors.ink),
                ),
              ],
            ),
            const SizedBox(height: Dimens.spacing),
          ],
          for (final review in reviews)
            _Review(
              review: review,
              unit: unitOf?.call(review),
              onReport: (entry) => _reportReview(context, entry),
            ),
        ],
      ),
    );
  }
}

/// RM-M27-06 — reporting a review needs an account, like reporting a listing.
Future<void> _reportReview(BuildContext context, ReviewEntry review) async {
  final l10n = I18n.of(context);

  if (!getIt<SessionSnapshot>().hasSession) {
    MboaToast.info(context: context, title: l10n.reportSignInBody);
    return;
  }

  await showReportSheet(
    context,
    target: ReportTarget.review(review.id),
    title: l10n.reportReviewTitle,
    cubit: getIt<ReportCubit>(),
  );
}

class _Review extends StatelessWidget {
  const _Review({required this.review, this.unit, required this.onReport});

  final ReviewEntry review;
  final String? unit;
  final void Function(ReviewEntry review) onReport;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  // RM-M07bis-08 — the review outlives its author.
                  review.authorName ?? l10n.reviewDeletedAuthor,
                  style: context.mboaText.label.copyWith(color: colors.ink),
                ),
              ),
              if (review.rating case final rating?)
                Text(
                  '$rating/5',
                  style:
                      context.mboaText.label.copyWith(color: colors.primaryDark),
                ),
            ],
          ),
          if (unit case final unit?) ...[
            const SizedBox(height: 2),
            Row(
              children: [
                Icon(LucideIcons.doorOpen, size: 14, color: colors.textTertiary),
                const SizedBox(width: Dimens.spacingXs),
                Flexible(
                  child: Text(
                    unit,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.mboaText.caption.copyWith(color: colors.textTertiary),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: Dimens.spacingXs),
          Row(
            children: [
              // RG-06 — which kind of testimony this is, because a tenant of a
              // year and a visitor of an hour do not weigh the same.
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.spacingSm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: review.kind == ReviewKind.resident
                      ? colors.primaryPale
                      : colors.surfaceWarm,
                  borderRadius: BorderRadius.circular(Dimens.radiusFull),
                ),
                child: Text(
                  review.kind == ReviewKind.resident
                      ? l10n.listingReviewResident
                      : l10n.listingReviewVisit,
                  style: context.mboaText.caption
                      .copyWith(color: colors.textSecondary),
                ),
              ),
              // §24.2 — the stay in the contract's own unit: "3 jours",
              // "12 mois". A short let says its real length now, instead of
              // rounding to "0 mois". Null (no duration) shows nothing.
              if (review.stayLabel(l10n) case final stay?) ...[
                const SizedBox(width: Dimens.spacingSm),
                Text(
                  stay,
                  style: context.mboaText.caption
                      .copyWith(color: colors.textTertiary),
                ),
              ],
              const Spacer(),
              if (review.publishedAt case final at?)
                Text(
                  DateFormat.yMMMd().format(at),
                  style: context.mboaText.caption
                      .copyWith(color: colors.textTertiary),
                ),
            ],
          ),
          // RM-M27-02 — a resident may revise theirs, so a corrected review
          // says so. The copy for this has existed since the feed shipped and
          // was never rendered.
          if (review.editedAt case final at?) ...[
            const SizedBox(height: Dimens.spacingXs),
            Text(
              l10n.listingReviewEdited(DateFormat.yMMMd().format(at)),
              style: context.mboaText.caption
                  .copyWith(color: colors.textTertiary),
            ),
          ],
          if (review.comment case final comment?
              when comment.trim().isNotEmpty) ...[
            const SizedBox(height: Dimens.spacingSm),
            Text(
              comment,
              style: context.mboaText.body.copyWith(color: colors.ink),
            ),
          ],
          // M07bis's content table: the bullets and the photos are half of
          // what a visitor writes, and the fiche showed neither until the
          // tenant app could write them.
          if (review.pros.isNotEmpty || review.cons.isNotEmpty) ...[
            const SizedBox(height: Dimens.spacingSm),
            Wrap(
              spacing: Dimens.spacingSm,
              runSpacing: Dimens.spacingXs,
              children: [
                for (final pro in review.pros)
                  _ReviewPoint(label: pro, isPro: true),
                for (final con in review.cons)
                  _ReviewPoint(label: con, isPro: false),
              ],
            ),
          ],
          if (review.photoKeys.isNotEmpty) ...[
            const SizedBox(height: Dimens.spacingSm),
            SizedBox(
              height: 72,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: review.photoKeys.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(width: Dimens.spacingSm),
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(Dimens.radius),
                  child: SizedBox(
                    width: 72,
                    child: MboaNetworkImage(
                      url: BaseProfile.mediaUrl(review.photoKeys[index]),
                      placeholder: const MboaImagePlaceholder(size: 72),
                    ),
                  ),
                ),
              ),
            ),
          ],
          for (final reply in review.replies) ...[
            const SizedBox(height: Dimens.spacingSm),
            Container(
              padding: const EdgeInsets.all(Dimens.spacingMd),
              decoration: BoxDecoration(
                color: colors.surfaceWarm,
                borderRadius: BorderRadius.circular(Dimens.radius),
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
          // RM-M27-06 — any signed-in user may report a review, of either
          // kind. Placed under the review rather than in its header: a flag
          // beside somebody's name reads as an accusation before anyone has
          // read what they wrote.
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => onReport(review),
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

/// One bullet of a review — the sign carries the meaning, not the colour
/// alone, so it still reads in greyscale and to a colour-blind reader.
class _ReviewPoint extends StatelessWidget {
  const _ReviewPoint({required this.label, required this.isPro});

  final String label;
  final bool isPro;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isPro ? LucideIcons.plus : LucideIcons.minus,
          size: 14,
          color: isPro ? colors.success : colors.error,
        ),
        const SizedBox(width: Dimens.spacingXs),
        Text(
          label,
          style: context.mboaText.caption.copyWith(color: colors.textSecondary),
        ),
      ],
    );
  }
}
