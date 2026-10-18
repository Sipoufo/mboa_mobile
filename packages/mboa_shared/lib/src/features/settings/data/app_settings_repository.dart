import 'package:mboa_core/mboa_core.dart';

import '../models/notification_preference.dart';

/// App-level user settings (`/users/me/settings`): the language preference and
/// the notification opt-outs.
class AppSettingsRepository {
  AppSettingsRepository({required DioClient dioClient}) : _dioClient = dioClient;

  final DioClient _dioClient;

  Future<void> updateLanguage(String languageCode) async {
    final language = languageCode.toLowerCase() == 'en'
        ? UpdateUserSettingsRequestLanguageEnum.EN
        : UpdateUserSettingsRequestLanguageEnum.FR;
    await _dioClient.api.getUserSettingsApi().updateMyUserSettings(
          updateUserSettingsRequest: UpdateUserSettingsRequest((b) => b..language = language),
        );
  }

  /// The whole catalogue, each type with whether this account receives it.
  Future<List<NotificationPreference>> fetchNotifications() async {
    final response = await _dioClient.api.getUserSettingsApi().getMyUserSettings();
    return _preferences(response.data);
  }

  /// Saves [disabled] as the account's opt-out set.
  ///
  /// The set **replaces** the stored one (it is not a delta), so it must hold
  /// every opt-out the account wants kept — including types this screen does
  /// not show. Answers with the catalogue as the server now holds it.
  Future<List<NotificationPreference>> saveDisabledNotifications(Set<String> disabled) async {
    final response = await _dioClient.api.getUserSettingsApi().updateMyUserSettings(
          updateUserSettingsRequest: UpdateUserSettingsRequest(
            (b) => b.disabledNotifications.replace([
              for (final code in disabled) UpdateUserSettingsRequestDisabledNotificationsEnum.valueOf(code),
            ]),
          ),
        );
    return _preferences(response.data);
  }

  /// A type newer than this client reads as `unknownDefaultOpenApi`: it is
  /// left out, since it can be neither labelled nor written back.
  static List<NotificationPreference> _preferences(UserSettingsResponse? settings) => [
        for (final n in settings?.notifications ?? const <NotificationSetting>[])
          if (n.type case final type? when type != NotificationSettingTypeEnum.unknownDefaultOpenApi)
            NotificationPreference(
              code: type.name,
              enabled: n.enabled ?? true,
              mandatory: n.mandatory ?? false,
            ),
      ];
}
