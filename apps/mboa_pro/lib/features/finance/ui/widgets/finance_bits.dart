import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../../app/router/app_router.gr.dart';
import '../../models/finance_refusal.dart';

/// A finance refusal, in words.
String financeRefusalText(I18n l10n, FinanceRefusal reason) => switch (reason) {
      FinanceRefusal.planRequired => l10n.financeRefusedPlan,
      FinanceRefusal.settled => l10n.financeRefusedSettled,
      FinanceRefusal.notDeclaredByHand => l10n.financeRefusedNotByHand,
      FinanceRefusal.labelRequired => l10n.financeRefusedLabel,
      FinanceRefusal.contractNotActive => l10n.financeRefusedContract,
      FinanceRefusal.readOnlyLine => l10n.financeRefusedReadOnly,
      FinanceRefusal.propertyConflict => l10n.financeRefusedProperty,
      FinanceRefusal.providerHasPayments => l10n.financeRefusedHasPayments,
      FinanceRefusal.providerArchived => l10n.financeRefusedArchived,
      FinanceRefusal.providerDuplicate => l10n.financeRefusedDuplicate,
    };

/// A list that could not be read. The finance tools never held
/// ([planRequired], RM-M13-09): where they are — the plans —, never a retry
/// that cannot work. Otherwise, try again.
class FinanceLoadFailure extends StatelessWidget {
  const FinanceLoadFailure({super.key, required this.planRequired, required this.onRetry});

  final bool planRequired;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    if (!planRequired) {
      return Center(child: TextButton(onPressed: onRetry, child: Text(l10n.commonRetry)));
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.spacingXl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LucideIcons.wallet, size: Dimens.iconLg, color: colors.primary),
            const SizedBox(height: Dimens.spacingMd),
            Text(
              l10n.financePlanRequiredRead,
              textAlign: TextAlign.center,
              style: context.mboaText.body.copyWith(color: colors.textSecondary),
            ),
            const SizedBox(height: Dimens.spacing),
            Button.primary(title: l10n.financeSeePlans, onPressed: () => context.router.push(const PlansRoute())),
          ],
        ),
      ),
    );
  }
}

/// A chosen chip reads in the brand's green, like the search's — the
/// theme's own selected colour is the coral of alerts.
TextStyle financeChipLabel(BuildContext context, {required bool selected}) => context.mboaText.label.copyWith(
      color: selected ? context.mboaColors.primaryDark : context.mboaColors.textSecondary,
      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
    );

BorderSide financeChipSide(BuildContext context, {required bool selected}) =>
    BorderSide(color: selected ? context.mboaColors.primary : context.mboaColors.border);

/// One of the rarer actions behind « ⋯ » (Doc05 §6.1) — red when it undoes.
typedef FinanceAction<T> = ({IconData icon, String label, T value, bool destructive});

/// The sheet behind « ⋯ »: the screen's other actions, the destructive ones
/// in red.
Future<T?> showFinanceActions<T>(BuildContext context, List<FinanceAction<T>> actions) {
  final colors = context.mboaColors;
  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: colors.surface,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl))),
    builder: (sheetContext) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.spacing),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final action in actions)
              ListTile(
                leading: Icon(action.icon, color: action.destructive ? colors.error : colors.primary),
                title: Text(
                  action.label,
                  style: context.mboaText.label.copyWith(color: action.destructive ? colors.error : colors.ink),
                ),
                onTap: () => Navigator.of(sheetContext).pop(action.value),
              ),
          ],
        ),
      ),
    ),
  );
}

/// A bar with one main action and, when there are others, the square « ⋯ »
/// (Doc05 §6.1) — never a column of buttons.
class FinanceActionBar extends StatelessWidget {
  const FinanceActionBar({super.key, required this.main, this.onMore, this.isBusy = false});

  final Widget main;
  final VoidCallback? onMore;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    return Container(
      decoration: BoxDecoration(color: colors.surface, border: Border(top: BorderSide(color: colors.border))),
      child: SafeArea(
        minimum: const EdgeInsets.all(Dimens.spacing),
        child: Row(
          children: [
            Expanded(child: main),
            if (onMore != null) ...[
              const SizedBox(width: Dimens.spacingSm),
              SizedBox.square(
                dimension: Dimens.buttonHeight,
                child: IconButton(
                  tooltip: l10n.listingMoreActions,
                  onPressed: isBusy ? null : onMore,
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimens.radius),
                      side: BorderSide(color: colors.primary),
                    ),
                  ),
                  icon: Icon(LucideIcons.ellipsis, color: colors.primary),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Asked once more before what cannot be taken back.
Future<bool> confirmFinance(BuildContext context, String question) async {
  final l10n = I18n.of(context);
  final yes = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      content: Text(question),
      actions: [
        TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: Text(l10n.commonNo)),
        TextButton(onPressed: () => Navigator.of(dialogContext).pop(true), child: Text(l10n.commonYes)),
      ],
    ),
  );
  return yes ?? false;
}
