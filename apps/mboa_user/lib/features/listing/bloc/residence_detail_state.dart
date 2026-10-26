part of 'residence_detail_bloc.dart';

sealed class ResidenceDetailState extends Equatable {
  const ResidenceDetailState();

  @override
  List<Object?> get props => [];
}

class ResidenceDetailInitial extends ResidenceDetailState {
  const ResidenceDetailInitial();
}

class ResidenceDetailLoadInProgress extends ResidenceDetailState {
  const ResidenceDetailLoadInProgress();
}

class ResidenceDetailReady extends ResidenceDetailState {
  const ResidenceDetailReady({required this.detail, this.reviews = const [], this.isOffline = false});

  final ResidenceDetail detail;

  /// §36 — empty until the second read lands, and for good on a residence
  /// nobody has reviewed. Both draw nothing.
  final List<ReviewEntry> reviews;

  /// Read from the 24h cache — no exact position, no reviews.
  final bool isOffline;

  @override
  List<Object?> get props => [detail, reviews, isOffline];
}

/// The residence was withdrawn. Not an error to retry.
class ResidenceGone extends ResidenceDetailState {
  const ResidenceGone();
}

class ResidenceDetailFailure extends ResidenceDetailState {
  const ResidenceDetailFailure();
}
