part of 'listing_detail_bloc.dart';

sealed class ListingDetailState extends Equatable {
  const ListingDetailState();

  @override
  List<Object?> get props => [];
}

class ListingDetailInitial extends ListingDetailState {
  const ListingDetailInitial();
}

class ListingDetailLoadInProgress extends ListingDetailState {
  const ListingDetailLoadInProgress();
}

class ListingDetailReady extends ListingDetailState {
  const ListingDetailReady({
    required this.detail,
    this.reviews = const [],
    this.isOffline = false,
  });

  final ListingDetail detail;

  /// RM-M05-08 — empty until the second read lands, and empty for good on a
  /// property nobody has reviewed. Both draw nothing, which is correct.
  final List<ReviewEntry> reviews;

  /// Read from the 24h cache: the figures are right, the verdicts are not, so
  /// the actions stay off (see `ListingRepository.cached`).
  final bool isOffline;

  @override
  List<Object?> get props => [detail, reviews, isOffline];
}

/// CE-M05-01 — the listing is gone or expired. Not an error to retry.
class ListingGone extends ListingDetailState {
  const ListingGone();
}

class ListingDetailFailure extends ListingDetailState {
  const ListingDetailFailure();
}
