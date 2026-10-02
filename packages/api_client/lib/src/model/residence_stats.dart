//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/dashboard_figures.dart';
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/listing_stats.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'residence_stats.g.dart';

/// ResidenceStats
///
/// Properties:
/// * [residenceId] 
/// * [name] 
/// * [unitCount] 
/// * [totals] 
/// * [units] 
@BuiltValue()
abstract class ResidenceStats implements Built<ResidenceStats, ResidenceStatsBuilder> {
  @BuiltValueField(wireName: r'residenceId')
  String? get residenceId;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'unitCount')
  int? get unitCount;

  @BuiltValueField(wireName: r'totals')
  DashboardFigures? get totals;

  @BuiltValueField(wireName: r'units')
  BuiltList<ListingStats>? get units;

  ResidenceStats._();

  factory ResidenceStats([void updates(ResidenceStatsBuilder b)]) = _$ResidenceStats;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ResidenceStatsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ResidenceStats> get serializer => _$ResidenceStatsSerializer();
}

class _$ResidenceStatsSerializer implements PrimitiveSerializer<ResidenceStats> {
  @override
  final Iterable<Type> types = const [ResidenceStats, _$ResidenceStats];

  @override
  final String wireName = r'ResidenceStats';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ResidenceStats object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.residenceId != null) {
      yield r'residenceId';
      yield serializers.serialize(
        object.residenceId,
        specifiedType: const FullType(String),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.unitCount != null) {
      yield r'unitCount';
      yield serializers.serialize(
        object.unitCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.totals != null) {
      yield r'totals';
      yield serializers.serialize(
        object.totals,
        specifiedType: const FullType(DashboardFigures),
      );
    }
    if (object.units != null) {
      yield r'units';
      yield serializers.serialize(
        object.units,
        specifiedType: const FullType(BuiltList, [FullType(ListingStats)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ResidenceStats object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ResidenceStatsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'residenceId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.residenceId = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.name = valueDes;
          break;
        case r'unitCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.unitCount = valueDes;
          break;
        case r'totals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DashboardFigures),
          ) as DashboardFigures?;
          if (valueDes == null) continue;
          result.totals.replace(valueDes);
          break;
        case r'units':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(ListingStats)]),
          ) as BuiltList<ListingStats>?;
          if (valueDes == null) continue;
          result.units.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ResidenceStats deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ResidenceStatsBuilder();
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

