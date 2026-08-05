//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tier_info.g.dart';

/// TierInfo
///
/// Properties:
/// * [tier] 
/// * [rank] 
/// * [monthlyPrice] 
/// * [activeListingLimit] 
/// * [residenceUnitAllowance] 
@BuiltValue()
abstract class TierInfo implements Built<TierInfo, TierInfoBuilder> {
  @BuiltValueField(wireName: r'tier')
  TierInfoTierEnum? get tier;
  // enum tierEnum {  FREE,  BASIC_PLUS,  PRO,  PRO_PLUS,  };

  @BuiltValueField(wireName: r'rank')
  int? get rank;

  @BuiltValueField(wireName: r'monthlyPrice')
  int? get monthlyPrice;

  @BuiltValueField(wireName: r'activeListingLimit')
  int? get activeListingLimit;

  @BuiltValueField(wireName: r'residenceUnitAllowance')
  int? get residenceUnitAllowance;

  TierInfo._();

  factory TierInfo([void updates(TierInfoBuilder b)]) = _$TierInfo;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TierInfoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TierInfo> get serializer => _$TierInfoSerializer();
}

class _$TierInfoSerializer implements PrimitiveSerializer<TierInfo> {
  @override
  final Iterable<Type> types = const [TierInfo, _$TierInfo];

  @override
  final String wireName = r'TierInfo';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TierInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.tier != null) {
      yield r'tier';
      yield serializers.serialize(
        object.tier,
        specifiedType: const FullType(TierInfoTierEnum),
      );
    }
    if (object.rank != null) {
      yield r'rank';
      yield serializers.serialize(
        object.rank,
        specifiedType: const FullType(int),
      );
    }
    if (object.monthlyPrice != null) {
      yield r'monthlyPrice';
      yield serializers.serialize(
        object.monthlyPrice,
        specifiedType: const FullType(int),
      );
    }
    if (object.activeListingLimit != null) {
      yield r'activeListingLimit';
      yield serializers.serialize(
        object.activeListingLimit,
        specifiedType: const FullType(int),
      );
    }
    if (object.residenceUnitAllowance != null) {
      yield r'residenceUnitAllowance';
      yield serializers.serialize(
        object.residenceUnitAllowance,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TierInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TierInfoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'tier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(TierInfoTierEnum),
          ) as TierInfoTierEnum?;
          if (valueDes == null) continue;
          result.tier = valueDes;
          break;
        case r'rank':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.rank = valueDes;
          break;
        case r'monthlyPrice':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.monthlyPrice = valueDes;
          break;
        case r'activeListingLimit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.activeListingLimit = valueDes;
          break;
        case r'residenceUnitAllowance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.residenceUnitAllowance = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TierInfo deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TierInfoBuilder();
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

class TierInfoTierEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'FREE')
  static const TierInfoTierEnum FREE = _$tierInfoTierEnum_FREE;
  @BuiltValueEnumConst(wireName: r'BASIC_PLUS')
  static const TierInfoTierEnum BASIC_PLUS = _$tierInfoTierEnum_BASIC_PLUS;
  @BuiltValueEnumConst(wireName: r'PRO')
  static const TierInfoTierEnum PRO = _$tierInfoTierEnum_PRO;
  @BuiltValueEnumConst(wireName: r'PRO_PLUS')
  static const TierInfoTierEnum PRO_PLUS = _$tierInfoTierEnum_PRO_PLUS;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const TierInfoTierEnum unknownDefaultOpenApi = _$tierInfoTierEnum_unknownDefaultOpenApi;

  static Serializer<TierInfoTierEnum> get serializer => _$tierInfoTierEnumSerializer;

  const TierInfoTierEnum._(String name): super(name);

  static BuiltSet<TierInfoTierEnum> get values => _$tierInfoTierEnumValues;
  static TierInfoTierEnum valueOf(String name) => _$tierInfoTierEnumValueOf(name);
}

