//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'type_change_review_item.g.dart';

/// TypeChangeReviewItem
///
/// Properties:
/// * [id] 
/// * [accountId] 
/// * [currentType] 
/// * [requestedType] 
/// * [reason] 
/// * [createdAt] 
@BuiltValue()
abstract class TypeChangeReviewItem implements Built<TypeChangeReviewItem, TypeChangeReviewItemBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'accountId')
  String? get accountId;

  @BuiltValueField(wireName: r'currentType')
  TypeChangeReviewItemCurrentTypeEnum? get currentType;
  // enum currentTypeEnum {  PARTICULIER,  AGENCE,  PROMOTEUR,  };

  @BuiltValueField(wireName: r'requestedType')
  TypeChangeReviewItemRequestedTypeEnum? get requestedType;
  // enum requestedTypeEnum {  PARTICULIER,  AGENCE,  PROMOTEUR,  };

  @BuiltValueField(wireName: r'reason')
  String? get reason;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  TypeChangeReviewItem._();

  factory TypeChangeReviewItem([void updates(TypeChangeReviewItemBuilder b)]) = _$TypeChangeReviewItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TypeChangeReviewItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TypeChangeReviewItem> get serializer => _$TypeChangeReviewItemSerializer();
}

class _$TypeChangeReviewItemSerializer implements PrimitiveSerializer<TypeChangeReviewItem> {
  @override
  final Iterable<Type> types = const [TypeChangeReviewItem, _$TypeChangeReviewItem];

  @override
  final String wireName = r'TypeChangeReviewItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TypeChangeReviewItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.accountId != null) {
      yield r'accountId';
      yield serializers.serialize(
        object.accountId,
        specifiedType: const FullType(String),
      );
    }
    if (object.currentType != null) {
      yield r'currentType';
      yield serializers.serialize(
        object.currentType,
        specifiedType: const FullType(TypeChangeReviewItemCurrentTypeEnum),
      );
    }
    if (object.requestedType != null) {
      yield r'requestedType';
      yield serializers.serialize(
        object.requestedType,
        specifiedType: const FullType(TypeChangeReviewItemRequestedTypeEnum),
      );
    }
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType(String),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TypeChangeReviewItem object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TypeChangeReviewItemBuilder result,
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
        case r'accountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.accountId = valueDes;
          break;
        case r'currentType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(TypeChangeReviewItemCurrentTypeEnum),
          ) as TypeChangeReviewItemCurrentTypeEnum?;
          if (valueDes == null) continue;
          result.currentType = valueDes;
          break;
        case r'requestedType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(TypeChangeReviewItemRequestedTypeEnum),
          ) as TypeChangeReviewItemRequestedTypeEnum?;
          if (valueDes == null) continue;
          result.requestedType = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reason = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TypeChangeReviewItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TypeChangeReviewItemBuilder();
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

class TypeChangeReviewItemCurrentTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PARTICULIER')
  static const TypeChangeReviewItemCurrentTypeEnum PARTICULIER = _$typeChangeReviewItemCurrentTypeEnum_PARTICULIER;
  @BuiltValueEnumConst(wireName: r'AGENCE')
  static const TypeChangeReviewItemCurrentTypeEnum AGENCE = _$typeChangeReviewItemCurrentTypeEnum_AGENCE;
  @BuiltValueEnumConst(wireName: r'PROMOTEUR')
  static const TypeChangeReviewItemCurrentTypeEnum PROMOTEUR = _$typeChangeReviewItemCurrentTypeEnum_PROMOTEUR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const TypeChangeReviewItemCurrentTypeEnum unknownDefaultOpenApi = _$typeChangeReviewItemCurrentTypeEnum_unknownDefaultOpenApi;

  static Serializer<TypeChangeReviewItemCurrentTypeEnum> get serializer => _$typeChangeReviewItemCurrentTypeEnumSerializer;

  const TypeChangeReviewItemCurrentTypeEnum._(String name): super(name);

  static BuiltSet<TypeChangeReviewItemCurrentTypeEnum> get values => _$typeChangeReviewItemCurrentTypeEnumValues;
  static TypeChangeReviewItemCurrentTypeEnum valueOf(String name) => _$typeChangeReviewItemCurrentTypeEnumValueOf(name);
}

class TypeChangeReviewItemRequestedTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PARTICULIER')
  static const TypeChangeReviewItemRequestedTypeEnum PARTICULIER = _$typeChangeReviewItemRequestedTypeEnum_PARTICULIER;
  @BuiltValueEnumConst(wireName: r'AGENCE')
  static const TypeChangeReviewItemRequestedTypeEnum AGENCE = _$typeChangeReviewItemRequestedTypeEnum_AGENCE;
  @BuiltValueEnumConst(wireName: r'PROMOTEUR')
  static const TypeChangeReviewItemRequestedTypeEnum PROMOTEUR = _$typeChangeReviewItemRequestedTypeEnum_PROMOTEUR;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const TypeChangeReviewItemRequestedTypeEnum unknownDefaultOpenApi = _$typeChangeReviewItemRequestedTypeEnum_unknownDefaultOpenApi;

  static Serializer<TypeChangeReviewItemRequestedTypeEnum> get serializer => _$typeChangeReviewItemRequestedTypeEnumSerializer;

  const TypeChangeReviewItemRequestedTypeEnum._(String name): super(name);

  static BuiltSet<TypeChangeReviewItemRequestedTypeEnum> get values => _$typeChangeReviewItemRequestedTypeEnumValues;
  static TypeChangeReviewItemRequestedTypeEnum valueOf(String name) => _$typeChangeReviewItemRequestedTypeEnumValueOf(name);
}

