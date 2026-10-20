import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../../app/router/app_router.gr.dart';
import '../../bloc/my_homes_bloc.dart';

/// On top of the search tab, while a space is active: the next rent, or
/// what is late — one tap from "Mon logement". Nothing for a visitor, or a
/// tenant with nothing due.
///
/// Reads the session's singleton directly, so the search screen needs no
/// extra provider (and its tests none).
class NextRentBanner extends StatelessWidget {
  const NextRentBanner({super.key});

  @override
  Widget build(BuildContext context) {
    if (!getIt.isRegistered<MyHomesBloc>()) return const SizedBox.shrink();
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();

    return BlocBuilder<MyHomesBloc, MyHomesState>(
      bloc: getIt<MyHomesBloc>(),
      builder: (context, state) {
        final home = state is MyHomesReady ? state.current : null;
        final next = home?.nextDue;
        if (home == null || next == null) return const SizedBox.shrink();
        final late = home.isOverdue;

        return Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, 0, Dimens.screenMargin, Dimens.spacingSm),
          child: Material(
            color: late ? colors.error.withValues(alpha: 0.08) : colors.primaryPale,
            borderRadius: BorderRadius.circular(Dimens.radiusMd),
            child: InkWell(
              borderRadius: BorderRadius.circular(Dimens.radiusMd),
              onTap: () => context.router.root.push(
                AuthenticatedRouter(children: [MyHomeRoute(contractId: home.contractId)]),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing, vertical: Dimens.spacingMd),
                child: Row(
                  children: [
                    Icon(late ? LucideIcons.triangleAlert : LucideIcons.house, size: Dimens.icon, color: late ? colors.error : colors.primary),
                    const SizedBox(width: Dimens.spacingMd),
                    Expanded(
                      child: Text(
                        late
                            ? '${l10n.myHomeOverdueCount(home.overdueCount)} · ${fcfaOf(context, home.overdueAmount)}'
                            : '${l10n.myHomeNextRent} · ${fcfaOf(context, next.remaining)}'
                                '${next.dueDate == null ? '' : ' · ${DateFormat.MMMd(locale).format(next.dueDate!)}'}',
                        style: context.mboaText.label.copyWith(color: late ? colors.error : colors.primaryDark),
                      ),
                    ),
                    Icon(LucideIcons.chevronRight, size: Dimens.icon, color: late ? colors.error : colors.primary),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
