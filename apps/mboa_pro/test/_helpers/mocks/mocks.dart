import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_pro/features/auth/data/auth_repository.dart';
import 'package:mboa_pro/features/kyc/data/kyc_repository.dart';
import 'package:mboa_pro/features/login/data/credential_auth_repository.dart';
import 'package:mboa_pro/features/profile/data/profile_repository.dart';
import 'package:mboa_pro/features/register/data/register_repository.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

/// Shared mocktail doubles for App Mboa Pro tests.
class MockAuthRepository extends Mock implements AuthRepository {}

class MockProProfileRepository extends Mock implements ProProfileRepository {}

class MockKycRepository extends Mock implements KycRepository {}

class MockMediaUploader extends Mock implements MediaUploader {}

class MockSessionRepository extends Mock implements SessionRepository {}

class MockCredentialAuthRepository extends Mock implements CredentialAuthRepository {}

class MockRegisterRepository extends Mock implements RegisterRepository {}

class MockDioClient extends Mock implements DioClient {}

class MockApiClient extends Mock implements ApiClient {}

class MockAuthApi extends Mock implements AuthenticationApi {}

class MockSecureTokenStorage extends Mock implements SecureTokenStorage {}
