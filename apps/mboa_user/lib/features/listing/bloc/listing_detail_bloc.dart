import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../data/listing_repository.dart';

part 'listing_detail_event.dart';
part 'listing_detail_state.dart';

/// One listing's public fiche (CDC M05).
///
/// The fiche and its reviews are **two reads**, and the second one failing must
/// not take the first down: a property whose review feed is unreachable is
/// still a property worth showing.
class ListingDetailBloc extends Bloc<ListingDetailEvent, ListingDetailState> {
  ListingDetailBloc({required ListingRepository repository})
      : _repository = repository,
        super(const ListingDetailInitial()) {
    on<ListingRequested>(_onRequested);
    on<ListingRefreshed>(_onRefreshed);
  }

  final ListingRepository _repository;

  Future<void> _onRequested(
    ListingRequested event,
    Emitter<ListingDetailState> emit,
  ) async {
    emit(const ListingDetailLoadInProgress());
    await _load(event.id, emit);
  }

  Future<void> _onRefreshed(
    ListingRefreshed event,
    Emitter<ListingDetailState> emit,
  ) async {
    final current = state;
    if (current is! ListingDetailReady) return;
    await _load(current.detail.id, emit);
  }

  Future<void> _load(String id, Emitter<ListingDetailState> emit) async {
    try {
      final detail = await _repository.one(id);
      emit(ListingDetailReady(detail: detail));

      // The feed is a second request, deliberately after the first paint:
      // RM-M05-08 adds to a fiche, it does not gate it.
      try {
        final reviews = await _repository.reviews(id);
        emit(ListingDetailReady(detail: detail, reviews: reviews));
      } catch (_) {
        // The fiche stays; the reviews section simply does not appear.
      }
    } on DioException catch (e) {
      // CE-M05-01 — deleted or expired is not a failure to retry: there is
      // nothing behind that id any more, and the screen says so.
      if (e.response?.statusCode == 404) {
        emit(const ListingGone());
        return;
      }
      _fallBackToCache(id, emit);
    } catch (_) {
      _fallBackToCache(id, emit);
    }
  }

  void _fallBackToCache(String id, Emitter<ListingDetailState> emit) {
    final cached = _repository.cached(id);
    if (cached != null) {
      emit(ListingDetailReady(detail: cached, isOffline: true));
      return;
    }
    emit(const ListingDetailFailure());
  }
}
