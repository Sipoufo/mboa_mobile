import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

/// Where the reader stands, in WGS 84 degrees — held in memory for the
/// session's searches, never stored, never logged (RM-M04-08).
class UserPosition extends Equatable {
  const UserPosition(this.latitude, this.longitude);

  final double latitude;
  final double longitude;

  @override
  List<Object?> get props => [latitude, longitude];
}

/// Why there is no position — each said differently.
enum LocationRefusal {
  /// Location is off on the phone.
  serviceOff,

  /// The reader said no this time.
  denied,

  /// The reader said no for good: only the settings can change it.
  deniedForever,

  /// Allowed, but no fix came in time.
  unavailable,
}

class LocationUnavailable implements Exception {
  const LocationUnavailable(this.reason);

  final LocationRefusal reason;
}

/// The device's position, for « Proche de vous » — asked when the reader taps
/// it, never at launch, in the foreground only.
class LocationService {
  /// A street's precision is plenty for « à 2,3 km », and is quicker to get.
  static const _settings = LocationSettings(accuracy: LocationAccuracy.medium, timeLimit: Duration(seconds: 10));

  Future<UserPosition> current() async {
    if (!await Geolocator.isLocationServiceEnabled()) throw const LocationUnavailable(LocationRefusal.serviceOff);
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) permission = await Geolocator.requestPermission();
    switch (permission) {
      case LocationPermission.denied:
        throw const LocationUnavailable(LocationRefusal.denied);
      case LocationPermission.deniedForever:
        throw const LocationUnavailable(LocationRefusal.deniedForever);
      case LocationPermission.whileInUse || LocationPermission.always || LocationPermission.unableToDetermine:
        break;
    }
    try {
      final position = await Geolocator.getCurrentPosition(locationSettings: _settings);
      return UserPosition(position.latitude, position.longitude);
    } catch (_) {
      throw const LocationUnavailable(LocationRefusal.unavailable);
    }
  }

  /// Where the reader can change their mind: the app's settings, or the
  /// phone's location switch.
  Future<void> openSettings(LocationRefusal reason) async {
    if (reason == LocationRefusal.serviceOff) {
      await Geolocator.openLocationSettings();
    } else {
      await Geolocator.openAppSettings();
    }
  }
}
