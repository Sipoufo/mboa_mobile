import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:mboa_core/mboa_core.dart';

import '../models/push_message.dart';

/// FCM device registration and message intake (CDC M03).
///
/// Shared by both apps: registration, permission and payload handling are
/// identical; only the routing of a tapped notification is app-specific, and
/// that is delegated to the [onOpened] callback.
///
/// **iOS returns no token until APNs is configured** (see
/// `docs/notifications-setup.md`). That is not an error — [start] simply
/// registers nothing, so the app behaves normally on iOS while Android works
/// end to end.
class NotificationsRepository {
  NotificationsRepository({
    required DioClient dioClient,
    FirebaseMessaging? messaging,
  })  : _dioClient = dioClient,
        _messaging = messaging ?? FirebaseMessaging.instance;

  final DioClient _dioClient;
  final FirebaseMessaging _messaging;

  StreamSubscription<String>? _tokenRefreshSub;
  StreamSubscription<RemoteMessage>? _foregroundSub;
  StreamSubscription<RemoteMessage>? _openedSub;

  /// The token currently registered with the API, so logout can revoke exactly
  /// what was registered.
  String? _registeredToken;

  /// Starts intake and registers this device. Call **after** authentication —
  /// the register endpoint is authenticated, and a token registered before
  /// login can't be attributed to a user.
  ///
  /// Idempotent: safe to call on every login and app resume.
  Future<void> start({
    void Function(PushMessage message)? onForeground,
    void Function(PushMessage message)? onOpened,
  }) async {
    try {
      await _messaging.requestPermission();

      final token = await _messaging.getToken();
      if (token != null && token.isNotEmpty) {
        await _register(token);
      }

      await _tokenRefreshSub?.cancel();
      _tokenRefreshSub = _messaging.onTokenRefresh.listen(_register);

      await _foregroundSub?.cancel();
      _foregroundSub = FirebaseMessaging.onMessage.listen((message) {
        onForeground?.call(_toPush(message));
      });

      await _openedSub?.cancel();
      _openedSub = FirebaseMessaging.onMessageOpenedApp.listen((message) {
        onOpened?.call(_toPush(message));
      });

      // The app may have been launched *by* a notification.
      final initial = await _messaging.getInitialMessage();
      if (initial != null) onOpened?.call(_toPush(initial));
    } catch (error, stack) {
      // Push is an enhancement — never let it break startup or login.
      _log('notifications start failed', error, stack);
    }
  }

  /// Revokes this device server-side and stops intake.
  ///
  /// **Must run before the auth tokens are cleared**, or the call 401s and the
  /// device keeps receiving pushes for a signed-out account.
  Future<void> stop() async {
    final token = _registeredToken;
    _registeredToken = null;

    if (token != null && token.isNotEmpty) {
      try {
        await _dioClient.api.getNotificationDevicesApi().unregister(token: token);
      } catch (error, stack) {
        // Best-effort, exactly like the logout revoke.
        _log('device unregister failed', error, stack);
      }
    }

    await _tokenRefreshSub?.cancel();
    await _foregroundSub?.cancel();
    await _openedSub?.cancel();
    _tokenRefreshSub = null;
    _foregroundSub = null;
    _openedSub = null;
  }

  Future<void> _register(String token) async {
    try {
      await _dioClient.api.getNotificationDevicesApi().register(
            registerDeviceRequest: RegisterDeviceRequest((b) => b
              ..token = token
              ..platform = _platform),
          );
      _registeredToken = token;
    } catch (error, stack) {
      _log('device register failed', error, stack);
    }
  }

  RegisterDeviceRequestPlatformEnum get _platform => Platform.isIOS
      ? RegisterDeviceRequestPlatformEnum.IOS
      : RegisterDeviceRequestPlatformEnum.ANDROID;

  PushMessage _toPush(RemoteMessage message) => PushMessage.fromData(
        message.data,
        title: message.notification?.title,
        body: message.notification?.body,
      );

  void _log(String what, Object error, StackTrace stack) {
    if (kDebugMode) debugPrint('[notifications] $what: $error');
  }
}
