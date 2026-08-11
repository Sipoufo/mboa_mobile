import 'package:mboa_core/mboa_core.dart';

/// Account-level operations shared by both apps: deletion (and, later, phone /
/// password changes).
class AccountRepository {
  AccountRepository({required DioClient dioClient}) : _dioClient = dioClient;

  final DioClient _dioClient;

  /// Permanently deletes the account (RGPD anonymisation server-side).
  Future<void> deleteAccount() => _dioClient.api.getAccountApi().deleteMyAccount();

  /// Requests a phone-number change; the backend sends an OTP to both the old
  /// and the new number (RM-M02-02).
  Future<void> requestPhoneChange(String newPhoneNumber) {
    return _dioClient.api.getPhoneChangeApi().requestPhoneChange(
          requestPhoneChangeRequest:
              RequestPhoneChangeRequest((b) => b..newPhoneNumber = newPhoneNumber),
        );
  }

  /// Confirms the phone change with both codes (old number + new number).
  Future<void> confirmPhoneChange({
    required String newPhoneNumber,
    required String oldCode,
    required String newCode,
  }) async {
    await _dioClient.api.getPhoneChangeApi().confirmPhoneChange(
          confirmPhoneChangeRequest: ConfirmPhoneChangeRequest((b) => b
            ..newPhoneNumber = newPhoneNumber
            ..oldCode = oldCode
            ..newCode = newCode),
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
}
