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
    this.isConfirming = false,
    this.isCancelling = false,
    this.lastActionFailed = false,
    this.locationFailure,
    this.pendingFix,
    this.distanceMetres,
  });

  final AgentVisitDetail visit;
  final bool isConfirming;
  final bool isCancelling;
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
    bool? isConfirming,
    bool? isCancelling,
    bool lastActionFailed = false,
    LocationFailure? locationFailure,
    LocationFix? pendingFix,
    bool clearPendingFix = false,
    double? distanceMetres,
  }) =>
      VisitDetailReady(
        visit ?? this.visit,
        isConfirming: isConfirming ?? this.isConfirming,
        isCancelling: isCancelling ?? this.isCancelling,
        lastActionFailed: lastActionFailed,
        locationFailure: locationFailure,
        pendingFix: clearPendingFix ? null : (pendingFix ?? this.pendingFix),
        distanceMetres: distanceMetres ?? this.distanceMetres,
      );

  @override
  List<Object?> get props => [
        visit,
        isConfirming,
        isCancelling,
        lastActionFailed,
        locationFailure,
        pendingFix,
        distanceMetres,
      ];
}

/// Cancelled. Terminal: the screen closes rather than showing a visit that no
/// longer exists.
class VisitWasCancelled extends VisitDetailState {
  const VisitWasCancelled();
}

class VisitDetailFailure extends VisitDetailState {
  const VisitDetailFailure();
}
