//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'type_change_review_result.g.dart';

/// TypeChangeReviewResult
///
/// Properties:
/// * [id] 
/// * [status] 
/// * [requestedType] 
/// * [adminReason] 
@BuiltValue()
abstract class TypeChangeReviewResult implements Built<TypeChangeReviewResult, TypeChangeReviewResultBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'status')
  TypeChangeReviewResultStatusEnum? get status;
  // enum statusEnum {  PENDING,  APPROVED,  REJECTED,  };

  @BuiltValueField(wireName: r'requestedType')
  TypeChangeReviewResultRequestedTypeEnum? get requestedType;
  // enum requestedTypeEnum {  PARTICULIER,  AGENCE,  PROMOTEUR,  };

  @BuiltValueField(wireName: r'adminReason')
  String? get adminReason;

  TypeChangeReviewResult._();

  factory TypeChangeReviewResult([void updates(TypeChangeReviewResultBuilder b)]) = _$TypeChangeReviewResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TypeChangeReviewResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TypeChangeReviewResult> get serializer => _$TypeChangeReviewResultSerializer();
}

class _$TypeChangeReviewResultSerializer implements PrimitiveSerializer<TypeChangeReviewResult> {
  @override
  final Iterable<Type> types = const [TypeChangeReviewResult, _$TypeChangeReviewResult];

  @override
  final String wireName = r'TypeChangeReviewResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TypeChangeReviewResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(TypeChangeReviewResultStatusEnum),
      );
    }
    if (object.requestedType != null) {
      yield r'requestedType';
      yield serializers.serialize(
        object.requestedType,
        specifiedType: const FullType(TypeChangeReviewResultRequestedTypeEnum),
      );
    }
    if (object.adminReason != null) {
      yield r'adminReason';
      yield serializers.serialize(
        object.adminReason,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TypeChangeReviewResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TypeChangeReviewResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.id = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(TypeChangeReviewResultStatusEnum),
          ) as TypeChangeReviewResultStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        case r'requestedType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(TypeChangeReviewResultRequestedTypeEnum),
          ) as TypeChangeReviewResultRequestedTypeEnum?;
          if (valueDes == null) continue;
          result.requestedType = valueDes;
          break;
        case r'adminReason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.adminReason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TypeChangeReviewResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TypeChangeReviewResultBuilder();
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

class TypeChangeReviewResultStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PENDING')
  static const TypeChangeReviewResultStatusEnum PENDING = _$typeChangeReviewResultStatusEnum_PENDING;
  @BuiltValueEnumConst(wireName: r'APPROVED')
  static const TypeChangeReviewResultStatusEnum APPROVED = _$typeChangeReviewResultStatusEnum_APPROVED;
  @BuiltValueEnumConst(wireName: r'REJECTED')
  static const TypeChangeReviewResultStatusEnum REJECTED = _$typeChangeReviewResultStatusEnum_REJECTED;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const TypeChangeReviewResultStatusEnum unknownDefaultOpenApi = _$typeChangeReviewResultStatusEnum_unknownDefaultOpenApi;

  static Serializer<TypeChangeReviewResultStatusEnum> get serializer => _$typeChangeReviewResultStatusEnumSerializer;

  const TypeChangeReviewResultStatusEnum._(String name): super(name);

  static BuiltSet<TypeChangeReviewResultStatusEnum> get values => _$typeChangeReviewResultStatusEnumValues;
  static TypeChangeReviewResultStatusEnum valueOf(String name) => _$typeChangeReviewResultStatusEnumValueOf(name);
}

class TypeChangeReviewResultRequestedTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PARTICULIER')
  static const TypeChangeReviewResultRequestedTypeEnum PARTICULIER = _$typeChangeReviewResultRequestedTypeEnum_PARTICULIER;
  @BuiltValueEnumConst(wireName: r'AGENCE')
  static const TypeChangeReviewResultRequestedTypeEnum AGENCE = _$typeChangeReviewResultRequestedTypeEnum_AGENCE;
  @BuiltValueEnumConst(wireName: r'PROMOTEUR')
  static const TypeChangeReviewResultRequestedTypeEnum PROMOTEUR = _$typeChangeReviewResultRequestedTypeEnum_PROMOTEUR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const TypeChangeReviewResultRequestedTypeEnum unknownDefaultOpenApi = _$typeChangeReviewResultRequestedTypeEnum_unknownDefaultOpenApi;

  static Serializer<TypeChangeReviewResultRequestedTypeEnum> get serializer => _$typeChangeReviewResultRequestedTypeEnumSerializer;

  const TypeChangeReviewResultRequestedTypeEnum._(String name): super(name);

  static BuiltSet<TypeChangeReviewResultRequestedTypeEnum> get values => _$typeChangeReviewResultRequestedTypeEnumValues;
  static TypeChangeReviewResultRequestedTypeEnum valueOf(String name) => _$typeChangeReviewResultRequestedTypeEnumValueOf(name);
}

