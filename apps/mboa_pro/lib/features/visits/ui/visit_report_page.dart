import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/visit_report_bloc.dart';
import '../models/visit_report.dart';

/// The report the agent files after a visit (CDC M16).
///
/// **Filed once.** RM-M16-03 locks it, so the submit button waits for a
/// complete draft rather than letting the server refuse a half-filled form
/// after three photo uploads.
@RoutePage()
class VisitReportPage extends StatelessWidget implements AutoRouteWrapper {
  const VisitReportPage({super.key, required this.visitId});

  final String visitId;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<VisitReportBloc>(
        create: (_) => getIt<VisitReportBloc>(),
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: Text(l10n.visitsReportTitle)),
      body: BlocConsumer<VisitReportBloc, VisitReportState>(
        listenWhen: (prev, curr) =>
            curr is ReportSubmittedSuccessfully ||
            (curr is ReportEditing && (curr.photoFailed || curr.submitFailed)),
        listener: (context, state) {
          if (state is ReportSubmittedSuccessfully) {
            MboaToast.success(context: context, title: l10n.visitsReportDone);
            context.router.maybePop();
            return;
          }
          final editing = state as ReportEditing;
          MboaToast.error(
            context: context,
            title: l10n.commonErrorTitle,
            description: editing.photoFailed
                ? l10n.annonceFormErrorPhoto
                : l10n.visitsActionFailed,
          );
        },
        builder: (context, state) {
          if (state is! ReportEditing) return const Center(child: Loader());
          final draft = state.draft;

          return ListView(
            padding: const EdgeInsets.all(Dimens.spacing),
            children: [
              Text(l10n.visitsReportCondition, style: context.mboaText.h3),
              const SizedBox(height: Dimens.spacingSm),
              _ConditionPicker(value: draft.overallCondition),
              const SizedBox(height: Dimens.spacingLg),

              Text(l10n.visitsReportConformity, style: context.mboaText.h3),
              const SizedBox(height: Dimens.spacingSm),
              _ConformityPicker(value: draft.conformity),
              const SizedBox(height: Dimens.spacingLg),

              Text(l10n.visitsReportPhotos, style: context.mboaText.h3),
              const SizedBox(height: Dimens.spacingXs),
              if (!draft.hasEnoughPhotos)
                Text(
                  l10n.visitsReportPhotosNeeded(draft.missingPhotos),
                  style: context.mboaText.caption
                      .copyWith(color: context.mboaColors.error),
                ),
              const SizedBox(height: Dimens.spacingSm),
              _Photos(draft: draft, isUploading: state.isUploading),
              const SizedBox(height: Dimens.spacingLg),

              Text(l10n.visitsReportComment, style: context.mboaText.h3),
              const SizedBox(height: Dimens.spacingSm),
              TextField(
                maxLines: 4,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                onChanged: (value) => context
                    .read<VisitReportBloc>()
                    .add(ReportCommentChanged(value)),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<VisitReportBloc, VisitReportState>(
        builder: (context, state) {
          if (state is! ReportEditing) return const SizedBox.shrink();
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(Dimens.spacing),
              child: Button.primary(
                title: l10n.visitsReportSubmit,
                isLoading: state.isSubmitting,
                onPressed: state.draft.isValid
                    ? () => _confirm(context)
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _confirm(BuildContext context) async {
    final l10n = I18n.of(context);
    final bloc = context.read<VisitReportBloc>();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.visitsReportSubmit),
        // RM-M16-03 — there is no correcting it afterwards.
        content: Text(l10n.visitsReportSubmitConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.visitsReportSubmit),
          ),
        ],
      ),
    );

    if (confirmed ?? false) bloc.add(ReportSubmitted(visitId));
  }
}

class _ConditionPicker extends StatelessWidget {
  const _ConditionPicker({this.value});

  final int? value;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Row(
      children: [
        for (var score = VisitReportDraft.minCondition;
            score <= VisitReportDraft.maxCondition;
            score++)
          Padding(
            padding: const EdgeInsets.only(right: Dimens.spacingSm),
            child: ChoiceChip(
              label: Text('$score'),
              selected: value == score,
              onSelected: (_) => context
                  .read<VisitReportBloc>()
                  .add(ReportConditionChanged(score)),
              selectedColor: colors.primaryPale,
            ),
          ),
      ],
    );
  }
}

class _ConformityPicker extends StatelessWidget {
  const _ConformityPicker({this.value});

  final ListingConformity? value;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Wrap(
      spacing: Dimens.spacingSm,
      children: [
        for (final conformity in ListingConformity.values)
          ChoiceChip(
            label: Text(
              switch (conformity) {
                ListingConformity.oui => l10n.visitsConformityYes,
                ListingConformity.partiellement => l10n.visitsConformityPartly,
                ListingConformity.non => l10n.visitsConformityNo,
              },
            ),
            selected: value == conformity,
            onSelected: (_) => context
                .read<VisitReportBloc>()
                .add(ReportConformityChanged(conformity)),
          ),
      ],
    );
  }
}

class _Photos extends StatelessWidget {
  const _Photos({required this.draft, required this.isUploading});

  final VisitReportDraft draft;
  final bool isUploading;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Wrap(
      spacing: Dimens.spacingSm,
      runSpacing: Dimens.spacingSm,
      children: [
        for (final key in draft.photoKeys)
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.radius),
                child: SizedBox(
                  width: 88,
                  height: 88,
                  child: Image.network(
                    BaseProfile.mediaUrl(key) ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) =>
                        ColoredBox(color: colors.primaryPale),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(LucideIcons.x, color: colors.error, size: 18),
                  onPressed: () => context
                      .read<VisitReportBloc>()
                      .add(ReportPhotoRemoved(key)),
                ),
              ),
            ],
          ),
        if (isUploading)
          const SizedBox(width: 88, height: 88, child: Center(child: Loader()))
        else if (draft.canAddPhoto)
          InkWell(
            onTap: () => _add(context),
            child: Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimens.radius),
                border: Border.all(color: colors.border),
              ),
              child: Icon(LucideIcons.plus, color: colors.primary),
            ),
          ),
      ],
    );
  }

  Future<void> _add(BuildContext context) async {
    final bloc = context.read<VisitReportBloc>();
    final source = await showCaptureSourceSheet(context);
    if (source != null) bloc.add(ReportPhotoAdded(source));
  }
}
