//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/dashboard_figures.dart';
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/dashboard_metric.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dashboard_summary_response.g.dart';

/// DashboardSummaryResponse
///
/// Properties:
/// * [tier] 
/// * [totals] 
/// * [averagePosition] 
@BuiltValue()
abstract class DashboardSummaryResponse implements Built<DashboardSummaryResponse, DashboardSummaryResponseBuilder> {
  @BuiltValueField(wireName: r'tier')
  DashboardSummaryResponseTierEnum? get tier;
  // enum tierEnum {  FREE,  BASIC_PLUS,  PRO,  PRO_PLUS,  };

  @BuiltValueField(wireName: r'totals')
  DashboardFigures? get totals;

  @BuiltValueField(wireName: r'averagePosition')
  DashboardMetric? get averagePosition;

  DashboardSummaryResponse._();

  factory DashboardSummaryResponse([void updates(DashboardSummaryResponseBuilder b)]) = _$DashboardSummaryResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DashboardSummaryResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DashboardSummaryResponse> get serializer => _$DashboardSummaryResponseSerializer();
}

class _$DashboardSummaryResponseSerializer implements PrimitiveSerializer<DashboardSummaryResponse> {
  @override
  final Iterable<Type> types = const [DashboardSummaryResponse, _$DashboardSummaryResponse];

  @override
  final String wireName = r'DashboardSummaryResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DashboardSummaryResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.tier != null) {
      yield r'tier';
      yield serializers.serialize(
        object.tier,
        specifiedType: const FullType(DashboardSummaryResponseTierEnum),
      );
    }
    if (object.totals != null) {
      yield r'totals';
      yield serializers.serialize(
        object.totals,
        specifiedType: const FullType(DashboardFigures),
      );
    }
    if (object.averagePosition != null) {
      yield r'averagePosition';
      yield serializers.serialize(
        object.averagePosition,
        specifiedType: const FullType(DashboardMetric),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DashboardSummaryResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DashboardSummaryResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'tier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DashboardSummaryResponseTierEnum),
          ) as DashboardSummaryResponseTierEnum?;
          if (valueDes == null) continue;
          result.tier = valueDes;
          break;
        case r'totals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DashboardFigures),
          ) as DashboardFigures?;
          if (valueDes == null) continue;
          result.totals.replace(valueDes);
          break;
        case r'averagePosition':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DashboardMetric),
          ) as DashboardMetric?;
          if (valueDes == null) continue;
          result.averagePosition.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DashboardSummaryResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DashboardSummaryResponseBuilder();
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

class DashboardSummaryResponseTierEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'FREE')
  static const DashboardSummaryResponseTierEnum FREE = _$dashboardSummaryResponseTierEnum_FREE;
  @BuiltValueEnumConst(wireName: r'BASIC_PLUS')
  static const DashboardSummaryResponseTierEnum BASIC_PLUS = _$dashboardSummaryResponseTierEnum_BASIC_PLUS;
  @BuiltValueEnumConst(wireName: r'PRO')
  static const DashboardSummaryResponseTierEnum PRO = _$dashboardSummaryResponseTierEnum_PRO;
  @BuiltValueEnumConst(wireName: r'PRO_PLUS')
  static const DashboardSummaryResponseTierEnum PRO_PLUS = _$dashboardSummaryResponseTierEnum_PRO_PLUS;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DashboardSummaryResponseTierEnum unknownDefaultOpenApi = _$dashboardSummaryResponseTierEnum_unknownDefaultOpenApi;

  static Serializer<DashboardSummaryResponseTierEnum> get serializer => _$dashboardSummaryResponseTierEnumSerializer;

  const DashboardSummaryResponseTierEnum._(String name): super(name);

  static BuiltSet<DashboardSummaryResponseTierEnum> get values => _$dashboardSummaryResponseTierEnumValues;
  static DashboardSummaryResponseTierEnum valueOf(String name) => _$dashboardSummaryResponseTierEnumValueOf(name);
}

