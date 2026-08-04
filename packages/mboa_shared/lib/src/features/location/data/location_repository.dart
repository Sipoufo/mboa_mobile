import 'package:mboa_core/mboa_core.dart';

import '../models/city_option.dart';

/// Reads the locations catalogue (cities/regions/districts). Shared by both
/// apps for the city picker used in profile editing (CDC M02).
class LocationRepository {
  LocationRepository({required DioClient dioClient}) : _dioClient = dioClient;

  final DioClient _dioClient;

  /// All cities, or those in [regionId] when provided.
  Future<List<CityOption>> cities({String? regionId}) async {
    final response = await _dioClient.api.getLocationsApi().cities(regionId: regionId);
    final data = response.data;
    if (data == null) return const [];
    return [
      for (final c in data)
        if (c.id != null && c.name != null) CityOption(id: c.id!, name: c.name!),
    ];
  }
}
