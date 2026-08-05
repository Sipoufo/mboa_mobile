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

  /// Districts of [cityId].
  ///
  /// Listings are created against a **district**, not a city
  /// (`CreateAnnonceRequest.districtId`), so M10's location step needs this.
  Future<List<CityOption>> districts(String cityId) async {
    final response =
        await _dioClient.api.getLocationsApi().districts(cityId: cityId);
    final data = response.data;
    if (data == null) return const [];
    return [
      for (final d in data)
        if (d.id != null && d.name != null) CityOption(id: d.id!, name: d.name!),
    ];
  }

  /// Best-effort match of a geocoded place name to a catalogue city.
  ///
  /// Reverse geocoding returns a free-form locality ("Douala", "Douala 5e",
  /// "Douala V"), which will not equal our catalogue name. Matching is
  /// deliberately loose and **may return null** — the UI must always allow
  /// picking the city by hand.
  CityOption? matchCity(List<CityOption> cities, String? placeName) {
    final needle = _normalise(placeName);
    if (needle.isEmpty) return null;

    for (final city in cities) {
      final name = _normalise(city.name);
      if (name == needle) return city;
    }
    // Fall back to containment either way round, so "Douala 5e" still matches
    // "Douala" and vice versa.
    for (final city in cities) {
      final name = _normalise(city.name);
      if (name.isNotEmpty && (needle.contains(name) || name.contains(needle))) {
        return city;
      }
    }
    return null;
  }

  static String _normalise(String? value) {
    if (value == null) return '';
    const accents = 'àâäáãåçèéêëìíîïñòóôöõùúûüýÿ';
    const plain = 'aaaaaaceeeeiiiinooooouuuuyy';
    final lower = value.toLowerCase().trim();
    final buffer = StringBuffer();
    for (final rune in lower.runes) {
      final char = String.fromCharCode(rune);
      final index = accents.indexOf(char);
      buffer.write(index >= 0 ? plain[index] : char);
    }
    return buffer.toString();
  }
}
