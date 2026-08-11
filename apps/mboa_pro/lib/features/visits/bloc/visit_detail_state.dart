part of 'visit_detail_bloc.dart';

sealed class VisitDetailState extends Equatable {
  const VisitDetailState();

  @override
  List<Object?> get props => [];
}

class VisitDetailInitial extends VisitDetailState {
  const VisitDetailInitial();
}

class VisitDetailLoadInProgress extends VisitDetailState {
  const VisitDetailLoadInProgress();
}

class VisitDetailReady extends VisitDetailState {
  const VisitDetailReady(
    this.visit, {
    this.isStarting = false,
    this.lastActionFailed = false,
    this.locationFailure,
    this.pendingFix,
    this.distanceMetres,
  });

  final AgentVisitDetail visit;
  final bool isStarting;
  final bool lastActionFailed;

  /// Set when the fix could not be taken at all — the agent needs to know it is
  /// a permission problem, not a refusal.
  final LocationFailure? locationFailure;

  /// A fix taken outside the 500 m radius, held while the agent writes their
  /// justification (RM-M16-02). Non-null means the prompt is open.
  final LocationFix? pendingFix;

  final double? distanceMetres;

  bool get needsOverride => pendingFix != null;

  VisitDetailReady copyWith({
    AgentVisitDetail? visit,
    bool? isStarting,
    bool lastActionFailed = false,
    LocationFailure? locationFailure,
    LocationFix? pendingFix,
    bool clearPendingFix = false,
    double? distanceMetres,
  }) =>
      VisitDetailReady(
        visit ?? this.visit,
        isStarting: isStarting ?? this.isStarting,
        lastActionFailed: lastActionFailed,
        locationFailure: locationFailure,
        pendingFix: clearPendingFix ? null : (pendingFix ?? this.pendingFix),
        distanceMetres: distanceMetres ?? this.distanceMetres,
      );

  @override
  List<Object?> get props => [
        visit,
        isStarting,
        lastActionFailed,
        locationFailure,
        pendingFix,
        distanceMetres,
      ];
}

class VisitDetailFailure extends VisitDetailState {
  const VisitDetailFailure();
}
