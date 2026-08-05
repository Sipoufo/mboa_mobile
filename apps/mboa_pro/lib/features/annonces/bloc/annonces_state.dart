part of 'annonces_bloc.dart';

sealed class AnnoncesState extends Equatable {
  const AnnoncesState();

  @override
  List<Object?> get props => [];
}

final class AnnoncesInitial extends AnnoncesState {
  const AnnoncesInitial();
}

final class AnnoncesLoadInProgress extends AnnoncesState {
  const AnnoncesLoadInProgress();
}

final class AnnoncesFailure extends AnnoncesState {
  const AnnoncesFailure();
}

final class AnnoncesReady extends AnnoncesState {
  const AnnoncesReady({
    required this.items,
    required this.filter,
    this.mutatingId,
    this.lastActionFailed = false,
  });

  /// Every listing, unfiltered — [visible] applies the tab.
  final List<Annonce> items;
  final AnnonceFilter filter;

  /// The listing currently being transitioned or deleted, so its card alone
  /// shows a spinner instead of blocking the whole list.
  final String? mutatingId;

  /// Set for one emission after a failed transition/delete, for a toast.
  final bool lastActionFailed;

  /// Standalone listings only — `items` may also hold a residence unit fetched
  /// for its detail screen, and those belong to the residence, not this list.
  List<Annonce> get standalone =>
      items.where((a) => a.residenceId == null).toList();

  /// Listings in the active tab. Archived listings appear only under Archivés.
  List<Annonce> get visible =>
      standalone.where((a) => filter.matches(a.status)).toList();

  /// Counts against the tier's `activeListingLimit` (RM-M10-02).
  ///
  /// Units are excluded deliberately: the backend does not charge a unit
  /// against the active-listing quota — a residence's allowance is enforced at
  /// creation instead.
  int get activeCount => standalone.where((a) => a.status.isActive).length;

  AnnoncesReady copyWith({
    List<Annonce>? items,
    AnnonceFilter? filter,
    String? mutatingId,
    bool clearMutating = false,
    bool lastActionFailed = false,
  }) =>
      AnnoncesReady(
        items: items ?? this.items,
        filter: filter ?? this.filter,
        mutatingId: clearMutating ? null : (mutatingId ?? this.mutatingId),
        lastActionFailed: lastActionFailed,
      );

  @override
  List<Object?> get props => [items, filter, mutatingId, lastActionFailed];
}
