import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_user/features/auth/data/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

/// Shared mocktail doubles for App Mboa tests.
class MockAuthRepository extends Mock implements AuthRepository {}

class MockBaseProfileRepository extends Mock implements BaseProfileRepository {}

class MockSessionRepository extends Mock implements SessionRepository {}

class MockDioClient extends Mock implements DioClient {}

class MockApiClient extends Mock implements ApiClient {}

class MockAuthApi extends Mock implements AuthenticationApi {}

class MockSecureTokenStorage extends Mock implements SecureTokenStorage {}
