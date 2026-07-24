import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

/// Thin reactive wrapper over `connectivity_plus`, used by repositories to
/// decide between a live request and a cached (offline) response, and by the UI
/// to show the "Offline data" banner.
class NetworkMonitor {
  NetworkMonitor({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  Future<bool> get isOnline async {
    final result = await _connectivity.checkConnectivity();
    return _isOnline(result);
  }

  Stream<bool> get onStatusChange =>
      _connectivity.onConnectivityChanged.map(_isOnline);

  bool _isOnline(List<ConnectivityResult> results) =>
      results.any((r) => r != ConnectivityResult.none);
}
