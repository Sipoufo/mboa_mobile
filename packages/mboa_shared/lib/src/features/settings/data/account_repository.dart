import 'package:mboa_core/mboa_core.dart';

import '../../../api/otp_guard.dart';

/// Account-level operations shared by both apps: deletion (and, later, phone /
/// password changes).
class AccountRepository {
  AccountRepository({required DioClient dioClient}) : _dioClient = dioClient;

  final DioClient _dioClient;

  /// Permanently deletes the account (RGPD anonymisation server-side).
  Future<void> deleteAccount() => _dioClient.api.getAccountApi().deleteMyAccount();

  /// Requests a phone-number change; the backend checks [currentPhoneNumber]
  /// is the account's, then sends an OTP to both the old and the new number
  /// (RM-M02-02). §40 A — an account made by email has none: no current
  /// number, one code, on the new one.
  Future<void> requestPhoneChange({String? currentPhoneNumber, required String newPhoneNumber}) {
    return _dioClient.api.getPhoneChangeApi().requestPhoneChange(
          requestPhoneChangeRequest: RequestPhoneChangeRequest((b) => b
            ..currentPhoneNumber = currentPhoneNumber
            ..newPhoneNumber = newPhoneNumber),
        );
  }

  /// Confirms the phone change with both codes (old number + new number).
  /// Throws [OtpCodeBurnt] once the codes can no longer be accepted.
  Future<void> confirmPhoneChange({
    required String newPhoneNumber,
    String? oldCode,
    required String newCode,
  }) async {
    await guardOtp(
      () => _dioClient.api.getPhoneChangeApi().confirmPhoneChange(
            confirmPhoneChangeRequest: ConfirmPhoneChangeRequest((b) => b
              ..newPhoneNumber = newPhoneNumber
              ..oldCode = oldCode
              ..newCode = newCode),
          ),
    );
  }

  /// Changes the account password (Pro/admin — email accounts only).
  Future<void> changePassword({required String currentPassword, required String newPassword}) {
    return _dioClient.api.getPasswordApi().changePassword(
          changePasswordRequest: ChangePasswordRequest((b) => b
            ..currentPassword = currentPassword
            ..newPassword = newPassword),
        );
  }

  /// §40 A — a code to [newEmail], and one to the phone when the account has
  /// one.
  Future<void> requestEmailChange(String newEmail) =>
      _dioClient.api.getEmailChangeApi().requestEmailChange(
            requestEmailChangeRequest: RequestEmailChangeRequest((b) => b..newEmail = newEmail),
          );

  /// §40 A — both codes (the phone's only when the account has one); the
  /// address now verified. Throws [OtpCodeBurnt] once the codes are dead.
  Future<String?> confirmEmailChange({required String newEmail, String? oldCode, required String newCode}) async {
    final response = await guardOtp(
      () => _dioClient.api.getEmailChangeApi().confirmEmailChange(
            confirmEmailChangeRequest: ConfirmEmailChangeRequest((b) => b
              ..newEmail = newEmail
              ..oldCode = oldCode
              ..newCode = newCode),
          ),
    );
    return response.data?.email;
  }
}
