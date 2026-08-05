import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/subscribe_bloc.dart';
import '../models/subscription_models.dart';

/// Runs the payment and reports the outcome.
///
/// Not dismissible while the charge is in flight — closing mid-payment would
/// leave the prestataire with no idea whether they were charged.
Future<void> showPaymentFlowSheet(
  BuildContext context, {
  required SubscriptionTier tier,
  required PaymentMethod method,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isDismissible: false,
    enableDrag: false,
    isScrollControlled: true,
    builder: (_) => BlocProvider<SubscribeBloc>(
      create: (_) => getIt<SubscribeBloc>()
        ..add(SubscribeRequested(tier: tier, method: method)),
      child: const _PaymentFlowView(),
    ),
  );
}

class _PaymentFlowView extends StatelessWidget {
  const _PaymentFlowView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscribeBloc, SubscribeState>(
      builder: (context, state) {
        final body = switch (state) {
          SubscribeIdle() ||
          SubscribeInitiating() =>
            const _Busy(labelKey: _BusyLabel.initiating),
          SubscribeAwaitingConfirmation(:final attempt) =>
            _Awaiting(attempt: attempt),
          SubscribeConfirmed(:final attempt) => _Confirmed(attempt: attempt),
          SubscribePendingHandoff() => const _PendingHandoff(),
          SubscribeFailure() => const _Failed(),
        };

        return PopScope(
          // Block the back gesture only while money is moving.
          canPop: state is! SubscribeInitiating &&
              state is! SubscribeAwaitingConfirmation,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(Dimens.spacingLg),
              child: body,
            ),
          ),
        );
      },
    );
  }
}

enum _BusyLabel { initiating }

class _Busy extends StatelessWidget {
  const _Busy({required this.labelKey});

  final _BusyLabel labelKey;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Loader(),
        const SizedBox(height: Dimens.spacing),
        Text(
          switch (labelKey) { _BusyLabel.initiating => l10n.paymentInitiating },
          style: context.mboaText.body,
        ),
      ],
    );
  }
}

class _Awaiting extends StatelessWidget {
  const _Awaiting({required this.attempt});

  final PaymentAttempt attempt;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Loader(),
        const SizedBox(height: Dimens.spacing),
        Text(
          l10n.paymentAwaitingTitle,
          style: context.mboaText.h3,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Dimens.spacingSm),
        Text(
          l10n.paymentAwaitingBody,
          style: context.mboaText.body.copyWith(color: colors.textSecondary),
          textAlign: TextAlign.center,
        ),
        if (attempt.providerRef case final ref? when ref.isNotEmpty) ...[
          const SizedBox(height: Dimens.spacingMd),
          Text(
            l10n.paymentReference(ref),
            style: context.mboaText.micro.copyWith(color: colors.textTertiary),
          ),
        ],
      ],
    );
  }
}

class _Confirmed extends StatelessWidget {
  const _Confirmed({required this.attempt});

  final PaymentAttempt attempt;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(LucideIcons.circleCheck, size: Dimens.iconLg, color: colors.success),
        const SizedBox(height: Dimens.spacing),
        Text(l10n.paymentConfirmedTitle, style: context.mboaText.h3),
        const SizedBox(height: Dimens.spacingSm),
        Text(
          l10n.paymentConfirmedBody(attempt.tier.label),
          style: context.mboaText.body.copyWith(color: colors.textSecondary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Dimens.spacingLg),
        SizedBox(
          width: double.infinity,
          child: Button.primary(
            title: l10n.paymentDone,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }
}

class _PendingHandoff extends StatelessWidget {
  const _PendingHandoff();

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(LucideIcons.hourglass, size: Dimens.iconLg, color: colors.warning),
        const SizedBox(height: Dimens.spacing),
        Text(l10n.paymentPendingTitle, style: context.mboaText.h3),
        const SizedBox(height: Dimens.spacingSm),
        Text(
          l10n.paymentPendingBody,
          style: context.mboaText.body.copyWith(color: colors.textSecondary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Dimens.spacingLg),
        SizedBox(
          width: double.infinity,
          child: Button.primary(
            title: l10n.paymentDone,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }
}

class _Failed extends StatelessWidget {
  const _Failed();

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(LucideIcons.circleX, size: Dimens.iconLg, color: colors.error),
        const SizedBox(height: Dimens.spacing),
        Text(l10n.paymentFailedTitle, style: context.mboaText.h3),
        const SizedBox(height: Dimens.spacingSm),
        Text(
          l10n.paymentFailedBody,
          style: context.mboaText.body.copyWith(color: colors.textSecondary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Dimens.spacingLg),
        SizedBox(
          width: double.infinity,
          child: Button.primary(
            title: l10n.paymentRetry,
            // Replays with the same idempotency key — a request that actually
            // landed cannot charge twice.
            onPressed: () => context
                .read<SubscribeBloc>()
                .add(const SubscribeRetryRequested()),
          ),
        ),
        const SizedBox(height: Dimens.spacingSm),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.paymentDone),
        ),
      ],
    );
  }
}
