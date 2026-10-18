import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/mocks/mocks.dart';

Response<UserSettingsResponse> _settings(List<NotificationSetting> notifications) => Response(
      requestOptions: RequestOptions(path: '/users/me/settings'),
      data: UserSettingsResponse((b) => b.notifications.replace(notifications)),
    );

NotificationSetting _n(NotificationSettingTypeEnum type, {bool enabled = true, bool mandatory = false}) =>
    NotificationSetting(
      (b) => b
        ..type = type
        ..enabled = enabled
        ..mandatory = mandatory,
    );

void main() {
  late MockDioClient dioClient;
  late MockApiClient apiClient;
  late MockUserSettingsApi settingsApi;
  late AppSettingsRepository repository;

  setUpAll(() => registerFallbackValue(UpdateUserSettingsRequest()));

  setUp(() {
    dioClient = MockDioClient();
    apiClient = MockApiClient();
    settingsApi = MockUserSettingsApi();
    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getUserSettingsApi).thenReturn(settingsApi);
    repository = AppSettingsRepository(dioClient: dioClient);
  });

  test('reads the catalogue, and leaves out a type newer than this client', () async {
    when(() => settingsApi.getMyUserSettings()).thenAnswer(
      (_) async => _settings([
        _n(NotificationSettingTypeEnum.N01, enabled: false),
        _n(NotificationSettingTypeEnum.N07, mandatory: true),
        _n(NotificationSettingTypeEnum.unknownDefaultOpenApi),
      ]),
    );

    expect(await repository.fetchNotifications(), const [
      NotificationPreference(code: 'N01', enabled: false),
      NotificationPreference(code: 'N07', enabled: true, mandatory: true),
    ]);
  });

  test('sends the opt-out set whole, and answers with what the server holds', () async {
    when(
      () => settingsApi.updateMyUserSettings(updateUserSettingsRequest: any(named: 'updateUserSettingsRequest')),
    ).thenAnswer((_) async => _settings([_n(NotificationSettingTypeEnum.N05, enabled: false)]));

    final saved = await repository.saveDisabledNotifications({'N05', 'N18'});

    final request = verify(
      () => settingsApi.updateMyUserSettings(
        updateUserSettingsRequest: captureAny(named: 'updateUserSettingsRequest'),
      ),
    ).captured.single as UpdateUserSettingsRequest;
    expect(
      request.disabledNotifications,
      BuiltSet<UpdateUserSettingsRequestDisabledNotificationsEnum>([
        UpdateUserSettingsRequestDisabledNotificationsEnum.N05,
        UpdateUserSettingsRequestDisabledNotificationsEnum.N18,
      ]),
    );
    // A partial update: nothing else is touched.
    expect(request.language, isNull);
    expect(saved, const [NotificationPreference(code: 'N05', enabled: false)]);
  });
}
