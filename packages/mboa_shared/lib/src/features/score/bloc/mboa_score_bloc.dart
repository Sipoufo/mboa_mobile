import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/mboa_score_repository.dart';
import '../models/mboa_score.dart';

part 'mboa_score_event.dart';
part 'mboa_score_state.dart';

/// Whose score is being read.
sealed class ScoreSource extends Equatable {
  const ScoreSource();

  @override
  List<Object?> get props => [];
}

/// RM-M09-03 — the tenant's own, in App Mboa.
final class OwnScore extends ScoreSource {
  const OwnScore();
}

/// RM-M09-04 — a tenant who contacted this prestataire, in App Mboa Pro.
final class TenantScore extends ScoreSource {
  const TenantScore(this.userAccountId);

  final String userAccountId;

  @override
  List<Object?> get props => [userAccountId];
}

/// The Mboa Score (CDC M09) — shown, never computed here.
class MboaScoreBloc extends Bloc<MboaScoreEvent, MboaScoreState> {
  MboaScoreBloc({required MboaScoreRepository repository, required ScoreSource source})
      : _repository = repository,
        _source = source,
        super(const MboaScoreLoading()) {
    on<MboaScoreRequested>(_onRequested);
  }

  final MboaScoreRepository _repository;
  final ScoreSource _source;

  Future<void> _onRequested(MboaScoreRequested event, Emitter<MboaScoreState> emit) async {
    emit(const MboaScoreLoading());
    try {
      final score = await switch (_source) {
        OwnScore() => _repository.mine(),
        TenantScore(:final userAccountId) => _repository.tenant(userAccountId),
      };
      emit(MboaScoreReady(score));
    } on ScoreUnavailable catch (unavailable) {
      emit(MboaScoreUnavailable(unavailable.reason));
    } catch (_) {
      emit(const MboaScoreFailure());
    }
  }
}
