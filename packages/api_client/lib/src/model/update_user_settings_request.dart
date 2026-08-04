//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_user_settings_request.g.dart';

/// UpdateUserSettingsRequest
///
/// Properties:
/// * [language] 
/// * [searchable] 
/// * [disabledNotifications] 
@BuiltValue()
abstract class UpdateUserSettingsRequest implements Built<UpdateUserSettingsRequest, UpdateUserSettingsRequestBuilder> {
  @BuiltValueField(wireName: r'language')
  UpdateUserSettingsRequestLanguageEnum? get language;
  // enum languageEnum {  FR,  EN,  };

  @BuiltValueField(wireName: r'searchable')
  bool? get searchable;

  @BuiltValueField(wireName: r'disabledNotifications')
  BuiltSet<UpdateUserSettingsRequestDisabledNotificationsEnum>? get disabledNotifications;
  // enum disabledNotificationsEnum {  N01,  N02,  N03,  N04,  N05,  N06,  N07,  N08,  N09,  N10,  N11,  N12,  N13,  };

  UpdateUserSettingsRequest._();

  factory UpdateUserSettingsRequest([void updates(UpdateUserSettingsRequestBuilder b)]) = _$UpdateUserSettingsRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateUserSettingsRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateUserSettingsRequest> get serializer => _$UpdateUserSettingsRequestSerializer();
}

class _$UpdateUserSettingsRequestSerializer implements PrimitiveSerializer<UpdateUserSettingsRequest> {
  @override
  final Iterable<Type> types = const [UpdateUserSettingsRequest, _$UpdateUserSettingsRequest];

  @override
  final String wireName = r'UpdateUserSettingsRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateUserSettingsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.language != null) {
      yield r'language';
      yield serializers.serialize(
        object.language,
        specifiedType: const FullType(UpdateUserSettingsRequestLanguageEnum),
      );
    }
    if (object.searchable != null) {
      yield r'searchable';
      yield serializers.serialize(
        object.searchable,
        specifiedType: const FullType(bool),
      );
    }
    if (object.disabledNotifications != null) {
      yield r'disabledNotifications';
      yield serializers.serialize(
        object.disabledNotifications,
        specifiedType: const FullType(BuiltSet, [FullType(UpdateUserSettingsRequestDisabledNotificationsEnum)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateUserSettingsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateUserSettingsRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'language':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(UpdateUserSettingsRequestLanguageEnum),
          ) as UpdateUserSettingsRequestLanguageEnum?;
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
        case r'disabledNotifications':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltSet, [FullType(UpdateUserSettingsRequestDisabledNotificationsEnum)]),
          ) as BuiltSet<UpdateUserSettingsRequestDisabledNotificationsEnum>?;
          if (valueDes == null) continue;
          result.disabledNotifications.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateUserSettingsRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateUserSettingsRequestBuilder();
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

class UpdateUserSettingsRequestLanguageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'FR')
  static const UpdateUserSettingsRequestLanguageEnum FR = _$updateUserSettingsRequestLanguageEnum_FR;
  @BuiltValueEnumConst(wireName: r'EN')
  static const UpdateUserSettingsRequestLanguageEnum EN = _$updateUserSettingsRequestLanguageEnum_EN;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const UpdateUserSettingsRequestLanguageEnum unknownDefaultOpenApi = _$updateUserSettingsRequestLanguageEnum_unknownDefaultOpenApi;

  static Serializer<UpdateUserSettingsRequestLanguageEnum> get serializer => _$updateUserSettingsRequestLanguageEnumSerializer;

  const UpdateUserSettingsRequestLanguageEnum._(String name): super(name);

  static BuiltSet<UpdateUserSettingsRequestLanguageEnum> get values => _$updateUserSettingsRequestLanguageEnumValues;
  static UpdateUserSettingsRequestLanguageEnum valueOf(String name) => _$updateUserSettingsRequestLanguageEnumValueOf(name);
}

class UpdateUserSettingsRequestDisabledNotificationsEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'N01')
  static const UpdateUserSettingsRequestDisabledNotificationsEnum N01 = _$updateUserSettingsRequestDisabledNotificationsEnum_N01;
  @BuiltValueEnumConst(wireName: r'N02')
  static const UpdateUserSettingsRequestDisabledNotificationsEnum N02 = _$updateUserSettingsRequestDisabledNotificationsEnum_N02;
  @BuiltValueEnumConst(wireName: r'N03')
  static const UpdateUserSettingsRequestDisabledNotificationsEnum N03 = _$updateUserSettingsRequestDisabledNotificationsEnum_N03;
  @BuiltValueEnumConst(wireName: r'N04')
  static const UpdateUserSettingsRequestDisabledNotificationsEnum N04 = _$updateUserSettingsRequestDisabledNotificationsEnum_N04;
  @BuiltValueEnumConst(wireName: r'N05')
  static const UpdateUserSettingsRequestDisabledNotificationsEnum N05 = _$updateUserSettingsRequestDisabledNotificationsEnum_N05;
  @BuiltValueEnumConst(wireName: r'N06')
  static const UpdateUserSettingsRequestDisabledNotificationsEnum N06 = _$updateUserSettingsRequestDisabledNotificationsEnum_N06;
  @BuiltValueEnumConst(wireName: r'N07')
  static const UpdateUserSettingsRequestDisabledNotificationsEnum N07 = _$updateUserSettingsRequestDisabledNotificationsEnum_N07;
  @BuiltValueEnumConst(wireName: r'N08')
  static const UpdateUserSettingsRequestDisabledNotificationsEnum N08 = _$updateUserSettingsRequestDisabledNotificationsEnum_N08;
  @BuiltValueEnumConst(wireName: r'N09')
  static const UpdateUserSettingsRequestDisabledNotificationsEnum N09 = _$updateUserSettingsRequestDisabledNotificationsEnum_N09;
  @BuiltValueEnumConst(wireName: r'N10')
  static const UpdateUserSettingsRequestDisabledNotificationsEnum N10 = _$updateUserSettingsRequestDisabledNotificationsEnum_N10;
  @BuiltValueEnumConst(wireName: r'N11')
  static const UpdateUserSettingsRequestDisabledNotificationsEnum N11 = _$updateUserSettingsRequestDisabledNotificationsEnum_N11;
  @BuiltValueEnumConst(wireName: r'N12')
  static const UpdateUserSettingsRequestDisabledNotificationsEnum N12 = _$updateUserSettingsRequestDisabledNotificationsEnum_N12;
  @BuiltValueEnumConst(wireName: r'N13')
  static const UpdateUserSettingsRequestDisabledNotificationsEnum N13 = _$updateUserSettingsRequestDisabledNotificationsEnum_N13;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const UpdateUserSettingsRequestDisabledNotificationsEnum unknownDefaultOpenApi = _$updateUserSettingsRequestDisabledNotificationsEnum_unknownDefaultOpenApi;

  static Serializer<UpdateUserSettingsRequestDisabledNotificationsEnum> get serializer => _$updateUserSettingsRequestDisabledNotificationsEnumSerializer;

  const UpdateUserSettingsRequestDisabledNotificationsEnum._(String name): super(name);

  static BuiltSet<UpdateUserSettingsRequestDisabledNotificationsEnum> get values => _$updateUserSettingsRequestDisabledNotificationsEnumValues;
  static UpdateUserSettingsRequestDisabledNotificationsEnum valueOf(String name) => _$updateUserSettingsRequestDisabledNotificationsEnumValueOf(name);
}

