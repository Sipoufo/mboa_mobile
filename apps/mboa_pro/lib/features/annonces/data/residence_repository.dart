import 'package:built_collection/built_collection.dart';
import 'package:mboa_core/mboa_core.dart';

import '../models/annonce_draft.dart';
import '../models/annonce_status.dart';
import '../models/residence.dart';

/// Multi-unit properties (“Bien Multiple”).
///
/// A separate resource from `AnnonceRepository`, not a variant of it: creation
/// takes *groups* of units that the backend expands, and the lifecycle
/// transitions act on every unit at once.
class ResidenceRepository {
  ResidenceRepository({required DioClient dioClient}) : _dioClient = dioClient;

  final DioClient _dioClient;

  static const int _pageSize = 100;

  ResidencesApi get _api => _dioClient.api.getResidencesApi();

  Future<List<Residence>> list() async {
    final response = await _api.listMyResidences(
      pageable: Pageable((b) => b
        ..page = 0
        ..size = _pageSize),
    );
    return (response.data?.content ?? const <ResidenceResponse>[])
        .map(Residence.fromResponse)
        .toList();
  }

  Future<Residence> getOne(String id) async {
    final response = await _api.getMyResidence(id: id);
    final data = response.data;
    if (data == null) throw StateError('Residence $id not found');
    return Residence.fromResponse(data);
  }

  Future<Residence> create(AnnonceDraft draft) async {
    final location = draft.location;
    final availableFrom = draft.availableFrom;
    if (location == null || availableFrom == null) {
      throw StateError('Draft is missing its location or availability date');
    }
    if (draft.units.isEmpty) {
      throw StateError('A residence needs at least one unit group');
    }

    final response = await _api.createResidence(
      createResidenceRequest: CreateResidenceRequest((b) => b
        ..name = draft.title.trim()
        ..districtId = location.districtId
        ..exactAddress = location.exactAddress ?? location.label
        ..latitude = location.latitude
        ..longitude = location.longitude
        ..availableFrom = availableFrom.toDate()
        ..description = draft.description
        ..photoKeys = ListBuilder<String>(draft.photoKeys)
        ..units = ListBuilder<UnitGroup>(draft.units.map(_toUnitGroup))),
    );

    final data = response.data;
    if (data == null) throw StateError('create returned no residence');
    return Residence.fromResponse(data);
  }

  /// Bulk lifecycle transition — these act on every unit in the residence.
  Future<Residence> transition(String id, AnnonceTransition transition) async {
    final response = await switch (transition) {
      AnnonceTransition.publish => _api.publishResidenceUnits(id: id),
      AnnonceTransition.reserve => _api.reserveResidenceUnits(id: id),
      AnnonceTransition.markRented => _api.rentResidenceUnits(id: id),
      AnnonceTransition.archive => _api.archiveResidenceUnits(id: id),
      // Not `publishResidenceUnits`: that rejects anything but DRAFT with a 409. Unarchive
      // (RM-M10-08) returns every unit to DRAFT, so publishing again re-checks
      // the quota and the photo rule.
      AnnonceTransition.unarchive => _api.unarchiveResidenceUnits(id: id),
    };

    final data = response.data;
    if (data == null) throw StateError('transition returned no residence');
    return Residence.fromResponse(data);
  }

  Future<void> delete(String id) => _api.deleteResidence(id: id);

  UnitGroup _toUnitGroup(UnitGroupDraft draft) => UnitGroup((b) => b
    ..propertyType = draft.propertyType.asUnitGroup
    ..count = draft.count
    ..namePrefix = draft.namePrefix.trim()
    ..price = draft.price ?? 0
    ..rentalPeriod = draft.rentalPeriod.asUnitGroup
    ..chargesIncluded = draft.chargesIncluded
    ..chargesAmount = draft.chargesAmount
    ..surfaceArea = draft.surfaceArea
    ..roomCount = draft.roomCount
    ..bathroomCount = draft.bathroomCount
    ..furnished = draft.furnished
    ..description = draft.description);
}
