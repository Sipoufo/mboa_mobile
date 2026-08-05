import 'package:geolocator/geolocator.dart';

/// Why a GPS fix could not be taken.
enum LocationFailure { denied, deniedForever, disabled, unavailable }

class LocationCaptureException implements Exception {
  const LocationCaptureException(this.failure);

  final LocationFailure failure;
}

/// Captures the device's coordinates for the listing location step.
///
/// `latitude`/`longitude` are required by the create endpoints, but the design
/// shows a single "Localisation" field — so we take a GPS fix and pair it with
/// a district the prestataire picks.
///
/// **Caveat:** this is where the *prestataire* is standing, not necessarily
/// where the property is. Fine on site, wrong from home — which is why the form
/// lets them adjust the address text, and why a MapLibre picker (Doc 13) is the
/// real fix. Kept behind this class so that swap touches nothing else.
class LocationCapture {
  const LocationCapture();

  Future<({double latitude, double longitude})> current() async {
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

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 15),
        ),
      );
      return (latitude: position.latitude, longitude: position.longitude);
    } catch (_) {
      throw const LocationCaptureException(LocationFailure.unavailable);
    }
  }
}
