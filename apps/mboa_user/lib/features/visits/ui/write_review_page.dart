import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/my_visits_bloc.dart';
import '../bloc/write_review_bloc.dart';

/// The client's report on a visit (CDC M07bis).
///
/// Written by the **client** since the 2026-08-13 revision: the visitor reads
/// it and may only answer beside it. Reached from a visit that both parties
/// confirmed being at — the only one that may be reported on
/// (RM-M07bis-01).
@RoutePage()
class WriteReviewPage extends StatelessWidget implements AutoRouteWrapper {
  const WriteReviewPage({super.key, required this.visitId});

  final String visitId;

  /// Both blocs, because this is a **root-level** route: it is pushed from the
  /// visit card, outside the list's provider, so nothing above it carries
  /// `MyVisitsBloc` — and publishing a report has to make the list re-read
  /// itself. Third time this shape has bitten: a screen under `/app` provides
  /// what it reads, or it provides nothing at all.
  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<WriteReviewBloc>(
            create: (_) => getIt<WriteReviewBloc>()..add(ReviewOpened(visitId)),
          ),
          BlocProvider<MyVisitsBloc>.value(value: getIt<MyVisitsBloc>()),
        ],
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(
        leading: const MboaHeaderBackButton(),
        title: Text(l10n.reviewWriteTitle),
      ),
      body: BlocConsumer<WriteReviewBloc, WriteReviewState>(
        listener: (context, state) {
          switch (state) {
            case ReviewJustPublished():
              // The visit list carries "already reviewed" nowhere, so it is
              // re-read rather than guessed at.
              context.read<MyVisitsBloc>().add(const MyVisitsRequested());
              context.router.maybePop();
              MboaToast.success(
                context: context,
                title: l10n.reviewPublished,
                description: l10n.reviewLocked,
              );
            case ReviewDraft(refusal: final refusal?):
              MboaToast.error(
                context: context,
                title: l10n.commonErrorTitle,
                description: switch (refusal) {
                  ReviewRefusal.alreadyWritten => l10n.reviewAlreadyWritten,
                  ReviewRefusal.notAllowed => l10n.reviewNotAllowed,
                  ReviewRefusal.failed => l10n.commonError,
                },
              );
            case ReviewDraft():
            case ReviewLoadInProgress():
            case ReviewLoadFailure():
            case ReviewAlreadyPublished():
              break;
          }
        },
        builder: (context, state) => switch (state) {
          ReviewLoadInProgress() ||
          ReviewJustPublished() =>
            const Center(child: Loader()),
          ReviewLoadFailure() => Center(
              child: Text(
                l10n.commonError,
                style: context.mboaText.body
                    .copyWith(color: context.mboaColors.textSecondary),
              ),
            ),
          // RM-M07bis-03 — locked once published.
          ReviewAlreadyPublished() => _Locked(),
          final ReviewDraft draft => WriteReviewForm(draft: draft),
        },
      ),
    );
  }
}

class _Locked extends StatelessWidget {
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
            Icon(LucideIcons.lock, size: Dimens.iconLg, color: colors.textTertiary),
            const SizedBox(height: Dimens.spacing),
            Text(
              l10n.reviewAlreadyWritten,
              textAlign: TextAlign.center,
              style: context.mboaText.h3.copyWith(color: colors.ink),
            ),
            const SizedBox(height: Dimens.spacingXs),
            Text(
              // A visit report describes one moment and has no reason to
              // change — unlike a resident's review (RM-M27-02).
              l10n.reviewLocked,
              textAlign: TextAlign.center,
              style: context.mboaText.body.copyWith(color: colors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

/// The form itself, public so it can be pumped without a router — the page
/// around it needs an auto_route stack for its back button.
class WriteReviewForm extends StatelessWidget {
  const WriteReviewForm({super.key, required this.draft});

  final ReviewDraft draft;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final bloc = context.read<WriteReviewBloc>();

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              Dimens.screenMargin,
              Dimens.spacing,
              Dimens.screenMargin,
              Dimens.spacingXl,
            ),
            children: [
              // Said before writing, not after: the report is public and
              // final (RM-M07bis-03, RM-M07bis-05).
              Text(
                l10n.reviewWriteSubtitle,
                style:
                    context.mboaText.body.copyWith(color: colors.textSecondary),
              ),
              const SizedBox(height: Dimens.spacingLg),

              _Label(l10n.reviewRatingLabel, required: true),
              _Stars(
                value: draft.rating,
                onPick: (value) => bloc.add(ReviewRatingChanged(value)),
              ),
              const SizedBox(height: Dimens.spacingLg),

              _Label(l10n.reviewConditionLabel),
              _Stars(
                value: draft.perceivedCondition,
                onPick: (value) => bloc.add(ReviewConditionChanged(value)),
              ),
              const SizedBox(height: Dimens.spacingLg),

              _Label(l10n.reviewPros),
              _Points(
                values: draft.pros,
                isPro: true,
                onAdd: (value) =>
                    bloc.add(ReviewPointAdded(value: value, isPro: true)),
                onRemove: (value) =>
                    bloc.add(ReviewPointRemoved(value: value, isPro: true)),
              ),
              const SizedBox(height: Dimens.spacingLg),

              _Label(l10n.reviewCons),
              _Points(
                values: draft.cons,
                isPro: false,
                onAdd: (value) =>
                    bloc.add(ReviewPointAdded(value: value, isPro: false)),
                onRemove: (value) =>
                    bloc.add(ReviewPointRemoved(value: value, isPro: false)),
              ),
              const SizedBox(height: Dimens.spacingLg),

              _Label(l10n.reviewCommentLabel),
              TextFormField(
                initialValue: draft.comment,
                maxLines: 5,
                maxLength: 2000,
                decoration: InputDecoration(hintText: l10n.reviewFreeTextHint),
                onChanged: (value) => bloc.add(ReviewCommentChanged(value)),
              ),
              const SizedBox(height: Dimens.spacing),

              _Label(l10n.reviewPhotosLabel),
              _Photos(draft: draft),
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.screenMargin),
            child: SizedBox(
              width: double.infinity,
              child: Button.primary(
                title: l10n.reviewPublish,
                isLoading: draft.isSubmitting,
                onPressed: draft.canSubmit
                    ? () => bloc.add(const ReviewSubmitted())
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text, {this.required = false});

  final String text;
  final bool required;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.spacingSm),
      child: Row(
        children: [
          Text(
            text,
            style: context.mboaText.label.copyWith(color: colors.ink),
          ),
          if (required)
            Text(
              ' *',
              style: context.mboaText.label.copyWith(color: colors.action),
            ),
        ],
      ),
    );
  }
}

/// 1 to 5, filled up to the chosen one.
class _Stars extends StatelessWidget {
  const _Stars({required this.value, required this.onPick});

  final int? value;
  final ValueChanged<int> onPick;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Row(
      children: [
        for (var star = 1; star <= 5; star++)
          IconButton(
            onPressed: () => onPick(star),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
            icon: Icon(
              LucideIcons.star,
              size: Dimens.iconMd,
              // Filled up to the choice: five outlines say nothing about what
              // was picked.
              color: (value ?? 0) >= star ? colors.warning : colors.border,
            ),
          ),
      ],
    );
  }
}

/// A free list — type, add, remove. Both lists use it.
class _Points extends StatefulWidget {
  const _Points({
    required this.values,
    required this.isPro,
    required this.onAdd,
    required this.onRemove,
  });

  final List<String> values;
  final bool isPro;
  final ValueChanged<String> onAdd;
  final ValueChanged<String> onRemove;

  @override
  State<_Points> createState() => _PointsState();
}

class _PointsState extends State<_Points> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _add() {
    widget.onAdd(_controller.text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.values.isNotEmpty) ...[
          Wrap(
            spacing: Dimens.spacingSm,
            runSpacing: Dimens.spacingSm,
            children: [
              for (final value in widget.values)
                Chip(
                  label: Text(value),
                  onDeleted: () => widget.onRemove(value),
                  deleteIcon: const Icon(LucideIcons.x, size: 14),
                  backgroundColor:
                      widget.isPro ? colors.primaryPale : colors.actionPale,
                ),
            ],
          ),
          const SizedBox(height: Dimens.spacingSm),
        ],
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                maxLength: 120,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: l10n.reviewPointHint,
                  counterText: '',
                ),
                onSubmitted: (_) => _add(),
              ),
            ),
            const SizedBox(width: Dimens.spacingSm),
            TextButton(onPressed: _add, child: Text(l10n.reviewAddPoint)),
          ],
        ),
      ],
    );
  }
}

/// Up to ten, each compressed before it leaves the phone (CLAUDE.md media
/// rules — `MediaUploader` does the compressing).
class _Photos extends StatelessWidget {
  const _Photos({required this.draft});

  final ReviewDraft draft;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final bloc = context.read<WriteReviewBloc>();

    Future<void> add() async {
      final source = await showCaptureSourceSheet(context);
      if (source == null) return;
      final key = await getIt<MediaUploader>().captureAndUpload(
        source: source,
        category: CreateUploadRequestCategoryEnum.VISIT_REPORT,
      );
      if (key != null) bloc.add(ReviewPhotoAdded(key));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: Dimens.spacingSm,
          runSpacing: Dimens.spacingSm,
          children: [
            for (final key in draft.photoKeys)
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Dimens.radius),
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: MboaNetworkImage(
                        url: BaseProfile.mediaUrl(key),
                        placeholder: const MboaImagePlaceholder(size: 80),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => bloc.add(ReviewPhotoRemoved(key)),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: colors.surface,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(LucideIcons.x, size: 14, color: colors.ink),
                      ),
                    ),
                  ),
                ],
              ),
            if (draft.canAddPhoto)
              GestureDetector(
                onTap: add,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: colors.surfaceWarm,
                    borderRadius: BorderRadius.circular(Dimens.radius),
                    border: Border.all(color: colors.border),
                  ),
                  child: Icon(LucideIcons.plus, color: colors.primary),
                ),
              ),
          ],
        ),
        const SizedBox(height: Dimens.spacingXs),
        Text(
          l10n.reviewPhotosLimit,
          style: context.mboaText.caption.copyWith(color: colors.textTertiary),
        ),
      ],
    );
  }
}
