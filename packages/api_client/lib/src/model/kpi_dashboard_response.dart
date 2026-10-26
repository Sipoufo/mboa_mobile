//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/tier_count.dart';
import 'package:api_client/src/model/conversion.dart';
import 'package:api_client/src/model/churn.dart';
import 'package:api_client/src/model/targets.dart';
import 'package:api_client/src/model/window.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'kpi_dashboard_response.g.dart';

/// KpiDashboardResponse
///
/// Properties:
/// * [asOf] 
/// * [activeListings] 
/// * [prestatairesByTier] 
/// * [paidPrestataires] 
/// * [mrr] 
/// * [newPrestataires] 
/// * [agentVisitsCompleted] 
/// * [contractsSigned] 
/// * [conversion] 
/// * [churnThisMonth] 
/// * [churnLastMonth] 
/// * [targets] 
@BuiltValue()
abstract class KpiDashboardResponse implements Built<KpiDashboardResponse, KpiDashboardResponseBuilder> {
  @BuiltValueField(wireName: r'asOf')
  DateTime? get asOf;

  @BuiltValueField(wireName: r'activeListings')
  int? get activeListings;

  @BuiltValueField(wireName: r'prestatairesByTier')
  BuiltList<TierCount>? get prestatairesByTier;

  @BuiltValueField(wireName: r'paidPrestataires')
  int? get paidPrestataires;

  @BuiltValueField(wireName: r'mrr')
  int? get mrr;

  @BuiltValueField(wireName: r'newPrestataires')
  Window? get newPrestataires;

  @BuiltValueField(wireName: r'agentVisitsCompleted')
  Window? get agentVisitsCompleted;

  @BuiltValueField(wireName: r'contractsSigned')
  Window? get contractsSigned;

  @BuiltValueField(wireName: r'conversion')
  Conversion? get conversion;

  @BuiltValueField(wireName: r'churnThisMonth')
  Churn? get churnThisMonth;

  @BuiltValueField(wireName: r'churnLastMonth')
  Churn? get churnLastMonth;

  @BuiltValueField(wireName: r'targets')
  Targets? get targets;

  KpiDashboardResponse._();

  factory KpiDashboardResponse([void updates(KpiDashboardResponseBuilder b)]) = _$KpiDashboardResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(KpiDashboardResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<KpiDashboardResponse> get serializer => _$KpiDashboardResponseSerializer();
}

class _$KpiDashboardResponseSerializer implements PrimitiveSerializer<KpiDashboardResponse> {
  @override
  final Iterable<Type> types = const [KpiDashboardResponse, _$KpiDashboardResponse];

  @override
  final String wireName = r'KpiDashboardResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    KpiDashboardResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.asOf != null) {
      yield r'asOf';
      yield serializers.serialize(
        object.asOf,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.activeListings != null) {
      yield r'activeListings';
      yield serializers.serialize(
        object.activeListings,
        specifiedType: const FullType(int),
      );
    }
    if (object.prestatairesByTier != null) {
      yield r'prestatairesByTier';
      yield serializers.serialize(
        object.prestatairesByTier,
        specifiedType: const FullType(BuiltList, [FullType(TierCount)]),
      );
    }
    if (object.paidPrestataires != null) {
      yield r'paidPrestataires';
      yield serializers.serialize(
        object.paidPrestataires,
        specifiedType: const FullType(int),
      );
    }
    if (object.mrr != null) {
      yield r'mrr';
      yield serializers.serialize(
        object.mrr,
        specifiedType: const FullType(int),
      );
    }
    if (object.newPrestataires != null) {
      yield r'newPrestataires';
      yield serializers.serialize(
        object.newPrestataires,
        specifiedType: const FullType(Window),
      );
    }
    if (object.agentVisitsCompleted != null) {
      yield r'agentVisitsCompleted';
      yield serializers.serialize(
        object.agentVisitsCompleted,
        specifiedType: const FullType(Window),
      );
    }
    if (object.contractsSigned != null) {
      yield r'contractsSigned';
      yield serializers.serialize(
        object.contractsSigned,
        specifiedType: const FullType(Window),
      );
    }
    if (object.conversion != null) {
      yield r'conversion';
      yield serializers.serialize(
        object.conversion,
        specifiedType: const FullType(Conversion),
      );
    }
    if (object.churnThisMonth != null) {
      yield r'churnThisMonth';
      yield serializers.serialize(
        object.churnThisMonth,
        specifiedType: const FullType(Churn),
      );
    }
    if (object.churnLastMonth != null) {
      yield r'churnLastMonth';
      yield serializers.serialize(
        object.churnLastMonth,
        specifiedType: const FullType(Churn),
      );
    }
    if (object.targets != null) {
      yield r'targets';
      yield serializers.serialize(
        object.targets,
        specifiedType: const FullType(Targets),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    KpiDashboardResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required KpiDashboardResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'asOf':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.asOf = valueDes;
          break;
        case r'activeListings':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.activeListings = valueDes;
          break;
        case r'prestatairesByTier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(TierCount)]),
          ) as BuiltList<TierCount>?;
          if (valueDes == null) continue;
          result.prestatairesByTier.replace(valueDes);
          break;
        case r'paidPrestataires':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.paidPrestataires = valueDes;
          break;
        case r'mrr':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.mrr = valueDes;
          break;
        case r'newPrestataires':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Window),
          ) as Window?;
          if (valueDes == null) continue;
          result.newPrestataires.replace(valueDes);
          break;
        case r'agentVisitsCompleted':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Window),
          ) as Window?;
          if (valueDes == null) continue;
          result.agentVisitsCompleted.replace(valueDes);
          break;
        case r'contractsSigned':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Window),
          ) as Window?;
          if (valueDes == null) continue;
          result.contractsSigned.replace(valueDes);
          break;
        case r'conversion':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Conversion),
          ) as Conversion?;
          if (valueDes == null) continue;
          result.conversion.replace(valueDes);
          break;
        case r'churnThisMonth':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Churn),
          ) as Churn?;
          if (valueDes == null) continue;
          result.churnThisMonth.replace(valueDes);
          break;
        case r'churnLastMonth':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Churn),
          ) as Churn?;
          if (valueDes == null) continue;
          result.churnLastMonth.replace(valueDes);
          break;
        case r'targets':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Targets),
          ) as Targets?;
          if (valueDes == null) continue;
          result.targets.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  KpiDashboardResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = KpiDashboardResponseBuilder();
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

