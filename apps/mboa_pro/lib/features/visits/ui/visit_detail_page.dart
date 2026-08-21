import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'widgets/visit_row_tile.dart';

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
    create: (_) => getIt<VisitDetailBloc>()..add(VisitDetailRequested(id)),
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
            (curr is VisitDetailReady && (curr.lastActionFailed || curr.locationFailure != null || curr.needsOverride)),
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
                    LocationFailure.deniedForever => l10n.visitsLocationDeniedForever,
                    LocationFailure.disabled => l10n.visitsLocationDisabled,
                    LocationFailure.unavailable => l10n.visitsLocationUnavailable,
                  },
          );
        },
        builder: (context, state) => switch (state) {
          VisitDetailInitial() || VisitDetailLoadInProgress() => const Center(child: Loader()),
          VisitWasCancelled() => const Center(child: Loader()),
          VisitDetailFailure() => Center(
            child: TextButton(
              onPressed: () => context.read<VisitDetailBloc>().add(VisitDetailRequested(id)),
              child: Text(l10n.commonRetry),
            ),
          ),
          final VisitDetailReady ready => _Body(state: ready),
        },
      ),
      // The action the agent came for stays in reach whatever the page's
      // length: it is the one thing this screen is for on the day.
      bottomNavigationBar: BlocBuilder<VisitDetailBloc, VisitDetailState>(
        builder: (context, state) => state is VisitDetailReady ? _ActionBar(state: state) : const SizedBox.shrink(),
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
    final visit = state.visit;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        Dimens.spacing,
        Dimens.spacing,
        Dimens.spacing,
        Dimens.spacingXl,
      ),
      children: [
        _WhenCard(visit: visit),
        const SizedBox(height: Dimens.spacing),
        _PresenceCard(visit: visit),
        if (visit.exactAddress != null) ...[
          const SizedBox(height: Dimens.spacing),
          _AddressCard(visit: visit),
        ],
        if (visit.userName != null || visit.prestataireName != null) ...[
          const SizedBox(height: Dimens.spacing),
          _ContactsCard(visit: visit),
        ],
      ],
    );
  }
}

/// When the visit is, what it is, and where it has got to.
///
/// The hour is the headline: the agent opens this on the day and needs it
/// before anything else. The property title names the errand under it.
class _WhenCard extends StatelessWidget {
  const _WhenCard({required this.visit});

  final AgentVisitDetail visit;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final at = visit.scheduledAt;

    return Container(
      padding: const EdgeInsets.all(Dimens.spacingLg),
      decoration: BoxDecoration(
        color: colors.primaryLight2,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (at != null)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.Hm().format(at),
                        style: context.mboaText.h1.copyWith(color: colors.primaryDark),
                      ),
                      Text(
                        // "vendredi 21 août" reads as a fragment under a
                        // heading; sentence case is the convention here.
                        toBeginningOfSentenceCase(
                          DateFormat.yMMMMEEEEd().format(at),
                        ),
                        style: context.mboaText.body.copyWith(color: colors.primaryDark),
                      ),
                    ],
                  ),
                )
              else
                const Spacer(),
              VisitStatusChip(status: visit.status, onTint: true),
            ],
          ),
          const SizedBox(height: Dimens.spacing),
          Text(
            visit.annonceTitle ?? '',
            style: context.mboaText.h3.copyWith(color: colors.primaryDark),
          ),
        ],
      ),
    );
  }
}

/// RM-M07-05 — the mutual confirmation, drawn as the two halves it is.
///
/// This is what the screen is about on the day, and it used to be a sentence
/// under a button. Two rows say who has confirmed and who is still owed, so an
/// agent at a gate can see whether he is waiting on the client or the client
/// on him.
class _PresenceCard extends StatelessWidget {
  const _PresenceCard({required this.visit});

  final AgentVisitDetail visit;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return _Card(
      title: l10n.visitsPresenceTitle,
      child: Column(
        children: [
          _PresenceRow(
            label: l10n.visitsPresenceYou,
            at: visit.visitorConfirmedAt,
          ),
          const SizedBox(height: Dimens.spacingMd),
          _PresenceRow(
            label: l10n.visitsPresenceClient,
            at: visit.clientConfirmedAt,
          ),
          const SizedBox(height: Dimens.spacingMd),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                LucideIcons.info,
                size: Dimens.iconSm,
                color: colors.textTertiary,
              ),
              const SizedBox(width: Dimens.spacingSm),
              Expanded(
                child: Text(
                  l10n.visitsPresenceExplain,
                  style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PresenceRow extends StatelessWidget {
  const _PresenceRow({required this.label, this.at});

  final String label;
  final DateTime? at;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final done = at != null;

    return Row(
      children: [
        Container(
          width: Dimens.iconLg,
          height: Dimens.iconLg,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: done ? colors.success.withValues(alpha: 0.12) : colors.border.withValues(alpha: 0.5),
          ),
          child: Icon(
            done ? LucideIcons.check : LucideIcons.clock,
            size: Dimens.iconSm,
            color: done ? colors.success : colors.textTertiary,
          ),
        ),
        const SizedBox(width: Dimens.spacingMd),
        Expanded(
          child: Text(
            label,
            style: context.mboaText.label.copyWith(color: colors.ink),
          ),
        ),
        Text(
          done ? l10n.visitsPresenceConfirmedAt(DateFormat.Hm().format(at!)) : l10n.visitsPresencePending,
          style: context.mboaText.caption.copyWith(
            color: done ? colors.success : colors.textTertiary,
          ),
        ),
      ],
    );
  }
}

/// RM-M16-01 — the exact address exists nowhere else in the app.
class _AddressCard extends StatelessWidget {
  const _AddressCard({required this.visit});

  final AgentVisitDetail visit;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return _Card(
      title: l10n.visitsAddress,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _IconChip(icon: LucideIcons.mapPin),
          const SizedBox(width: Dimens.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  visit.exactAddress ?? '',
                  style: context.mboaText.bodyLarge.copyWith(color: colors.ink),
                ),
                const SizedBox(height: Dimens.spacingXs),
                Text(
                  l10n.visitsAddressNote,
                  style: context.mboaText.caption.copyWith(color: colors.textTertiary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The only screen in either app that shows a phone number: the agent is going
/// to a stranger's property to meet another stranger and needs to reach both.
///
/// Tapping a row copies the number. Dialling would be better and is one
/// `url_launcher` call away — but that package is unwired everywhere else in
/// the app, and a half-wired launcher is worse than a number he can paste into
/// his own dialler.
class _ContactsCard extends StatelessWidget {
  const _ContactsCard({required this.visit});

  final AgentVisitDetail visit;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return _Card(
      title: l10n.visitsContactsTitle,
      child: Column(
        children: [
          _ContactRow(
            role: l10n.visitsTenant,
            name: visit.userName,
            phone: visit.userPhone,
          ),
          if (visit.userName != null && visit.prestataireName != null) const SizedBox(height: Dimens.spacingMd),
          _ContactRow(
            role: l10n.visitsOwner,
            name: visit.prestataireName,
            phone: visit.prestatairePhone,
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.role, this.name, this.phone});

  final String role;
  final String? name;
  final String? phone;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    if (name == null && phone == null) return const SizedBox.shrink();

    return InkWell(
      borderRadius: BorderRadius.circular(Dimens.radius),
      onTap: phone == null
          ? null
          : () async {
              await Clipboard.setData(ClipboardData(text: phone!));
              if (!context.mounted) return;
              MboaToast.success(
                context: context,
                title: l10n.visitsPhoneCopied,
                description: phone!,
              );
            },
      child: Row(
        children: [
          MboaAvatar(initials: _initialsOf(name), size: Dimens.avatar),
          const SizedBox(width: Dimens.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name ?? '',
                  style: context.mboaText.label.copyWith(color: colors.ink),
                ),
                Text(
                  role,
                  style: context.mboaText.caption.copyWith(color: colors.textTertiary),
                ),
              ],
            ),
          ),
          if (phone case final phone?) ...[
            Text(
              phone,
              style: context.mboaText.body.copyWith(color: colors.textSecondary),
            ),
            const SizedBox(width: Dimens.spacingSm),
            Icon(
              LucideIcons.copy,
              size: Dimens.iconSm,
              color: colors.textTertiary,
            ),
          ],
        ],
      ),
    );
  }
}

/// A white block with a heading — the shape every section here takes.
class _Card extends StatelessWidget {
  const _Card({required this.title, required this.child});

  final String title;
  final Widget child;

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
          Text(
            title,
            style: context.mboaText.h3.copyWith(color: colors.primaryDark),
          ),
          const SizedBox(height: Dimens.spacing),
          child,
        ],
      ),
    );
  }
}

class _IconChip extends StatelessWidget {
  const _IconChip({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Container(
      width: Dimens.avatar,
      height: Dimens.avatar,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.primaryLight.withValues(alpha: 0.35),
      ),
      child: Icon(icon, size: Dimens.icon, color: colors.primaryDark),
    );
  }
}

/// What the agent may do, pinned to the bottom of the screen.
///
/// A visit that is over says so and offers nothing: RM-M16-03 forbids
/// restarting a completed one, and RM-M16-05's "non honorée" cannot be revived.
class _ActionBar extends StatelessWidget {
  const _ActionBar({required this.state});

  final VisitDetailReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final visit = state.visit;

    final Widget content;
    if (visit.status == VisitStatus.completed) {
      content = _Outcome(
        icon: LucideIcons.circleCheck,
        title: l10n.visitsCompletedTitle,
        body: l10n.visitsCompletedBody,
        color: colors.success,
      );
    } else if (visit.status == VisitStatus.notFulfilled) {
      content = _Outcome(
        icon: LucideIcons.circleAlert,
        title: l10n.visitsNotFulfilledTitle,
        body: l10n.visitsNotFulfilledBody,
        color: colors.error,
      );
    } else if (visit.isAwaitingClient) {
      // RM-M07-05 — he cannot supply the client's half, so offering the button
      // again would promise something he cannot do.
      content = _Outcome(
        icon: LucideIcons.hourglass,
        title: l10n.visitsAwaitingClientTitle,
        body: l10n.visitsAwaitingClientBody,
        color: colors.primary,
      );
    } else {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Button.primary(
            title: state.isConfirming ? l10n.visitsLocating : l10n.visitsConfirmPresence,
            isLoading: state.isConfirming,
            // `canConfirm` is the server's answer to "is it the day yet" — the
            // app does not re-derive that rule.
            onPressed: visit.canConfirm
                ? () => context.read<VisitDetailBloc>().add(const VisitPresenceConfirmed())
                : null,
          ),
          const SizedBox(height: Dimens.spacingSm),
          Text(
            visit.canConfirm ? l10n.visitsConfirmPresenceHint : l10n.visitsConfirmNotYet,
            textAlign: TextAlign.center,
            style: context.mboaText.caption.copyWith(color: colors.textSecondary),
          ),
          if (visit.status.isOpen)
            TextButton(
              onPressed: () => _confirmCancel(context, visit),
              style: TextButton.styleFrom(foregroundColor: colors.error),
              child: Text(l10n.visitsCancel),
            ),
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: SafeArea(
        minimum: const EdgeInsets.all(Dimens.spacing),
        child: content,
      ),
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

    // Through the detail's own bloc: the agenda's bloc lives on the Visites
    // tab, a sibling route, and reaching for it from here threw
    // ProviderNotFoundException on a device.
    if (confirmed ?? false) bloc.add(const VisitCancelRequested());
  }
}

/// A visit that has reached an end state, or is waiting on somebody else: an
/// icon, a heading and the sentence that says what happens next.
class _Outcome extends StatelessWidget {
  const _Outcome({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String body;
  final Color color;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, color: color, size: Dimens.iconMd),
      const SizedBox(width: Dimens.spacingMd),
      Expanded(
        child: Column(
          // The bar lives in `bottomNavigationBar`, which offers the whole
          // screen's height: a Column defaulting to `max` swallows it and
          // pushes the page's own content off-screen. It did.
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: context.mboaText.h3.copyWith(color: color)),
            const SizedBox(height: Dimens.spacingXs),
            Text(
              body,
              style: context.mboaText.caption.copyWith(color: context.mboaColors.textSecondary),
            ),
          ],
        ),
      ),
    ],
  );
}

/// Payloads carry a name whole, not first/last.
String _initialsOf(String? name) {
  final parts = (name ?? '').trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
  if (parts.isEmpty) return '';
  if (parts.length == 1) return parts.first[0].toUpperCase();
  return (parts.first[0] + parts.last[0]).toUpperCase();
}
