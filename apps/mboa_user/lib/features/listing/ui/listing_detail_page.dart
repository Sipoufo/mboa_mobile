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
import '../../favorites/bloc/favorites_bloc.dart';
import '../../messaging/ui/contact_sheet.dart';
import '../../reservations/models/reservation_draft.dart';
import '../../visits/ui/book_visit_sheet.dart';
import '../bloc/listing_detail_bloc.dart';
import 'widgets/fiche_sections.dart';
import 'widgets/listing_bits.dart';

/// The public fiche of a listing (CDC M05).
///
/// Readable by anyone (CA-M04-04). What needs an account — contacting, booking
/// — is gated by the server's own verdicts (`canContact`, `canPlanVisit`), so
/// the app never promises a screen that would open empty.
@RoutePage()
class ListingDetailPage extends StatelessWidget implements AutoRouteWrapper {
  const ListingDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<ListingDetailBloc>(
            create: (_) =>
                getIt<ListingDetailBloc>()..add(ListingRequested(id)),
          ),
          // The fiche is a **root** route, a sibling of the tab shell — not a
          // screen inside a tab (see `AppRouter`). Nothing above it provides
          // the shell's `FavoritesBloc`, so the heart in the carousel threw
          // and took the whole gallery down with it. `.value` on the getIt
          // singleton: the same instance the tabs read, and this route must
          // not close it on pop.
          BlocProvider<FavoritesBloc>.value(value: getIt<FavoritesBloc>()),
        ],
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(title: Text(l10n.listingTitle)),
      body: BlocBuilder<ListingDetailBloc, ListingDetailState>(
        builder: (context, state) => switch (state) {
          ListingDetailInitial() || ListingDetailLoadInProgress() =>
            const Center(child: Loader()),
          ListingGone() => const _Gone(),
          ListingDetailFailure() => Center(
              child: TextButton(
                onPressed: () =>
                    context.read<ListingDetailBloc>().add(ListingRequested(id)),
                child: Text(l10n.commonRetry),
              ),
            ),
          final ListingDetailReady ready => _Body(state: ready),
        },
      ),
      bottomNavigationBar: BlocBuilder<ListingDetailBloc, ListingDetailState>(
        builder: (context, state) =>
            state is ListingDetailReady && !state.isOffline
                ? _Actions(detail: state.detail)
                : const SizedBox.shrink(),
      ),
    );
  }
}

/// CE-M05-01 — withdrawn or expired. Nothing to retry.
class _Gone extends StatelessWidget {
  const _Gone();

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.spacingXl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              LucideIcons.searchX,
              size: Dimens.iconLg,
              color: colors.textTertiary,
            ),
            const SizedBox(height: Dimens.spacing),
            Text(
              l10n.listingGoneTitle,
              textAlign: TextAlign.center,
              style: context.mboaText.h3.copyWith(color: colors.ink),
            ),
            const SizedBox(height: Dimens.spacingXs),
            Text(
              l10n.listingGoneBody,
              textAlign: TextAlign.center,
              style: context.mboaText.body.copyWith(color: colors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

/// The founder's fiche: the photo with what it is laid over, who rents it
/// out, what it is as pills, the description, then where it is and what
/// people say side by side — and the reviews themselves below.
class _Body extends StatefulWidget {
  const _Body({required this.state});

  final ListingDetailReady state;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  /// Where the "Avis" card scrolls to.
  final _reviewsKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final state = widget.state;
    final detail = state.detail;
    final hasReviews = detail.rating.hasRating || state.reviews.isNotEmpty;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        Dimens.spacing,
        Dimens.spacing,
        Dimens.spacing,
        Dimens.spacingXl,
      ),
      children: [
        if (state.isOffline) const _OfflineBanner(),
        // §20 — someone with a visit still to happen can read an off-market
        // fiche; it says so before anything else on it.
        if (detail.availability != ListingAvailability.available)
          _AvailabilityBanner(availability: detail.availability),
        ListingHero(detail: detail),
        const SizedBox(height: Dimens.spacingSm),
        // RM-M05-02 / CA-M05-03 — the exact address is not withheld by the UI:
        // the API never sends it. The coordinates are fuzzed by ~200 m until
        // contact (RM-M04-06); once the server says they are exact, the note
        // says so — the written address still waits for the signed contract.
        Text(
          detail.exactLocation ? l10n.listingLocationExactNote : l10n.listingLocationNote,
          style: context.mboaText.caption.copyWith(color: colors.textTertiary),
        ),
        if (detail.provider case final provider?) ...[
          const SizedBox(height: Dimens.spacing),
          ListingProviderRow(provider: provider),
        ],
        const SizedBox(height: Dimens.spacing),
        ListingFactChips(detail: detail),
        if (detail.description case final description? when description.trim().isNotEmpty) ...[
          const SizedBox(height: Dimens.spacingLg),
          Text(l10n.listingDescription, style: context.mboaText.h3.copyWith(color: colors.primaryDark)),
          const SizedBox(height: Dimens.spacingSm),
          Text(description, style: context.mboaText.body.copyWith(color: colors.ink)),
        ],
        const SizedBox(height: Dimens.spacingLg),
        ListingCardsRow(
          detail: detail,
          onOpenMap: () => context.router.push(
            ListingMapRoute(
              latitude: detail.latitude!,
              longitude: detail.longitude!,
              exact: detail.exactLocation,
              title: detail.title,
            ),
          ),
          onOpenReviews: () {
            final target = _reviewsKey.currentContext;
            if (target != null) {
              Scrollable.ensureVisible(target, duration: const Duration(milliseconds: 350), curve: Curves.easeOut);
            }
          },
        ),
        // RM-M05-08 — no review, no block: a "0/5" reads as a bad property
        // rather than an unrated one.
        if (hasReviews) ...[
          const SizedBox(height: Dimens.spacing),
          KeyedSubtree(key: _reviewsKey, child: _Reviews(state: state)),
        ],
      ],
    );
  }
}

class _AvailabilityBanner extends StatelessWidget {
  const _AvailabilityBanner({required this.availability});

  final ListingAvailability availability;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final (text, icon) = switch (availability) {
      ListingAvailability.reserved =>
        (l10n.listingReservedBanner, LucideIcons.bookmark),
      ListingAvailability.rented =>
        (l10n.listingRentedBanner, LucideIcons.keyRound),
      ListingAvailability.offMarket ||
      ListingAvailability.available =>
        (l10n.listingOffMarketBanner, LucideIcons.eyeOff),
    };

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: Dimens.spacing),
      padding: const EdgeInsets.all(Dimens.spacingMd),
      decoration: BoxDecoration(
        color: colors.info.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(Dimens.radius),
      ),
      child: Row(
        children: [
          Icon(icon, size: Dimens.iconSm, color: colors.info),
          const SizedBox(width: Dimens.spacingSm),
          Expanded(
            child: Text(
              text,
              style: context.mboaText.caption.copyWith(color: colors.ink),
            ),
          ),
        ],
      ),
    );
  }
}

class _OfflineBanner extends StatelessWidget {
  const _OfflineBanner();

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: Dimens.spacing),
      padding: const EdgeInsets.all(Dimens.spacingMd),
      decoration: BoxDecoration(
        color: colors.warning.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(Dimens.radius),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.wifiOff, size: Dimens.iconSm, color: colors.warning),
          const SizedBox(width: Dimens.spacingSm),
          Expanded(
            child: Text(
              l10n.listingOfflineBanner,
              style: context.mboaText.caption.copyWith(color: colors.warning),
            ),
          ),
        ],
      ),
    );
  }
}

/// RM-M05-08 — the weighted average and the feed behind it.
class _Reviews extends StatelessWidget {
  const _Reviews({required this.state});

  final ListingDetailReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final rating = state.detail.rating;

    return ListingSection(
      title: l10n.listingReviewsTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (rating.hasRating) ...[
            Row(
              children: [
                Icon(LucideIcons.star, size: Dimens.icon, color: colors.primary),
                const SizedBox(width: Dimens.spacingSm),
                Text(
                  l10n.listingRatingSummary(
                    rating.reviewCount,
                    rating.average!.toStringAsFixed(1),
                  ),
                  style: context.mboaText.label.copyWith(color: colors.ink),
                ),
              ],
            ),
            const SizedBox(height: Dimens.spacing),
          ],
          for (final review in state.reviews)
            _Review(
              review: review,
              onReport: (entry) => _reportReview(context, entry),
            ),
        ],
      ),
    );
  }
}

/// RM-M27-06 — reporting a review needs an account, like reporting a listing.
Future<void> _reportReview(BuildContext context, ReviewEntry review) async {
  final l10n = I18n.of(context);

  if (!getIt<SessionSnapshot>().hasSession) {
    MboaToast.info(context: context, title: l10n.reportSignInBody);
    return;
  }

  await showReportSheet(
    context,
    target: ReportTarget.review(review.id),
    title: l10n.reportReviewTitle,
    cubit: getIt<ReportCubit>(),
  );
}

class _Review extends StatelessWidget {
  const _Review({required this.review, required this.onReport});

  final ReviewEntry review;
  final void Function(ReviewEntry review) onReport;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  // RM-M07bis-08 — the review outlives its author.
                  review.authorName ?? l10n.reviewDeletedAuthor,
                  style: context.mboaText.label.copyWith(color: colors.ink),
                ),
              ),
              if (review.rating case final rating?)
                Text(
                  '$rating/5',
                  style:
                      context.mboaText.label.copyWith(color: colors.primaryDark),
                ),
            ],
          ),
          const SizedBox(height: Dimens.spacingXs),
          Row(
            children: [
              // RG-06 — which kind of testimony this is, because a tenant of a
              // year and a visitor of an hour do not weigh the same.
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.spacingSm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: review.kind == ReviewKind.resident
                      ? colors.primaryPale
                      : colors.surfaceWarm,
                  borderRadius: BorderRadius.circular(Dimens.radiusFull),
                ),
                child: Text(
                  review.kind == ReviewKind.resident
                      ? l10n.listingReviewResident
                      : l10n.listingReviewVisit,
                  style: context.mboaText.caption
                      .copyWith(color: colors.textSecondary),
                ),
              ),
              // §24.2 — the stay in the contract's own unit: "3 jours",
              // "12 mois". A short let says its real length now, instead of
              // rounding to "0 mois". Null (no duration) shows nothing.
              if (review.stayLabel(l10n) case final stay?) ...[
                const SizedBox(width: Dimens.spacingSm),
                Text(
                  stay,
                  style: context.mboaText.caption
                      .copyWith(color: colors.textTertiary),
                ),
              ],
              const Spacer(),
              if (review.publishedAt case final at?)
                Text(
                  DateFormat.yMMMd().format(at),
                  style: context.mboaText.caption
                      .copyWith(color: colors.textTertiary),
                ),
            ],
          ),
          // RM-M27-02 — a resident may revise theirs, so a corrected review
          // says so. The copy for this has existed since the feed shipped and
          // was never rendered.
          if (review.editedAt case final at?) ...[
            const SizedBox(height: Dimens.spacingXs),
            Text(
              l10n.listingReviewEdited(DateFormat.yMMMd().format(at)),
              style: context.mboaText.caption
                  .copyWith(color: colors.textTertiary),
            ),
          ],
          if (review.comment case final comment?
              when comment.trim().isNotEmpty) ...[
            const SizedBox(height: Dimens.spacingSm),
            Text(
              comment,
              style: context.mboaText.body.copyWith(color: colors.ink),
            ),
          ],
          // M07bis's content table: the bullets and the photos are half of
          // what a visitor writes, and the fiche showed neither until the
          // tenant app could write them.
          if (review.pros.isNotEmpty || review.cons.isNotEmpty) ...[
            const SizedBox(height: Dimens.spacingSm),
            Wrap(
              spacing: Dimens.spacingSm,
              runSpacing: Dimens.spacingXs,
              children: [
                for (final pro in review.pros)
                  _ReviewPoint(label: pro, isPro: true),
                for (final con in review.cons)
                  _ReviewPoint(label: con, isPro: false),
              ],
            ),
          ],
          if (review.photoKeys.isNotEmpty) ...[
            const SizedBox(height: Dimens.spacingSm),
            SizedBox(
              height: 72,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: review.photoKeys.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(width: Dimens.spacingSm),
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(Dimens.radius),
                  child: SizedBox(
                    width: 72,
                    child: MboaNetworkImage(
                      url: BaseProfile.mediaUrl(review.photoKeys[index]),
                      placeholder: const MboaImagePlaceholder(size: 72),
                    ),
                  ),
                ),
              ),
            ),
          ],
          for (final reply in review.replies) ...[
            const SizedBox(height: Dimens.spacingSm),
            Container(
              padding: const EdgeInsets.all(Dimens.spacingMd),
              decoration: BoxDecoration(
                color: colors.surfaceWarm,
                borderRadius: BorderRadius.circular(Dimens.radius),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reply.authorName ?? '',
                    style: context.mboaText.caption
                        .copyWith(color: colors.primaryDark),
                  ),
                  const SizedBox(height: Dimens.spacingXs),
                  Text(
                    reply.body ?? '',
                    style: context.mboaText.body
                        .copyWith(color: colors.textSecondary),
                  ),
                ],
              ),
            ),
          ],
          // RM-M27-06 — any signed-in user may report a review, of either
          // kind. Placed under the review rather than in its header: a flag
          // beside somebody's name reads as an accusation before anyone has
          // read what they wrote.
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => onReport(review),
              icon: Icon(
                LucideIcons.flag,
                size: Dimens.iconSm,
                color: colors.textTertiary,
              ),
              label: Text(
                l10n.listingReport,
                style: context.mboaText.caption
                    .copyWith(color: colors.textTertiary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// One bullet of a review — the sign carries the meaning, not the colour
/// alone, so it still reads in greyscale and to a colour-blind reader.
class _ReviewPoint extends StatelessWidget {
  const _ReviewPoint({required this.label, required this.isPro});

  final String label;
  final bool isPro;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isPro ? LucideIcons.plus : LucideIcons.minus,
          size: 14,
          color: isPro ? colors.success : colors.error,
        ),
        const SizedBox(width: Dimens.spacingXs),
        Text(
          label,
          style: context.mboaText.caption.copyWith(color: colors.textSecondary),
        ),
      ],
    );
  }
}

/// The rent, one main action, and "⋯" for the rest.
///
/// The main action is reserving (M29) where the listing can be asked for,
/// contacting otherwise; the others — contact, plan a visit, report — sit
/// behind "⋯" so the bar never carries three buttons (the founder's call).
/// Contacting and visiting are the server's to allow: `canContact` carries
/// RM-M04-05 and `canPlanVisit` carries RM-M05-07 — a bookable visitor must
/// exist, or the button would open an empty booking screen.
class _Actions extends StatelessWidget {
  const _Actions({required this.detail});

  final ListingDetail detail;

  /// Opens the thread the first message created — or the one that already
  /// existed, since a second tap is a 409 and not a failure.
  /// RM-M27-06 / RM-M05-05 — reporting needs an account, so a visitor is
  /// told that rather than shown a sheet whose send button would 401.
  Future<void> _report(
    BuildContext context, {
    required ReportTarget target,
    required String title,
  }) async {
    final l10n = I18n.of(context);

    if (!getIt<SessionSnapshot>().hasSession) {
      MboaToast.info(context: context, title: l10n.reportSignInBody);
      return;
    }

    await showReportSheet(
      context,
      target: target,
      title: title,
      cubit: getIt<ReportCubit>(),
    );
  }

  Future<void> _contact(BuildContext context, ListingDetail detail) async {
    final l10n = I18n.of(context);
    final router = context.router;

    final conversation = await showContactSheet(
      context,
      annonceId: detail.id,
      annonceTitle: detail.title,
    );
    if (conversation == null || !context.mounted) return;

    MboaToast.success(context: context, title: l10n.messagingContactSent);
    await router.push(ThreadRoute(conversation: conversation));
  }

  /// M29 — asking to reserve, or opening the request already sent. The fiche
  /// is read again on the way back: the request changes what it offers.
  Future<void> _reserve(BuildContext context, ListingDetail detail) async {
    final bloc = context.read<ListingDetailBloc>();
    final router = context.router.root;

    if (!getIt<SessionSnapshot>().hasSession) {
      await router.push(const WelcomeRoute());
      return;
    }

    final requestId = detail.myReservationRequestId;
    await router.push(
      AuthenticatedRouter(
        children: [
          if (requestId != null)
            ReservationDetailRoute(id: requestId)
          else
            RequestReservationRoute(listing: ReservationListing.fromDetail(detail)),
        ],
      ),
    );
    bloc.add(ListingRequested(detail.id));
  }

  /// "⋯": what the bar does not carry. The sheet answers with a choice and
  /// the bar acts on it, so nothing runs on a context the sheet took away.
  Future<void> _more(BuildContext context, {required bool withContact}) async {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final signedIn = getIt<SessionSnapshot>().hasSession;

    final choice = await showModalBottomSheet<_MoreAction>(
      context: context,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl)),
      ),
      builder: (sheetContext) {
        Widget item(IconData icon, String label, _MoreAction action, {bool enabled = true}) => ListTile(
              enabled: enabled,
              leading: Icon(icon, color: enabled ? colors.primary : colors.textTertiary),
              title: Text(label, style: context.mboaText.label.copyWith(color: enabled ? colors.ink : colors.textTertiary)),
              onTap: () => Navigator.of(sheetContext).pop(action),
            );

        Widget note(String text, Color color) => Padding(
              padding: const EdgeInsets.fromLTRB(Dimens.spacingLg, Dimens.spacingSm, Dimens.spacingLg, 0),
              child: Text(text, textAlign: TextAlign.center, style: context.mboaText.caption.copyWith(color: color)),
            );

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimens.spacing),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (withContact)
                  item(LucideIcons.messageCircle, l10n.listingContact, _MoreAction.contact, enabled: detail.canContact),
                if (detail.canPlanVisit) item(LucideIcons.calendarPlus, l10n.listingPlanVisit, _MoreAction.plan),
                // RM-M05-05 — any signed-in user may report a listing.
                item(LucideIcons.flag, l10n.listingReport, _MoreAction.report),
                // Only where it explains something: a signed-out reader whose
                // actions are live has nothing to be told (and the server
                // would not return `canContact` for one anyway).
                if (!signedIn && !detail.canContact)
                  note(l10n.listingActionsSignIn, colors.textSecondary)
                else if (!detail.canPlanVisit)
                  note(l10n.listingNoVisitor, colors.textTertiary),
              ],
            ),
          ),
        );
      },
    );
    if (choice == null || !context.mounted) return;

    switch (choice) {
      case _MoreAction.contact:
        await _contact(context, detail);
      // M07. `canPlanVisit` is the server's verdict that someone can actually
      // show this place (RM-M07-01); the sheet then says who, and when.
      case _MoreAction.plan:
        await showBookVisitSheet(context, annonceId: detail.id, annonceTitle: detail.title);
      case _MoreAction.report:
        await _report(context, target: ReportTarget.annonce(detail.id), title: l10n.listingReport);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final signedIn = getIt<SessionSnapshot>().hasSession;
    final requestId = detail.myReservationRequestId;
    // The server's verdict for a signed-in reader; a visitor is shown the
    // door on an available listing and sent to sign in (CA-M04-04).
    final reservable = requestId != null ||
        detail.canRequestReservation ||
        (!signedIn && detail.availability == ListingAvailability.available);
    final price = detail.displayPrice;

    final main = reservable
        ? Button.primary(
            title: requestId != null ? l10n.listingReservationSent : l10n.listingRequestReservation,
            onPressed: () => _reserve(context, detail),
          )
        : Button.primary(
            title: l10n.listingContact,
            // RM-M12-01 — the tenant's first word, on this listing. The gate
            // is the server's (`canContact`).
            onPressed: detail.canContact ? () => _contact(context, detail) : null,
          );

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: SafeArea(
        minimum: const EdgeInsets.all(Dimens.spacing),
        // The founder's fiche: the rent on the left, the one thing this
        // screen leads to on the right.
        child: Row(
          children: [
            if (price != null) ...[
              // As wide as the rent needs, within reason: the button takes
              // the rest.
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 170),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.reservationRentTitle,
                      style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                    ),
                    Text(
                      detail.rentalPeriod.priceLabel(l10n, price),
                      maxLines: 2,
                      style: context.mboaText.label.copyWith(color: colors.primary, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: Dimens.spacingMd),
            ],
            Expanded(child: main),
            const SizedBox(width: Dimens.spacingSm),
            SizedBox.square(
              dimension: Dimens.buttonHeight,
              child: IconButton(
                tooltip: l10n.listingMoreActions,
                onPressed: () => _more(context, withContact: reservable),
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
        ),
      ),
    );
  }
}

enum _MoreAction { contact, plan, report }
