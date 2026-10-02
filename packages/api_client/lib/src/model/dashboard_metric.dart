//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dashboard_metric.g.dart';

/// DashboardMetric
///
/// Properties:
/// * [value] 
/// * [locked] 
/// * [requiredTier] 
/// * [available] 
@BuiltValue()
abstract class DashboardMetric implements Built<DashboardMetric, DashboardMetricBuilder> {
  @BuiltValueField(wireName: r'value')
  num? get value;

  @BuiltValueField(wireName: r'locked')
  bool? get locked;

  @BuiltValueField(wireName: r'requiredTier')
  DashboardMetricRequiredTierEnum? get requiredTier;
  // enum requiredTierEnum {  FREE,  BASIC_PLUS,  PRO,  PRO_PLUS,  };

  @BuiltValueField(wireName: r'available')
  bool? get available;

  DashboardMetric._();

  factory DashboardMetric([void updates(DashboardMetricBuilder b)]) = _$DashboardMetric;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DashboardMetricBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DashboardMetric> get serializer => _$DashboardMetricSerializer();
}

class _$DashboardMetricSerializer implements PrimitiveSerializer<DashboardMetric> {
  @override
  final Iterable<Type> types = const [DashboardMetric, _$DashboardMetric];

  @override
  final String wireName = r'DashboardMetric';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DashboardMetric object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.value != null) {
      yield r'value';
      yield serializers.serialize(
        object.value,
        specifiedType: const FullType(num),
      );
    }
    if (object.locked != null) {
      yield r'locked';
      yield serializers.serialize(
        object.locked,
        specifiedType: const FullType(bool),
      );
    }
    if (object.requiredTier != null) {
      yield r'requiredTier';
      yield serializers.serialize(
        object.requiredTier,
        specifiedType: const FullType(DashboardMetricRequiredTierEnum),
      );
    }
    if (object.available != null) {
      yield r'available';
      yield serializers.serialize(
        object.available,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DashboardMetric object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DashboardMetricBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'value':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(num),
          ) as num?;
          if (valueDes == null) continue;
          result.value = valueDes;
          break;
        case r'locked':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.locked = valueDes;
          break;
        case r'requiredTier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DashboardMetricRequiredTierEnum),
          ) as DashboardMetricRequiredTierEnum?;
          if (valueDes == null) continue;
          result.requiredTier = valueDes;
          break;
        case r'available':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.available = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DashboardMetric deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DashboardMetricBuilder();
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

class DashboardMetricRequiredTierEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'FREE')
  static const DashboardMetricRequiredTierEnum FREE = _$dashboardMetricRequiredTierEnum_FREE;
  @BuiltValueEnumConst(wireName: r'BASIC_PLUS')
  static const DashboardMetricRequiredTierEnum BASIC_PLUS = _$dashboardMetricRequiredTierEnum_BASIC_PLUS;
  @BuiltValueEnumConst(wireName: r'PRO')
  static const DashboardMetricRequiredTierEnum PRO = _$dashboardMetricRequiredTierEnum_PRO;
  @BuiltValueEnumConst(wireName: r'PRO_PLUS')
  static const DashboardMetricRequiredTierEnum PRO_PLUS = _$dashboardMetricRequiredTierEnum_PRO_PLUS;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DashboardMetricRequiredTierEnum unknownDefaultOpenApi = _$dashboardMetricRequiredTierEnum_unknownDefaultOpenApi;

  static Serializer<DashboardMetricRequiredTierEnum> get serializer => _$dashboardMetricRequiredTierEnumSerializer;

  const DashboardMetricRequiredTierEnum._(String name): super(name);

  static BuiltSet<DashboardMetricRequiredTierEnum> get values => _$dashboardMetricRequiredTierEnumValues;
  static DashboardMetricRequiredTierEnum valueOf(String name) => _$dashboardMetricRequiredTierEnumValueOf(name);
}

