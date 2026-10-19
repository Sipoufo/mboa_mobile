//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'owner_decision_request.g.dart';

/// OwnerDecisionRequest
///
/// Properties:
/// * [reason] 
/// * [note] 
@BuiltValue()
abstract class OwnerDecisionRequest implements Built<OwnerDecisionRequest, OwnerDecisionRequestBuilder> {
  @BuiltValueField(wireName: r'reason')
  OwnerDecisionRequestReasonEnum get reason;
  // enum reasonEnum {  RESERVED_ELSEWHERE,  PROFILE_NOT_RETAINED,  DATES_INCOMPATIBLE,  OTHER,  };

  @BuiltValueField(wireName: r'note')
  String? get note;

  OwnerDecisionRequest._();

  factory OwnerDecisionRequest([void updates(OwnerDecisionRequestBuilder b)]) = _$OwnerDecisionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OwnerDecisionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OwnerDecisionRequest> get serializer => _$OwnerDecisionRequestSerializer();
}

class _$OwnerDecisionRequestSerializer implements PrimitiveSerializer<OwnerDecisionRequest> {
  @override
  final Iterable<Type> types = const [OwnerDecisionRequest, _$OwnerDecisionRequest];

  @override
  final String wireName = r'OwnerDecisionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OwnerDecisionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(OwnerDecisionRequestReasonEnum),
    );
    if (object.note != null) {
      yield r'note';
      yield serializers.serialize(
        object.note,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    OwnerDecisionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OwnerDecisionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OwnerDecisionRequestReasonEnum),
          ) as OwnerDecisionRequestReasonEnum;
          result.reason = valueDes;
          break;
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.note = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OwnerDecisionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OwnerDecisionRequestBuilder();
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

class OwnerDecisionRequestReasonEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'RESERVED_ELSEWHERE')
  static const OwnerDecisionRequestReasonEnum RESERVED_ELSEWHERE = _$ownerDecisionRequestReasonEnum_RESERVED_ELSEWHERE;
  @BuiltValueEnumConst(wireName: r'PROFILE_NOT_RETAINED')
  static const OwnerDecisionRequestReasonEnum PROFILE_NOT_RETAINED = _$ownerDecisionRequestReasonEnum_PROFILE_NOT_RETAINED;
  @BuiltValueEnumConst(wireName: r'DATES_INCOMPATIBLE')
  static const OwnerDecisionRequestReasonEnum DATES_INCOMPATIBLE = _$ownerDecisionRequestReasonEnum_DATES_INCOMPATIBLE;
  @BuiltValueEnumConst(wireName: r'OTHER')
  static const OwnerDecisionRequestReasonEnum OTHER = _$ownerDecisionRequestReasonEnum_OTHER;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const OwnerDecisionRequestReasonEnum unknownDefaultOpenApi = _$ownerDecisionRequestReasonEnum_unknownDefaultOpenApi;

  static Serializer<OwnerDecisionRequestReasonEnum> get serializer => _$ownerDecisionRequestReasonEnumSerializer;

  const OwnerDecisionRequestReasonEnum._(String name): super(name);

  static BuiltSet<OwnerDecisionRequestReasonEnum> get values => _$ownerDecisionRequestReasonEnumValues;
  static OwnerDecisionRequestReasonEnum valueOf(String name) => _$ownerDecisionRequestReasonEnumValueOf(name);
}

