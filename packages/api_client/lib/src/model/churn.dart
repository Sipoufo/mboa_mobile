//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'churn.g.dart';

/// Churn
///
/// Properties:
/// * [month] 
/// * [provisional] 
/// * [paidAtStart] 
/// * [lost] 
/// * [rate] 
@BuiltValue()
abstract class Churn implements Built<Churn, ChurnBuilder> {
  @BuiltValueField(wireName: r'month')
  String? get month;

  @BuiltValueField(wireName: r'provisional')
  bool? get provisional;

  @BuiltValueField(wireName: r'paidAtStart')
  int? get paidAtStart;

  @BuiltValueField(wireName: r'lost')
  int? get lost;

  @BuiltValueField(wireName: r'rate')
  double? get rate;

  Churn._();

  factory Churn([void updates(ChurnBuilder b)]) = _$Churn;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChurnBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Churn> get serializer => _$ChurnSerializer();
}

class _$ChurnSerializer implements PrimitiveSerializer<Churn> {
  @override
  final Iterable<Type> types = const [Churn, _$Churn];

  @override
  final String wireName = r'Churn';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Churn object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.month != null) {
      yield r'month';
      yield serializers.serialize(
        object.month,
        specifiedType: const FullType(String),
      );
    }
    if (object.provisional != null) {
      yield r'provisional';
      yield serializers.serialize(
        object.provisional,
        specifiedType: const FullType(bool),
      );
    }
    if (object.paidAtStart != null) {
      yield r'paidAtStart';
      yield serializers.serialize(
        object.paidAtStart,
        specifiedType: const FullType(int),
      );
    }
    if (object.lost != null) {
      yield r'lost';
      yield serializers.serialize(
        object.lost,
        specifiedType: const FullType(int),
      );
    }
    if (object.rate != null) {
      yield r'rate';
      yield serializers.serialize(
        object.rate,
        specifiedType: const FullType(double),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Churn object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ChurnBuilder result,
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
        case r'provisional':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.provisional = valueDes;
          break;
        case r'paidAtStart':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.paidAtStart = valueDes;
          break;
        case r'lost':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.lost = valueDes;
          break;
        case r'rate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.rate = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Churn deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChurnBuilder();
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

