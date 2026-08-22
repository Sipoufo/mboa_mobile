import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/visit_review_bloc.dart';

/// The client's review of a visit, as the visitor reads it (CDC M07bis).
///
/// One screen for both personas: the agent reaches it from his visit detail,
/// the prestataire from his own agenda. Neither may touch the note or the text
/// — RM-M07bis-04 allows a comment beside them and nothing else, and this
/// screen is built so that asymmetry is visible rather than merely enforced.
@RoutePage()
class VisitReviewPage extends StatefulWidget implements AutoRouteWrapper {
  const VisitReviewPage({super.key, required this.id, this.propertyTitle});

  final String id;

  /// Names the exported file, so it reads as the property rather than an id.
  final String? propertyTitle;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<VisitReviewBloc>(
        create: (_) =>
            getIt<VisitReviewBloc>()..add(VisitReviewRequested(id)),
        child: this,
      );

  @override
  State<VisitReviewPage> createState() => _VisitReviewPageState();
}

class _VisitReviewPageState extends State<VisitReviewPage> {
  final _comment = TextEditingController();

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(
        title: Text(l10n.reviewTitle),
        actions: [
          BlocBuilder<VisitReviewBloc, VisitReviewState>(
            builder: (context, state) {
              if (state is! VisitReviewReady || !state.hasReview) {
                return const SizedBox.shrink();
              }
              return state.isExporting
                  ? const Padding(
                      padding: EdgeInsets.all(Dimens.spacing),
                      child: SizedBox(
                        width: Dimens.icon,
                        height: Dimens.icon,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : IconButton(
                      tooltip: l10n.reviewExport,
                      icon: const Icon(LucideIcons.share2),
                      onPressed: () => context.read<VisitReviewBloc>().add(
                            VisitReviewPdfRequested(
                              fileName: _fileName(l10n),
                            ),
                          ),
                    );
            },
          ),
        ],
      ),
      body: BlocConsumer<VisitReviewBloc, VisitReviewState>(
        listenWhen: (prev, curr) =>
            curr is VisitReviewReady &&
            (curr.lastActionFailed || curr.commentJustSent),
        listener: (context, state) {
          final ready = state as VisitReviewReady;
          if (ready.commentJustSent) {
            _comment.clear();
            FocusScope.of(context).unfocus();
            MboaToast.success(context: context, title: l10n.reviewCommentSent);
            return;
          }
          MboaToast.error(
            context: context,
            title: l10n.commonErrorTitle,
            description: l10n.visitsActionFailed,
          );
        },
        builder: (context, state) => switch (state) {
          VisitReviewInitial() || VisitReviewLoadInProgress() =>
            const Center(child: Loader()),
          VisitReviewFailure() => Center(
              child: TextButton(
                onPressed: () => context
                    .read<VisitReviewBloc>()
                    .add(VisitReviewRequested(widget.id)),
                child: Text(l10n.commonRetry),
              ),
            ),
          final VisitReviewReady ready => ready.review == null
              ? const _NotYet()
              : _Review(
                  state: ready,
                  controller: _comment,
                ),
        },
      ),
    );
  }

  /// "Avis - Studio Bonapriso", or the visit's id when the caller had no title.
  String _fileName(I18n l10n) {
    final title = widget.propertyTitle?.trim();
    final subject = (title == null || title.isEmpty) ? widget.id : title;
    return '${l10n.reviewTitle} - $subject';
  }
}

/// RM-M07bis-02 — writing is optional and has no deadline, so "not yet" is an
/// ordinary state and says whose move it is.
class _NotYet extends StatelessWidget {
  const _NotYet();

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
              LucideIcons.messageSquareDashed,
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
              l10n.reviewNoneBody,
              textAlign: TextAlign.center,
              style:
                  context.mboaText.body.copyWith(color: colors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class _Review extends StatelessWidget {
  const _Review({required this.state, required this.controller});

  final VisitReviewReady state;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final review = state.review!;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        Dimens.spacing,
        Dimens.spacing,
        Dimens.spacing,
        Dimens.spacingXl,
      ),
      children: [
        _Card(child: _Verdict(review: review)),
        if (review.hasDetail) ...[
          const SizedBox(height: Dimens.spacing),
          _Card(
            title: l10n.reviewWhatTheySaw,
            child: _Detail(review: review),
          ),
        ],
        const SizedBox(height: Dimens.spacing),
        _Card(
          title: l10n.reviewCommentsTitle,
          child: _Comments(state: state, controller: controller),
        ),
      ],
    );
  }
}

/// The note, the author and the date — the part nobody but the client may
/// change.
class _Verdict extends StatelessWidget {
  const _Verdict({required this.review});

  final VisitReview review;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // RM-M07bis-08 — the review outlives its author, anonymised.
                review.authorName ?? l10n.reviewDeletedAuthor,
                style: context.mboaText.h3.copyWith(color: colors.ink),
              ),
              if (review.publishedAt case final at?) ...[
                const SizedBox(height: Dimens.spacingXs),
                Text(
                  DateFormat.yMMMMd().format(at),
                  style: context.mboaText.caption
                      .copyWith(color: colors.textTertiary),
                ),
              ],
              if (review.perceivedCondition case final condition?) ...[
                const SizedBox(height: Dimens.spacingSm),
                Text(
                  l10n.reviewCondition(condition),
                  style: context.mboaText.caption
                      .copyWith(color: colors.textSecondary),
                ),
              ],
            ],
          ),
        ),
        if (review.rating case final rating?) _Rating(rating: rating),
      ],
    );
  }
}

class _Rating extends StatelessWidget {
  const _Rating({required this.rating});

  final int rating;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.spacingMd,
        vertical: Dimens.spacingSm,
      ),
      decoration: BoxDecoration(
        color: colors.primaryPale,
        borderRadius: BorderRadius.circular(Dimens.radius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LucideIcons.star, size: Dimens.iconSm, color: colors.primary),
          const SizedBox(width: Dimens.spacingXs),
          Text(
            '$rating/5',
            style: context.mboaText.label.copyWith(color: colors.primaryDark),
          ),
        ],
      ),
    );
  }
}

class _Detail extends StatelessWidget {
  const _Detail({required this.review});

  final VisitReview review;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (review.comment case final comment? when comment.trim().isNotEmpty)
          Text(
            comment,
            style: context.mboaText.body.copyWith(color: colors.ink),
          ),
        if (review.pros.isNotEmpty) ...[
          const SizedBox(height: Dimens.spacing),
          _Points(
            title: l10n.reviewPros,
            points: review.pros,
            icon: LucideIcons.plus,
            color: colors.success,
          ),
        ],
        if (review.cons.isNotEmpty) ...[
          const SizedBox(height: Dimens.spacing),
          _Points(
            title: l10n.reviewCons,
            points: review.cons,
            icon: LucideIcons.minus,
            color: colors.error,
          ),
        ],
        if (review.photoUrls.isNotEmpty) ...[
          const SizedBox(height: Dimens.spacing),
          SizedBox(
            height: 96,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: review.photoUrls.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(width: Dimens.spacingSm),
              itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.radius),
                child: Image.network(
                  review.photoUrls[index],
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
            ),
          ),
        ],
      ],
    );
  }
}

class _Points extends StatelessWidget {
  const _Points({
    required this.title,
    required this.points,
    required this.icon,
    required this.color,
  });

  final String title;
  final List<String> points;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.mboaText.label.copyWith(color: colors.textSecondary),
        ),
        const SizedBox(height: Dimens.spacingXs),
        for (final point in points)
          Padding(
            padding: const EdgeInsets.only(bottom: Dimens.spacingXs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, size: Dimens.iconSm, color: color),
                const SizedBox(width: Dimens.spacingSm),
                Expanded(
                  child: Text(
                    point,
                    style: context.mboaText.body.copyWith(color: colors.ink),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// RM-M07bis-04 — the visitor's replies, and the box to add one.
class _Comments extends StatelessWidget {
  const _Comments({required this.state, required this.controller});

  final VisitReviewReady state;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final comments = state.review!.comments;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (comments.isEmpty)
          Text(
            l10n.reviewCommentsEmpty,
            style: context.mboaText.body.copyWith(color: colors.textSecondary),
          )
        else
          for (final comment in comments)
            Padding(
              padding: const EdgeInsets.only(bottom: Dimens.spacing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        comment.authorName ?? '',
                        style: context.mboaText.label
                            .copyWith(color: colors.primaryDark),
                      ),
                      if (comment.createdAt case final at?) ...[
                        const SizedBox(width: Dimens.spacingSm),
                        Text(
                          DateFormat.yMMMd().format(at),
                          style: context.mboaText.caption
                              .copyWith(color: colors.textTertiary),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: Dimens.spacingXs),
                  Text(
                    comment.body ?? '',
                    style: context.mboaText.body.copyWith(color: colors.ink),
                  ),
                ],
              ),
            ),
        const SizedBox(height: Dimens.spacingSm),
        Input(
          controller: controller,
          enabled: !state.isCommenting,
          hintText: l10n.reviewCommentHint,
          maxLines: 3,
          maxLength: 1000,
        ),
        const SizedBox(height: Dimens.spacingXs),
        // The asymmetry, said plainly: he answers beside the client's words and
        // cannot touch them.
        Text(
          l10n.reviewCommentRule,
          style: context.mboaText.caption.copyWith(color: colors.textTertiary),
        ),
        const SizedBox(height: Dimens.spacingSm),
        Button.primary(
          title: l10n.reviewCommentSend,
          isLoading: state.isCommenting,
          onPressed: state.isCommenting
              ? null
              : () => context
                  .read<VisitReviewBloc>()
                  .add(VisitReviewCommented(controller.text)),
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child, this.title});

  final Widget child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Dimens.spacingLg),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title case final title?) ...[
            Text(
              title,
              style: context.mboaText.h3.copyWith(color: colors.primaryDark),
            ),
            const SizedBox(height: Dimens.spacing),
          ],
          child,
        ],
      ),
    );
  }
}
