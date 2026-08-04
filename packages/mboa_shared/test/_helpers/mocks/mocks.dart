import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

/// Shared mocktail doubles for the login feature tests.
class MockLoginRepository extends Mock implements LoginRepository {}

class MockDioClient extends Mock implements DioClient {}

class MockApiClient extends Mock implements ApiClient {}

class MockAuthApi extends Mock implements AuthenticationApi {}

class MockCurrentUserApi extends Mock implements CurrentUserApi {}

class MockLocationsApi extends Mock implements LocationsApi {}

class MockAccountRepository extends Mock implements AccountRepository {}

class MockSecureTokenStorage extends Mock implements SecureTokenStorage {}

class MockNetworkMonitor extends Mock implements NetworkMonitor {}

class MockSessionRepository extends Mock implements SessionRepository {}
