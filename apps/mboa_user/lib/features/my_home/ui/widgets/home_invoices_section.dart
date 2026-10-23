import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../bloc/home_invoices_bloc.dart';

/// The space's "Factures" tab (slice E): the tenancy's invoices, each
/// opening where it can be declared paid.
class HomeInvoicesSection extends StatelessWidget {
  const HomeInvoicesSection({super.key, required this.onOpen});

  final ValueChanged<HomeInvoice> onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    Widget said(String text) => Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.spacingXl),
          child: Text(text, textAlign: TextAlign.center, style: context.mboaText.body.copyWith(color: colors.textSecondary)),
        );

    return BlocBuilder<HomeInvoicesBloc, HomeInvoicesState>(
      builder: (context, state) => switch (state) {
        HomeInvoicesLoading() => const Padding(padding: EdgeInsets.all(Dimens.spacingXl), child: Center(child: Loader())),
        HomeInvoicesFailure() => said(l10n.commonError),
        HomeInvoicesReady(:final items) when items.isEmpty => said(l10n.invoicesEmpty),
        HomeInvoicesReady(:final items) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [for (final invoice in items) InvoiceRow(invoice: invoice, onTap: () => onOpen(invoice))],
          ),
      },
    );
  }
}
