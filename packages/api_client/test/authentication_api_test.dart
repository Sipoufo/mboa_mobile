import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AuthenticationApi
void main() {
  final instance = ApiClient().getAuthenticationApi();

  group(AuthenticationApi, () {
    // Credential login step 1: verify email + password, sends an OTP second factor
    //
    //Future login(LoginRequest loginRequest) async
    test('test login', () async {
      // TODO
    });

    // Revoke a refresh token (logout)
    //
    //Future logout(LogoutRequest logoutRequest) async
    test('test logout', () async {
      // TODO
    });

    // Exchange a refresh token for a new token pair
    //
    //Future<AuthTokens> refresh(RefreshTokenRequest refreshTokenRequest) async
    test('test refresh', () async {
      // TODO
    });

    // Register a professional (AGENT or PRESTATAIRE); sends an OTP to verify the phone
    //
    //Future registerProfessional(RegisterProfessionalRequest registerProfessionalRequest) async
    test('test registerProfessional', () async {
      // TODO
    });

    // Request an OTP for a phone number
    //
    //Future requestOtp(SendOtpRequest sendOtpRequest) async
    test('test requestOtp', () async {
      // TODO
    });

    // Log in with a Google or Apple ID token
    //
    //Future<AuthTokens> socialLogin(SocialLoginRequest socialLoginRequest) async
    test('test socialLogin', () async {
      // TODO
    });

    // Credential login step 2: verify the OTP and obtain access + refresh tokens
    //
    //Future<AuthTokens> verifyLoginOtp(LoginOtpRequest loginOtpRequest) async
    test('test verifyLoginOtp', () async {
      // TODO
    });

    // Verify an OTP and obtain access + refresh tokens
    //
    //Future<AuthTokens> verifyOtp(VerifyOtpRequest verifyOtpRequest) async
    test('test verifyOtp', () async {
      // TODO
    });

  });
}
