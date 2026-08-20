import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../annonces/data/location_capture.dart';
import '../bloc/visit_detail_bloc.dart';
import '../models/agent_visit.dart';

/// Everything the agent needs on the day (CDC M16).
///
/// **The only screen that shows the exact address** (RM-M16-01) and the only
/// one in either app that shows a phone number — the agent is going to a
/// stranger's property to meet another stranger and needs to reach both.
@RoutePage()
class VisitDetailPage extends StatelessWidget implements AutoRouteWrapper {
  const VisitDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<VisitDetailBloc>(
        create: (_) =>
            getIt<VisitDetailBloc>()..add(VisitDetailRequested(id)),
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(title: Text(l10n.visitsDetailTitle)),
      body: BlocConsumer<VisitDetailBloc, VisitDetailState>(
        listenWhen: (prev, curr) =>
            curr is VisitWasCancelled ||
            (curr is VisitDetailReady &&
                (curr.lastActionFailed ||
                    curr.locationFailure != null ||
                    curr.needsOverride)),
        listener: (context, state) {
          if (state is VisitWasCancelled) {
            // The list is a sibling route and cannot be reached from here, so
            // it reloads when the agent lands back on it.
            context.router.maybePop();
            return;
          }
          final ready = state as VisitDetailReady;
          if (ready.needsOverride) {
            _askForJustification(context, ready);
            return;
          }
          MboaToast.error(
            context: context,
            title: l10n.commonErrorTitle,
            description: ready.locationFailure == null
                ? l10n.visitsActionFailed
                : switch (ready.locationFailure!) {
                    LocationFailure.denied => l10n.visitsLocationDenied,
                    LocationFailure.deniedForever =>
                      l10n.visitsLocationDeniedForever,
                    LocationFailure.disabled => l10n.visitsLocationDisabled,
                    LocationFailure.unavailable =>
                      l10n.visitsLocationUnavailable,
                  },
          );
        },
        builder: (context, state) => switch (state) {
          VisitDetailInitial() || VisitDetailLoadInProgress() =>
            const Center(child: Loader()),
          VisitWasCancelled() => const Center(child: Loader()),
          VisitDetailFailure() => Center(
              child: TextButton(
                onPressed: () => context
                    .read<VisitDetailBloc>()
                    .add(VisitDetailRequested(id)),
                child: Text(l10n.commonRetry),
              ),
            ),
          final VisitDetailReady ready => _Body(state: ready),
        },
      ),
    );
  }

  /// RM-M16-02 — beyond 500 m the confirmation is not blocked, it is
  /// questioned. A GPS fix can be wrong, and an agent at the gate should not be
  /// stranded by it.
  Future<void> _askForJustification(
    BuildContext context,
    VisitDetailReady state,
  ) async {
    final bloc = context.read<VisitDetailBloc>();

    final reason = await showDialog<String>(
      context: context,
      builder: (_) => _JustificationDialog(
        distanceMetres: (state.distanceMetres ?? 0).round(),
      ),
    );

    if (reason == null || reason.isEmpty) {
      // No justification, no confirmation — the record has to say why.
      bloc.add(const VisitOverrideDismissed());
      return;
    }
    bloc.add(VisitPresenceOverridden(reason));
  }
}

/// Owns its controller, so the framework disposes it when the route is gone.
///
/// Disposing it by hand after `showDialog` returns is too early: the dialog is
/// still animating out and its TextField still reads the controller, which
/// threw "used after being disposed" and took the frame down with it.
class _JustificationDialog extends StatefulWidget {
  const _JustificationDialog({required this.distanceMetres});

  final int distanceMetres;

  @override
  State<_JustificationDialog> createState() => _JustificationDialogState();
}

class _JustificationDialogState extends State<_JustificationDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return AlertDialog(
      title: Text(l10n.visitsTooFarTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.visitsTooFarBody(widget.distanceMetres)),
          const SizedBox(height: Dimens.spacing),
          TextField(
            controller: _controller,
            autofocus: true,
            maxLines: 2,
            decoration: InputDecoration(hintText: l10n.visitsTooFarHint),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.commonCancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_controller.text.trim()),
          child: Text(l10n.visitsTooFarConfirm),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state});

  final VisitDetailReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final visit = state.visit;

    return ListView(
      padding: const EdgeInsets.all(Dimens.spacing),
      children: [
        Text(visit.annonceTitle ?? '', style: context.mboaText.h2),
        if (visit.scheduledAt case final at?) ...[
          const SizedBox(height: Dimens.spacingXs),
          Text(
            DateFormat.yMMMMEEEEd().add_Hm().format(at),
            style: context.mboaText.body.copyWith(color: colors.textSecondary),
          ),
        ],
        const SizedBox(height: Dimens.spacingLg),

        // RM-M16-01 — the exact address exists nowhere else in the app.
        if (visit.exactAddress case final address?) ...[
          _Section(title: l10n.visitsAddress),
          Text(address, style: context.mboaText.body),
          const SizedBox(height: Dimens.spacingXs),
          Text(
            l10n.visitsAddressNote,
            style: context.mboaText.caption.copyWith(color: colors.textTertiary),
          ),
          const SizedBox(height: Dimens.spacingLg),
        ],

        if (visit.userName != null || visit.prestataireName != null) ...[
          _Contact(
            label: l10n.visitsTenant,
            name: visit.userName,
            phone: visit.userPhone,
          ),
          _Contact(
            label: l10n.visitsOwner,
            name: visit.prestataireName,
            phone: visit.prestatairePhone,
          ),
          const SizedBox(height: Dimens.spacingLg),
        ],

        _Actions(state: state),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: Dimens.spacingSm),
        child: Text(title, style: context.mboaText.h3),
      );
}

class _Contact extends StatelessWidget {
  const _Contact({required this.label, this.name, this.phone});

  final String label;
  final String? name;
  final String? phone;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    if (name == null && phone == null) return const SizedBox.shrink();

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(LucideIcons.userRound, color: colors.primary),
      title: Text(name ?? ''),
      subtitle: Text('$label${phone == null ? '' : ' · $phone'}'),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({required this.state});

  final VisitDetailReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final visit = state.visit;

    // RM-M16-03 — a completed visit cannot be restarted; RM-M16-05 marks one
    // nobody confirmed as not fulfilled. Neither offers an action.
    if (visit.status == VisitStatus.completed) {
      return _Outcome(
        title: l10n.visitsCompletedTitle,
        body: l10n.visitsCompletedBody,
        color: colors.success,
      );
    }
    if (visit.status == VisitStatus.notFulfilled) {
      return _Outcome(
        title: l10n.visitsNotFulfilledTitle,
        body: l10n.visitsNotFulfilledBody,
        color: colors.error,
      );
    }

    // RM-M07-05 — the agent's half is done and the client's is not. Offering
    // the button again would suggest the agent can supply a confirmation that
    // is not theirs to give.
    if (visit.isAwaitingClient) {
      return _Outcome(
        title: l10n.visitsAwaitingClientTitle,
        body: l10n.visitsAwaitingClientBody,
        color: colors.primary,
      );
    }

    return Column(
      children: [
        Button.primary(
          title: state.isConfirming
              ? l10n.visitsLocating
              : l10n.visitsConfirmPresence,
          isLoading: state.isConfirming,
          // `canConfirm` is the server's answer to "is it the day yet" — the
          // app does not re-derive that rule.
          onPressed: visit.canConfirm
              ? () => context.read<VisitDetailBloc>().add(
                    const VisitPresenceConfirmed(),
                  )
              : null,
        ),
        const SizedBox(height: Dimens.spacingXs),
        Text(
          visit.canConfirm
              ? l10n.visitsConfirmPresenceHint
              : l10n.visitsConfirmNotYet,
          textAlign: TextAlign.center,
          style:
              context.mboaText.caption.copyWith(color: colors.textSecondary),
        ),
        const SizedBox(height: Dimens.spacing),
        if (visit.status.isOpen)
          TextButton(
            onPressed: () => _confirmCancel(context, visit),
            style: TextButton.styleFrom(foregroundColor: colors.error),
            child: Text(l10n.visitsCancel),
          ),
      ],
    );
  }

  Future<void> _confirmCancel(
    BuildContext context,
    AgentVisitDetail visit,
  ) async {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final bloc = context.read<VisitDetailBloc>();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.visitsCancel),
        // RM-M16-04 — the one-hour cutoff is the server's; this says what the
        // agent is doing to somebody else's plans.
        content: Text(l10n.visitsCancelConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: TextButton.styleFrom(foregroundColor: colors.error),
            child: Text(l10n.visitsCancel),
          ),
        ],
      ),
    );

    // Through the detail's own bloc: AgentVisitsBloc lives on the Visites tab,
    // a sibling route, and reaching for it from here threw
    // ProviderNotFoundException on a device.
    if (confirmed ?? false) bloc.add(const VisitCancelRequested());
  }
}

/// A visit that has reached an end state, or is waiting on somebody else: a
/// heading and the sentence that explains what happens next.
class _Outcome extends StatelessWidget {
  const _Outcome({
    required this.title,
    required this.body,
    required this.color,
  });

  final String title;
  final String body;
  final Color color;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(title, style: context.mboaText.h3.copyWith(color: color)),
          const SizedBox(height: Dimens.spacingXs),
          Text(
            body,
            textAlign: TextAlign.center,
            style: context.mboaText.caption
                .copyWith(color: context.mboaColors.textSecondary),
          ),
        ],
      );
}
