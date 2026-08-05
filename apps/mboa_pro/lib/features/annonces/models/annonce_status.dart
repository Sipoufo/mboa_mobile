import 'package:mboa_core/mboa_core.dart';

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
  occupied;

  bool matches(AnnonceStatus status) => switch (this) {
        AnnonceFilter.available =>
          status == AnnonceStatus.published || status == AnnonceStatus.draft,
        AnnonceFilter.occupied =>
          status == AnnonceStatus.reserved || status == AnnonceStatus.rented,
      };
}

/// A status change the prestataire can trigger from the list or detail.
enum AnnonceTransition { publish, reserve, markRented, archive }
