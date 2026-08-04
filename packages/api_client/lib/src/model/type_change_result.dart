//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'type_change_result.g.dart';

/// TypeChangeResult
///
/// Properties:
/// * [outcome] 
/// * [requestedType] 
/// * [requestId] 
@BuiltValue()
abstract class TypeChangeResult implements Built<TypeChangeResult, TypeChangeResultBuilder> {
  @BuiltValueField(wireName: r'outcome')
  String? get outcome;

  @BuiltValueField(wireName: r'requestedType')
  TypeChangeResultRequestedTypeEnum? get requestedType;
  // enum requestedTypeEnum {  PARTICULIER,  AGENCE,  PROMOTEUR,  };

  @BuiltValueField(wireName: r'requestId')
  String? get requestId;

  TypeChangeResult._();

  factory TypeChangeResult([void updates(TypeChangeResultBuilder b)]) = _$TypeChangeResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TypeChangeResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TypeChangeResult> get serializer => _$TypeChangeResultSerializer();
}

class _$TypeChangeResultSerializer implements PrimitiveSerializer<TypeChangeResult> {
  @override
  final Iterable<Type> types = const [TypeChangeResult, _$TypeChangeResult];

  @override
  final String wireName = r'TypeChangeResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TypeChangeResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.outcome != null) {
      yield r'outcome';
      yield serializers.serialize(
        object.outcome,
        specifiedType: const FullType(String),
      );
    }
    if (object.requestedType != null) {
      yield r'requestedType';
      yield serializers.serialize(
        object.requestedType,
        specifiedType: const FullType(TypeChangeResultRequestedTypeEnum),
      );
    }
    if (object.requestId != null) {
      yield r'requestId';
      yield serializers.serialize(
        object.requestId,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TypeChangeResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TypeChangeResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'outcome':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.outcome = valueDes;
          break;
        case r'requestedType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(TypeChangeResultRequestedTypeEnum),
          ) as TypeChangeResultRequestedTypeEnum?;
          if (valueDes == null) continue;
          result.requestedType = valueDes;
          break;
        case r'requestId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.requestId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TypeChangeResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TypeChangeResultBuilder();
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

class TypeChangeResultRequestedTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PARTICULIER')
  static const TypeChangeResultRequestedTypeEnum PARTICULIER = _$typeChangeResultRequestedTypeEnum_PARTICULIER;
  @BuiltValueEnumConst(wireName: r'AGENCE')
  static const TypeChangeResultRequestedTypeEnum AGENCE = _$typeChangeResultRequestedTypeEnum_AGENCE;
  @BuiltValueEnumConst(wireName: r'PROMOTEUR')
  static const TypeChangeResultRequestedTypeEnum PROMOTEUR = _$typeChangeResultRequestedTypeEnum_PROMOTEUR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const TypeChangeResultRequestedTypeEnum unknownDefaultOpenApi = _$typeChangeResultRequestedTypeEnum_unknownDefaultOpenApi;

  static Serializer<TypeChangeResultRequestedTypeEnum> get serializer => _$typeChangeResultRequestedTypeEnumSerializer;

  const TypeChangeResultRequestedTypeEnum._(String name): super(name);

  static BuiltSet<TypeChangeResultRequestedTypeEnum> get values => _$typeChangeResultRequestedTypeEnumValues;
  static TypeChangeResultRequestedTypeEnum valueOf(String name) => _$typeChangeResultRequestedTypeEnumValueOf(name);
}

