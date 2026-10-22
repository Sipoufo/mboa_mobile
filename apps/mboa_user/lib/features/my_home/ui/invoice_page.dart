import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../bloc/invoice_bloc.dart';
import '../models/declaration_form.dart';
import 'widgets/invoice_bits.dart';

/// One invoice, the tenant's (CDC M24, slice E) — what N-36 opens for an
/// invoice. Paid outside Mboa and declared here, like the rent: the landlord
/// confirms, and the invoice is paid once the confirmations cover it.
/// Nothing is paid from this screen (RM-M30-06).
@RoutePage()
class InvoicePage extends StatelessWidget implements AutoRouteWrapper {
  const InvoicePage({super.key, @PathParam('invoiceId') required this.invoiceId});

  final String invoiceId;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<InvoiceBloc>(
        create: (_) => getIt<InvoiceBloc>()..add(InvoiceRequested(invoiceId)),
        child: this,
      );

  @override
  Widget build(BuildContext context) => InvoiceView(
        onDeclare: (state) async {
          final bloc = context.read<InvoiceBloc>();
          final invoice = state.invoice;
          final sent = await context.router.push<bool>(
            DeclarePaymentRoute(
              contractId: invoice.contractId ?? '',
              form: DeclarationForm.invoice(invoice, left: state.left, today: DateTime.now()),
            ),
          );
          if (sent ?? false) bloc.add(InvoiceRequested(invoiceId));
        },
        onOpenDeclaration: (declaration) => context.router.push(
          MyDeclarationRoute(contractId: declaration.contractId ?? '', declarationId: declaration.id),
        ),
      );
}

/// The invoice under its bloc — public so it can be pumped with a mock one.
class InvoiceView extends StatelessWidget {
  const InvoiceView({super.key, required this.onDeclare, required this.onOpenDeclaration});

  final ValueChanged<InvoiceReady> onDeclare;
  final ValueChanged<Declaration> onOpenDeclaration;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocBuilder<InvoiceBloc, InvoiceState>(
      builder: (context, state) => Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(leading: const MboaHeaderBackButton(), title: Text(l10n.invoiceTitle)),
        body: switch (state) {
          InvoiceLoading() => const Center(child: Loader()),
          InvoiceFailure(:final id) => Center(
              child: TextButton(
                onPressed: () => context.read<InvoiceBloc>().add(InvoiceRequested(id)),
                child: Text(l10n.commonRetry),
              ),
            ),
          final InvoiceReady ready => RefreshIndicator(
              onRefresh: () async => context.read<InvoiceBloc>().add(InvoiceRequested(ready.invoice.id)),
              child: _Body(state: ready, onOpenDeclaration: onOpenDeclaration),
            ),
        },
        // One main action, and only while it can be taken (Doc05 §6.1).
        bottomNavigationBar: state is InvoiceReady && state.canDeclare
            ? Container(
                decoration: BoxDecoration(color: colors.surface, border: Border(top: BorderSide(color: colors.border))),
                child: SafeArea(
                  minimum: const EdgeInsets.all(Dimens.spacing),
                  child: Button.primary(title: l10n.invoiceDeclare, onPressed: () => onDeclare(state)),
                ),
              )
            : null,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state, required this.onOpenDeclaration});

  final InvoiceReady state;
  final ValueChanged<Declaration> onOpenDeclaration;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final invoice = state.invoice;
    final kind = invoiceKindLook(l10n, invoice.kind);
    String date(DateTime value) => DateFormat.yMMMMd(locale).format(value);

    return ListView(
      padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, Dimens.spacing, Dimens.screenMargin, Dimens.spacingXl),
      children: [
        if (state.isOffline) ...[
          Text(l10n.myHomeOffline, style: context.mboaText.caption.copyWith(color: colors.warning)),
          const SizedBox(height: Dimens.spacingSm),
        ],
        Container(
          padding: const EdgeInsets.all(Dimens.spacingLg),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(Dimens.radiusLg),
            boxShadow: MboaShadows.card,
          ),
          child: Column(
            children: [
              InvoiceKindTile(kind: invoice.kind, size: 56),
              const SizedBox(height: Dimens.spacingSm),
              Text(
                invoice.label ?? kind.label,
                textAlign: TextAlign.center,
                style: context.mboaText.h3.copyWith(color: colors.ink),
              ),
              if (invoice.annonceTitle case final title?)
                Text(title, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
              const SizedBox(height: Dimens.spacing),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(fcfaOf(context, invoice.amount), style: context.mboaText.h1.copyWith(color: colors.ink)),
              ),
              const SizedBox(height: Dimens.spacingSm),
              InvoiceStatusChip(status: invoice.status),
              const SizedBox(height: Dimens.spacingSm),
              if (switch (invoice) {
                HomeInvoice(status: InvoiceStatus.paid, :final paidAt?) => l10n.invoicePaidOn(date(paidAt)),
                HomeInvoice(:final dueDate?) when invoice.status.isOpen => l10n.invoiceDueOn(date(dueDate)),
                _ => null,
              }
                  case final day?)
                Text(day, style: context.mboaText.body.copyWith(color: colors.textSecondary)),
              // Partly confirmed, still open: how much is left to declare.
              if (invoice.status.isOpen && state.confirmedTotal > 0) ...[
                const SizedBox(height: Dimens.spacingXs),
                Text(
                  l10n.invoiceConfirmedSoFar(fcfaOf(context, state.confirmedTotal), fcfaOf(context, state.left)),
                  textAlign: TextAlign.center,
                  style: context.mboaText.caption.copyWith(color: colors.primary, fontWeight: FontWeight.w600),
                ),
              ],
            ],
          ),
        ),
        if (invoice.status.isOpen) ...[
          const SizedBox(height: Dimens.spacing),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(LucideIcons.shieldCheck, size: Dimens.iconSm, color: colors.primary),
              const SizedBox(width: Dimens.spacingSm),
              Expanded(
                child: Text(l10n.invoiceNoMoney, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
              ),
            ],
          ),
        ],
        if (state.declarations.isNotEmpty) ...[
          const SizedBox(height: Dimens.spacingLg),
          HomeSectionTitle(l10n.invoiceDeclarations),
          for (final declaration in state.declarations)
            DeclarationRow(declaration: declaration, onTap: () => onOpenDeclaration(declaration)),
        ],
      ],
    );
  }
}

