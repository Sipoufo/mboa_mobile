//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'home_finance_summary.g.dart';

/// HomeFinanceSummary
///
/// Properties:
/// * [confirmedTotal] 
/// * [declaredTotal] 
/// * [contestedTotal] 
/// * [lastConfirmedAt] 
@BuiltValue()
abstract class HomeFinanceSummary implements Built<HomeFinanceSummary, HomeFinanceSummaryBuilder> {
  @BuiltValueField(wireName: r'confirmedTotal')
  int? get confirmedTotal;

  @BuiltValueField(wireName: r'declaredTotal')
  int? get declaredTotal;

  @BuiltValueField(wireName: r'contestedTotal')
  int? get contestedTotal;

  @BuiltValueField(wireName: r'lastConfirmedAt')
  DateTime? get lastConfirmedAt;

  HomeFinanceSummary._();

  factory HomeFinanceSummary([void updates(HomeFinanceSummaryBuilder b)]) = _$HomeFinanceSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HomeFinanceSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HomeFinanceSummary> get serializer => _$HomeFinanceSummarySerializer();
}

class _$HomeFinanceSummarySerializer implements PrimitiveSerializer<HomeFinanceSummary> {
  @override
  final Iterable<Type> types = const [HomeFinanceSummary, _$HomeFinanceSummary];

  @override
  final String wireName = r'HomeFinanceSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HomeFinanceSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.confirmedTotal != null) {
      yield r'confirmedTotal';
      yield serializers.serialize(
        object.confirmedTotal,
        specifiedType: const FullType(int),
      );
    }
    if (object.declaredTotal != null) {
      yield r'declaredTotal';
      yield serializers.serialize(
        object.declaredTotal,
        specifiedType: const FullType(int),
      );
    }
    if (object.contestedTotal != null) {
      yield r'contestedTotal';
      yield serializers.serialize(
        object.contestedTotal,
        specifiedType: const FullType(int),
      );
    }
    if (object.lastConfirmedAt != null) {
      yield r'lastConfirmedAt';
      yield serializers.serialize(
        object.lastConfirmedAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HomeFinanceSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HomeFinanceSummaryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'confirmedTotal':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.confirmedTotal = valueDes;
          break;
        case r'declaredTotal':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.declaredTotal = valueDes;
          break;
        case r'contestedTotal':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.contestedTotal = valueDes;
          break;
        case r'lastConfirmedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.lastConfirmedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HomeFinanceSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HomeFinanceSummaryBuilder();
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

