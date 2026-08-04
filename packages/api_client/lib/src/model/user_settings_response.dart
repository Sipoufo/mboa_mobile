//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/notification_setting.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_settings_response.g.dart';

/// UserSettingsResponse
///
/// Properties:
/// * [language] 
/// * [searchable] 
/// * [notifications] 
@BuiltValue()
abstract class UserSettingsResponse implements Built<UserSettingsResponse, UserSettingsResponseBuilder> {
  @BuiltValueField(wireName: r'language')
  UserSettingsResponseLanguageEnum? get language;
  // enum languageEnum {  FR,  EN,  };

  @BuiltValueField(wireName: r'searchable')
  bool? get searchable;

  @BuiltValueField(wireName: r'notifications')
  BuiltList<NotificationSetting>? get notifications;

  UserSettingsResponse._();

  factory UserSettingsResponse([void updates(UserSettingsResponseBuilder b)]) = _$UserSettingsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserSettingsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserSettingsResponse> get serializer => _$UserSettingsResponseSerializer();
}

class _$UserSettingsResponseSerializer implements PrimitiveSerializer<UserSettingsResponse> {
  @override
  final Iterable<Type> types = const [UserSettingsResponse, _$UserSettingsResponse];

  @override
  final String wireName = r'UserSettingsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserSettingsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.language != null) {
      yield r'language';
      yield serializers.serialize(
        object.language,
        specifiedType: const FullType(UserSettingsResponseLanguageEnum),
      );
    }
    if (object.searchable != null) {
      yield r'searchable';
      yield serializers.serialize(
        object.searchable,
        specifiedType: const FullType(bool),
      );
    }
    if (object.notifications != null) {
      yield r'notifications';
      yield serializers.serialize(
        object.notifications,
        specifiedType: const FullType(BuiltList, [FullType(NotificationSetting)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UserSettingsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UserSettingsResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'language':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(UserSettingsResponseLanguageEnum),
          ) as UserSettingsResponseLanguageEnum?;
          if (valueDes == null) continue;
          result.language = valueDes;
          break;
        case r'searchable':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.searchable = valueDes;
          break;
        case r'notifications':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(NotificationSetting)]),
          ) as BuiltList<NotificationSetting>?;
          if (valueDes == null) continue;
          result.notifications.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UserSettingsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserSettingsResponseBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class UserSettingsResponseLanguageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'FR')
  static const UserSettingsResponseLanguageEnum FR = _$userSettingsResponseLanguageEnum_FR;
  @BuiltValueEnumConst(wireName: r'EN')
  static const UserSettingsResponseLanguageEnum EN = _$userSettingsResponseLanguageEnum_EN;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const UserSettingsResponseLanguageEnum unknownDefaultOpenApi = _$userSettingsResponseLanguageEnum_unknownDefaultOpenApi;

  static Serializer<UserSettingsResponseLanguageEnum> get serializer => _$userSettingsResponseLanguageEnumSerializer;

  const UserSettingsResponseLanguageEnum._(String name): super(name);

  static BuiltSet<UserSettingsResponseLanguageEnum> get values => _$userSettingsResponseLanguageEnumValues;
  static UserSettingsResponseLanguageEnum valueOf(String name) => _$userSettingsResponseLanguageEnumValueOf(name);
}

