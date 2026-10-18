//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'adjustment_response.g.dart';

/// AdjustmentResponse
///
/// Properties:
/// * [id] 
/// * [kind] 
/// * [tier] 
/// * [days] 
/// * [reason] 
/// * [adminAccountId] 
/// * [periodEndBefore] 
/// * [periodEndAfter] 
/// * [createdAt] 
/// * [product] 
@BuiltValue()
abstract class AdjustmentResponse implements Built<AdjustmentResponse, AdjustmentResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'kind')
  AdjustmentResponseKindEnum? get kind;
  // enum kindEnum {  GRANT,  EXTEND,  };

  @BuiltValueField(wireName: r'tier')
  AdjustmentResponseTierEnum? get tier;
  // enum tierEnum {  FREE,  BASIC_PLUS,  PRO,  PRO_PLUS,  };

  @BuiltValueField(wireName: r'days')
  int? get days;

  @BuiltValueField(wireName: r'reason')
  String? get reason;

  @BuiltValueField(wireName: r'adminAccountId')
  String? get adminAccountId;

  @BuiltValueField(wireName: r'periodEndBefore')
  DateTime? get periodEndBefore;

  @BuiltValueField(wireName: r'periodEndAfter')
  DateTime? get periodEndAfter;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'product')
  AdjustmentResponseProductEnum? get product;
  // enum productEnum {  TIER,  FINANCE_ADDON,  };

  AdjustmentResponse._();

  factory AdjustmentResponse([void updates(AdjustmentResponseBuilder b)]) = _$AdjustmentResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdjustmentResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdjustmentResponse> get serializer => _$AdjustmentResponseSerializer();
}

class _$AdjustmentResponseSerializer implements PrimitiveSerializer<AdjustmentResponse> {
  @override
  final Iterable<Type> types = const [AdjustmentResponse, _$AdjustmentResponse];

  @override
  final String wireName = r'AdjustmentResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdjustmentResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.kind != null) {
      yield r'kind';
      yield serializers.serialize(
        object.kind,
        specifiedType: const FullType(AdjustmentResponseKindEnum),
      );
    }
    if (object.tier != null) {
      yield r'tier';
      yield serializers.serialize(
        object.tier,
        specifiedType: const FullType(AdjustmentResponseTierEnum),
      );
    }
    if (object.days != null) {
      yield r'days';
      yield serializers.serialize(
        object.days,
        specifiedType: const FullType(int),
      );
    }
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType(String),
      );
    }
    if (object.adminAccountId != null) {
      yield r'adminAccountId';
      yield serializers.serialize(
        object.adminAccountId,
        specifiedType: const FullType(String),
      );
    }
    if (object.periodEndBefore != null) {
      yield r'periodEndBefore';
      yield serializers.serialize(
        object.periodEndBefore,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.periodEndAfter != null) {
      yield r'periodEndAfter';
      yield serializers.serialize(
        object.periodEndAfter,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.product != null) {
      yield r'product';
      yield serializers.serialize(
        object.product,
        specifiedType: const FullType(AdjustmentResponseProductEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AdjustmentResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdjustmentResponseBuilder result,
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
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AdjustmentResponseKindEnum),
          ) as AdjustmentResponseKindEnum?;
          if (valueDes == null) continue;
          result.kind = valueDes;
          break;
        case r'tier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AdjustmentResponseTierEnum),
          ) as AdjustmentResponseTierEnum?;
          if (valueDes == null) continue;
          result.tier = valueDes;
          break;
        case r'days':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.days = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reason = valueDes;
          break;
        case r'adminAccountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.adminAccountId = valueDes;
          break;
        case r'periodEndBefore':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.periodEndBefore = valueDes;
          break;
        case r'periodEndAfter':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.periodEndAfter = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        case r'product':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(AdjustmentResponseProductEnum),
          ) as AdjustmentResponseProductEnum?;
          if (valueDes == null) continue;
          result.product = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdjustmentResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdjustmentResponseBuilder();
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

class AdjustmentResponseKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'GRANT')
  static const AdjustmentResponseKindEnum GRANT = _$adjustmentResponseKindEnum_GRANT;
  @BuiltValueEnumConst(wireName: r'EXTEND')
  static const AdjustmentResponseKindEnum EXTEND = _$adjustmentResponseKindEnum_EXTEND;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AdjustmentResponseKindEnum unknownDefaultOpenApi = _$adjustmentResponseKindEnum_unknownDefaultOpenApi;

  static Serializer<AdjustmentResponseKindEnum> get serializer => _$adjustmentResponseKindEnumSerializer;

  const AdjustmentResponseKindEnum._(String name): super(name);

  static BuiltSet<AdjustmentResponseKindEnum> get values => _$adjustmentResponseKindEnumValues;
  static AdjustmentResponseKindEnum valueOf(String name) => _$adjustmentResponseKindEnumValueOf(name);
}

class AdjustmentResponseTierEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'FREE')
  static const AdjustmentResponseTierEnum FREE = _$adjustmentResponseTierEnum_FREE;
  @BuiltValueEnumConst(wireName: r'BASIC_PLUS')
  static const AdjustmentResponseTierEnum BASIC_PLUS = _$adjustmentResponseTierEnum_BASIC_PLUS;
  @BuiltValueEnumConst(wireName: r'PRO')
  static const AdjustmentResponseTierEnum PRO = _$adjustmentResponseTierEnum_PRO;
  @BuiltValueEnumConst(wireName: r'PRO_PLUS')
  static const AdjustmentResponseTierEnum PRO_PLUS = _$adjustmentResponseTierEnum_PRO_PLUS;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AdjustmentResponseTierEnum unknownDefaultOpenApi = _$adjustmentResponseTierEnum_unknownDefaultOpenApi;

  static Serializer<AdjustmentResponseTierEnum> get serializer => _$adjustmentResponseTierEnumSerializer;

  const AdjustmentResponseTierEnum._(String name): super(name);

  static BuiltSet<AdjustmentResponseTierEnum> get values => _$adjustmentResponseTierEnumValues;
  static AdjustmentResponseTierEnum valueOf(String name) => _$adjustmentResponseTierEnumValueOf(name);
}

class AdjustmentResponseProductEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'TIER')
  static const AdjustmentResponseProductEnum TIER = _$adjustmentResponseProductEnum_TIER;
  @BuiltValueEnumConst(wireName: r'FINANCE_ADDON')
  static const AdjustmentResponseProductEnum FINANCE_ADDON = _$adjustmentResponseProductEnum_FINANCE_ADDON;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AdjustmentResponseProductEnum unknownDefaultOpenApi = _$adjustmentResponseProductEnum_unknownDefaultOpenApi;

  static Serializer<AdjustmentResponseProductEnum> get serializer => _$adjustmentResponseProductEnumSerializer;

  const AdjustmentResponseProductEnum._(String name): super(name);

  static BuiltSet<AdjustmentResponseProductEnum> get values => _$adjustmentResponseProductEnumValues;
  static AdjustmentResponseProductEnum valueOf(String name) => _$adjustmentResponseProductEnumValueOf(name);
}

