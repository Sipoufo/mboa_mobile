import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../bloc/home_invoices_bloc.dart';
import 'invoice_bits.dart';

/// The space's "Factures" (slice E): the tenancy's invoices, each opening
/// where it can be declared paid. Nothing at all when there are none, or
/// when they could not be read — the space is the screen, this a section.
class HomeInvoicesSection extends StatelessWidget {
  const HomeInvoicesSection({super.key, required this.onOpen});

  final ValueChanged<HomeInvoice> onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return BlocBuilder<HomeInvoicesBloc, HomeInvoicesState>(
      builder: (context, state) => switch (state) {
        HomeInvoicesReady(:final items) when items.isNotEmpty => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: Dimens.spacingLg),
              HomeSectionTitle(l10n.invoicesTitle),
              for (final invoice in items) InvoiceRow(invoice: invoice, onTap: () => onOpen(invoice)),
            ],
          ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
