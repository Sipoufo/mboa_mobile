import 'package:equatable/equatable.dart';

/// A JWT access/refresh pair. This is the domain model — the raw wire type
/// lives in the generated `api_client` (`TokenPair`) and is mapped here.
///
/// Tokens are only ever persisted through [SecureTokenStorage]; never store an
/// instance of this in Hive, SharedPreferences, or a global.
class AuthTokens extends Equatable {
  const AuthTokens({
    required this.accessToken,
    required this.refreshToken,
    this.accessTokenExpiresAt,
    this.refreshTokenExpiresAt,
  });

  final String accessToken;
  final String refreshToken;
  final DateTime? accessTokenExpiresAt;
  final DateTime? refreshTokenExpiresAt;

  bool get isValid => accessToken.isNotEmpty && refreshToken.isNotEmpty;

  @override
  List<Object?> get props => [accessToken, refreshToken, accessTokenExpiresAt, refreshTokenExpiresAt];
}
