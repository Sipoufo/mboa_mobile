import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../data/listing_repository.dart';

part 'residence_detail_event.dart';
part 'residence_detail_state.dart';

/// One residence's public fiche (CDC M10bis / M05), and the way into its units.
///
/// Like a listing's: the fiche and its reviews are two reads, and the second
/// failing leaves the first on screen.
class ResidenceDetailBloc extends Bloc<ResidenceDetailEvent, ResidenceDetailState> {
  ResidenceDetailBloc({required ListingRepository repository})
      : _repository = repository,
        super(const ResidenceDetailInitial()) {
    on<ResidenceRequested>(_onRequested);
  }

  final ListingRepository _repository;

  Future<void> _onRequested(ResidenceRequested event, Emitter<ResidenceDetailState> emit) async {
    emit(const ResidenceDetailLoadInProgress());
    final id = event.id;
    try {
      final detail = await _repository.residence(id);
      emit(ResidenceDetailReady(detail: detail));

      // §36 — after the first paint: the reviews add to the fiche, they do
      // not gate it.
      try {
        final reviews = await _repository.residenceReviews(id);
        emit(ResidenceDetailReady(detail: detail, reviews: reviews));
      } catch (_) {
        // The fiche stays; the reviews section simply does not appear.
      }
    } on DioException catch (e) {
      // Withdrawn: nothing to retry, and the screen says so.
      if (e.response?.statusCode == 404) {
        emit(const ResidenceGone());
        return;
      }
      _fallBackToCache(id, emit);
    } catch (_) {
      _fallBackToCache(id, emit);
    }
  }

  void _fallBackToCache(String id, Emitter<ResidenceDetailState> emit) {
    final cached = _repository.cachedResidence(id);
    if (cached != null) {
      emit(ResidenceDetailReady(detail: cached, isOffline: true));
      return;
    }
    emit(const ResidenceDetailFailure());
  }
}
