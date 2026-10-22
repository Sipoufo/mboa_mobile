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
import '../bloc/past_home_bloc.dart';

/// One ended tenancy (CDC M31), what « Anciens » opens: the place and the
/// lease as signed, what was paid, the contract, the rating, the review and
/// the tenancy's requests and photos — each where it already lives.
@RoutePage()
class PastHomePage extends StatelessWidget implements AutoRouteWrapper {
  const PastHomePage({super.key, @PathParam('contractId') required this.contractId});

  final String contractId;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<PastHomeBloc>(
        create: (_) => getIt<PastHomeBloc>()..add(PastHomeRequested(contractId)),
        child: this,
      );

  @override
  Widget build(BuildContext context) => PastHomeView(
        onListing: (annonceId) => context.router.push(ListingDetailRoute(id: annonceId)),
        onContract: () => context.router.push(MyContractDetailRoute(id: contractId)),
        onReview: () async {
          final bloc = context.read<PastHomeBloc>();
          await context.router.push(ResidentReviewRoute(contractId: contractId));
          // Written or changed there: what may still be done shows here.
          bloc.add(PastHomeRequested(contractId));
        },
        onExpense: (expense) =>
            context.router.push(MyDeclarationRoute(contractId: contractId, declarationId: expense.declarationId)),
        onRequests: () => context.router.push(HomeRequestsRoute(contractId: contractId, readOnly: true)),
        onEvidence: ({required canAdd}) =>
            context.router.push(HomeEvidenceRoute(contractId: contractId, readOnly: !canAdd)),
        onSpace: () => context.router.push(MyHomeRoute(contractId: contractId)),
      );
}

/// The sheet under its bloc — public so it can be pumped with a mock one.
class PastHomeView extends StatelessWidget {
  const PastHomeView({
    super.key,
    required this.onListing,
    required this.onContract,
    required this.onReview,
    required this.onExpense,
    required this.onRequests,
    required this.onEvidence,
    required this.onSpace,
  });

  final void Function(String annonceId) onListing;
  final VoidCallback onContract;
  final VoidCallback onReview;
  final void Function(PastExpense expense) onExpense;
  final VoidCallback onRequests;

  /// [canAdd]: exit photos are still taken (RM-M31-08).
  final void Function({required bool canAdd}) onEvidence;

  /// The space itself, read only: its schedule and declarations.
  final VoidCallback onSpace;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocConsumer<PastHomeBloc, PastHomeState>(
      listenWhen: (_, current) => current is PastHomeReady && current.statementFailed,
      listener: (context, _) =>
          MboaToast.error(context: context, title: l10n.commonErrorTitle, description: l10n.pastHomeStatementFailed),
      builder: (context, state) => Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(leading: const MboaHeaderBackButton(), title: Text(l10n.pastHomeTitle)),
        body: switch (state) {
          PastHomeLoading() => const Center(child: Loader()),
          PastHomeFailure(:final contractId) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n.commonError, style: context.mboaText.body.copyWith(color: colors.textSecondary)),
                  TextButton(
                    onPressed: () => context.read<PastHomeBloc>().add(PastHomeRequested(contractId)),
                    child: Text(l10n.commonRetry),
                  ),
                ],
              ),
            ),
          final PastHomeReady ready => _Sheet(view: this, ready: ready),
        },
        // The statement is the one thing this page is for doing; nothing to
        // state, no bar.
        bottomNavigationBar: switch (state) {
          final PastHomeReady ready when ready.past.confirmed.isNotEmpty || ready.past.notConfirmed.isNotEmpty =>
            _StatementBar(state: ready),
          _ => null,
        },
      ),
    );
  }
}

class _Sheet extends StatelessWidget {
  const _Sheet({required this.view, required this.ready});

  final PastHomeView view;
  final PastHomeReady ready;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    String day(DateTime d) => DateFormat.yMMMd(locale).format(d);
    final past = ready.past;
    final review = past.myReview;
    final photosUntil = past.exitPhotosUntil;
    final canAddPhotos = !ready.isOffline && photosUntil != null && !photosUntil.isBefore(DateTime.now());

    final reviewRow = switch (review) {
      MyPastReview(canWrite: true) => _LinkRow(
          icon: LucideIcons.star,
          title: l10n.pastHomeReviewWrite,
          line: l10n.pastHomeReviewWriteHint,
          onTap: view.onReview,
        ),
      MyPastReview(canEdit: true, :final editableUntil) => _LinkRow(
          icon: LucideIcons.pencil,
          title: l10n.pastHomeReviewEdit,
          line: editableUntil == null ? null : l10n.pastHomeReviewEditUntil(day(editableUntil)),
          onTap: view.onReview,
        ),
      MyPastReview(:final rating?) => _LinkRow(
          icon: LucideIcons.star,
          title: l10n.pastHomeReviewMine(rating),
          line: l10n.pastHomeReviewLocked,
          onTap: view.onReview,
        ),
      _ => null,
    };

    return RefreshIndicator(
      onRefresh: () async => context.read<PastHomeBloc>().add(PastHomeRequested(past.home.contractId)),
      child: ListView(
        padding: const EdgeInsets.all(Dimens.screenMargin),
        children: [
          if (ready.isOffline) ...[
            _Notice(icon: LucideIcons.wifiOff, tone: colors.warning, text: l10n.pastHomeOffline),
            const SizedBox(height: Dimens.spacing),
          ],
          _PlaceCard(past: past, onListing: view.onListing),
          const SizedBox(height: Dimens.spacingLg),
          _Total(past: past),
          const SizedBox(height: Dimens.spacingLg),
          _Section(
            title: l10n.pastHomeExpensesTitle,
            children: [
              if (past.confirmed.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimens.spacingSm),
                  child: Text(
                    l10n.pastHomeNoExpense,
                    style: context.mboaText.body.copyWith(color: colors.textSecondary),
                  ),
                ),
              for (final expense in past.confirmed) _ExpenseRow(expense: expense, onTap: () => view.onExpense(expense)),
              if (past.notConfirmed.isNotEmpty) ...[
                const SizedBox(height: Dimens.spacing),
                Text(
                  l10n.pastHomeNotConfirmedTitle,
                  style: context.mboaText.label.copyWith(color: colors.textSecondary),
                ),
                for (final expense in past.notConfirmed)
                  _ExpenseRow(expense: expense, onTap: () => view.onExpense(expense)),
              ],
            ],
          ),
          const SizedBox(height: Dimens.spacing),
          _Section(
            title: l10n.pastHomeContractTitle,
            children: [
              _LinkRow(
                icon: LucideIcons.fileText,
                title: l10n.pastHomeContractOpen,
                line: past.verificationCode == null ? null : l10n.pastHomeVerificationCode(past.verificationCode!),
                onTap: view.onContract,
              ),
            ],
          ),
          // RM-M31-04 — no review, no block: « 0/5 » would read as a bad place.
          if (past.rating.hasRating) ...[
            const SizedBox(height: Dimens.spacing),
            _Section(title: l10n.pastHomeRatingTitle, children: [_Rating(rating: past.rating)]),
          ],
          if (reviewRow != null) ...[
            const SizedBox(height: Dimens.spacing),
            _Section(title: l10n.pastHomeReviewTitle, children: [reviewRow]),
          ],
          const SizedBox(height: Dimens.spacing),
          _Section(
            title: l10n.pastHomeLifeTitle,
            children: [
              _LinkRow(
                icon: LucideIcons.messagesSquare,
                title: l10n.requestsTitle,
                line: [
                  l10n.pastHomeRequests(past.requestCount),
                  if (past.openRequestCount > 0) l10n.pastHomeRequestsOpen(past.openRequestCount),
                ].join(', '),
                onTap: view.onRequests,
              ),
              _LinkRow(
                icon: LucideIcons.camera,
                title: l10n.evidenceTitle,
                line: canAddPhotos ? l10n.pastHomeEvidenceOpen(day(photosUntil)) : l10n.pastHomeEvidenceClosed,
                onTap: () => view.onEvidence(canAdd: canAddPhotos),
              ),
              _LinkRow(icon: LucideIcons.calendarDays, title: l10n.pastHomeSpace, onTap: view.onSpace),
            ],
          ),
        ],
      ),
    );
  }
}

/// The place and the lease as signed (RM-M31-02).
class _PlaceCard extends StatelessWidget {
  const _PlaceCard({required this.past, required this.onListing});

  final PastHome past;
  final void Function(String annonceId) onListing;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    String day(DateTime d) => DateFormat.yMMMd(locale).format(d);
    final home = past.home;
    final address = home.exactAddress ?? [home.district, home.city].nonNulls.join(', ');

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(Dimens.radiusLg),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 148,
            child: switch (home.coverUrl) {
              final url? => MboaNetworkImage(url: url),
              null => ColoredBox(
                  color: colors.primary,
                  child: MboaBrandPattern(color: colors.onBrand, opacity: 0.08),
                ),
            },
          ),
          Padding(
            padding: const EdgeInsets.all(Dimens.spacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        home.placeTitle ?? l10n.reservationUntitled,
                        style: context.mboaText.h3.copyWith(color: colors.ink),
                      ),
                    ),
                    const SizedBox(width: Dimens.spacingSm),
                    _Pill(text: l10n.myHomeEnded),
                  ],
                ),
                if (address.isNotEmpty) ...[
                  const SizedBox(height: Dimens.spacingXs),
                  _IconLine(icon: LucideIcons.mapPin, text: address),
                ],
                if ((home.startDate, home.endDate) case (final from?, final to?)) ...[
                  const SizedBox(height: Dimens.spacingXs),
                  _IconLine(icon: LucideIcons.calendar, text: l10n.pastHomeDates(day(from), day(to))),
                ],
                const SizedBox(height: Dimens.spacingMd),
                Row(
                  children: [
                    Expanded(child: _Figure(label: l10n.pastHomeRent, amount: home.rent)),
                    if (home.deposit.amount > 0)
                      Expanded(child: _Figure(label: l10n.myHomeDeposit, amount: home.deposit.amount)),
                  ],
                ),
                if (past.listingOnline && home.annonceId != null) ...[
                  const SizedBox(height: Dimens.spacingSm),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextButton.icon(
                      onPressed: () => onListing(home.annonceId!),
                      icon: const Icon(LucideIcons.externalLink, size: Dimens.icon),
                      label: Text(l10n.pastHomeSeeListing),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The big figure: what was paid and confirmed, by year beneath.
class _Total extends StatelessWidget {
  const _Total({required this.past});

  final PastHome past;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();

    return Column(
      children: [
        Text(l10n.pastHomePaidTotal, style: context.mboaText.bodyLarge.copyWith(color: colors.textSecondary)),
        const SizedBox(height: Dimens.spacingSm),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                NumberFormat.decimalPattern(locale).format(past.confirmedTotal),
                style: context.mboaText.display.copyWith(color: colors.primaryDark, fontSize: 44, height: 1.1),
              ),
              const SizedBox(width: Dimens.spacingSm),
              Text(l10n.annonceFormCurrency, style: context.mboaText.h3.copyWith(color: colors.primaryDark)),
            ],
          ),
        ),
        if (past.byYear.length > 1 || (past.byYear.length == 1 && past.byYear.single.$2 != past.confirmedTotal)) ...[
          const SizedBox(height: Dimens.spacingMd),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: Dimens.spacingSm,
            runSpacing: Dimens.spacingSm,
            children: [
              for (final (year, total) in past.byYear) _Pill(text: '$year · ${fcfaOf(context, total)}', strong: true),
            ],
          ),
        ],
        const SizedBox(height: Dimens.spacingMd),
        _Notice(icon: LucideIcons.shieldCheck, tone: colors.primary, text: l10n.pastHomeTotalNote),
      ],
    );
  }
}

/// One payment: what, when, how much — tapping opens its declaration and
/// receipt.
class _ExpenseRow extends StatelessWidget {
  const _ExpenseRow({required this.expense, required this.onTap});

  final PastExpense expense;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final confirmed = expense.status == DeclarationStatus.confirmed;
    final title = expense.label ??
        switch (expense.kind) {
          DeclarationKind.invoice => l10n.invoicesTitle,
          _ => l10n.pastHomeRent,
        };

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Dimens.radius),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.spacingSm),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: confirmed ? colors.primaryPale : colors.background,
                borderRadius: BorderRadius.circular(Dimens.radius),
              ),
              child: Icon(
                expense.receiptId != null ? LucideIcons.fileCheck2 : LucideIcons.banknote,
                size: Dimens.icon,
                color: confirmed ? colors.primary : colors.textTertiary,
              ),
            ),
            const SizedBox(width: Dimens.spacingMd),
            // The server's label is long — « Loyer du 18 octobre 2026 au 17
            // novembre 2026 »: it has the width, the figures go beneath.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.mboaText.label.copyWith(color: colors.ink),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      if (!confirmed)
                        DeclarationStatusChip(status: expense.status)
                      else if (expense.paidOn case final paidOn?)
                        Text(
                          DateFormat.yMMMd(locale).format(paidOn),
                          style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                        ),
                      const Spacer(),
                      Text(
                        fcfaOf(context, expense.amount),
                        style: context.mboaText.label.copyWith(
                          color: confirmed ? colors.ink : colors.textTertiary,
                          decoration: confirmed ? null : TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: Dimens.spacingXs),
            Icon(LucideIcons.chevronRight, size: Dimens.icon, color: colors.textTertiary),
          ],
        ),
      ),
    );
  }
}

class _Rating extends StatelessWidget {
  const _Rating({required this.rating});

  final PropertyRatingSummary rating;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final average = NumberFormat('0.0', locale).format(rating.average);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.spacingSm),
      child: Row(
        children: [
          Icon(LucideIcons.star, color: colors.warning, size: Dimens.iconMd),
          const SizedBox(width: Dimens.spacingSm),
          Text(
            l10n.listingRatingSummary(rating.reviewCount, average),
            style: context.mboaText.bodyLarge.copyWith(color: colors.ink, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

/// A titled white block of the sheet.
class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: context.mboaColors.surface,
          borderRadius: BorderRadius.circular(Dimens.radiusLg),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [HomeSectionTitle(title), ...children],
          ),
        ),
      );
}

/// A row that opens something kept elsewhere.
class _LinkRow extends StatelessWidget {
  const _LinkRow({required this.icon, required this.title, this.line, required this.onTap});

  final IconData icon;
  final String title;
  final String? line;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Dimens.radius),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.spacingSm),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: colors.primaryPale, borderRadius: BorderRadius.circular(Dimens.radius)),
              child: Icon(icon, size: Dimens.icon, color: colors.primary),
            ),
            const SizedBox(width: Dimens.spacingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: context.mboaText.label.copyWith(color: colors.ink)),
                  if (line case final line?)
                    Text(line, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
                ],
              ),
            ),
            Icon(LucideIcons.chevronRight, size: Dimens.icon, color: colors.textTertiary),
          ],
        ),
      ),
    );
  }
}

class _IconLine extends StatelessWidget {
  const _IconLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    return Row(
      children: [
        Icon(icon, size: Dimens.iconSm, color: colors.textTertiary),
        const SizedBox(width: Dimens.spacingXs),
        Expanded(child: Text(text, style: context.mboaText.caption.copyWith(color: colors.textSecondary))),
      ],
    );
  }
}

class _Figure extends StatelessWidget {
  const _Figure({required this.label, required this.amount});

  final String label;
  final int amount;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
        Text(fcfaOf(context, amount), style: context.mboaText.label.copyWith(color: colors.ink)),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text, this.strong = false});

  final String text;
  final bool strong;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingSm, vertical: 4),
      decoration: BoxDecoration(
        color: strong ? colors.primaryPale : colors.background,
        borderRadius: BorderRadius.circular(Dimens.radiusFull),
      ),
      child: Text(
        text,
        style: context.mboaText.caption.copyWith(
          color: strong ? colors.primaryDark : colors.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _Notice extends StatelessWidget {
  const _Notice({required this.icon, required this.tone, required this.text});

  final IconData icon;
  final Color tone;
  final String text;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(Dimens.spacingMd),
        decoration: BoxDecoration(
          color: tone.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(Dimens.radiusMd),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: Dimens.icon, color: tone),
            const SizedBox(width: Dimens.spacingSm),
            Expanded(child: Text(text, style: context.mboaText.caption.copyWith(color: context.mboaColors.ink))),
          ],
        ),
      );
}

/// The one main action: the expenses statement, on the share sheet.
class _StatementBar extends StatelessWidget {
  const _StatementBar({required this.state});

  final PastHomeReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    // The file name the user sees: what and where — never an id.
    final name = [l10n.pastHomeStatementName, ?state.past.home.placeTitle].join(' — ');

    return Container(
      decoration: BoxDecoration(color: colors.surface, border: Border(top: BorderSide(color: colors.border))),
      child: SafeArea(
        minimum: const EdgeInsets.all(Dimens.spacing),
        child: Button.primary(
          title: l10n.pastHomeStatement,
          icon: const Icon(LucideIcons.download, size: Dimens.icon),
          iconAlignment: IconAlignment.start,
          isLoading: state.statementBusy,
          onPressed: () => context.read<PastHomeBloc>().add(PastHomeStatementRequested(name: name)),
        ),
      ),
    );
  }
}
