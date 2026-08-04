//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'type_count.g.dart';

/// TypeCount
///
/// Properties:
/// * [propertyType] 
/// * [count] 
@BuiltValue()
abstract class TypeCount implements Built<TypeCount, TypeCountBuilder> {
  @BuiltValueField(wireName: r'propertyType')
  TypeCountPropertyTypeEnum? get propertyType;
  // enum propertyTypeEnum {  APARTMENT,  STUDIO,  VILLA,  ROOM,  OFFICE,  COMMERCIAL_SPACE,  };

  @BuiltValueField(wireName: r'count')
  int? get count;

  TypeCount._();

  factory TypeCount([void updates(TypeCountBuilder b)]) = _$TypeCount;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TypeCountBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TypeCount> get serializer => _$TypeCountSerializer();
}

class _$TypeCountSerializer implements PrimitiveSerializer<TypeCount> {
  @override
  final Iterable<Type> types = const [TypeCount, _$TypeCount];

  @override
  final String wireName = r'TypeCount';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TypeCount object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.propertyType != null) {
      yield r'propertyType';
      yield serializers.serialize(
        object.propertyType,
        specifiedType: const FullType(TypeCountPropertyTypeEnum),
      );
    }
    if (object.count != null) {
      yield r'count';
      yield serializers.serialize(
        object.count,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TypeCount object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TypeCountBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'propertyType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(TypeCountPropertyTypeEnum),
          ) as TypeCountPropertyTypeEnum?;
          if (valueDes == null) continue;
          result.propertyType = valueDes;
          break;
        case r'count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.count = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TypeCount deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TypeCountBuilder();
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

class TypeCountPropertyTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'APARTMENT')
  static const TypeCountPropertyTypeEnum APARTMENT = _$typeCountPropertyTypeEnum_APARTMENT;
  @BuiltValueEnumConst(wireName: r'STUDIO')
  static const TypeCountPropertyTypeEnum STUDIO = _$typeCountPropertyTypeEnum_STUDIO;
  @BuiltValueEnumConst(wireName: r'VILLA')
  static const TypeCountPropertyTypeEnum VILLA = _$typeCountPropertyTypeEnum_VILLA;
  @BuiltValueEnumConst(wireName: r'ROOM')
  static const TypeCountPropertyTypeEnum ROOM = _$typeCountPropertyTypeEnum_ROOM;
  @BuiltValueEnumConst(wireName: r'OFFICE')
  static const TypeCountPropertyTypeEnum OFFICE = _$typeCountPropertyTypeEnum_OFFICE;
  @BuiltValueEnumConst(wireName: r'COMMERCIAL_SPACE')
  static const TypeCountPropertyTypeEnum COMMERCIAL_SPACE = _$typeCountPropertyTypeEnum_COMMERCIAL_SPACE;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const TypeCountPropertyTypeEnum unknownDefaultOpenApi = _$typeCountPropertyTypeEnum_unknownDefaultOpenApi;

  static Serializer<TypeCountPropertyTypeEnum> get serializer => _$typeCountPropertyTypeEnumSerializer;

  const TypeCountPropertyTypeEnum._(String name): super(name);

  static BuiltSet<TypeCountPropertyTypeEnum> get values => _$typeCountPropertyTypeEnumValues;
  static TypeCountPropertyTypeEnum valueOf(String name) => _$typeCountPropertyTypeEnumValueOf(name);
}

