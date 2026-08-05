import 'package:built_collection/built_collection.dart';
import 'package:mboa_core/mboa_core.dart';

import '../models/annonce.dart';
import '../models/annonce_draft.dart';
import '../models/annonce_status.dart';

/// Listings CRUD and lifecycle (CDC M10).
class AnnonceRepository {
  AnnonceRepository({required DioClient dioClient}) : _dioClient = dioClient;

  final DioClient _dioClient;

  ResidencesApi get _residencesApi => _dioClient.api.getResidencesApi();

  /// One page big enough for any realistic portfolio — the API paginates but
  /// the Pro screens present a single list. Revisit if portfolios grow.
  static const int _pageSize = 100;

  AnnoncesApi get _api => _dioClient.api.getAnnoncesApi();

  /// Standalone listings only — residence units are excluded.
  ///
  /// `GET /annonces` returns **every** listing the prestataire owns, including
  /// the units a residence expanded into, and `AnnonceResponse` carries no
  /// residence link to filter on. So the unit ids are collected from the
  /// residences side and subtracted here.
  ///
  /// If that lookup fails, the full list is returned unfiltered — showing a few
  /// extra rows beats showing none.
  Future<List<Annonce>> list() async {
    final response = await _api.listMine2(
      pageable: Pageable((b) => b
        ..page = 0
        ..size = _pageSize),
    );
    final all = (response.data?.content ?? const <AnnonceResponse>[])
        .map(Annonce.fromResponse)
        .toList();

    final unitIds = await _residenceUnitIds();
    if (unitIds.isEmpty) return all;
    return all.where((a) => !unitIds.contains(a.id)).toList();
  }

  /// Ids of every unit belonging to a residence.
  ///
  /// The residences *list* payload carries the unit counts but not reliably the
  /// `units` array, so any residence that reports units without listing them is
  /// fetched individually. That is N+1 in the worst case — bounded by the
  /// residence count, not the listing count — and goes away the moment the
  /// backend puts a `residenceId` on `AnnonceResponse`.
  Future<Set<String>> _residenceUnitIds() async {
    try {
      final response = await _residencesApi.listMine(
        pageable: Pageable((b) => b
          ..page = 0
          ..size = _pageSize),
      );
      final residences =
          response.data?.content ?? const <ResidenceResponse>[];

      final ids = <String>{};
      final needDetail = <String>[];

      for (final residence in residences) {
        final units = residence.units ?? const <UnitSummary>[];
        if (units.isEmpty && (residence.unitCount ?? 0) > 0) {
          if (residence.id != null) needDetail.add(residence.id!);
          continue;
        }
        for (final unit in units) {
          if (unit.id != null) ids.add(unit.id!);
        }
      }

      if (needDetail.isNotEmpty) {
        final details = await Future.wait(
          needDetail.map(
            (id) => _residencesApi
                .getOne(id: id)
                .then<ResidenceResponse?>((r) => r.data)
                .catchError((_) => null),
          ),
        );
        for (final residence in details) {
          for (final unit in residence?.units ?? const <UnitSummary>[]) {
            if (unit.id != null) ids.add(unit.id!);
          }
        }
      }

      return ids;
    } catch (_) {
      return const {};
    }
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
