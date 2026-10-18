import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_user/features/auth/data/auth_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mboa_user/features/saved_searches/data/saved_searches_repository.dart';

/// Shared mocktail doubles for App Mboa tests.
class MockAuthRepository extends Mock implements AuthRepository {}

class MockBaseProfileRepository extends Mock implements BaseProfileRepository {}

class MockSessionRepository extends Mock implements SessionRepository {}

class MockDioClient extends Mock implements DioClient {}

class MockApiClient extends Mock implements ApiClient {}

class MockHiveCache extends Mock implements HiveCache {}

class MockAuthApi extends Mock implements AuthenticationApi {}

class MockSecureTokenStorage extends Mock implements SecureTokenStorage {}

class MockSavedSearchesRepository extends Mock implements SavedSearchesRepository {}
