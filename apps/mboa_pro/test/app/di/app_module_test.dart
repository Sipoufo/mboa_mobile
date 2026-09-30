import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_pro/app/di/app_module.dart';

/// **Registering the same type twice throws at startup, and only at startup.**
///
/// `get_it` refuses a second `registerLazySingleton`, and because every
/// registration is lazy the failure lands in `main()` — before any screen, so
/// no widget test sees it, and `flutter analyze` cannot: two calls in different
/// sections of the same file are both perfectly valid Dart.
///
/// It shipped in the tenant app (`LocationRepository` and `MediaUploader`,
/// registered by a feature and again by the profile module). This app's module
/// has grown through seven modules; the same test guards it.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(getIt.reset);

  test('the app module registers cleanly on top of the core module', () async {
    await registerCoreModule(onSessionExpired: () async {});

    expect(registerAppModule, returnsNormally);
  });

  test('every type the app reads is registered exactly once', () async {
    await registerCoreModule(onSessionExpired: () async {});
    registerAppModule();

    expect(registerAppModule, throwsA(isA<ArgumentError>()));
  });
}
