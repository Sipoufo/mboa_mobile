import 'package:mboa_core/mboa_core.dart';

/// App-level user settings (`/users/me/settings`). Currently the language
/// preference; searchable/notifications can be added later.
class AppSettingsRepository {
  AppSettingsRepository({required DioClient dioClient}) : _dioClient = dioClient;

  final DioClient _dioClient;

  Future<void> updateLanguage(String languageCode) async {
    final language = languageCode.toLowerCase() == 'en'
        ? UpdateUserSettingsRequestLanguageEnum.EN
        : UpdateUserSettingsRequestLanguageEnum.FR;
    await _dioClient.api.getUserSettingsApi().updateMySettings(
          updateUserSettingsRequest: UpdateUserSettingsRequest((b) => b..language = language),
        );
  }
}
