import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

/// Why a GPS fix could not be taken.
enum LocationFailure { denied, deniedForever, disabled, unavailable }

class LocationCaptureException implements Exception {
  const LocationCaptureException(this.failure);

  final LocationFailure failure;
}

/// A GPS fix, with the locality name when reverse geocoding could supply one.
typedef LocationFix = ({double latitude, double longitude, String? cityName});

/// Captures the device position for the listing location step, and names the
/// city so the district list can be narrowed automatically.
///
/// Listings are created against a **district** (`CreateAnnonceRequest.districtId`),
/// which is why the flow is: fix → city → that city's districts → pick.
///
/// **Caveat:** this is where the *prestataire* is standing, not necessarily
/// where the property is. Fine on site, wrong from home — the form therefore
/// lets them change both the city and the address. A MapLibre picker (Doc 13)
/// is the real fix, and it replaces only this class.
class LocationCapture {
  const LocationCapture();

  Future<LocationFix> current() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw const LocationCaptureException(LocationFailure.disabled);
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw const LocationCaptureException(LocationFailure.deniedForever);
    }
    if (permission == LocationPermission.denied) {
      throw const LocationCaptureException(LocationFailure.denied);
    }

    final Position position;
    try {
      position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 15),
        ),
      );
    } catch (_) {
      throw const LocationCaptureException(LocationFailure.unavailable);
    }

    return (
      latitude: position.latitude,
      longitude: position.longitude,
      cityName: await _cityName(position),
    );
  }

  /// Reverse geocodes to a locality. Best-effort: the platform geocoder needs a
  /// network and may return nothing, so a null here must never block the flow —
  /// the user picks the city by hand instead.
  Future<String?> _cityName(Position position) async {
    try {
      final places = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      for (final place in places) {
        final name = place.locality?.trim();
        if (name != null && name.isNotEmpty) return name;
        final area = place.subAdministrativeArea?.trim();
        if (area != null && area.isNotEmpty) return area;
      }
    } catch (_) {
      // Geocoding is a convenience, not a requirement.
    }
    return null;
  }
}
