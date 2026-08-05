import 'package:built_collection/built_collection.dart';
import 'package:mboa_core/mboa_core.dart';

import '../models/annonce.dart';
import '../models/annonce_draft.dart';
import '../models/annonce_status.dart';

/// Listings CRUD and lifecycle (CDC M10).
class AnnonceRepository {
  AnnonceRepository({required DioClient dioClient}) : _dioClient = dioClient;

  final DioClient _dioClient;

  /// One page big enough for any realistic portfolio — the API paginates but
  /// the Pro screens present a single list. Revisit if portfolios grow.
  static const int _pageSize = 100;

  AnnoncesApi get _api => _dioClient.api.getAnnoncesApi();

  Future<List<Annonce>> list() async {
    final response = await _api.listMine2(
      pageable: Pageable((b) => b
        ..page = 0
        ..size = _pageSize),
    );
    return (response.data?.content ?? const <AnnonceResponse>[])
        .map(Annonce.fromResponse)
        .toList();
  }

  Future<Annonce> getOne(String id) async {
    final response = await _api.getOne1(id: id);
    final data = response.data;
    if (data == null) throw StateError('Listing $id not found');
    return Annonce.fromResponse(data);
  }

  Future<Annonce> create(AnnonceDraft draft) async {
    final location = draft.location;
    final availableFrom = draft.availableFrom;
    if (location == null || availableFrom == null) {
      throw StateError('Draft is missing its location or availability date');
    }

    final response = await _api.create1(
      createAnnonceRequest: CreateAnnonceRequest((b) => b
        ..propertyType = draft.propertyType.asCreate
        ..title = draft.title.trim()
        ..districtId = location.districtId
        ..exactAddress = location.exactAddress ?? location.label
        ..latitude = location.latitude
        ..longitude = location.longitude
        ..monthlyRent = draft.monthlyRent ?? 0
        ..chargesIncluded = draft.chargesIncluded
        ..chargesAmount = draft.chargesAmount
        ..surfaceArea = draft.surfaceArea
        ..roomCount = draft.roomCount
        ..bathroomCount = draft.bathroomCount
        ..furnished = draft.furnished
        ..availableFrom = availableFrom.toDate()
        ..description = draft.description
        ..photoKeys = ListBuilder<String>(draft.photoKeys)),
    );

    final data = response.data;
    if (data == null) throw StateError('create returned no listing');
    return Annonce.fromResponse(data);
  }

  Future<Annonce> update(AnnonceDraft draft) async {
    final id = draft.id;
    if (id == null) throw StateError('Cannot update a draft with no id');

    final location = draft.location;
    final response = await _api.update1(
      id: id,
      updateAnnonceRequest: UpdateAnnonceRequest((b) => b
        ..propertyType = draft.propertyType.asUpdate
        ..title = draft.title.trim()
        ..districtId = location?.districtId
        ..exactAddress = location?.exactAddress
        ..latitude = location?.latitude
        ..longitude = location?.longitude
        ..monthlyRent = draft.monthlyRent
        ..chargesIncluded = draft.chargesIncluded
        ..chargesAmount = draft.chargesAmount
        ..surfaceArea = draft.surfaceArea
        ..roomCount = draft.roomCount
        ..bathroomCount = draft.bathroomCount
        ..furnished = draft.furnished
        ..availableFrom = draft.availableFrom?.toDate()
        ..description = draft.description
        ..photoKeys = ListBuilder<String>(draft.photoKeys)),
    );

    final data = response.data;
    if (data == null) throw StateError('update returned no listing');
    return Annonce.fromResponse(data);
  }

  /// Applies a lifecycle transition and returns the updated listing.
  Future<Annonce> transition(String id, AnnonceTransition transition) async {
    final response = await switch (transition) {
      AnnonceTransition.publish => _api.publish(id: id),
      AnnonceTransition.reserve => _api.reserve(id: id),
      AnnonceTransition.markRented => _api.markRented(id: id),
      AnnonceTransition.archive => _api.archive(id: id),
    };

    final data = response.data;
    if (data == null) throw StateError('transition returned no listing');
    return Annonce.fromResponse(data);
  }

  /// RM-M10-07 — only permitted when no active Mboa contract references it;
  /// the backend enforces that, the UI adds the two-step confirmation.
  Future<void> delete(String id) => _api.delete1(id: id);
}
