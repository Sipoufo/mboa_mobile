import 'package:mboa_pro/features/auth/data/auth_repository.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

/// Shared mocktail doubles for App Mboa Pro tests.
class MockAuthRepository extends Mock implements AuthRepository {}

class MockSessionRepository extends Mock implements SessionRepository {}
