import 'package:mboa_core/mboa_core.dart';

import '../models/professional_role.dart';

/// The sole network layer for App Mboa Pro's professional registration.
///
/// Three backend steps:
///  1. [register] — create the account; the backend sends an OTP to the phone.
///  2. [resendOtp] — request a fresh OTP for the phone.
///  3. [verifyOtp] — verify the phone OTP and persist the issued tokens.
class RegisterRepository {
  RegisterRepository({
    required DioClient dioClient,
    required SecureTokenStorage tokenStorage,
  })  : _dioClient = dioClient,
        _tokenStorage = tokenStorage;

  final DioClient _dioClient;
  final SecureTokenStorage _tokenStorage;

  AuthenticationApi get _api => _dioClient.api.getAuthenticationApi();

  /// Step 1 — register the professional. The backend sends an OTP to [phone].
  Future<void> register({
    required ProfessionalRole role,
    required String email,
    required String password,
    required String phone,
  }) async {
    await _api.registerProfessional(
      registerProfessionalRequest: RegisterProfessionalRequest((b) => b
        ..role = role.apiValue
        ..email = email
        ..password = password
        ..phoneNumber = phone),
    );
  }

  /// Re-send the OTP for [phone] (dedicated resend endpoint).
  Future<void> resendOtp(String phone) async {
    await _api.resendOtp(
      sendOtpRequest: SendOtpRequest((b) => b..phoneNumber = phone),
    );
  }

  /// Step 2 — verify the phone [code] and persist the issued tokens.
  Future<void> verifyOtp({required String phone, required String code}) async {
    final response = await _api.verifyOtp(
      verifyOtpRequest: VerifyOtpRequest((b) => b
        ..phoneNumber = phone
        ..code = code),
    );
    final pair = response.data!;
    await _tokenStorage.save(
      AuthTokens(
        accessToken: pair.accessToken ?? '',
        refreshToken: pair.refreshToken ?? '',
        accessTokenExpiresAt: pair.accessTokenExpiresAt,
        refreshTokenExpiresAt: pair.refreshTokenExpiresAt,
      ),
    );
  }
}
