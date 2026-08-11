//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_setting.g.dart';

/// NotificationSetting
///
/// Properties:
/// * [type] 
/// * [enabled] 
/// * [mandatory] 
@BuiltValue()
abstract class NotificationSetting implements Built<NotificationSetting, NotificationSettingBuilder> {
  @BuiltValueField(wireName: r'type')
  NotificationSettingTypeEnum? get type;
  // enum typeEnum {  N01,  N02,  N03,  N04,  N05,  N06,  N07,  N08,  N09,  N10,  N11,  N12,  N13,  N14,  N15,  N16,  N17,  };

  @BuiltValueField(wireName: r'enabled')
  bool? get enabled;

  @BuiltValueField(wireName: r'mandatory')
  bool? get mandatory;

  NotificationSetting._();

  factory NotificationSetting([void updates(NotificationSettingBuilder b)]) = _$NotificationSetting;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationSettingBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationSetting> get serializer => _$NotificationSettingSerializer();
}

class _$NotificationSettingSerializer implements PrimitiveSerializer<NotificationSetting> {
  @override
  final Iterable<Type> types = const [NotificationSetting, _$NotificationSetting];

  @override
  final String wireName = r'NotificationSetting';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationSetting object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(NotificationSettingTypeEnum),
      );
    }
    if (object.enabled != null) {
      yield r'enabled';
      yield serializers.serialize(
        object.enabled,
        specifiedType: const FullType(bool),
      );
    }
    if (object.mandatory != null) {
      yield r'mandatory';
      yield serializers.serialize(
        object.mandatory,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationSetting object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationSettingBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(NotificationSettingTypeEnum),
          ) as NotificationSettingTypeEnum?;
          if (valueDes == null) continue;
          result.type = valueDes;
          break;
        case r'enabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.enabled = valueDes;
          break;
        case r'mandatory':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.mandatory = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NotificationSetting deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationSettingBuilder();
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

class NotificationSettingTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'N01')
  static const NotificationSettingTypeEnum N01 = _$notificationSettingTypeEnum_N01;
  @BuiltValueEnumConst(wireName: r'N02')
  static const NotificationSettingTypeEnum N02 = _$notificationSettingTypeEnum_N02;
  @BuiltValueEnumConst(wireName: r'N03')
  static const NotificationSettingTypeEnum N03 = _$notificationSettingTypeEnum_N03;
  @BuiltValueEnumConst(wireName: r'N04')
  static const NotificationSettingTypeEnum N04 = _$notificationSettingTypeEnum_N04;
  @BuiltValueEnumConst(wireName: r'N05')
  static const NotificationSettingTypeEnum N05 = _$notificationSettingTypeEnum_N05;
  @BuiltValueEnumConst(wireName: r'N06')
  static const NotificationSettingTypeEnum N06 = _$notificationSettingTypeEnum_N06;
  @BuiltValueEnumConst(wireName: r'N07')
  static const NotificationSettingTypeEnum N07 = _$notificationSettingTypeEnum_N07;
  @BuiltValueEnumConst(wireName: r'N08')
  static const NotificationSettingTypeEnum N08 = _$notificationSettingTypeEnum_N08;
  @BuiltValueEnumConst(wireName: r'N09')
  static const NotificationSettingTypeEnum N09 = _$notificationSettingTypeEnum_N09;
  @BuiltValueEnumConst(wireName: r'N10')
  static const NotificationSettingTypeEnum N10 = _$notificationSettingTypeEnum_N10;
  @BuiltValueEnumConst(wireName: r'N11')
  static const NotificationSettingTypeEnum N11 = _$notificationSettingTypeEnum_N11;
  @BuiltValueEnumConst(wireName: r'N12')
  static const NotificationSettingTypeEnum N12 = _$notificationSettingTypeEnum_N12;
  @BuiltValueEnumConst(wireName: r'N13')
  static const NotificationSettingTypeEnum N13 = _$notificationSettingTypeEnum_N13;
  @BuiltValueEnumConst(wireName: r'N14')
  static const NotificationSettingTypeEnum N14 = _$notificationSettingTypeEnum_N14;
  @BuiltValueEnumConst(wireName: r'N15')
  static const NotificationSettingTypeEnum N15 = _$notificationSettingTypeEnum_N15;
  @BuiltValueEnumConst(wireName: r'N16')
  static const NotificationSettingTypeEnum N16 = _$notificationSettingTypeEnum_N16;
  @BuiltValueEnumConst(wireName: r'N17')
  static const NotificationSettingTypeEnum N17 = _$notificationSettingTypeEnum_N17;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const NotificationSettingTypeEnum unknownDefaultOpenApi = _$notificationSettingTypeEnum_unknownDefaultOpenApi;

  static Serializer<NotificationSettingTypeEnum> get serializer => _$notificationSettingTypeEnumSerializer;

  const NotificationSettingTypeEnum._(String name): super(name);

  static BuiltSet<NotificationSettingTypeEnum> get values => _$notificationSettingTypeEnumValues;
  static NotificationSettingTypeEnum valueOf(String name) => _$notificationSettingTypeEnumValueOf(name);
}

