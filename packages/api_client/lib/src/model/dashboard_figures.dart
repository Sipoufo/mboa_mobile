//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/dashboard_metric.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dashboard_figures.g.dart';

/// DashboardFigures
///
/// Properties:
/// * [views] 
/// * [viewsLast7Days] 
/// * [contacts] 
/// * [conversionRate] 
/// * [agentVisits] 
/// * [signedContracts] 
@BuiltValue()
abstract class DashboardFigures implements Built<DashboardFigures, DashboardFiguresBuilder> {
  @BuiltValueField(wireName: r'views')
  DashboardMetric? get views;

  @BuiltValueField(wireName: r'viewsLast7Days')
  DashboardMetric? get viewsLast7Days;

  @BuiltValueField(wireName: r'contacts')
  DashboardMetric? get contacts;

  @BuiltValueField(wireName: r'conversionRate')
  DashboardMetric? get conversionRate;

  @BuiltValueField(wireName: r'agentVisits')
  DashboardMetric? get agentVisits;

  @BuiltValueField(wireName: r'signedContracts')
  DashboardMetric? get signedContracts;

  DashboardFigures._();

  factory DashboardFigures([void updates(DashboardFiguresBuilder b)]) = _$DashboardFigures;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DashboardFiguresBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DashboardFigures> get serializer => _$DashboardFiguresSerializer();
}

class _$DashboardFiguresSerializer implements PrimitiveSerializer<DashboardFigures> {
  @override
  final Iterable<Type> types = const [DashboardFigures, _$DashboardFigures];

  @override
  final String wireName = r'DashboardFigures';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DashboardFigures object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.views != null) {
      yield r'views';
      yield serializers.serialize(
        object.views,
        specifiedType: const FullType(DashboardMetric),
      );
    }
    if (object.viewsLast7Days != null) {
      yield r'viewsLast7Days';
      yield serializers.serialize(
        object.viewsLast7Days,
        specifiedType: const FullType(DashboardMetric),
      );
    }
    if (object.contacts != null) {
      yield r'contacts';
      yield serializers.serialize(
        object.contacts,
        specifiedType: const FullType(DashboardMetric),
      );
    }
    if (object.conversionRate != null) {
      yield r'conversionRate';
      yield serializers.serialize(
        object.conversionRate,
        specifiedType: const FullType(DashboardMetric),
      );
    }
    if (object.agentVisits != null) {
      yield r'agentVisits';
      yield serializers.serialize(
        object.agentVisits,
        specifiedType: const FullType(DashboardMetric),
      );
    }
    if (object.signedContracts != null) {
      yield r'signedContracts';
      yield serializers.serialize(
        object.signedContracts,
        specifiedType: const FullType(DashboardMetric),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DashboardFigures object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DashboardFiguresBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'views':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DashboardMetric),
          ) as DashboardMetric?;
          if (valueDes == null) continue;
          result.views.replace(valueDes);
          break;
        case r'viewsLast7Days':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DashboardMetric),
          ) as DashboardMetric?;
          if (valueDes == null) continue;
          result.viewsLast7Days.replace(valueDes);
          break;
        case r'contacts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DashboardMetric),
          ) as DashboardMetric?;
          if (valueDes == null) continue;
          result.contacts.replace(valueDes);
          break;
        case r'conversionRate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DashboardMetric),
          ) as DashboardMetric?;
          if (valueDes == null) continue;
          result.conversionRate.replace(valueDes);
          break;
        case r'agentVisits':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DashboardMetric),
          ) as DashboardMetric?;
          if (valueDes == null) continue;
          result.agentVisits.replace(valueDes);
          break;
        case r'signedContracts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DashboardMetric),
          ) as DashboardMetric?;
          if (valueDes == null) continue;
          result.signedContracts.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DashboardFigures deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DashboardFiguresBuilder();
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

