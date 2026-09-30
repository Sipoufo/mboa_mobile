import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_user/app/di/app_module.dart';

/// **Registering the same type twice throws at startup, and only at startup.**
///
/// `get_it` refuses a second `registerLazySingleton` for a type, and because
/// every registration is lazy the failure lands in `main()` — before any
/// screen, so no widget test sees it, and `flutter analyze` cannot: two calls
/// in different sections of the same file are both perfectly valid Dart.
///
/// It shipped: `LocationRepository` and `MediaUploader` were each registered
/// by a feature and again by the profile module, and the tenant app would not
/// boot. This walks the real module the way `main()` does.
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

    // A second pass is what a hot restart does, and what a duplicate looks
    // like from the inside.
    expect(registerAppModule, throwsA(isA<ArgumentError>()));
  });
}
