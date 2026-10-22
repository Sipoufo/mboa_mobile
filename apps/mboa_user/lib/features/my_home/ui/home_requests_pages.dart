import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../bloc/home_request_form_bloc.dart';

/// A home's requests to the landlord, the tenant's side (CDC M30 lot 3,
/// RM-M30-09): the shared list, with « Nouvelle demande ».
@RoutePage()
class HomeRequestsPage extends StatelessWidget implements AutoRouteWrapper {
  const HomeRequestsPage({super.key, @PathParam('contractId') required this.contractId, this.title});

  final String contractId;
  final String? title;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<HomeRequestsBloc>(
        create: (_) => getIt<HomeRequestsBloc>(param1: contractId)..add(const HomeRequestsRequested()),
        child: this,
      );

  @override
  Widget build(BuildContext context) => HomeRequestsView(
        title: title,
        onNew: () async {
          final bloc = context.read<HomeRequestsBloc>();
          final sent = await context.router.push<bool>(HomeRequestFormRoute(contractId: contractId));
          if (sent ?? false) bloc.add(const HomeRequestsRequested());
        },
        onOpen: (request) async {
          final bloc = context.read<HomeRequestsBloc>();
          await context.router.push(HomeRequestRoute(requestId: request.id));
          // Closed or reopened there: read again on the way back.
          bloc.add(const HomeRequestsRequested());
        },
      );
}

/// One request — the shared view; what N-38 opens.
@RoutePage()
class HomeRequestPage extends StatelessWidget implements AutoRouteWrapper {
  const HomeRequestPage({super.key, @PathParam('requestId') required this.requestId});

  final String requestId;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<HomeRequestBloc>(
        create: (_) => getIt<HomeRequestBloc>()..add(HomeRequestOpened(requestId)),
        child: this,
      );

  @override
  Widget build(BuildContext context) => const HomeRequestView();
}

/// « Nouvelle demande »: what kind, a title, what is going on, photos.
@RoutePage()
class HomeRequestFormPage extends StatelessWidget implements AutoRouteWrapper {
  const HomeRequestFormPage({super.key, @PathParam('contractId') required this.contractId});

  final String contractId;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<HomeRequestFormBloc>(
        create: (_) => getIt<HomeRequestFormBloc>()..add(HomeRequestFormStarted(contractId)),
        child: this,
      );

  @override
  Widget build(BuildContext context) => const HomeRequestFormView();
}

/// The form under its bloc — public so it can be pumped with a mock one.
class HomeRequestFormView extends StatelessWidget {
  const HomeRequestFormView({super.key});

  Future<void> _addPhoto(BuildContext context) async {
    final bloc = context.read<HomeRequestFormBloc>();
    final source = await showCaptureSourceSheet(context);
    if (source != null) bloc.add(HomeRequestPhotoAdded(source));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    Widget label(String text) => Padding(
          padding: const EdgeInsets.only(top: Dimens.spacingLg, bottom: Dimens.spacingSm),
          child: Text(text, style: context.mboaText.label.copyWith(color: colors.textSecondary)),
        );

    return BlocConsumer<HomeRequestFormBloc, HomeRequestFormState>(
      listenWhen: (_, current) =>
          current.sent != null || current.refusal != null || current.failed || current.uploadFailed,
      listener: (context, state) {
        if (state.sent != null) {
          MboaToast.success(context: context, title: l10n.requestSentTitle, description: l10n.requestSentBody);
          context.router.maybePop(true);
        } else if (state.uploadFailed) {
          MboaToast.error(context: context, title: l10n.commonErrorTitle, description: l10n.declareUploadFailed);
        } else {
          MboaToast.error(
            context: context,
            title: l10n.commonErrorTitle,
            description: state.refusal == HomeRequestRefusal.readOnly ? l10n.requestRefusedReadOnly : l10n.requestFailed,
          );
        }
      },
      builder: (context, state) {
        final bloc = context.read<HomeRequestFormBloc>();
        final busy = state.isSending;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppBar(leading: const MboaHeaderBackButton(), title: Text(l10n.requestNew)),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, 0, Dimens.screenMargin, Dimens.spacingXl),
            children: [
              label(l10n.requestFormType),
              Wrap(
                spacing: Dimens.spacingSm,
                runSpacing: Dimens.spacingSm,
                children: [
                  for (final type in HomeRequestType.values)
                    ChoiceChip(
                      selected: state.type == type,
                      showCheckmark: false,
                      avatar: Icon(
                        homeRequestTypeLook(l10n, type).icon,
                        size: 16,
                        color: state.type == type ? colors.primary : colors.textSecondary,
                      ),
                      label: Text(homeRequestTypeLook(l10n, type).label),
                      selectedColor: colors.primaryPale,
                      backgroundColor: colors.surface,
                      side: BorderSide(color: state.type == type ? colors.primary : colors.border),
                      labelStyle: context.mboaText.label.copyWith(color: state.type == type ? colors.primary : colors.ink),
                      onSelected: busy ? null : (_) => bloc.add(HomeRequestFormChanged(type: type)),
                    ),
                ],
              ),
              label(l10n.requestFormTitle),
              TextField(
                maxLength: HomeRequestFormState.maxTitle,
                textCapitalization: TextCapitalization.sentences,
                enabled: !busy,
                decoration: InputDecoration(hintText: l10n.requestFormTitleHint),
                onChanged: (value) => bloc.add(HomeRequestFormChanged(title: value)),
              ),
              label(l10n.requestFormDescription),
              TextField(
                minLines: 4,
                maxLines: 8,
                maxLength: HomeRequestFormState.maxDescription,
                textCapitalization: TextCapitalization.sentences,
                enabled: !busy,
                decoration: InputDecoration(hintText: l10n.requestFormDescriptionHint),
                onChanged: (value) => bloc.add(HomeRequestFormChanged(description: value)),
              ),
              label(l10n.requestFormPhotos),
              Wrap(
                spacing: Dimens.spacingSm,
                runSpacing: Dimens.spacingSm,
                children: [
                  for (final (index, key) in state.photoKeys.indexed)
                    InputChip(
                      avatar: Icon(LucideIcons.image, size: 16, color: colors.primary),
                      label: Text(l10n.requestFormPhotoN('${index + 1}')),
                      deleteIcon: const Icon(LucideIcons.x, size: 16),
                      onDeleted: busy ? null : () => bloc.add(HomeRequestPhotoRemoved(key)),
                    ),
                  if (state.hasPhotoRoom)
                    ActionChip(
                      avatar: state.isUploading
                          ? const Loader(size: Dimens.loaderSizeXs)
                          : Icon(LucideIcons.camera, size: 16, color: colors.primary),
                      label: Text(l10n.declareAddProof),
                      onPressed: busy || state.isUploading ? null : () => _addPhoto(context),
                    ),
                ],
              ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            minimum: const EdgeInsets.all(Dimens.spacing),
            child: Button.primary(
              title: l10n.requestFormSend,
              isLoading: busy,
              onPressed: state.isComplete && !busy && !state.isUploading
                  ? () => bloc.add(const HomeRequestFormSubmitted())
                  : null,
            ),
          ),
        );
      },
    );
  }
}
