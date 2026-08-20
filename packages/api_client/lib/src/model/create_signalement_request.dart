//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_signalement_request.g.dart';

/// CreateSignalementRequest
///
/// Properties:
/// * [targetType] 
/// * [targetId] 
/// * [reason] 
/// * [comment] 
@BuiltValue()
abstract class CreateSignalementRequest implements Built<CreateSignalementRequest, CreateSignalementRequestBuilder> {
  @BuiltValueField(wireName: r'targetType')
  CreateSignalementRequestTargetTypeEnum get targetType;
  // enum targetTypeEnum {  ANNONCE,  MESSAGE,  REVIEW,  };

  @BuiltValueField(wireName: r'targetId')
  String get targetId;

  @BuiltValueField(wireName: r'reason')
  CreateSignalementRequestReasonEnum get reason;
  // enum reasonEnum {  FRAUDULENT_LISTING,  ABNORMAL_PRICE,  INAPPROPRIATE_CONTENT,  HARASSMENT,  };

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  CreateSignalementRequest._();

  factory CreateSignalementRequest([void updates(CreateSignalementRequestBuilder b)]) = _$CreateSignalementRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateSignalementRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateSignalementRequest> get serializer => _$CreateSignalementRequestSerializer();
}

class _$CreateSignalementRequestSerializer implements PrimitiveSerializer<CreateSignalementRequest> {
  @override
  final Iterable<Type> types = const [CreateSignalementRequest, _$CreateSignalementRequest];

  @override
  final String wireName = r'CreateSignalementRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateSignalementRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'targetType';
    yield serializers.serialize(
      object.targetType,
      specifiedType: const FullType(CreateSignalementRequestTargetTypeEnum),
    );
    yield r'targetId';
    yield serializers.serialize(
      object.targetId,
      specifiedType: const FullType(String),
    );
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(CreateSignalementRequestReasonEnum),
    );
    if (object.comment != null) {
      yield r'comment';
      yield serializers.serialize(
        object.comment,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateSignalementRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateSignalementRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'targetType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateSignalementRequestTargetTypeEnum),
          ) as CreateSignalementRequestTargetTypeEnum;
          result.targetType = valueDes;
          break;
        case r'targetId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.targetId = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateSignalementRequestReasonEnum),
          ) as CreateSignalementRequestReasonEnum;
          result.reason = valueDes;
          break;
        case r'comment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.comment = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateSignalementRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateSignalementRequestBuilder();
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

class CreateSignalementRequestTargetTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ANNONCE')
  static const CreateSignalementRequestTargetTypeEnum ANNONCE = _$createSignalementRequestTargetTypeEnum_ANNONCE;
  @BuiltValueEnumConst(wireName: r'MESSAGE')
  static const CreateSignalementRequestTargetTypeEnum MESSAGE = _$createSignalementRequestTargetTypeEnum_MESSAGE;
  @BuiltValueEnumConst(wireName: r'REVIEW')
  static const CreateSignalementRequestTargetTypeEnum REVIEW = _$createSignalementRequestTargetTypeEnum_REVIEW;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CreateSignalementRequestTargetTypeEnum unknownDefaultOpenApi = _$createSignalementRequestTargetTypeEnum_unknownDefaultOpenApi;

  static Serializer<CreateSignalementRequestTargetTypeEnum> get serializer => _$createSignalementRequestTargetTypeEnumSerializer;

  const CreateSignalementRequestTargetTypeEnum._(String name): super(name);

  static BuiltSet<CreateSignalementRequestTargetTypeEnum> get values => _$createSignalementRequestTargetTypeEnumValues;
  static CreateSignalementRequestTargetTypeEnum valueOf(String name) => _$createSignalementRequestTargetTypeEnumValueOf(name);
}

class CreateSignalementRequestReasonEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'FRAUDULENT_LISTING')
  static const CreateSignalementRequestReasonEnum FRAUDULENT_LISTING = _$createSignalementRequestReasonEnum_FRAUDULENT_LISTING;
  @BuiltValueEnumConst(wireName: r'ABNORMAL_PRICE')
  static const CreateSignalementRequestReasonEnum ABNORMAL_PRICE = _$createSignalementRequestReasonEnum_ABNORMAL_PRICE;
  @BuiltValueEnumConst(wireName: r'INAPPROPRIATE_CONTENT')
  static const CreateSignalementRequestReasonEnum INAPPROPRIATE_CONTENT = _$createSignalementRequestReasonEnum_INAPPROPRIATE_CONTENT;
  @BuiltValueEnumConst(wireName: r'HARASSMENT')
  static const CreateSignalementRequestReasonEnum HARASSMENT = _$createSignalementRequestReasonEnum_HARASSMENT;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const CreateSignalementRequestReasonEnum unknownDefaultOpenApi = _$createSignalementRequestReasonEnum_unknownDefaultOpenApi;

  static Serializer<CreateSignalementRequestReasonEnum> get serializer => _$createSignalementRequestReasonEnumSerializer;

  const CreateSignalementRequestReasonEnum._(String name): super(name);

  static BuiltSet<CreateSignalementRequestReasonEnum> get values => _$createSignalementRequestReasonEnumValues;
  static CreateSignalementRequestReasonEnum valueOf(String name) => _$createSignalementRequestReasonEnumValueOf(name);
}

