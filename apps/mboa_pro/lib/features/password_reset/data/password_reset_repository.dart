import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// Why a reset was refused — the server's codes, read once here.
enum PasswordResetRefusal {
  /// `OTP_INVALID` — a wrong code; another try is allowed.
  wrongCode,

  /// `OTP_INVALID_OR_EXPIRED` — no valid code for this email: expired, never
  /// sent, or an email with no resettable account (the server answers the
  /// same, so the two cannot be told apart).
  expired,

  /// `OTP_MAX_ATTEMPTS` — the code is burnt; a new one is needed.
  tooManyAttempts,
}

class PasswordResetRefused implements Exception {
  const PasswordResetRefused(this.reason);

  final PasswordResetRefusal reason;
}

/// Forgotten password for App Mboa Pro (M02) — `POST /auth/password/forgot`,
/// then `/auth/password/reset`.
///
/// The code goes **by SMS to the account's phone**, not by email. The first
/// call always succeeds, whether or not the email has an account: the server
/// refuses to say which emails exist.
class PasswordResetRepository {
  PasswordResetRepository({required DioClient dioClient}) : _dioClient = dioClient;

  final DioClient _dioClient;

  AuthenticationApi get _api => _dioClient.api.getAuthenticationApi();

  Future<void> requestCode(String email) =>
      _api.forgotPassword(forgotPasswordRequest: ForgotPasswordRequest((b) => b..email = email.trim()));

  /// Sets the new password. On success every session is revoked server-side,
  /// so the prestataire signs in again.
  ///
  /// Throws [PasswordResetRefused] for a code the server turned down.
  Future<void> reset({required String email, required String code, required String newPassword}) async {
    try {
      await _api.resetPassword(
        resetPasswordRequest: ResetPasswordRequest(
          (b) => b
            ..email = email.trim()
            ..code = code
            ..newPassword = newPassword,
        ),
      );
    } catch (error) {
      final api = ApiError.from(error);
      if (api.hasCode('OTP_INVALID')) throw const PasswordResetRefused(PasswordResetRefusal.wrongCode);
      if (api.hasCode('OTP_INVALID_OR_EXPIRED')) throw const PasswordResetRefused(PasswordResetRefusal.expired);
      if (api.hasCode('OTP_MAX_ATTEMPTS')) throw const PasswordResetRefused(PasswordResetRefusal.tooManyAttempts);
      rethrow;
    }
  }
}
