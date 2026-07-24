import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

/// Shared mocktail doubles for the login feature tests.
class MockLoginRepository extends Mock implements LoginRepository {}

class MockDioClient extends Mock implements DioClient {}

class MockApiClient extends Mock implements ApiClient {}

class MockAuthApi extends Mock implements AuthenticationApi {}

class MockSecureTokenStorage extends Mock implements SecureTokenStorage {}
