//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:api_client/src/model/line.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'subscription_recap_response.g.dart';

/// SubscriptionRecapResponse
///
/// Properties:
/// * [month] 
/// * [live] 
/// * [snapshotTakenAt] 
/// * [tiers] 
/// * [total] 
@BuiltValue()
abstract class SubscriptionRecapResponse implements Built<SubscriptionRecapResponse, SubscriptionRecapResponseBuilder> {
  @BuiltValueField(wireName: r'month')
  String? get month;

  @BuiltValueField(wireName: r'live')
  bool? get live;

  @BuiltValueField(wireName: r'snapshotTakenAt')
  DateTime? get snapshotTakenAt;

  @BuiltValueField(wireName: r'tiers')
  BuiltList<Line>? get tiers;

  @BuiltValueField(wireName: r'total')
  Line? get total;

  SubscriptionRecapResponse._();

  factory SubscriptionRecapResponse([void updates(SubscriptionRecapResponseBuilder b)]) = _$SubscriptionRecapResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SubscriptionRecapResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SubscriptionRecapResponse> get serializer => _$SubscriptionRecapResponseSerializer();
}

class _$SubscriptionRecapResponseSerializer implements PrimitiveSerializer<SubscriptionRecapResponse> {
  @override
  final Iterable<Type> types = const [SubscriptionRecapResponse, _$SubscriptionRecapResponse];

  @override
  final String wireName = r'SubscriptionRecapResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SubscriptionRecapResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.month != null) {
      yield r'month';
      yield serializers.serialize(
        object.month,
        specifiedType: const FullType(String),
      );
    }
    if (object.live != null) {
      yield r'live';
      yield serializers.serialize(
        object.live,
        specifiedType: const FullType(bool),
      );
    }
    if (object.snapshotTakenAt != null) {
      yield r'snapshotTakenAt';
      yield serializers.serialize(
        object.snapshotTakenAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.tiers != null) {
      yield r'tiers';
      yield serializers.serialize(
        object.tiers,
        specifiedType: const FullType(BuiltList, [FullType(Line)]),
      );
    }
    if (object.total != null) {
      yield r'total';
      yield serializers.serialize(
        object.total,
        specifiedType: const FullType(Line),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SubscriptionRecapResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SubscriptionRecapResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'month':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.month = valueDes;
          break;
        case r'live':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.live = valueDes;
          break;
        case r'snapshotTakenAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.snapshotTakenAt = valueDes;
          break;
        case r'tiers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(Line)]),
          ) as BuiltList<Line>?;
          if (valueDes == null) continue;
          result.tiers.replace(valueDes);
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Line),
          ) as Line?;
          if (valueDes == null) continue;
          result.total.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SubscriptionRecapResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SubscriptionRecapResponseBuilder();
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

