import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for AuthenticationApi
void main() {
  final instance = ApiClient().getAuthenticationApi();

  group(AuthenticationApi, () {
    // Start a password reset; sends an OTP if the email has a password account
    //
    //Future forgotPassword(ForgotPasswordRequest forgotPasswordRequest) async
    test('test forgotPassword', () async {
      // TODO
    });

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
    //Future<AuthTokens> refreshToken(RefreshTokenRequest refreshTokenRequest) async
    test('test refreshToken', () async {
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

    // Resend the OTP to a phone that has a pending verification
    //
    //Future resendOtp(SendOtpRequest sendOtpRequest) async
    test('test resendOtp', () async {
      // TODO
    });

    // Complete a password reset with the OTP received on the phone
    //
    //Future resetPassword(ResetPasswordRequest resetPasswordRequest) async
    test('test resetPassword', () async {
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
