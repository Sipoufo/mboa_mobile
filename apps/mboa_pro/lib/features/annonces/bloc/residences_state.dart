part of 'residences_bloc.dart';

sealed class ResidencesState extends Equatable {
  const ResidencesState();

  @override
  List<Object?> get props => [];
}

final class ResidencesInitial extends ResidencesState {
  const ResidencesInitial();
}

final class ResidencesLoadInProgress extends ResidencesState {
  const ResidencesLoadInProgress();
}

final class ResidencesFailure extends ResidencesState {
  const ResidencesFailure();
}

final class ResidencesReady extends ResidencesState {
  const ResidencesReady({
    required this.items,
    this.mutatingId,
    this.lastActionFailed = false,
  });

  final List<Residence> items;

  /// The residence currently being transitioned, so only its card spins.
  final String? mutatingId;
  final bool lastActionFailed;

  /// Residences whose units are published — the multi-unit analogue of an
  /// active listing, for the tier limit.
  int get activeCount =>
      items.where((r) => (r.publishedUnitCount ?? 0) > 0).length;

  ResidencesReady copyWith({
    List<Residence>? items,
    String? mutatingId,
    bool clearMutating = false,
    bool lastActionFailed = false,
  }) =>
      ResidencesReady(
        items: items ?? this.items,
        mutatingId: clearMutating ? null : (mutatingId ?? this.mutatingId),
        lastActionFailed: lastActionFailed,
      );

  @override
  List<Object?> get props => [items, mutatingId, lastActionFailed];
}
