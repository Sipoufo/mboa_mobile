part of 'my_visits_bloc.dart';

sealed class MyVisitsState extends Equatable {
  const MyVisitsState();

  @override
  List<Object?> get props => const [];
}

final class MyVisitsInitial extends MyVisitsState {
  const MyVisitsInitial();
}

final class MyVisitsLoadInProgress extends MyVisitsState {
  const MyVisitsLoadInProgress();
}

final class MyVisitsReady extends MyVisitsState {
  const MyVisitsReady({
    this.upcoming = const [],
    this.past = const [],
    this.isOffline = false,
    this.busyVisitId,
    this.failed = false,
    this.ratedVisitIds = const {},
    this.reviewedVisitIds = const {},
  });

  /// Soonest first — what is coming is read top-down.
  final List<Visit> upcoming;

  /// Most recent first.
  final List<Visit> past;

  /// Showing what was cached, because the list could not be read.
  final bool isOffline;

  /// The visit an action is running on, so only its own row spins.
  final String? busyVisitId;
  final bool failed;

  /// Rated in this session. The endpoint accepts a rating once (RM-M07-07) and
  /// nothing in `VisiteResponse` says whether one was given, so the stars are
  /// hidden here and the screen stops offering what would be refused.
  final Set<String> ratedVisitIds;

  /// RM-M07bis-01 — one report per visit, so a visit in here is done being
  /// written about. Read from the server, because `VisiteResponse` carries no
  /// flag for it.
  final Set<String> reviewedVisitIds;

  bool get isEmpty => upcoming.isEmpty && past.isEmpty;

  MyVisitsReady copyWith({
    List<Visit>? upcoming,
    List<Visit>? past,
    bool? isOffline,
    String? busyVisitId,
    bool failed = false,
    Set<String>? ratedVisitIds,
    Set<String>? reviewedVisitIds,
  }) =>
      MyVisitsReady(
        upcoming: upcoming ?? this.upcoming,
        past: past ?? this.past,
        isOffline: isOffline ?? this.isOffline,
        busyVisitId: busyVisitId,
        failed: failed,
        ratedVisitIds: ratedVisitIds ?? this.ratedVisitIds,
        reviewedVisitIds: reviewedVisitIds ?? this.reviewedVisitIds,
      );

  @override
  List<Object?> get props => [
        upcoming,
        past,
        isOffline,
        busyVisitId,
        failed,
        ratedVisitIds,
        reviewedVisitIds,
      ];
}

final class MyVisitsFailure extends MyVisitsState {
  const MyVisitsFailure();
}
