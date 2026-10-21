//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_home_request.g.dart';

/// CreateHomeRequest
///
/// Properties:
/// * [type] 
/// * [title] 
/// * [description] 
/// * [photoKeys] 
@BuiltValue()
abstract class CreateHomeRequest implements Built<CreateHomeRequest, CreateHomeRequestBuilder> {
  @BuiltValueField(wireName: r'type')
  CreateHomeRequestTypeEnum get type;
  // enum typeEnum {  REMARK,  MAINTENANCE,  QUESTION,  };

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'description')
  String get description;

  @BuiltValueField(wireName: r'photoKeys')
  BuiltList<String>? get photoKeys;

  CreateHomeRequest._();

  factory CreateHomeRequest([void updates(CreateHomeRequestBuilder b)]) = _$CreateHomeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateHomeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateHomeRequest> get serializer => _$CreateHomeRequestSerializer();
}

class _$CreateHomeRequestSerializer implements PrimitiveSerializer<CreateHomeRequest> {
  @override
  final Iterable<Type> types = const [CreateHomeRequest, _$CreateHomeRequest];

  @override
  final String wireName = r'CreateHomeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateHomeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(CreateHomeRequestTypeEnum),
    );
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'description';
    yield serializers.serialize(
      object.description,
      specifiedType: const FullType(String),
    );
    if (object.photoKeys != null) {
      yield r'photoKeys';
      yield serializers.serialize(
        object.photoKeys,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateHomeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateHomeRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateHomeRequestTypeEnum),
          ) as CreateHomeRequestTypeEnum;
          result.type = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'photoKeys':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.photoKeys.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateHomeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateHomeRequestBuilder();
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

class CreateHomeRequestTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'REMARK')
  static const CreateHomeRequestTypeEnum REMARK = _$createHomeRequestTypeEnum_REMARK;
  @BuiltValueEnumConst(wireName: r'MAINTENANCE')
  static const CreateHomeRequestTypeEnum MAINTENANCE = _$createHomeRequestTypeEnum_MAINTENANCE;
  @BuiltValueEnumConst(wireName: r'QUESTION')
  static const CreateHomeRequestTypeEnum QUESTION = _$createHomeRequestTypeEnum_QUESTION;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CreateHomeRequestTypeEnum unknownDefaultOpenApi = _$createHomeRequestTypeEnum_unknownDefaultOpenApi;

  static Serializer<CreateHomeRequestTypeEnum> get serializer => _$createHomeRequestTypeEnumSerializer;

  const CreateHomeRequestTypeEnum._(String name): super(name);

  static BuiltSet<CreateHomeRequestTypeEnum> get values => _$createHomeRequestTypeEnumValues;
  static CreateHomeRequestTypeEnum valueOf(String name) => _$createHomeRequestTypeEnumValueOf(name);
}

