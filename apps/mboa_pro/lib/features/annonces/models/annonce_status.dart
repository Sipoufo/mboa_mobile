import 'package:mboa_core/mboa_core.dart';

/// Why a listing is archived — `archivedReason`, null when it is not, or when
/// it was archived before the server kept reasons (2026-10-13).
///
/// Each one has a different way back, which is the point of telling them
/// apart: [expired] is republished for another 30 days (RM-M10-04),
/// [planLimit] needs room under the Free limit after a plan lapsed, and
/// [owner] was the prestataire's own doing.
enum ArchivedReason {
  owner,
  expired,
  planLimit,
  unknown;

  static ArchivedReason? fromResponse(AnnonceResponseArchivedReasonEnum? value) =>
      switch (value) {
        null => null,
        AnnonceResponseArchivedReasonEnum.OWNER => ArchivedReason.owner,
        AnnonceResponseArchivedReasonEnum.EXPIRED => ArchivedReason.expired,
        AnnonceResponseArchivedReasonEnum.PLAN_LIMIT => ArchivedReason.planLimit,
        _ => ArchivedReason.unknown,
      };
}

/// Lifecycle state of a listing (CDC M10).
///
/// ```
/// Brouillon → Publiée → [Louée | Archivée]
///                  ↓
///        (expirée Gratuit → Archivée)
/// ```
enum AnnonceStatus {
  draft,
  published,
  reserved,
  rented,
  archived,
  unknown;

  static AnnonceStatus fromResponse(AnnonceResponseStatusEnum? value) =>
      switch (value) {
        AnnonceResponseStatusEnum.DRAFT => AnnonceStatus.draft,
        AnnonceResponseStatusEnum.PUBLISHED => AnnonceStatus.published,
        AnnonceResponseStatusEnum.RESERVED => AnnonceStatus.reserved,
        AnnonceResponseStatusEnum.RENTED => AnnonceStatus.rented,
        AnnonceResponseStatusEnum.ARCHIVED => AnnonceStatus.archived,
        _ => AnnonceStatus.unknown,
      };

  static AnnonceStatus fromUnitSummary(UnitSummaryStatusEnum? value) =>
      switch (value) {
        UnitSummaryStatusEnum.DRAFT => AnnonceStatus.draft,
        UnitSummaryStatusEnum.PUBLISHED => AnnonceStatus.published,
        UnitSummaryStatusEnum.RESERVED => AnnonceStatus.reserved,
        UnitSummaryStatusEnum.RENTED => AnnonceStatus.rented,
        UnitSummaryStatusEnum.ARCHIVED => AnnonceStatus.archived,
        _ => AnnonceStatus.unknown,
      };

  /// Counts against the tier's `activeListingLimit` (RM-M10-02).
  bool get isActive =>
      this == AnnonceStatus.published || this == AnnonceStatus.reserved;
}

/// Which tab a listing belongs to on the Biens Uniques screen.
///
/// Drafts deliberately sit under [available] with a badge rather than being
/// hidden — a created-but-unpublished listing must not vanish from the app.
enum AnnonceFilter {
  available,
  occupied,

  /// Out of circulation but not deleted (RM-M10-05): a rented listing keeps its
  /// history, and a Gratuit listing archives itself at J+30 (RM-M10-04). They
  /// need somewhere to be seen.
  archived;

  bool matches(AnnonceStatus status) => switch (this) {
        AnnonceFilter.available =>
          status == AnnonceStatus.published || status == AnnonceStatus.draft,
        AnnonceFilter.occupied =>
          status == AnnonceStatus.reserved || status == AnnonceStatus.rented,
        AnnonceFilter.archived => status == AnnonceStatus.archived,
      };
}

/// A status change the prestataire can trigger from the list or detail.
///
/// [unreserve] lifts a reservation set by hand (RM-M10-10); one a client's
/// accepted request holds is cancelled from the request instead.
enum AnnonceTransition { publish, reserve, unreserve, markRented, archive, unarchive }
