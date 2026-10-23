import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../home/data/pro_dashboard_repository.dart';
import '../../home/models/listing_figures.dart';

/// A listing's « Statistiques » card (CDC M14): its own figures, locked or
/// not as the server says. Offline, the last read.
class ListingStatsBloc extends Bloc<ListingStatsEvent, ListingStatsState> {
  ListingStatsBloc({required ProDashboardRepository repository})
      : _repository = repository,
        super(const ListingStatsLoading()) {
    on<ListingStatsRequested>(_onRequested);
  }

  final ProDashboardRepository _repository;

  Future<void> _onRequested(ListingStatsRequested event, Emitter<ListingStatsState> emit) async {
    try {
      final read = await _repository.listingFigures(event.annonceId);
      emit(ListingStatsReady(read.value, isOffline: read.fromCache));
    } catch (_) {
      if (state is! ListingStatsReady) emit(const ListingStatsFailure());
    }
  }
}

sealed class ListingStatsEvent extends Equatable {
  const ListingStatsEvent();

  @override
  List<Object?> get props => [];
}

final class ListingStatsRequested extends ListingStatsEvent {
  const ListingStatsRequested(this.annonceId);

  final String annonceId;

  @override
  List<Object?> get props => [annonceId];
}

sealed class ListingStatsState extends Equatable {
  const ListingStatsState();

  @override
  List<Object?> get props => [];
}

final class ListingStatsLoading extends ListingStatsState {
  const ListingStatsLoading();
}

final class ListingStatsFailure extends ListingStatsState {
  const ListingStatsFailure();
}

final class ListingStatsReady extends ListingStatsState {
  const ListingStatsReady(this.figures, {this.isOffline = false});

  /// Null: the server counts nothing for it (a draft, say).
  final ListingFigures? figures;
  final bool isOffline;

  @override
  List<Object?> get props => [figures, isOffline];
}
