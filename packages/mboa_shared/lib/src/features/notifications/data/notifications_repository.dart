import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' show AppLifecycleListener;
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

  /// Whether the phone lets the app show notifications — sent at every
  /// registration (M03, RM-M03-02): when no device of an account shows them,
  /// the contract pushes N-07 / N-08 also go out by SMS.
  bool? _pushEnabled;

  /// Re-reads the permission when the app comes back: it may have been
  /// switched off (or on) in the phone's settings meanwhile.
  AppLifecycleListener? _lifecycle;

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
      _pushEnabled = _shows(await _messaging.requestPermission());

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

      _lifecycle ??= AppLifecycleListener(onResume: () => unawaited(syncPermission()));

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
        await _dioClient.api.getNotificationDevicesApi().unregisterDevice(token: token);
      } catch (error, stack) {
        // Best-effort, exactly like the logout revoke.
        _log('device unregister failed', error, stack);
      }
    }

    _lifecycle?.dispose();
    _lifecycle = null;
    _pushEnabled = null;
    await _tokenRefreshSub?.cancel();
    await _foregroundSub?.cancel();
    await _openedSub?.cancel();
    _tokenRefreshSub = null;
    _foregroundSub = null;
    _openedSub = null;
  }

  /// The permission read again; the same token re-registered when it changed
  /// (M03 — "whenever the permission changes").
  @visibleForTesting
  Future<void> syncPermission() async {
    final token = _registeredToken;
    if (token == null) return;
    try {
      final enabled = _shows(await _messaging.getNotificationSettings());
      if (enabled == _pushEnabled) return;
      _pushEnabled = enabled;
      await _register(token);
    } catch (error, stack) {
      _log('permission sync failed', error, stack);
    }
  }

  static bool _shows(NotificationSettings settings) =>
      settings.authorizationStatus == AuthorizationStatus.authorized ||
      settings.authorizationStatus == AuthorizationStatus.provisional;

  Future<void> _register(String token) async {
    try {
      await _dioClient.api.getNotificationDevicesApi().registerDevice(
            registerDeviceRequest: RegisterDeviceRequest((b) => b
              ..token = token
              ..platform = _platform
              ..pushEnabled = _pushEnabled),
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
